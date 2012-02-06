From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] tag: fix output of "tag -n" when errors occur
Date: Mon, 6 Feb 2012 03:13:12 -0500
Message-ID: <20120206081312.GA3966@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJhP-0007Ns-QS
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab2BFINP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:13:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58676
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab2BFINO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:13:14 -0500
Received: (qmail 25090 invoked by uid 107); 6 Feb 2012 08:20:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 03:20:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:13:12 -0500
Content-Disposition: inline
In-Reply-To: <20120206081119.GA3939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190042>

When "git tag" is instructed to print lines from annotated
tags via "-n", it first prints the tag name, then attempts
to parse and print the lines of the tag object, and then
finally adds a trailing newline.

If an error occurs, we return early from the function and
never print the newline, screwing up the output for the next
tag. Let's factor the line-printing into its own function so
we can manage the early returns better, and make sure that
we always terminate the line.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c |   66 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..2250915 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -83,18 +83,45 @@ static int contains(struct commit *candidate, const struct commit_list *want)
 	return contains_recurse(candidate, want);
 }
 
+static void show_tag_lines(const unsigned char *sha1, int lines)
+{
+	int i;
+	unsigned long size;
+	enum object_type type;
+	char *buf, *sp, *eol;
+	size_t len;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf || !size)
+		return;
+
+	/* skip header */
+	sp = strstr(buf, "\n\n");
+	if (!sp) {
+		free(buf);
+		return;
+	}
+	/* only take up to "lines" lines, and strip the signature */
+	size = parse_signature(buf, size);
+	for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
+		if (i)
+			printf("\n    ");
+		eol = memchr(sp, '\n', size - (sp - buf));
+		len = eol ? eol - sp : size - (sp - buf);
+		fwrite(sp, len, 1, stdout);
+		if (!eol)
+			break;
+		sp = eol + 1;
+	}
+	free(buf);
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
 
 	if (match_pattern(filter->patterns, refname)) {
-		int i;
-		unsigned long size;
-		enum object_type type;
-		char *buf, *sp, *eol;
-		size_t len;
-
 		if (filter->with_commit) {
 			struct commit *commit;
 
@@ -110,33 +137,8 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 			return 0;
 		}
 		printf("%-15s ", refname);
-
-		buf = read_sha1_file(sha1, &type, &size);
-		if (!buf || !size)
-			return 0;
-
-		/* skip header */
-		sp = strstr(buf, "\n\n");
-		if (!sp) {
-			free(buf);
-			return 0;
-		}
-		/* only take up to "lines" lines, and strip the signature */
-		size = parse_signature(buf, size);
-		for (i = 0, sp += 2;
-				i < filter->lines && sp < buf + size;
-				i++) {
-			if (i)
-				printf("\n    ");
-			eol = memchr(sp, '\n', size - (sp - buf));
-			len = eol ? eol - sp : size - (sp - buf);
-			fwrite(sp, len, 1, stdout);
-			if (!eol)
-				break;
-			sp = eol + 1;
-		}
+		show_tag_lines(sha1, filter->lines);
 		putchar('\n');
-		free(buf);
 	}
 
 	return 0;
-- 
1.7.9.rc1.29.g43677
