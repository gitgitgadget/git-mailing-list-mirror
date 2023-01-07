Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF1C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjAGN0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAGN0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:26:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B34758805
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:26:19 -0800 (PST)
Received: (qmail 23416 invoked by uid 109); 7 Jan 2023 13:26:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:26:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23618 invoked by uid 111); 7 Jan 2023 13:26:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:26:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:26:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] convert trivial uses of strncmp() to starts_with()
Message-ID: <Y7ly+h+pTaDB4TSF@coredump.intra.peff.net>
References: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's more readable to use starts_with() instead of strncmp() to match a
prefix, as the latter requires a manually-computed length, and has the
funny "matching is zero" return value common to cmp functions.  This
patch converts several cases which were found with:

  git grep 'strncmp(.*, [0-9]*)'

But note that it doesn't convert all such cases. There are several where
the magic length number is repeated elsewhere in the code, like:

  /* handle "buf" which isn't NUL-terminated and might be too small */
  if (len >= 3 && !strncmp(buf, "foo", 3))

or:

  /* exact match for "foo", but within a larger string */
  if (end - buf == 3 && !strncmp(buf, "foo", 3))

While it would not produce the wrong outcome to use starts_with() in
these cases, we'd still be left with one instance of "3". We're better
to leave them for now, as the repeated "3" makes it clear that the two
are linked (there may be other refactorings that handle both, but
they're out of scope for this patch).

A few things to note while reading the patch:

  - all cases but one are trying to match, and so lose the extra "!".
    The case in the first hunk of urlmatch.c is not-matching, and hence
    gains a "!".

  - the case in remote-fd.c is matching the beginning of "connect foo",
    but we never look at str+8 to parse the "foo" part (which would make
    this a candidate for skip_prefix(), not starts_with()). This seems
    at first glance like a bug, but is a limitation of how remote-fd
    works.

  - the second hunk in urlmatch.c shows some cases adjacent to other
    strncmp() calls that are left. These are of the "exact match within
    a larger string" type, as described above.

Signed-off-by: Jeff King <peff@peff.net>
---
No coccinelle rule for the reason given above that we don't want to just
convert all cases.

I do think a starts_with_mem() could help some of those, but I left that
for another day.

 builtin/remote-fd.c | 2 +-
 bundle-uri.c        | 2 +-
 ref-filter.c        | 2 +-
 urlmatch.c          | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 91dfe07e06..b2a3980b1d 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -40,7 +40,7 @@ static void command_loop(int input_fd, int output_fd)
 		if (!strcmp(buffer, "capabilities")) {
 			printf("*connect\n\n");
 			fflush(stdout);
-		} else if (!strncmp(buffer, "connect ", 8)) {
+		} else if (starts_with(buffer, "connect ")) {
 			printf("\n");
 			fflush(stdout);
 			if (bidirectional_transfer_loop(input_fd,
diff --git a/bundle-uri.c b/bundle-uri.c
index 36268dda17..6462ab6deb 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -620,7 +620,7 @@ static int config_to_packet_line(const char *key, const char *value, void *data)
 {
 	struct packet_reader *writer = data;
 
-	if (!strncmp(key, "bundle.", 7))
+	if (starts_with(key, "bundle."))
 		packet_write_fmt(writer->fd, "%s=%s", key, value);
 
 	return 0;
diff --git a/ref-filter.c b/ref-filter.c
index a24324123e..f8203c6b05 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1209,7 +1209,7 @@ static const char *copy_name(const char *buf)
 {
 	const char *cp;
 	for (cp = buf; *cp && *cp != '\n'; cp++) {
-		if (!strncmp(cp, " <", 2))
+		if (starts_with(cp, " <"))
 			return xmemdupz(buf, cp - buf);
 	}
 	return xstrdup("");
diff --git a/urlmatch.c b/urlmatch.c
index b615adc923..620a648efc 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -209,7 +209,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 	 */
 	if (!url_len || strchr(":/?#", *url)) {
 		/* Missing host invalid for all URL schemes except file */
-		if (strncmp(norm.buf, "file:", 5)) {
+		if (!starts_with(norm.buf, "file:")) {
 			if (out_info) {
 				out_info->url = NULL;
 				out_info->err = _("missing host and scheme is not 'file:'");
@@ -268,11 +268,11 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 		if (url == slash_ptr) {
 			/* Skip ":" port with no number, it's same as default */
 		} else if (slash_ptr - url == 2 &&
-			   !strncmp(norm.buf, "http:", 5) &&
+			   starts_with(norm.buf, "http:") &&
 			   !strncmp(url, "80", 2)) {
 			/* Skip http :80 as it's the default */
 		} else if (slash_ptr - url == 3 &&
-			   !strncmp(norm.buf, "https:", 6) &&
+			   starts_with(norm.buf, "https:") &&
 			   !strncmp(url, "443", 3)) {
 			/* Skip https :443 as it's the default */
 		} else {
-- 
2.39.0.469.g9000b9c396

