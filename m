From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 1/2] trailer: fix to ignore any line starting with '#'
Date: Sun, 27 Apr 2014 22:12:36 +0200
Message-ID: <20140427201238.16880.13774.chriscool@tuxfamily.org>
References: <20140427200327.16880.53255.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:13:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeVS3-0006Fp-NH
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 22:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbaD0UNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 16:13:24 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:51593 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200AbaD0UNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 16:13:22 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 641A25A;
	Sun, 27 Apr 2014 22:13:20 +0200 (CEST)
X-git-sha1: ea59b3e6c05ab41ad6c1684b3f3b3ac0fd53ece5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140427200327.16880.53255.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247224>

It looks like the commit-msg hook is passed a commit
message that can contain lines starting with a '#'.
Those comment lines will be removed from the commit
message after the hook is run.

If we want "git interpret-trailers" to be able to
process commit messages correctly in the commit-msg
hook we need to ignore those lines.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 26 ++++++++++++++++++++++++++
 trailer.c                     | 29 ++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 9aae721..aa63b1b 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -150,6 +150,32 @@ test_expect_success 'with 2 files arguments' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with message that has comments' '
+	cat basic_message >>message_with_comments &&
+	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
+		# comment
+
+		# other comment
+		Cc: Z
+		# yet another comment
+		Reviewed-by: Johan
+		Reviewed-by: Z
+		# last comment
+
+	EOF
+	cat basic_patch >>message_with_comments &&
+	cat basic_message >expected &&
+	cat >>expected <<-\EOF &&
+		# comment
+
+		Cc: Peff
+		Reviewed-by: Johan
+	EOF
+	cat basic_patch >>expected &&
+	git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with commit complex message and trailer args' '
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 4d32b42..81b2c5c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -644,10 +644,9 @@ static int find_patch_start(struct strbuf **lines, int count)
 /*
  * Return the (0 based) index of the first trailer line or count if
  * there are no trailers. Trailers are searched only in the lines from
- * index (count - 1) down to index 0. The has_blank_line parameter
- * tells if there is a blank line before the trailers.
+ * index (count - 1) down to index 0.
  */
-static int find_trailer_start(struct strbuf **lines, int count, int *has_blank_line)
+static int find_trailer_start(struct strbuf **lines, int count)
 {
 	int start, only_spaces = 1;
 
@@ -656,10 +655,11 @@ static int find_trailer_start(struct strbuf **lines, int count, int *has_blank_l
 	 * for a line with only spaces before lines with one ':'.
 	 */
 	for (start = count - 1; start >= 0; start--) {
+		if (lines[start]->buf[0] == '#')
+			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
 			if (only_spaces)
 				continue;
-			*has_blank_line = 1;
 			return start + 1;
 		}
 		if (strchr(lines[start]->buf, ':')) {
@@ -667,13 +667,20 @@ static int find_trailer_start(struct strbuf **lines, int count, int *has_blank_l
 				only_spaces = 0;
 			continue;
 		}
-		*has_blank_line = start == count - 1 ?
-		  0 : contains_only_spaces(lines[start + 1]->buf);
 		return count;
 	}
 
-	*has_blank_line = only_spaces ? count > 0 : 0;
-	return only_spaces ? count : start + 1;
+	return only_spaces ? count : 0;
+}
+
+static int has_blank_line_before(struct strbuf **lines, int start)
+{
+	for (;start >= 0; start--) {
+		if (lines[start]->buf[0] == '#')
+			continue;
+		return contains_only_spaces(lines[start]->buf);
+	}
+	return 0;
 }
 
 static void print_lines(struct strbuf **lines, int start, int end)
@@ -688,19 +695,19 @@ static int process_input_file(struct strbuf **lines,
 			      struct trailer_item **in_tok_last)
 {
 	int count = 0;
-	int patch_start, trailer_start, has_blank_line, i;
+	int patch_start, trailer_start, i;
 
 	/* Get the line count */
 	while (lines[count])
 		count++;
 
 	patch_start = find_patch_start(lines, count);
-	trailer_start = find_trailer_start(lines, patch_start, &has_blank_line);
+	trailer_start = find_trailer_start(lines, patch_start);
 
 	/* Print lines before the trailers as is */
 	print_lines(lines, 0, trailer_start);
 
-	if (!has_blank_line)
+	if (!has_blank_line_before(lines, trailer_start - 1))
 		printf("\n");
 
 	/* Parse trailer lines */
-- 
1.9.rc0.17.g651113e
