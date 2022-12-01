Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C189C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 20:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLAUZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiLAUZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 15:25:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA2BFCDD
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 12:25:33 -0800 (PST)
Received: (qmail 25975 invoked by uid 109); 1 Dec 2022 20:25:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Dec 2022 20:25:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28438 invoked by uid 111); 1 Dec 2022 20:25:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Dec 2022 15:25:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Dec 2022 15:25:31 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t5559-http-fetch-smart-http2 failures
Message-ID: <Y4kNu9iFQuKjuub1@coredump.intra.peff.net>
References: <Y4fUntdlc1mqwad5@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y4fUntdlc1mqwad5@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 05:09:34PM -0500, Todd Zullinger wrote:

> The changes in 73c49a4474 (t: run t5551 tests with both HTTP
> and HTTP/2, 2022-11-11) seem to rather frequently trigger
> test failures on Fedora.

Thanks for the report. I can't seem to reproduce here on my Debian
system, even with --stress.

I can try a Fedora chroot or vm, but it may take some time to set up. It
also sounds like you're not able to reproduce it locally on a Fedora
system? Have you tried "./t5559-* --stress"?

> The most frequent test to fail is "large fetch-pack requests
> can be sent using chunked encoding" (t5559.30), but earlier
> tests have also failed on occasion.  For the common failure,
> the test exits with:
> 
>     expecting success of 5559.30 'large fetch-pack requests can be sent using chunked encoding': 
> 	    GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
> 		    clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
> 	    {
> 		    test_have_prereq HTTP2 ||
> 		    grep "^=> Send header: Transfer-Encoding: chunked" err
> 	    }
>     +++ GIT_TRACE_CURL=true
>     +++ git -c http.postbuffer=65536 clone --bare http://127.0.0.1:5559/smart/repo.git split.git
>     error: last command exited with $?=128
>     not ok 30 - large fetch-pack requests can be sent using chunked encoding
> 
> (Less frequently, I've seen the last command exit 141.)

Interesting. 141 implies SIGPIPE, but that may be a red herring. The
operation isn't supposed to fail, but if it does due to the server
bailing, then the client sometimes hitting SIGPIPE is a known unrelated
problem.

Is it possible to see the contents of "err" here? That will have the
message from the client, but also the curl trace, which is probably
helpful.

It might also be interesting to see the server's view, which would be in
httpd/error.log in the trash directory (also access.log, but probably
that is not interesting).

> I can easily disable the failing tests for a bit, but does
> anyone have an idea what might be the cause or how to better
> debug it when it occurs on a buildsystem without direct
> access?

If t5551 isn't failing similarly, then presumably the problem is either:

  1. There is some race or bad interaction between curl and apache
     speaking http2 (possibly a buggy version of one?)

  2. http2 requires using mpm_event instead of mpm_prefork. Maybe this
     introduces problems with apache on this system?

  3. there is a bug in git. ;) This is always a possibility, of course,
     but we literally do nothing differently from our end, except pass
     it to curl via CURLOPT_HTTP_VERSION.

It would be interesting to see if doing this:

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0294739a77..b24ca44a95 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -73,16 +73,9 @@ LockFile accept.lock
 	LoadModule unixd_module modules/mod_unixd.so
 </IfModule>
 
-<IfDefine HTTP2>
 <IfModule !mod_mpm_event.c>
 	LoadModule mpm_event_module modules/mod_mpm_event.so
 </IfModule>
-</IfDefine>
-<IfDefine !HTTP2>
-<IfModule !mod_mpm_prefork.c>
-	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
-</IfModule>
-</IfDefine>
 </IfVersion>
 
 PassEnv GIT_VALGRIND

also causes t5551 to start failing. If so, then we can blame mpm_event,
and not http2.

-Peff
