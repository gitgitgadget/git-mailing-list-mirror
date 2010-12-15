From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/4] diff.c: pass struct diff_words into find_word_boundaries
Date: Wed, 15 Dec 2010 16:13:25 +0100
Message-ID: <3ced19036dcc25304d13a665af04485e2c5ad350.1292424926.git.trast@student.ethz.ch>
References: <cover.1292424926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:13:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSt2w-0005pJ-QQ
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab0LOPNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 10:13:32 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:20879 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab0LOPNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:13:31 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:21 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:29 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <cover.1292424926.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163779>

We need the word_regex_check member.  Instead of adding another
argument, just pass in the whole struct for future extensibility.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index a16ce69..8758a51 100644
--- a/diff.c
+++ b/diff.c
@@ -778,12 +778,13 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 }
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
-static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
+static int find_word_boundaries(mmfile_t *buffer, struct diff_words_data *diff_words,
 		int *begin, int *end)
 {
-	if (word_regex && *begin < buffer->size) {
+	if (diff_words->word_regex && *begin < buffer->size) {
 		regmatch_t match[1];
-		if (!regexec(word_regex, buffer->ptr + *begin, 1, match, 0)) {
+		if (!regexec(diff_words->word_regex, buffer->ptr + *begin,
+			     1, match, 0)) {
 			char *p = memchr(buffer->ptr + *begin + match[0].rm_so,
 					'\n', match[0].rm_eo - match[0].rm_so);
 			*end = p ? p - buffer->ptr : match[0].rm_eo + *begin;
@@ -813,7 +814,7 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
  * in buffer->orig.
  */
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
-		regex_t *word_regex)
+		struct diff_words_data *diff_words)
 {
 	int i, j;
 	long alloc = 0;
@@ -827,7 +828,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 	buffer->orig_nr = 1;
 
 	for (i = 0; i < buffer->text.size; i++) {
-		if (find_word_boundaries(&buffer->text, word_regex, &i, &j))
+		if (find_word_boundaries(&buffer->text, diff_words, &i, &j))
 			return;
 
 		/* store original boundaries */
-- 
1.7.3.3.807.g6ee1f
