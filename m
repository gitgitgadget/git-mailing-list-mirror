From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] clone: add --init-submodule=<pathspec> switch
Date: Fri, 20 May 2016 17:28:11 -0700
Message-ID: <20160521002811.24656-3-sbeller@google.com>
References: <20160521002811.24656-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat May 21 02:28:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3umO-0001EE-RC
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 02:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbcEUA2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 20:28:24 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35582 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbcEUA2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 20:28:23 -0400
Received: by mail-pa0-f42.google.com with SMTP id tb2so27038853pac.2
        for <git@vger.kernel.org>; Fri, 20 May 2016 17:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Td46qWAG/7FeMEmjIGm22mhXTNiyG7/kJ6EzFVbR5OY=;
        b=epgD5kBXIEBzsT5HX2o+QhrEHG3ieaq551Ik+0EauvdeRsPSvD5MyVptGN/XytJxxp
         kPRW2jNb+dFQVUfeO2OaKgIZRV64a2os8ZPlX37TRXdTHafNqi9b9IgS+lhhHmEmbgI5
         RRNMCjfTmaxVkrEsXO6Yz0NRquaTO3Lb4qzMyF2UBEPr4sV98iW2IaZ07uHs8cQBZ/iR
         IvukplmZztmZjSwzDC6kWdbkuRzfdwwDghXsFXazuECMochFlTc/Wz/OKik39tg/zEZF
         xcK3PedfYDi197zZQrfamtpZc/wi3NtmHbkYM6mzaAonaoSf5rtlPseA+53gq+i5K/lZ
         0JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Td46qWAG/7FeMEmjIGm22mhXTNiyG7/kJ6EzFVbR5OY=;
        b=UYk9AV014WTbVc9yg68BqTiUf3kJDyG5YcG1+LyLIyeMcBkEgYyWqrRshGT1DTJdf9
         0k9JgryUPDsN0pcWMG5J2XhBsb7b01eBl7aD4QGvAV5N0c4uUyJ3xy/uy9SZDirnFtmt
         8J5wZL/EZmzrrR/jQn0qtFqFA3nLLsfmRjNC3QUfjYfzlXzQqXIolioXqOjkGHtle+Dw
         VpvdLfLme9Xu0PFqghkVwZeLIFsnSXWjeud+e7kN43e4onOprlP2nLekUP1+5WKlivYc
         QsSU7Yt+LD052OX7slJTC7GkxgcIuvQN7Hn8BvQrhYfV0YhNQCldVFTkemP4TQsiJsFa
         Qqww==
X-Gm-Message-State: AOPr4FU+BF9t3DWMtBmY5Ra1YE5zbj0cRZPumE/WvU6VlxjVvCsVKLxoAmCJWFRFLkCJyR8E
X-Received: by 10.66.153.209 with SMTP id vi17mr8994806pab.0.1463790501600;
        Fri, 20 May 2016 17:28:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:104:6ffe:257d:9a11])
        by smtp.gmail.com with ESMTPSA id i6sm29720928pfc.65.2016.05.20.17.28.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 May 2016 17:28:21 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.396.g3aebe0e
In-Reply-To: <20160521002811.24656-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295222>

The new switch passes the pathspec to `git submodule update --init`
which is called after the actual clone is done.

Additionally this configures the submodule.defaultUpdatePath to
be the given pathspec, such that any future invocation of
`git submodule update --init-default-paths` will keep up
with the pathspec.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 25 +++++++++-----
 builtin/clone.c             | 34 +++++++++++++++++--
 t/t7400-submodule-basic.sh  | 81 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 1b15cd7..33e5894 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,8 +14,9 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
-	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
-	  [--jobs <n>] [--] <repository> [<directory>]
+	  [--recursive | --recurse-submodules] [--jobs <n>]
+	  [--init-submodule <submodulespec>] [--] <repository>
+	  [<directory>]
 
 DESCRIPTION
 -----------
@@ -207,12 +208,20 @@ objects from the source repository into a pack in the cloned repository.
 
 --recursive::
 --recurse-submodules::
-	After the clone is created, initialize all submodules within,
-	using their default settings. This is equivalent to running
-	`git submodule update --init --recursive` immediately after
-	the clone is finished. This option is ignored if the cloned
-	repository does not have a worktree/checkout (i.e. if any of
-	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+	After the clone is created, initialize and clone all submodules
+	within, using their default settings. This is equivalent to
+	running `git submodule update --recursive --init `
+	immediately after the clone is finished. This option is ignored
+	if the cloned repository does not have a worktree/checkout (i.e.
+	if any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+
+--init-submodule::
+	After the clone is created, initialize and clone specified
+	submodules within, using their default settings. It is possible
+	to give multiple specifications by giving this argument multiple
+	times. This is equivalent to configure `submodule.defaultUpdateGroup`
+	and then running `git submodule update --init-default-path`
+	immediately after the clone is finished.
 
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
diff --git a/builtin/clone.c b/builtin/clone.c
index 5f867e6..56967f9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -53,6 +53,16 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list init_submodules;
+
+static int init_submodules_cb(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		return -1;
+
+	string_list_append((struct string_list *)opt->value, arg);
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -103,6 +113,9 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_CALLBACK(0, "init-submodule", &init_submodules, N_("<pathspec>"),
+			N_("clone specific submodules. Pass ultiple times for complex pathspecs"),
+			init_submodules_cb),
 	OPT_END()
 };
 
@@ -734,14 +747,22 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (!err && (option_recursive || init_submodules.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		if (init_submodules.nr > 0)
+			argv_array_pushf(&args, "--init-default-path");
+		else
+			argv_array_pushf(&args, "--init");
 
 		if (option_shallow_submodules == 1
 		    || (option_shallow_submodules == -1 && option_depth))
 			argv_array_push(&args, "--depth=1");
 
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
+
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
@@ -883,6 +904,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.defaultUpdatePath=%s", item->string);
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 4173c72..af5d0ce 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1170,4 +1170,85 @@ test_expect_success 'submodule update --init-default-path' '
 	test_cmp expect actual
 '
 
+cat <<EOF > expected
+ sub0 (test2)
+-sub1
+-sub2
+-sub3
+EOF
+
+test_expect_success 'clone --init-submodule works' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules --init-submodule="sub0" multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c 1,43- >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expect
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+test_expect_success 'clone with multiple --init-submodule options' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules \
+		  --init-submodule="." \
+		  --init-submodule ":(exclude)sub0" \
+		  --init-submodule ":(exclude)sub2" \
+			multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat <<EOF > expect
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+EOF
+
+cat <<EOF > expect2
+-sub0
+ sub1 (test2)
+-sub2
+ sub3 (test2)
+-sub4
+ sub5 (test2)
+EOF
+
+test_expect_success 'clone and subsequent updates correctly auto-initialize submodules' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules --init-submodule="." \
+				       --init-submodule ":(exclude)sub0" \
+				       --init-submodule ":(exclude)sub2" \
+				       --init-submodule ":(exclude)sub4" \
+				       multisuper multisuper_clone &&
+	(
+		cd multisuper_clone &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect actual &&
+	(
+		cd multisuper &&
+		git submodule add ../sub1 sub4 &&
+		git submodule add ../sub1 sub5 &&
+		git commit -m "add more submodules"
+	) &&
+	(
+		cd multisuper_clone &&
+		# obtain the new superproject
+		git pull &&
+		git submodule update --init-default-path &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp expect2 actual
+'
+
 test_done
-- 
2.8.3.395.ga2acc22.dirty
