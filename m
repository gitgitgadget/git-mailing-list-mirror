From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"
Date: Sat, 22 Aug 2015 08:14:38 +0700
Message-ID: <1440206078-20559-1-git-send-email-pclouds@gmail.com>
References: <1440205700-19749-1-git-send-email-pclouds>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxOS-0008FD-9c
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbbHVBOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:14:44 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36413 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbHVBOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:14:43 -0400
Received: by pdbmi9 with SMTP id mi9so31966859pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VCJKsrQQziXFNarsz5fT4VODy627L4vRlU3bJukyUK4=;
        b=k6+4yHXbHJh/Oxl5d2RHZHXSgZwPCFLAkhx6DiAlSwre67+oOC2AL1m3bACFdDCUl9
         w9/K13SYD/t0vyqPjzRLsDOE3ELTeviRDceSQaGZzaYPFm0sHBB496wSLeE1bNaNbY+N
         r4/+5OQUdJoVLSyNdUlDAMbQLs5R7C3CzUBPVDOibiayISiviY7GMfYpXgpO+FnoQDXj
         6dSCC6X3mIE3+GKmYRJp3fPLHI6sEPd/ucVNNUnQJPMCquA0ZGLdfIqcfhp8nX7CVSox
         zbZ0y0F6n5ILPhpayw1DhPnN4Jv5n5EIwlSujnybirNkCEWL3LvTE/ineZu7Jq8YyXo8
         0iSw==
X-Received: by 10.70.132.228 with SMTP id ox4mr22924422pdb.0.1440206083261;
        Fri, 21 Aug 2015 18:14:43 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id v9sm9139590pdn.69.2015.08.21.18.14.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:14:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:14:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276361>

The original commit d95d728aba06a34394d15466045cbdabdada58a2 was
reverted in commit 78cc1a540ba127b13f2f3fd531777b57f3a9cd46 because we
were (and still are) not ready for a new world order. A lot more
investigation must be done to see what is impacted. See the 78cc1a5 for
details.

This patch takes a smaller and safer step. The new behavior is
controlled by SHIFT_INTENT_TO_ADD flag. We can gradually move more diff
users to the new behavior after we are sure it's safe to do so. This
flag is exposed to outside as "--shift-ita".

"git status" sets this flag unconditionally to display i-t-a entries
correctly. See d95d728 for details about "git status" and i-t-a entries=
=2E

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/diff-options.txt |  6 ++++++
 diff-lib.c                     | 14 ++++++++++++++
 diff.c                         |  2 ++
 diff.h                         |  1 +
 t/t2203-add-intent.sh          | 20 ++++++++++++++++++--
 wt-status.c                    |  2 ++
 6 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index d56ca90..b69db29 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -556,5 +556,11 @@ endif::git-format-patch[]
 --no-prefix::
 	Do not show any source or destination prefix.
=20
+--shift-ita::
+	By default entries added by "git add -N" appear as an existing
+	empty file in "git diff" and a new file in "git diff --cached".
+	This option makes the entry appear as a new file in "git diff"
+	and non-existent in "git diff --cached".
+
 For more detailed explanation on these common options, see also
 linkgit:gitdiffcore[7].
diff --git a/diff-lib.c b/diff-lib.c
index ae09034..2546f5a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -212,6 +212,12 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
 					       ce->sha1, !is_null_sha1(ce->sha1),
 					       ce->name, 0);
 				continue;
+			} else if (DIFF_OPT_TST(&revs->diffopt, SHIFT_INTENT_TO_ADD) &&
+				   ce_intent_to_add(ce)) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
=20
 			changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -376,6 +382,14 @@ static void do_oneway_diff(struct unpack_trees_opt=
ions *o,
 	struct rev_info *revs =3D o->unpack_data;
 	int match_missing, cached;
=20
+	/* i-t-a entries do not actually exist in the index */
+	if (DIFF_OPT_TST(&revs->diffopt, SHIFT_INTENT_TO_ADD) &&
+	    idx && ce_intent_to_add(idx)) {
+		idx =3D NULL;
+		if (!tree)
+			return;	/* nothing to diff.. */
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached =3D o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/diff.c b/diff.c
index 2485870..e554cad 100644
--- a/diff.c
+++ b/diff.c
@@ -3890,6 +3890,8 @@ int diff_opt_parse(struct diff_options *options, =
const char **av, int ac)
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=3D", &arg))
 		return parse_ws_error_highlight(options, arg);
+	else if (!strcmp(arg, "--shift-ita"))
+		DIFF_OPT_SET(options, SHIFT_INTENT_TO_ADD);
=20
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index 4241aa5..68a4400 100644
--- a/diff.h
+++ b/diff.h
@@ -92,6 +92,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct dif=
f_options *opt, void *data)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
 #define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
+#define DIFF_OPT_SHIFT_INTENT_TO_ADD (1ULL << 32)
=20
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_=
OPT_##flag)
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index d0f36a4..7c90eee 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,10 +5,24 @@ test_description=3D'Intent to add'
 . ./test-lib.sh
=20
 test_expect_success 'intent to add' '
+	test_commit 1 &&
+	git rm 1.t &&
+	echo hello >1.t &&
 	echo hello >file &&
 	echo hello >elif &&
 	git add -N file &&
-	git add elif
+	git add elif &&
+	git add -N 1.t
+'
+
+test_expect_success 'git status' '
+	git status --porcelain | grep -v actual >actual &&
+	cat >expect <<-\EOF &&
+	DA 1.t
+	A  elif
+	 A file
+	EOF
+	test_cmp expect actual
 '
=20
 test_expect_success 'check result of "add -N"' '
@@ -43,7 +57,9 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) =3D 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1 &&
+	test $(git diff --name-only --shift-ita HEAD -- nitfol | wc -l) =3D 0=
 &&
+	test $(git diff --name-only --shift-ita -- nitfol | wc -l) =3D 1
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
diff --git a/wt-status.c b/wt-status.c
index 717fd48..534d4ad 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -497,6 +497,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	DIFF_OPT_SET(&rev.diffopt, SHIFT_INTENT_TO_ADD);
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	if (s->ignore_submodule_arg) {
@@ -520,6 +521,7 @@ static void wt_status_collect_changes_index(struct =
wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
=20
 	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	DIFF_OPT_SET(&rev.diffopt, SHIFT_INTENT_TO_ADD);
 	if (s->ignore_submodule_arg) {
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	} else {
--=20
2.3.0.rc1.137.g477eb31
