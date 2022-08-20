Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51662C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 08:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbiHTIoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344259AbiHTIo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 04:44:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B352DC5
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 01:44:26 -0700 (PDT)
Received: (qmail 21851 invoked by uid 109); 20 Aug 2022 08:44:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 08:44:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9865 invoked by uid 111); 20 Aug 2022 08:44:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 04:44:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 04:44:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>
Cc:     Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
Message-ID: <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 10:51:16AM +0800, 王小建 wrote:

> What's different between what you expected and what actually happened?
> 
> When I use git v2.36.2  (docker image is alpine/git:v2.36.2) to clone
> with basic auth in url, when receiving the 401, it directly returns
> authentication failure, even recv head has www-authenticate: Basic
> realm=Restricted,
> and no request is send again. I think it should send request with
> authorization: Basic header after receive 401.
> And use git v2.34.2 (docker image is alpine/git:v2.34.1) to clone it works well.

I think the problem here is not the difference in Git versions, but
rather in libcurl versions. I can reproduce your problem using the
docker containers. But if I build locally, using the same version of
curl, then I see the issue with both git versions.

The problem is how curl handles cross-protocol redirects. From Git's
perspective, we hand the credentials to libcurl, and ask it to fetch the
requested URL, including following redirects. If it comes back with a
401, then we assume our credentials were bad.

But what changed in curl is that it will now discard credentials during
a redirect. And in your example, there's a redirect from http to https
(uninteresting bits snipped from the output):

> Info: Connected to xxx.xxx (xxx.xxx.xxx.xxx) port 80 (#0)
> Send header: GET /xxx/xxx/info/refs?service=git-upload-pack HTTP/1.1
> Recv header: HTTP/1.1 302 Found
> Recv header: Location: https://xxx.xxx/xxx/xxx/info/refs?service=git-upload-pack

In the older version, after the redirect we see a 401 and curl (not git)
resends with the stored credentials.

But in the newer version, we see this right after the redirect:

> Info: Connection #0 to host xxx.xxx left intact
> Info: Clear auth, redirects to port from 80 to 443

So it is dropping the credential that Git gave it.

The curl change seems to be from 620ea2141 (transfer: redirects to other
protocols or ports clear auth, 2022-04-25). The goal is to avoid leaking
credentials between ports: https://curl.se/docs/CVE-2022-27774.html

So that makes sense, though I wonder if curl ought to make an exception
for moving from 80 to 443 and http to https?

I don't think there's otherwise much Git can do here. We thought we gave
curl a username and password, but they weren't ultimately used. But Git
won't reissue the request, because it assumes the auth was rejected.

I guess we can ask curl if it saw a redirect, and assume if so that the
auth was cleared. That feels a bit hacky. And it's subverting curl's
attempt not to leak the credentials. In general, I'd like to defer as
much as possible to curl's ideas of how to handle things, because
they're much better at implementing http best practices than we are. :)

Another option is to allow the user to set CURLOPT_UNRESTRICTED_AUTH,
but that seems like a bad idea for the same reason.

Hopefully that explains what's going on. The short answer for your case
is: use an https url directly, and it should work. But there's an open
question of whether curl ought to handle this limited redirect case more
gracefully.

-Peff
