Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4AEEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 04:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjFQEmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 00:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFQEmf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 00:42:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5FA2D5F
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 21:42:33 -0700 (PDT)
Received: (qmail 8260 invoked by uid 109); 17 Jun 2023 04:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 04:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6446 invoked by uid 111); 17 Jun 2023 04:42:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 00:42:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 00:42:32 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Is MacOS CI flaky?
Message-ID: <20230617044232.GC562686@coredump.intra.peff.net>
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 03:05:14PM -0700, Glen Choo wrote:

> 1. https://github.com/chooglen/git/actions/runs/5294136258
> 
> is just
> 
> 2. https://github.com/chooglen/git/actions/runs/5292953535
> 
> with a fix for "win build", but 2. also failed for completely unrelated
> reasons on osx-*.

Hrm. So the failure in that first one is in t5559, which made me
immediately suspect http/2 race conditions (because as much as I've
tried to remove them, I still very occasionally see them in my local
builds, and you can definitely trigger them with --stress).

But much to my surprise, the failure is this:

  +++ grep -i 'Authorization: Basic [0-9a-zA-Z+/]' trace
  == Info: h2 [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==]
  == Info: h2 [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==]
  == Info: h2 [authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==]
  error: last command exited with $?=1
  not ok 17 - GIT_TRACE_CURL redacts auth details
  #	
  #		rm -rf redact-auth trace &&
  #		set_askpass user@host pass@host &&
  #		GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
  #		expect_askpass both user@host &&
  #	
  #		# Ensure that there is no "Basic" followed by a base64 string, but that
  #		# the auth details are redacted
  #		! grep -i "Authorization: Basic [0-9a-zA-Z+/]" trace &&
  #		grep -i "Authorization: Basic <redacted>" trace
  #	

The base64 blob is the actual user/pass we used for auth. That looks
like a real failure. So...for some reason we are racily sometimes not
redacting on macOS? That's super weird, and not something I'd expect to
be racy.

Looking at the string it prints, curl gave us "h2 [...".  But your
b637a41ebe (http: redact curl h2h3 headers in info, 2022-11-11) looks
for "h2h3 [...". I don't know why curl would print one versus the other.
The solution may be something like:

diff --git a/http.c b/http.c
index bb58bb3e6a..283410b3c7 100644
--- a/http.c
+++ b/http.c
@@ -746,7 +746,8 @@ static void redact_sensitive_info_header(struct strbuf *header)
 	 *   h2h3 [<header-name>: <header-val>]
 	 */
 	if (trace_curl_redact &&
-	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
+	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
+	    skip_iprefix(header->buf, "h2 [", &sensitive_header)) {
 		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
 			/* redaction ate our closing bracket */
 			strbuf_addch(header, ']');

but it would be nice to have some explanation of why we would see each
one.

-Peff
