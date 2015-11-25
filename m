From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/5] builtin/clone: support submodule groups
Date: Tue, 24 Nov 2015 17:32:19 -0800
Message-ID: <1448415139-23675-6-git-send-email-sbeller@google.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:32:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Owl-0005sT-WB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbbKYBcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:32:32 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33455 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbKYBc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:32:28 -0500
Received: by pabfh17 with SMTP id fh17so40845255pab.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wj6MIklu4cHeQD7cK8FmPqhN7YbVmAEwx1g4uUp51ZU=;
        b=oyIIznjDf5M1Lv6jysly09um4uxG3fpctRAZZqvMOeGtEybr4jwACDMTrALiDp7QQG
         owRFW8oscLdgKKXV+h3HjtZhVj1BCHsijy5H57HxfHkkZZlYm7Dsoso4HgOEuDOJ5Zx5
         QEyp+aEf09xd53NaL0kRRBkc9y4ZxQzcz4sGOWkHyHK9y/NnGf2WUszGT9g7diQ3PFSt
         EPRC7KoT7NKbNwycnh0Uzon1pUy4sLAIshhgORlQVsaO3vNG63btOMILnjXIeEtlldpz
         dTsCmzbdD00LgQkJXZpPBFLOp8gdnVNqp1RSyeyA2ShVVD2uelC7rL75Huzg6xko1iw9
         Sy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wj6MIklu4cHeQD7cK8FmPqhN7YbVmAEwx1g4uUp51ZU=;
        b=fdJtgkR7hMKBIwXz8tUVp3ecuOKHpGjIAOBBMbTyVRPzI/tXOCNZU+Bvxj94y+oIVV
         vNx5nCr30QrstaX2NPBgv/x3WgVthZq4NTHKBEt9giiGA2eIw0CwKkW4PnVdbmTbIX+S
         wEkrLXL6qs+ERDfycIMlGLfG+kVaMBFDEQCPdz7o4TeCaY4Gn0AFaQP8y4rJOVITieut
         Y6jNygh2RXuMPxz9g1WnCb9F4NmplDSYk3x8Qc36WNyZ6cGP43qDO+/IDJGnu2ny1qDn
         GEj7Jws5hx4VOTuRNY2tK+c5Rpx9tPqnDqdyGWQTFmTOSqmV6NYns+ZaFhGEQDtwT91T
         FZJg==
X-Gm-Message-State: ALoCoQkvNFlArE+yOsMzKEWI1rbyG1xNpOR1WYRgJqWVq1mkmr82ffhAqiIuAxYrnnlSfH4cAh+5
X-Received: by 10.67.6.1 with SMTP id cq1mr36744382pad.78.1448415147447;
        Tue, 24 Nov 2015 17:32:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id c1sm17377202pas.1.2015.11.24.17.32.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:32:27 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448415139-23675-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281674>

This passes each group to the `submodule update` invocation and
additionally configures the groups to be automatically updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 11 ++++++++
 builtin/clone.c             | 33 ++++++++++++++++++++--
 git-submodule.sh            |  5 ++++
 t/t7400-submodule-basic.sh  | 69 +++++++++++++++++++++++++++++++++++++++++++++
 t/t7406-submodule-update.sh | 32 +++++++++++++++++++++
 5 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 59d8c67..fbf68ab 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -209,6 +209,17 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--group::
+	After the clone is created, all submodules which are part of the
+	group are cloned. This option can be given multiple times to specify
+	different groups. This option will imply automatic submodule
+	updates for the groups by setting `submodule.update=groups`.
+	The group selection will be passed on recursively, i.e. if a submodule
+	is cloned because of group membership, its submodules will
+	be cloned according to group membership, too. If a submodule is
+	not cloned however, its submodules are not evaluated for group
+	membership.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index ce578d2..17e9f54 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,7 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list submodule_groups;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -95,6 +96,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST('g', "group", &submodule_groups, N_("group"),
+			N_("clone specific submodule groups")),
 	OPT_END()
 };
 
@@ -723,9 +726,18 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (err)
+		goto out;
+
+	if (option_recursive || submodule_groups.nr > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", "--init", NULL);
+
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
+
+		if (submodule_groups.nr > 0)
+			argv_array_pushf(&args, "--groups");
 
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
@@ -733,7 +745,7 @@ static int checkout(void)
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
-
+out:
 	return err;
 }
 
@@ -864,6 +876,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (option_recursive && submodule_groups.nr > 0)
+		die(_("submodule groups and recursive flag are incompatible"));
+	if (submodule_groups.nr > 0) {
+		int first_item = 1;
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, "submodule.groups=");
+		for_each_string_list_item(item, &submodule_groups) {
+			strbuf_addf(&sb, "%s%s", first_item ? "" : ",", item->string);
+			first_item = 0;
+		}
+		if (submodule_groups.nr > 0)
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 4092a48..e3d1667 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -611,6 +611,7 @@ cmd_deinit()
 #
 cmd_update()
 {
+	groups=
 	# parse $args after "submodule ... update".
 	while test $# -ne 0
 	do
@@ -650,6 +651,9 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--groups)
+			groups=1
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -691,6 +695,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${groups:+--groups} \
 		${jobs:+$jobs} \
 		"$@" | {
 	err=
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index caed4be..e8654d7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1049,4 +1049,73 @@ test_expect_success 'submodule init --group works' '
 	)
 '
 
+cat <<EOF > expected
+submodule
+-submodule1
+EOF
+
+test_expect_success 'submodule update --groups works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.groups groupA &&
+		git submodule init  &&
+		git submodule update --groups &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+test_expect_success 'submodule update --init --groups works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.groups groupA &&
+		git submodule update --init --groups &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+test_expect_success 'clone --group works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone --group groupA super super_clone &&
+	(
+		cd super_clone &&
+		test_pause
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 090891e..7e59846 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -801,4 +801,36 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+cat >expect <<-EOF &&
+-deeper/submodule
+-merging
+-moved/sub module
+-none
+-rebasing
+-submodule
+-submodule1
+EOF
+
+# none, merging rebasing, submodule1, submodule
+test_expect_success 'git clone works with submodule groups.' '
+	test_when_finished "rm -rf super5" &&
+	(
+		cd super &&
+		git config -f .gitmodules  submodule.submodule.groups default &&
+		git config -f .gitmodules  submodule.submodule1.groups "default,testing" &&
+		git config -f .gitmodules  submodule.none.groups testing &&
+		git commit -a -m "assigning groups to submodules"
+	) &&
+	git clone --group default --group testing super super5 &&
+	(
+		cd super5 &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git submodule update --groups' '
+	true
+'
+
 test_done
-- 
2.6.1.261.g0d9c4c1
