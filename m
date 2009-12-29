From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] resolve-undo: basic tests
Date: Tue, 29 Dec 2009 13:42:32 -0800
Message-ID: <1262122958-9378-4-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqT-0003SS-Nz
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZL2Vmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZL2Vmt
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZL2Vmr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EECC4ABFB7
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6eRq
	AObax2WZeUrCBfuond4Tz/8=; b=DxcEz3qTsC6gd04SW68iTPUfRxwe6UJMUobr
	aEmSTsPHkGjOoI/lqO4lu3bHF3D/HPxKhNN+ar6kfiGuwh2jKFBF1zyDvk9/wKdk
	MiBeMh/A6Qi+L23V5P55A78t1pxfq0Ge+/tNsPhUWFqsnvPE2WR9PwoCss6SaSOx
	2d5ylZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xmgTkB
	94VWx9dncLc1p162PazIw6Hd6ewDtmKAnniYFjbjoFdmC2qEaAAma3h/0a0wqBxa
	FlwuZeeYlt4Ca/4PZ3UuPQl7IkZBJ8y75yrYbdnSZ0ZR5mqxLFECp3rb9p2MmU4J
	65Df5girgCAi6HHHFR+QSzygQJqt+yHxNJHok=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB631ABFB6
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1CF07ABFB5 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:45 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1A91B11E-F4C3-11DE-AB55-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135826>

Make sure that resolving a failed merge with git add records
the conflicted state, committing the result keeps that state,
and checking out another commit clears the state.

"git ls-files" learns a new option --resolve-undo to show the
recorded information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-ls-files.c        |   43 +++++++++++++++++++++-
 t/t2030-unresolve-info.sh |   88 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletions(-)
 create mode 100755 t/t2030-unresolve-info.sh

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index c9a03e5..ef3a068 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -11,6 +11,8 @@
 #include "builtin.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "resolve-undo.h"
+#include "string-list.h"
 
 static int abbrev;
 static int show_deleted;
@@ -18,6 +20,7 @@ static int show_cached;
 static int show_others;
 static int show_stage;
 static int show_unmerged;
+static int show_resolve_undo;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
@@ -37,6 +40,7 @@ static const char *tag_removed = "";
 static const char *tag_other = "";
 static const char *tag_killed = "";
 static const char *tag_modified = "";
+static const char *tag_resolve_undo = "";
 
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
@@ -155,6 +159,38 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
 	write_name_quoted(ce->name + offset, stdout, line_terminator);
 }
 
+static int show_one_ru(struct string_list_item *item, void *cbdata)
+{
+	int offset = prefix_offset;
+	const char *path = item->string;
+	struct resolve_undo_info *ui = item->util;
+	int i, len;
+
+	len = strlen(path);
+	if (len < prefix_len)
+		return 0; /* outside of the prefix */
+	if (!match_pathspec(pathspec, path, len, prefix_len, ps_matched))
+		return 0; /* uninterested */
+	for (i = 0; i < 3; i++) {
+		if (!ui->mode[i])
+			continue;
+		printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
+		       abbrev
+		       ? find_unique_abbrev(ui->sha1[i], abbrev)
+		       : sha1_to_hex(ui->sha1[i]),
+		       i + 1);
+		write_name_quoted(path + offset, stdout, line_terminator);
+	}
+	return 0;
+}
+
+static void show_ru_info(const char *prefix)
+{
+	if (!the_index.resolve_undo)
+		return;
+	for_each_string_list(show_one_ru, the_index.resolve_undo, NULL);
+}
+
 static void show_files(struct dir_struct *dir, const char *prefix)
 {
 	int i;
@@ -454,6 +490,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			DIR_HIDE_EMPTY_DIRECTORIES),
 		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
 			"show unmerged files in the output"),
+		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
+			    "show resolve-undo information"),
 		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], "pattern",
 			"skip files matching pattern",
 			0, option_parse_exclude },
@@ -490,6 +528,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		tag_modified = "C ";
 		tag_other = "? ";
 		tag_killed = "K ";
+		tag_resolve_undo = "U ";
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
 		require_work_tree = 1;
@@ -529,7 +568,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage | show_deleted | show_others | show_unmerged |
-	      show_killed | show_modified))
+	      show_killed | show_modified | show_resolve_undo))
 		show_cached = 1;
 
 	if (prefix)
@@ -544,6 +583,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 		overlay_tree_on_cache(with_tree, prefix);
 	}
 	show_files(&dir, prefix);
+	if (show_resolve_undo)
+		show_ru_info(prefix);
 
 	if (ps_matched) {
 		int bad;
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
new file mode 100755
index 0000000..785c8b3
--- /dev/null
+++ b/t/t2030-unresolve-info.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='undoing resolution'
+
+. ./test-lib.sh
+
+check_resolve_undo () {
+	msg=$1
+	shift
+	while case $# in
+	0)	break ;;
+	1|2|3)	die "Bug in check-resolve-undo test" ;;
+	esac
+	do
+		path=$1
+		shift
+		for stage in 1 2 3
+		do
+			sha1=$1
+			shift
+			case "$sha1" in
+			'') continue ;;
+			esac
+			sha1=$(git rev-parse --verify "$sha1")
+			printf "100644 %s %s\t%s\n" $sha1 $stage $path
+		done
+	done >"$msg.expect" &&
+	git ls-files --resolve-undo >"$msg.actual" &&
+	test_cmp "$msg.expect" "$msg.actual"
+}
+
+prime_resolve_undo () {
+	git reset --hard &&
+	git checkout second^0 &&
+	test_tick &&
+	test_must_fail git merge third^0 &&
+	echo merge does not leave anything &&
+	check_resolve_undo empty &&
+	echo different >file &&
+	git add file &&
+	echo resolving records &&
+	check_resolve_undo recorded file initial:file second:file third:file
+}
+
+test_expect_success setup '
+	test_commit initial file first &&
+	git branch side &&
+	git branch another &&
+	test_commit second file second &&
+	git checkout side &&
+	test_commit third file third &&
+	git checkout another &&
+	test_commit fourth file fourth &&
+	git checkout master
+'
+
+test_expect_success 'add records switch clears' '
+	prime_resolve_undo &&
+	test_tick &&
+	git commit -m merged &&
+	echo committing keeps &&
+	check_resolve_undo kept file initial:file second:file third:file &&
+	git checkout second^0 &&
+	echo switching clears &&
+	check_resolve_undo cleared
+'
+
+test_expect_success 'rm records reset clears' '
+	prime_resolve_undo &&
+	test_tick &&
+	git commit -m merged &&
+	echo committing keeps &&
+	check_resolve_undo kept file initial:file second:file third:file &&
+
+	echo merge clears upfront &&
+	test_must_fail git merge fourth^0 &&
+	check_resolve_undo nuked &&
+
+	git rm -f file &&
+	echo resolving records &&
+	check_resolve_undo recorded file initial:file HEAD:file fourth:file &&
+
+	git reset --hard &&
+	echo resetting discards &&
+	check_resolve_undo discarded
+'
+
+test_done
-- 
1.6.6
