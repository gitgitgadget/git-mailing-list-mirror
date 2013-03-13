From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] Allow combined diff to ignore white-spaces
Date: Wed, 13 Mar 2013 22:21:23 +0100
Message-ID: <1363209683-10264-1-git-send-email-apelisse@gmail.com>
References: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 22:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFt7j-0000rV-FV
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 22:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309Ab3CMVVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 17:21:39 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:56998 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933237Ab3CMVVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 17:21:38 -0400
Received: by mail-we0-f169.google.com with SMTP id t11so1511465wey.14
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kZvWDshKqERR8AMvptPVni5OGxRtBSChouaLyp8kXlY=;
        b=mO0sQwXSho36uc3xfBVKHhmNjwlBw0hz4XIvocd2he0Iu55kQNe/HlFyO3l0qf93nT
         pIyeTwKzXIPxShhrIKAbd3a0YY704emBj9IBq2k3S8i9XdCptdxBXx2xneU1pAWzZKig
         m1pnmfwQN9bTNg71crOCXfsHAvLj4IsjSkccqL6Z5wS1UF9BLMUU8vGwd1e+f9haga2/
         msDt/qnLyCHn0ASRoE8Iunx4dGVrrCjEXkgLHCYqB3bVQSa9jN16+EU/7pEMRECODubw
         22rZM20k5KGKVDbepFSNYZ3jB+nQ/FQV5++/qpKxT9GulkybiPQjVWXLLS9Km27fevBL
         DSeA==
X-Received: by 10.194.176.165 with SMTP id cj5mr24650228wjc.37.1363209696673;
        Wed, 13 Mar 2013 14:21:36 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id c15sm1149wiw.3.2013.03.13.14.21.34
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 14:21:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218093>

Currently, it's not possible to use the space-ignoring options (-b, -w,
--ignore-space-at-eol) with combined diff. It makes it pretty impossible
to read a merge between a branch that changed all tabs to spaces, and a
branch with functional changes.

Pass diff flags to diff engine, so that combined diff behaves as normal
diff does with spaces.
Also coalesce lines that are removed from both (or more) parents.

It also means that a conflict-less merge done using a ignore-* strategy
option will not show any conflict if shown in combined-diff using the
same option.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
OK, I added some tests and coalesce similar lost lines (using the same flags
we used for diff.

 combine-diff.c           |   57 ++++++++++++++++++++++++++++++-----
 t/t4038-diff-combined.sh |   75 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 35d41cd..0f33983 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -5,6 +5,7 @@
 #include "diffcore.h"
 #include "quote.h"
 #include "xdiff-interface.h"
+#include "xdiff/xmacros.h"
 #include "log-tree.h"
 #include "refs.h"
 #include "userdiff.h"
@@ -122,7 +123,47 @@ static char *grab_blob(const unsigned char *sha1, unsigned int mode,
 	return blob;
 }

-static void append_lost(struct sline *sline, int n, const char *line, int len)
+static int match_string_spaces(const char *line1, int len1,
+			       const char *line2, int len2,
+			       long flags)
+{
+	if (flags & XDF_WHITESPACE_FLAGS) {
+		for (; len1 > 0 && XDL_ISSPACE(line1[len1 - 1]); len1--);
+		for (; len2 > 0 && XDL_ISSPACE(line2[len2 - 1]); len2--);
+	}
+
+	if (!(flags & (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE)))
+		return (len1 == len2 && !memcmp(line1, line2, len1));
+
+	while (len1 > 0 && len2 > 0) {
+		len1--;
+		len2--;
+		if (XDL_ISSPACE(line1[len1]) || XDL_ISSPACE(line2[len2])) {
+			if ((flags & XDF_IGNORE_WHITESPACE_CHANGE) &&
+			    (!XDL_ISSPACE(line1[len1]) || !XDL_ISSPACE(line2[len2])))
+				return 0;
+
+			for (; len1 > 0 && XDL_ISSPACE(line1[len1]); len1--);
+			for (; len2 > 0 && XDL_ISSPACE(line2[len2]); len2--);
+		}
+		if (line1[len1] != line2[len2])
+			return 0;
+	}
+
+	if (flags & XDF_IGNORE_WHITESPACE) {
+		// Consume remaining spaces
+		for (; len1 > 0 && XDL_ISSPACE(line1[len1 - 1]); len1--);
+		for (; len2 > 0 && XDL_ISSPACE(line2[len2 - 1]); len2--);
+	}
+
+	// We matched full line1 and line2
+	if (!len1 && !len2)
+		return 1;
+
+	return 0;
+}
+
+static void append_lost(struct sline *sline, int n, const char *line, int len, long flags)
 {
 	struct lline *lline;
 	unsigned long this_mask = (1UL<<n);
@@ -133,8 +174,8 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 	if (sline->lost_head) {
 		lline = sline->next_lost;
 		while (lline) {
-			if (lline->len == len &&
-			    !memcmp(lline->line, line, len)) {
+			if (match_string_spaces(lline->line, lline->len,
+						line, len, flags)) {
 				lline->parent_map |= this_mask;
 				sline->next_lost = lline->next;
 				return;
@@ -162,6 +203,7 @@ struct combine_diff_state {
 	int n;
 	struct sline *sline;
 	struct sline *lost_bucket;
+	long flags;
 };

 static void consume_line(void *state_, char *line, unsigned long len)
@@ -201,7 +243,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 		return; /* not in any hunk yet */
 	switch (line[0]) {
 	case '-':
-		append_lost(state->lost_bucket, state->n, line+1, len-1);
+		append_lost(state->lost_bucket, state->n, line+1, len-1, state->flags);
 		break;
 	case '+':
 		state->sline[state->lno-1].flag |= state->nmask;
@@ -215,7 +257,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 			 struct sline *sline, unsigned int cnt, int n,
 			 int num_parent, int result_deleted,
 			 struct userdiff_driver *textconv,
-			 const char *path)
+			 const char *path, long flags)
 {
 	unsigned int p_lno, lno;
 	unsigned long nmask = (1UL << n);
@@ -231,9 +273,10 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = 0;
+	xpp.flags = flags;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
+	state.flags = flags;
 	state.nmask = nmask;
 	state.sline = sline;
 	state.lno = 1;
@@ -962,7 +1005,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 				     elem->parent[i].mode,
 				     &result_file, sline,
 				     cnt, i, num_parent, result_deleted,
-				     textconv, elem->path);
+				     textconv, elem->path, opt->xdl_opts);
 	}

 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 614425a..ba8a56b 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -113,4 +113,79 @@ test_expect_success 'check --cc --raw with forty trees' '
 	grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
 '

+test_expect_success 'setup combined ignore spaces' '
+	git checkout master &&
+	>test &&
+	git add test &&
+	git commit -m initial &&
+
+	echo "
+	always coalesce
+	eol space coalesce \n\
+	space  change coalesce
+	all spa ces coalesce
+	eol spaces \n\
+	space  change
+	all spa ces" >test &&
+	git commit -m "change three" -a &&
+
+	git checkout -b side HEAD^ &&
+	echo "
+	always coalesce
+	eol space coalesce
+	space change coalesce
+	all spaces coalesce
+	eol spaces
+	space change
+	all spaces" >test &&
+	git commit -m indent -a &&
+
+	test_must_fail git merge master &&
+	echo "
+	eol spaces \n\
+	space  change
+	all spa ces" > test &&
+	git commit -m merged -a
+'
+
+test_expect_success 'check combined output (no ignore space)' '
+	git show | test_i18ngrep "^-\s*eol spaces" &&
+	git show | test_i18ngrep "^-\s*eol space coalesce" &&
+	git show | test_i18ngrep "^-\s*space change" &&
+	git show | test_i18ngrep "^-\s*space change coalesce" &&
+	git show | test_i18ngrep "^-\s*all spaces" &&
+	git show | test_i18ngrep "^-\s*all spaces coalesce" &&
+	git show | test_i18ngrep "^--\s*always coalesce"
+'
+
+test_expect_success 'check combined output (ignore space at eol)' '
+	git show --ignore-space-at-eol | test_i18ngrep "^\s*eol spaces" &&
+	git show --ignore-space-at-eol | test_i18ngrep "^--\s*eol space coalesce" &&
+	git show --ignore-space-at-eol | test_i18ngrep "^-\s*space change" &&
+	git show --ignore-space-at-eol | test_i18ngrep "^-\s*space change coalesce" &&
+	git show --ignore-space-at-eol | test_i18ngrep "^-\s*all spaces" &&
+	git show --ignore-space-at-eol | test_i18ngrep "^-\s*all spaces coalesce" &&
+	git show --ignore-space-at-eol | test_i18ngrep "^--\s*always coalesce"
+'
+
+test_expect_success 'check combined output (ignore space change)' '
+	git show -b | test_i18ngrep "^\s*eol spaces" &&
+	git show -b | test_i18ngrep "^--\s*eol space coalesce" &&
+	git show -b | test_i18ngrep "^\s*space  change" &&
+	git show -b | test_i18ngrep "^--\s*space change coalesce" &&
+	git show -b | test_i18ngrep "^-\s*all spaces" &&
+	git show -b | test_i18ngrep "^-\s*all spaces coalesce" &&
+	git show -b | test_i18ngrep "^--\s*always coalesce"
+'
+
+test_expect_success 'check combined output (ignore all spaces)' '
+	git show -w | test_i18ngrep "^\s*eol spaces" &&
+	git show -w | test_i18ngrep "^--\s*eol space coalesce" &&
+	git show -w | test_i18ngrep "^\s*space  change" &&
+	git show -w | test_i18ngrep "^--\s*space change coalesce" &&
+	git show -w | test_i18ngrep "^\s*all spa ces" &&
+	git show -w | test_i18ngrep "^--\s*all spaces coalesce" &&
+	git show -w | test_i18ngrep "^--\s*always coalesce"
+'
+
 test_done
--
1.7.9.5
