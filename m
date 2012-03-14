From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] diff: tweak a _copy_ of diff_options with word-diff
Date: Wed, 14 Mar 2012 19:24:09 +0100
Message-ID: <b7d30afe65910ffe614a894db65386477778c4da.1331749299.git.trast@student.ethz.ch>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:24:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ssR-0001Uz-12
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758830Ab2CNSYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 14:24:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33801 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761330Ab2CNSYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 14:24:15 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 19:24:10 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 19:24:10 +0100
X-Mailer: git-send-email 1.7.10.rc0.286.gd2cb29
In-Reply-To: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193145>

When using word diff, the code sets the word_regex from various
defaults if it was not set already.  The problem is that it does this
on the original diff_options, which will also be used in subsequent
diffs.

This means that when the word_regex is not given on the command line,
only the first diff for which a setting for word_regex (either from
attributes or diff.wordRegex) ever takes effect.  This value then
propagates to the rest of the diff runs and in particular prevents
further attribute lookups.

Fix the problem of changing diff state once and for all, by working
with a _copy_ of the diff_options.

Noticed-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 diff.c                |    5 ++++-
 t/t4034-diff-words.sh |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index aac86d3..c6104b9 100644
--- a/diff.c
+++ b/diff.c
@@ -1010,11 +1010,13 @@ static const char *userdiff_word_regex(struct diff_filespec *one)
 }
 
 static void init_diff_words_data(struct emit_callback *ecbdata,
-				 struct diff_options *o,
+				 struct diff_options *orig_opts,
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
 	int i;
+	struct diff_options *o = xmalloc(sizeof(struct diff_options));
+	memcpy(o, orig_opts, sizeof(struct diff_options));
 
 	ecbdata->diff_words =
 		xcalloc(1, sizeof(struct diff_words_data));
@@ -1054,6 +1056,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
+		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 69e81f3..c04756e 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -364,7 +364,7 @@ test_expect_success 'setup history with two files' '
 	git commit -mmodified -a
 '
 
-test_expect_failure 'wordRegex for the first file does not apply to the second' '
+test_expect_success 'wordRegex for the first file does not apply to the second' '
 	echo "a diff=tex" >.gitattributes &&
 	git config diff.tex.wordRegex "[a-z]+|." &&
 	cat >expect <<-\EOF &&
-- 
1.7.10.rc0.286.gd2cb29
