From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] color-words: take an optional regular expression describing
 words
Date: Sun, 11 Jan 2009 21:00:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112100050.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6VF-0004gj-1U
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZAKUAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZAKUAX
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:00:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:57526 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752772AbZAKUAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:00:21 -0500
Received: (qmail invoked by alias); 11 Jan 2009 20:00:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 11 Jan 2009 21:00:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bZlgX71VbmocfiyQWpFQamHTw03qgAM/YDXvdIr
	RSfbHoKNEjbl3U
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105209>


In some applications, words are not delimited by white space.  To
allow for that, you can specify a regular expression describing
what makes a word with

	git diff --color-words='^[A-Za-z0-9]*'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
 diff.h |    1 +
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 2a3d301..d6bba72 100644
--- a/diff.c
+++ b/diff.c
@@ -333,12 +333,14 @@ static void diff_words_append(char *line, unsigned long len,
 	len--;
 	memcpy(buffer->text.ptr + buffer->text.size, line, len);
 	buffer->text.size += len;
+	buffer->text.ptr[buffer->text.size] = '\0';
 }
 
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	const char *current_plus;
 	FILE *file;
+	regex_t *word_regex;
 };
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
@@ -372,17 +374,36 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	diff_words->current_plus = plus_end;
 }
 
+static int find_word_boundary(mmfile_t *buffer, int i, regex_t *word_regex)
+{
+	if (i >= buffer->size)
+		return i;
+
+	if (word_regex) {
+		regmatch_t match[1];
+		if (!regexec(word_regex, buffer->ptr + i, 1, match, 0))
+			i += match[0].rm_eo;
+	}
+	else
+		while (i < buffer->size && !isspace(buffer->ptr[i]))
+			i++;
+
+	return i;
+}
+
 /*
  * This function splits the words in buffer->text, stores the list with
  * newline separator into out, and saves the offsets of the original words
  * in buffer->orig.
  */
-static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
+static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
+		regex_t *word_regex)
 {
 	int i, j;
+	long alloc = 0;
 
 	out->size = 0;
-	out->ptr = xmalloc(buffer->text.size);
+	out->ptr = NULL;
 
 	/* fake an empty "0th" word */
 	ALLOC_GROW(buffer->orig, 1, buffer->orig_alloc);
@@ -390,11 +411,9 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
 	buffer->orig_nr = 1;
 
 	for (i = 0; i < buffer->text.size; i++) {
-		if (isspace(buffer->text.ptr[i]))
+		j = find_word_boundary(&buffer->text, i, word_regex);
+		if (i == j)
 			continue;
-		for (j = i + 1; j < buffer->text.size &&
-				!isspace(buffer->text.ptr[j]); j++)
-			; /* find the end of the word */
 
 		/* store original boundaries */
 		ALLOC_GROW(buffer->orig, buffer->orig_nr + 1,
@@ -404,6 +423,7 @@ static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out)
 		buffer->orig_nr++;
 
 		/* store one word */
+		ALLOC_GROW(out->ptr, out->size + j - i + 1, alloc);
 		memcpy(out->ptr + out->size, buffer->text.ptr + i, j - i);
 		out->ptr[out->size + j - i] = '\n';
 		out->size += j - i + 1;
@@ -432,8 +452,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
-	diff_words_fill(&diff_words->minus, &minus);
-	diff_words_fill(&diff_words->plus, &plus);
+	diff_words_fill(&diff_words->minus, &minus, diff_words->word_regex);
+	diff_words_fill(&diff_words->plus, &plus, diff_words->word_regex);
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
@@ -473,6 +493,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
 		free (ecbdata->diff_words->plus.orig);
+		free(ecbdata->diff_words->word_regex);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
@@ -1495,6 +1516,14 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
+			if (o->word_regex) {
+				ecbdata.diff_words->word_regex = (regex_t *)
+					xmalloc(sizeof(regex_t));
+				if (regcomp(ecbdata.diff_words->word_regex,
+						o->word_regex, REG_EXTENDED))
+					die ("Invalid regular expression: %s",
+							o->word_regex);
+			}
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 			      &xpp, &xecfg, &ecb);
@@ -2510,6 +2539,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--color-words"))
 		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+	else if (!prefixcmp(arg, "--color-words=")) {
+		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
+		options->word_regex = arg + 14;
+	}
 	else if (!strcmp(arg, "--exit-code"))
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
diff --git a/diff.h b/diff.h
index 4d5a327..23cd90c 100644
--- a/diff.h
+++ b/diff.h
@@ -98,6 +98,7 @@ struct diff_options {
 
 	int stat_width;
 	int stat_name_width;
+	const char *word_regex;
 
 	/* this is set by diffcore for DIFF_FORMAT_PATCH */
 	int found_changes;
-- 
1.6.1.186.g48f3bc4
