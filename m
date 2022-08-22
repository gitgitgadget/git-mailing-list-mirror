Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7078BC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 09:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiHVJEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 05:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiHVJEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 05:04:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C818B1F
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 02:04:36 -0700 (PDT)
Received: (qmail 32539 invoked by uid 109); 22 Aug 2022 09:04:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Aug 2022 09:04:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27993 invoked by uid 111); 22 Aug 2022 09:04:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Aug 2022 05:04:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Aug 2022 05:04:34 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     =?utf-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>,
        git@vger.kernel.org
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
Message-ID: <YwNGoqcx3c27XpQL@coredump.intra.peff.net>
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
 <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
 <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <o4sp3o6-75sp-o12o-2p29-r94s2s769r47@unkk.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2022 at 12:32:54AM +0200, Daniel Stenberg wrote:

> I would not mind having a discussion in the curl project to see if we should
> possibly consider adding a middle-ground where we allow sending credentials
> to another port for the same host name, but I am personally NOT sold on the
> idea. I think such redirects should rather be fixed and avoided - since I
> believe users will not understand the security implications of doing them.

I'm not 100% on it either. When it comes to security restrictions,
sometimes simple-and-stupid is the best way. I was literally thinking of
something as basic and restricted as:

  if (from_port == 80 && to_port == 443 &&
      from_protocol == HTTP && to_protocol == HTTPS)
        /* ok, allow it */

just because https upgrade is such a common (and presumably harmless)
redirect.  But possibly even that leaves wiggle room for bad things to
happen. I'm happy to defer to you and other curl folks there.

I think the worst thing about the user experience from Git here is that
it says "authentication failed", which is indistinguishable from a bogus
credential. We don't even mention the redirect, because we don't warn
about them unless the request ends up successful!

So I was thinking that curl could tell us "hey, I cleared the auth due
to a redirect" via some curl_easy_getinfo() call. But maybe just
noticing there was a redirect would be sufficient. This seems to work:

diff --git a/http.c b/http.c
index 5d0502f51f..0fe8a906e5 100644
--- a/http.c
+++ b/http.c
@@ -1934,7 +1934,7 @@ static int http_request_reauth(const char *url,
 {
 	int ret = http_request(url, result, target, options);
 
-	if (ret != HTTP_OK && ret != HTTP_REAUTH)
+	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_NOAUTH)
 		return ret;
 
 	if (options && options->effective_url && options->base_url) {
diff --git a/remote-curl.c b/remote-curl.c
index b8758757ec..d462077a97 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -501,6 +501,12 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		    transport_anonymize_url(url.buf));
 	case HTTP_NOAUTH:
 		show_http_message(&type, &charset, &buffer);
+		if (LIBCURL_VERSION_NUM >= 0x075300 &&
+		    strcmp(refs_url.buf, effective_url.buf)) {
+			char *u = transport_anonymize_url(url.buf);
+			warning(_("request redirected to %s"), u);
+			warning(_("authentication information may have been discarded"));
+		}
 		die(_("Authentication failed for '%s'"),
 		    transport_anonymize_url(url.buf));
 	case HTTP_NOMATCHPUBLICKEY:

Though I wonder if there is a cleaner way to determine what happened
than string comparisons.

-Peff
