From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v3] Allow combined diff to ignore white-spaces
Date: Thu, 14 Mar 2013 22:03:14 +0100
Message-ID: <1363294994-3127-1-git-send-email-apelisse@gmail.com>
References: <7v7glayp4l.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 22:07:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGFMl-0007ab-9m
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 22:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab3CNVGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 17:06:42 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37406 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab3CNVGk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 17:06:40 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq4so4222353wib.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hxZLFXnFYRb9UElCQ54LSEuXQmiesTKCoFIO/pfC+TE=;
        b=JW3sRU5NHYGhqT7Ye0aReFMem5N8SONEW1tBtNspCTAvTKW6+nwFCFGEkQKTrJbjc1
         XkNQXrbUyUW+aVTG0hJpFQZtXkLSpefwikgeyDkQp5kna45aOlbtz+Y6GxpeXHuZbu6U
         0JI3314GuE7XuGM9F1VlVIqYjilNhlOOSjswKMqo68TRIcRgNe4NSL/wHYBZbi65N22/
         uT+SRQXq8QttLYfrL3km0fipBqoMJEHSyZgxOuHKvYJI/zz5x0yJ64uSf5qEhuGo5o0T
         Vpp50RQR3q4BIuGuyyGhebvmBL/NHcGq5AakbL6Ooqt+STVTeyT6ye0gyxzGuxsE7kHv
         v04Q==
X-Received: by 10.194.89.169 with SMTP id bp9mr6928027wjb.57.1363295199351;
        Thu, 14 Mar 2013 14:06:39 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id fv2sm6550061wib.6.2013.03.14.14.06.37
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 14:06:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7v7glayp4l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218168>

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
Changes:
- Fixed comments
- Fixed tests (following Johannes suggestions)

 combine-diff.c           |   57 +++++++++++++++++++++---
 t/t4038-diff-combined.sh |  111 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 7 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 35d41cd..6288485 100644
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
+		/* Consume remaining spaces */
+		for (; len1 > 0 && XDL_ISSPACE(line1[len1 - 1]); len1--);
+		for (; len2 > 0 && XDL_ISSPACE(line2[len2 - 1]); len2--);
+	}
+
+	/* We matched full line1 and line2 */
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
index 614425a..b7e16a7 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -3,6 +3,7 @@
 test_description='combined diff'

 . ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh

 setup_helper () {
 	one=$1 branch=$2 side=$3 &&
@@ -113,4 +114,114 @@ test_expect_success 'check --cc --raw with forty trees' '
 	grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
 '

+test_expect_success 'setup combined ignore spaces' '
+	git checkout master &&
+	>test &&
+	git add test &&
+	git commit -m initial &&
+
+	tr -d Q <<-\EOF >test &&
+	always coalesce
+	eol space coalesce Q
+	space  change coalesce
+	all spa ces coalesce
+	eol spaces Q
+	space  change
+	all spa ces
+	EOF
+	git commit -m "test space change" -a &&
+
+	git checkout -b side HEAD^ &&
+	tr -d Q <<-\EOF >test &&
+	always coalesce
+	eol space coalesce
+	space change coalesce
+	all spaces coalesce
+	eol spaces
+	space change
+	all spaces
+	EOF
+	git commit -m "test other space changes" -a &&
+
+	test_must_fail git merge master &&
+	tr -d Q <<-\EOF >test &&
+	eol spaces Q
+	space  change
+	all spa ces
+	EOF
+	git commit -m merged -a
+'
+
+test_expect_success 'check combined output (no ignore space)' '
+	git show >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	--always coalesce
+	- eol space coalesce
+	- space change coalesce
+	- all spaces coalesce
+	- eol spaces
+	- space change
+	- all spaces
+	 -eol space coalesce Q
+	 -space  change coalesce
+	 -all spa ces coalesce
+	+ eol spaces Q
+	+ space  change
+	+ all spa ces
+	EOF
+	compare_diff_patch expected actual
+'
+
+test_expect_success 'check combined output (ignore space at eol)' '
+	git show --ignore-space-at-eol >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	--always coalesce
+	--eol space coalesce
+	- space change coalesce
+	- all spaces coalesce
+	 -space  change coalesce
+	 -all spa ces coalesce
+	  eol spaces Q
+	- space change
+	- all spaces
+	+ space  change
+	+ all spa ces
+	EOF
+	compare_diff_patch expected actual
+'
+
+test_expect_success 'check combined output (ignore space change)' '
+	git show -b >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	--always coalesce
+	--eol space coalesce
+	--space change coalesce
+	- all spaces coalesce
+	 -all spa ces coalesce
+	  eol spaces Q
+	  space  change
+	- all spaces
+	+ all spa ces
+	EOF
+	compare_diff_patch expected actual
+'
+
+test_expect_success 'check combined output (ignore all spaces)' '
+	git show -w >actual.tmp &&
+	sed -e "1,/^@@@/d" < actual.tmp >actual &&
+	tr -d Q <<-\EOF >expected &&
+	--always coalesce
+	--eol space coalesce
+	--space change coalesce
+	--all spaces coalesce
+	  eol spaces Q
+	  space  change
+	  all spa ces
+	EOF
+	compare_diff_patch expected actual
+'
+
 test_done
--
1.7.9.5
