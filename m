Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTTP_ESCAPED_HOST,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFC2C352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 21:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A20D20768
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 21:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634059AbgDNVnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:43:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:53864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2634051AbgDNVnH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 17:43:07 -0400
Received: (qmail 7907 invoked by uid 109); 14 Apr 2020 21:43:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Apr 2020 21:43:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2479 invoked by uid 111); 14 Apr 2020 21:53:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2020 17:53:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Apr 2020 17:43:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] credential: treat "?" and "#" in URLs as end of host
Message-ID: <20200414214304.GA1887601@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's unusual to see:

  https://example.com?query-parameters

without an intervening slash, like:

  https://example.com/some-path?query-parameters

or even:

  https://example.com/?query-parameters

but it is a valid end to the hostname (actually "authority component")
according to RFC 3986. Likewise for "#".

And curl will parse the URL according to the standard, meaning it will
contact example.com, but our credential code would ask about a bogus
hostname with a "?" in it. Let's make sure we follow the standard, and
more importantly ask about the same hosts that curl will be talking to.

It would be nice if we could just ask curl to parse the URL for us. But
it didn't grow a URL-parsing API until 7.62, so we'd be stuck with
fallback code either way. Plus we'd need this code in the main Git
binary, where we've tried to avoid having a link dependency on libcurl.

But let's at least fix our parser. Moving to curl's parser would prevent
other potential discrepancies, but this gives us immediate relief for
the known problem, and would help our fallback code if we eventually use
curl.

Signed-off-by: Jeff King <peff@peff.net>
---
Just a follow-on to today's release. This isn't security critical after
the earlier fix, but it made some of the attack vectors much easier.

 credential.c           |  9 ++++++++-
 t/t0300-credentials.sh | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/credential.c b/credential.c
index 21b3ba152f..8aa9777548 100644
--- a/credential.c
+++ b/credential.c
@@ -388,7 +388,14 @@ int credential_from_url_gently(struct credential *c, const char *url,
 	cp = proto_end + 3;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
-	slash = strchrnul(cp, '/');
+
+	/*
+	 * A query or fragment marker before the slash ends the host portion.
+	 * We'll just continue to call this "slash" for simplicity. Notably our
+	 * "trim leading slashes" part won't skip over this part of the path,
+	 * but that's what we'd want.
+	 */
+	slash = cp + strcspn(cp, "/?#");
 
 	if (!at || slash <= at) {
 		/* Case (1) */
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 5b78ebbc3f..b6ec676989 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -443,11 +443,45 @@ test_expect_success 'url parser ignores embedded newlines' '
 	username=askpass-username
 	password=askpass-password
 	--
-	warning: url contains a newline in its host component: https://one.example.com?%0ahost=two.example.com/
+	warning: url contains a newline in its path component: https://one.example.com?%0ahost=two.example.com/
 	warning: skipping credential lookup for url: https://one.example.com?%0ahost=two.example.com/
 	askpass: Username:
 	askpass: Password:
 	EOF
 '
 
+# usage: check_host_and_path <url> <expected-host> <expected-path>
+check_host_and_path () {
+	# we always parse the path component, but we need this to make sure it
+	# is passed to the helper
+	test_config credential.useHTTPPath true &&
+	check fill "verbatim user pass" <<-EOF
+	url=$1
+	--
+	protocol=https
+	host=$2
+	path=$3
+	username=user
+	password=pass
+	--
+	verbatim: get
+	verbatim: protocol=https
+	verbatim: host=$2
+	verbatim: path=$3
+	EOF
+}
+
+test_expect_success 'url parser handles bare query marker' '
+	check_host_and_path https://example.com?foo.git example.com ?foo.git
+'
+
+test_expect_success 'url parser handles bare fragment marker' '
+	check_host_and_path https://example.com#foo.git example.com "#foo.git"
+'
+
+test_expect_success 'url parser not confused by encoded markers' '
+	check_host_and_path https://example.com%23%3f%2f/foo.git \
+		"example.com#?/" foo.git
+'
+
 test_done
-- 
2.26.1.429.g609150846d
