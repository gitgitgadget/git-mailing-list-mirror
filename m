From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] show -c: show patch text
Date: Tue,  9 Mar 2010 01:42:54 -0800
Message-ID: <1268127775-9998-3-git-send-email-gitster@pobox.com>
References: <1268127775-9998-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 09 13:27:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXB-0001Do-KN
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab0CIJnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 04:43:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0CIJnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 04:43:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9504A09CC
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TnCe
	nRtkW/ARI0dDe7zWHn5qykk=; b=D48DxR5zQXGYXfGc6DmQL0VEMadeC/ZbpWrU
	zUNH1L8Ev0gUM5ROlkMdHefU0ixV4gC6gfCXIsMLdBtVKWsxz4a04DmNBiS2Ls0o
	9VmV41J8mv1aJUZPm1v+JSSeCuu/yqMoABRM7q+3VipdPtn6gIFmKfaXgvzjztZX
	oPk15T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KVYeIK
	h0Yjy6Pjik7wa2Zsyk9rcGFagxMhq9pg1PUH2jVxzji9iPIDfSzaUiMwwJTQMPeq
	8Hi/oOz6mIPvTMlze8541DC8/wYmBG1ArHWIDhERUlkybzymqBgDuO/ANryBvn0z
	YlfUa32nMjx0X77FLfu5ZAUbJSHj9diSk5KcA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A5808A09CB
	for <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C991A09CA for
 <git@vger.kernel.org>; Tue,  9 Mar 2010 04:43:01 -0500 (EST)
X-Mailer: git-send-email 1.7.0.2.384.g015e
In-Reply-To: <1268127775-9998-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 27A6A70A-2B60-11DF-85EA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141799>

Traditionally, "show" defaulted to "show --cc" (dense combined patch), but
asking for combined patch with "show -c" didn't turn the patch output
format on; the placement of this logic in setup_revisions() dates back to
cd2bdc5 (Common option parsing for "git log --diff" and friends,
2006-04-14).

This unfortunately cannot be done as a trivial change of "if dense
combined is asked, default to patch format" done in setup_revisions() to
"if any combined is asked, default to patch format", as "diff-tree -c"
needs to default to raw, while "diff-tree --cc" needs to default to patch,
and they share the codepath.  These command specific defaults are now
handled in the new "tweak" callback that can be customized by individual
command implementations.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-diff-tree.c         |   18 ++++++++++++++----
 builtin-log.c               |    7 +++++++
 revision.c                  |    7 +++----
 revision.h                  |    1 +
 t/t4013-diff-various.sh     |    1 +
 t/t4013/diff.show_-c_master |   36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 62 insertions(+), 8 deletions(-)
 create mode 100644 t/t4013/diff.show_-c_master

diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 2380c21..3c78bda 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -92,12 +92,23 @@ static const char diff_tree_usage[] =
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
+static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
+{
+	if (!rev->diffopt.output_format) {
+		if (rev->dense_combined_merges)
+			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+		else
+			rev->diffopt.output_format = DIFF_FORMAT_RAW;
+	}
+}
+
 int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 {
 	int nr_sha1;
 	char line[1000];
 	struct object *tree1, *tree2;
 	static struct rev_info *opt = &log_tree_opt;
+	struct setup_revision_opt s_r_opt;
 	int read_stdin = 0;
 
 	init_revisions(opt, prefix);
@@ -105,7 +116,9 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
-	argc = setup_revisions(argc, argv, opt, NULL);
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.tweak = diff_tree_tweak_rev;
+	argc = setup_revisions(argc, argv, opt, &s_r_opt);
 
 	while (--argc > 0) {
 		const char *arg = *++argv;
@@ -117,9 +130,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		usage(diff_tree_usage);
 	}
 
-	if (!opt->diffopt.output_format)
-		opt->diffopt.output_format = DIFF_FORMAT_RAW;
-
 	/*
 	 * NOTE! We expect "a ^b" to be equal to "a..b", so we
 	 * reverse the order of the objects if the second one
diff --git a/builtin-log.c b/builtin-log.c
index dfbf6f2..ab5f60c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -327,6 +327,12 @@ static int show_tree_object(const unsigned char *sha1,
 	return 0;
 }
 
+static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
+{
+	if (!rev->diffopt.output_format)
+		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+}
+
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -348,6 +354,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.no_walk = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
+	opt.tweak = show_rev_tweak_rev;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
 
 	count = rev.pending.nr;
diff --git a/revision.c b/revision.c
index 25c1bbb..2ddbb50 100644
--- a/revision.c
+++ b/revision.c
@@ -1463,6 +1463,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->def == NULL)
 		revs->def = opt ? opt->def : NULL;
+	if (opt && opt->tweak)
+		opt->tweak(revs, opt);
 	if (revs->show_merge)
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr) {
@@ -1496,11 +1498,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 	}
-	if (revs->combine_merges) {
+	if (revs->combine_merges)
 		revs->ignore_merges = 0;
-		if (revs->dense_combined_merges && !revs->diffopt.output_format)
-			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
-	}
 	revs->diffopt.abbrev = revs->abbrev;
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
diff --git a/revision.h b/revision.h
index fcc0de8..ceae4ca 100644
--- a/revision.h
+++ b/revision.h
@@ -139,6 +139,7 @@ extern volatile show_early_output_fn_t show_early_output;
 
 struct setup_revision_opt {
 	const char *def;
+	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 };
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 68cb651..8dd93d9 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -238,6 +238,7 @@ show initial
 show --root initial
 show side
 show master
+show -c master
 show --stat side
 show --stat --summary side
 show --patch-with-stat side
diff --git a/t/t4013/diff.show_-c_master b/t/t4013/diff.show_-c_master
new file mode 100644
index 0000000..81aba8d
--- /dev/null
+++ b/t/t4013/diff.show_-c_master
@@ -0,0 +1,36 @@
+$ git show -c master
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+diff --combined dir/sub
+index cead32e,7289e35..992913c
+--- a/dir/sub
++++ b/dir/sub
+@@@ -1,6 -1,4 +1,8 @@@
+  A
+  B
+ +C
+ +D
+ +E
+ +F
++ 1
++ 2
+diff --combined file0
+index b414108,f4615da..10a8a9f
+--- a/file0
++++ b/file0
+@@@ -1,6 -1,6 +1,9 @@@
+  1
+  2
+  3
+ +4
+ +5
+ +6
++ A
++ B
++ C
+$
-- 
1.7.0.2.384.g015e
