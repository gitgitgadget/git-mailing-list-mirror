From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] clone: add --init-submodule=<pathspec> switch
Date: Fri, 10 Jun 2016 16:07:52 -0700
Message-ID: <20160610230753.11641-3-sbeller@google.com>
References: <20160610230753.11641-1-sbeller@google.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 11 01:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBVXU-0008Tx-Tv
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 01:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbcFJXIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 19:08:22 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36165 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbcFJXIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 19:08:21 -0400
Received: by mail-pf0-f181.google.com with SMTP id t190so27322010pfb.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3jP+9LeoXT4eQ/Bnxis2vlgFgZDap1gaNZHxK5602yw=;
        b=e8/OfUMB9cKZGYBaZ/vqZArqoSq+3+lOeC49bhiSuCSvczFZ6h23PkQS5CZJPsDxVR
         11elC2IW5E3KnwRCE7wt1V2sWt0/3POebrFKxadagqEURD1qpr3otv5vuByDb520x/tc
         xKD/UXhPMg8tjwXFWL3S2oKYI4ukHvOgOKhYaZYnh/PoDKlMJWLkX1GNuIU/W/f/APzw
         kXYc7SGXNTu0zmNJXzh/bbOkVbkkBZGVHJ8PsNAf04B3i+k6nZLAHZqeBbfJVEfPoHGn
         T0BleF+zD6Fe8+jyPjuKBcBog255HHOkc2E/WVZu39bzP85btakPtp5PCNDPB10XIvCy
         OMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3jP+9LeoXT4eQ/Bnxis2vlgFgZDap1gaNZHxK5602yw=;
        b=eWeHgMLRTur1Fat7gMliW3BHQYbVlf7ihupfITtI2Dasow24DhykB4Rc1FTcY6q9sK
         T2/UL/ujQa56MLEgPdG1FBYefBflYeAxI27BF3NWIxEtssOI0hqKi9suTlEt5x6rw6G/
         BsKvZVtkQFx5wNwKJAhxuOP6QS0Mg9Wzu4m2Revzva60ryyoBT9YGMRiR7n5q4qfZkSQ
         +pHUNDmrwxyBxsUsVry1bXpEYlWwdkfoA0JH0eV9xMTbDDR7n0VlXPaGlVqXZl7BcWu2
         UAjumeZhltB/Dv/Om1wRmouxNTpoACfpCQagsnMeqvSs4jCaSuZfe65pQt6hc13fgjXA
         f5gw==
X-Gm-Message-State: ALyK8tLV4Iqzrlib1DCU+pjcDpN2VwxB7q1cBchvhQ2FqdbpGB1tEd2FV3ZKnhV4F/UFStXw
X-Received: by 10.98.69.81 with SMTP id s78mr4739805pfa.63.1465600099945;
        Fri, 10 Jun 2016 16:08:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2099:4ff:ce85:68a])
        by smtp.gmail.com with ESMTPSA id l67sm20172936pfi.10.2016.06.10.16.08.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 16:08:19 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.141.g4e46f88
In-Reply-To: <20160610230753.11641-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297084>

The new switch passes the pathspec to `git submodule update --init`
which is called after the actual clone is done.

Additionally this configures the submodule.defaultUpdatePath to
be the given pathspec, such that any future invocation of
`git submodule update --init-default-paths` will keep up
with the pathspec.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 23 +++++++++----
 builtin/clone.c             | 36 ++++++++++++++++++--
 t/t7400-submodule-basic.sh  | 81 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 1b15cd7..be05a87 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -15,7 +15,8 @@ SYNOPSIS
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
-	  [--jobs <n>] [--] <repository> [<directory>]
+	  [--init-submodule <pathspec>] [--jobs <n>] [--]
+	  <repository> [<directory>]
 
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
index 5f867e6..368014e 100644
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
+			N_("clone specific submodules. Pass multiple times for complex pathspecs"),
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
 
@@ -883,6 +904,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (init_submodules.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &init_submodules) {
+			strbuf_addf(&sb, "submodule.defaultUpdatePath=%s",
+				    item->string);
+			string_list_append(&option_config,
+					   strbuf_detach(&sb, NULL));
+		}
+	}
+
 	if (!option_origin)
 		option_origin = "origin";
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f126fcc..011129e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1132,4 +1132,85 @@ test_expect_success 'submodule update --init-default-path' '
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
2.8.2.141.g4e46f88
