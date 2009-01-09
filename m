From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [ILLUSTRATION PATCH] color-words: take an optional regular expression
 describing words
Date: Fri, 9 Jan 2009 12:59:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901091255230.30769@pacific.mpi-cbg.de>
References: <1231459505-14395-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901090121432.30769@pacific.mpi-cbg.de> <200901090151.10880.trast@student.ethz.ch> <alpine.DEB.1.00.0901091202250.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 09 13:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLG1j-0007pN-1a
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 12:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbZAIL6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 06:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbZAIL6X
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 06:58:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:50724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752804AbZAIL6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 06:58:22 -0500
Received: (qmail invoked by alias); 09 Jan 2009 11:58:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 09 Jan 2009 12:58:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jt5lVawpjlxogIvMz6YTXZ/BnnQAd4KV5T/0GNL
	FO+EKYWl0IUCDk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901091202250.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105008>


In some applications, words are not delimited by white space.  To
allow for that, you can specify a regular expression describing
what makes a word with

	git diff --color-words='^[A-Za-z0-9]*'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 9 Jan 2009, Johannes Schindelin wrote:

	> Intuitively, all you would have to do is to replace this part in 
	> diff_words_show()
	> 
	>         for (i = 0; i < minus.size; i++)
	>                 if (isspace(minus.ptr[i]))
	>                         minus.ptr[i] = '\n';
	> 
	> by a loop finding the next word boundary.  I would suggest making that a 
	> function, say,
	> 
	> 	int find_word_boundary(struct diff_words_data *data, char *minus);
	> 
	> This function would also be responsible to initialize the regexp.
	> 
	> However, as I said, I think it would be much more intuitive to 
	> characterize the _words_ instead of the _word boundaries_.
	> 
	> And I would like to keep the default as-is (together _with_ the 
	> performance.  IOW if the user did not specify a regexp, it should fall 
	> back to what it does now, which is slow enough).

	And this patch does all that, and it _is_ substantially more 
	compact, as promised.

	It lacks testing, a test script and documentation, as well as 
	configurability via config and/or attributes, but that's your
	job, as I am not really _that_ interested in the feature myself.

 diff.c |   45 +++++++++++++++++++++++++++++++++++++++------
 diff.h |    1 +
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 4643ffc..c7ddb60 100644
--- a/diff.c
+++ b/diff.c
@@ -339,6 +339,7 @@ static void diff_words_append(char *line, unsigned long len,
 struct diff_words_data {
 	struct diff_words_buffer minus, plus;
 	FILE *file;
+	regex_t *word_regex;
 };
 
 static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, int color,
@@ -398,6 +399,25 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	}
 }
 
+static int find_word_boundary(struct diff_words_data *diff_words,
+		mmfile_t *buffer, int i)
+{
+	if (i >= buffer->size)
+		return i;
+
+	if (diff_words->word_regex) {
+		regmatch_t match[1];
+		if (!regexec(diff_words->word_regex, buffer->ptr + i,
+				1, match, 0))
+			i += match[0].rm_eo;
+	}
+	else
+		while (i < buffer->size && !isspace(i))
+			i++;
+
+	return i;
+}
+
 /* this executes the word diff on the accumulated buffers */
 static void diff_words_show(struct diff_words_data *diff_words)
 {
@@ -412,17 +432,17 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	minus.size = diff_words->minus.text.size;
 	minus.ptr = xmalloc(minus.size);
 	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
-	for (i = 0; i < minus.size; i++)
-		if (isspace(minus.ptr[i]))
-			minus.ptr[i] = '\n';
+	for (i = 0; (i = find_word_boundary(diff_words, &minus, i))
+			< minus.size; i++)
+		minus.ptr[i] = '\n';
 	diff_words->minus.current = 0;
 
 	plus.size = diff_words->plus.text.size;
 	plus.ptr = xmalloc(plus.size);
 	memcpy(plus.ptr, diff_words->plus.text.ptr, plus.size);
-	for (i = 0; i < plus.size; i++)
-		if (isspace(plus.ptr[i]))
-			plus.ptr[i] = '\n';
+	for (i = 0; (i = find_word_boundary(diff_words, &plus, i))
+			< plus.size; i++)
+		plus.ptr[i] = '\n';
 	diff_words->plus.current = 0;
 
 	xpp.flags = XDF_NEED_MINIMAL;
@@ -461,6 +481,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->plus.text.ptr);
+		free(ecbdata->diff_words->word_regex);
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
@@ -1483,6 +1504,14 @@ static void builtin_diff(const char *name_a,
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
@@ -2496,6 +2525,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
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
1.6.1.203.gc8be3
