From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/4] diff.c: pass struct diff_words into find_word_boundaries
Date: Sat, 18 Dec 2010 17:17:51 +0100
Message-ID: <944a3f9ff6419115de6665f069eb87f5c81afd34.1292688058.git.trast@student.ethz.ch>
References: <cover.1292688058.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:18:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzUD-0004k3-Lk
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890Ab0LRQSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 11:18:05 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:2218 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756719Ab0LRQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 11:18:00 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:17:53 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:17:58 +0100
X-Mailer: git-send-email 1.7.3.4.789.g74ad1
In-Reply-To: <cover.1292688058.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163919>

We need the word_regex_check member.  Instead of adding another
argument, just pass in the whole struct for future extensibility.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 0a43869..5fdcb15 100644
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
1.7.3.4.789.g74ad1
