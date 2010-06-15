From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] fast-export: Add a --full-tree option
Date: Tue, 15 Jun 2010 10:16:02 -0600
Message-ID: <1276618562-24447-2-git-send-email-newren@gmail.com>
References: <1276618562-24447-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, spearce@spearce.org, Johannes.Schindelin@gmx.de,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 18:14:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYmi-0006bT-5g
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab0FOQOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:14:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56637 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab0FOQOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:14:39 -0400
Received: by mail-wy0-f174.google.com with SMTP id 40so4954494wyb.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+i8oDfgAhyJJsaUlw5Z60yiMezmxtFcSU+2sCUel8sQ=;
        b=okOne/KDJaIwHvYhM8XZcEXGKUHDBQYWzZvTGelJOFJYxkQOZ9q3OkOZp8AsE84UrD
         fsC1DwNAFYfa3W2DGEwQozdHeHnKxVnzPqh4IKgL4dur+EvnKTke1dVIwjWj7GQUoufi
         WMEwjPf14NlQ3+muT/JqZZAMjKvCYXlFUS2V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ps0lrAkvNNZ860eqcU1NciBLXzSO/zdT9mPLT9ghQmYtY/6LHha42KI+WG6wgH+kxJ
         MgVpE1sLYiDq+7EVflDQthJi/tTKRnYJqwXx5IlQHiWa2Tv5R2zfqQuCDQUjfS0I5jym
         /SDeCstWwggSy3LqWYEPHRWiqHHEs/Kg8fx/s=
Received: by 10.216.164.68 with SMTP id b46mr3581780wel.45.1276618479020;
        Tue, 15 Jun 2010 09:14:39 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id l46sm1855900wed.34.2010.06.15.09.14.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 09:14:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.339.gd291e.dirty
In-Reply-To: <1276618562-24447-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149196>

This option can be useful when doing incremental exports/imports when
later runs of fast-export are passed a larger list of PATHs (for
limiting what to export) than prior runs did.

It's also useful for working around potential bugs in prior incremental
exports/imports, such as fast-import ignoring symlinks that used to be
directories.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-export.txt |   11 +++++++++++
 builtin/fast-export.c             |    8 +++++++-
 t/t9350-fast-export.sh            |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 98ec6b5..5202501 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -90,6 +90,17 @@ marks the same across runs.
 	resulting stream can only be used by a repository which
 	already contains the necessary objects.
 
+--full-tree::
+	By default, for each commit that has a parent, only the files
+	that are different between the commit and its parent are
+	shown.  By using --full-tree, a "deleteall" directive will be
+	sent out with each commit followed by a listing of all files
+	contained in the commit.  This can be useful when doing
+	incremental exports/imports (making use of --export-marks and
+	--import-marks) when later runs of fast-export contain a
+	larger list of PATH limiters in [git-rev-list-args...] than
+	previous runs do.
+
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and references
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..d30bed8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -26,6 +26,7 @@ static int progress;
 static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
+static int full_tree;
 static int no_data;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -241,7 +242,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		message += 2;
 
 	if (commit->parents &&
-	    get_object_mark(&commit->parents->item->object) != 0) {
+	    get_object_mark(&commit->parents->item->object) != 0 &&
+	    !full_tree) {
 		parse_commit(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
@@ -281,6 +283,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		i++;
 	}
 
+	if (full_tree)
+		printf("deleteall\n");
 	log_tree_diff_flush(rev);
 	rev->diffopt.output_format = saved_output_format;
 
@@ -584,6 +588,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
+		OPT_BOOLEAN(0, "full-tree", &full_tree,
+			     "Output full tree for each commit"),
 		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
 			"Skip output of blob data",
 			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1ee1461..05c79ea 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -400,4 +400,39 @@ test_expect_success 'directory becomes symlink'        '
 	(cd result && git show master:foo)
 '
 
+cat >> dirtosymlink/expected << EOF
+blob
+mark :5
+data 6
+hello
+
+blob
+mark :6
+data 7
+badlink
+commit refs/heads/master
+mark :7
+author A U Thor <author@example.com> 1112912713 -0700
+committer C O Mitter <committer@example.com> 1112912713 -0700
+data 6
+three
+from :4
+deleteall
+M 100644 :5 bar/world
+M 120000 :6 foo
+
+EOF
+
+test_expect_success 'full-tree'        '
+	(
+		cd dirtosymlink &&
+		git fast-export --export-marks=marks master -- foo > output1 &&
+		rm foo &&
+		ln -s badlink foo &&
+		git commit -mthree foo &&
+		git fast-export --import-marks=marks --full-tree master -- foo bar > output &&
+		test_cmp output expected
+	)
+'
+
 test_done
-- 
1.6.6.1
