From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] builtin/clone: support submodule groups
Date: Tue, 19 Jan 2016 19:34:40 -0800
Message-ID: <1453260880-628-5-git-send-email-sbeller@google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 04:35:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjXz-0004hG-P0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935044AbcATDe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:34:57 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34153 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933912AbcATDeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:34:50 -0500
Received: by mail-pf0-f169.google.com with SMTP id q63so192075435pfb.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 19:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JLMeuIXQQeN34POqGAAO5rIYW33c9hZG+Jm0WhxHpPs=;
        b=U23VBICK5/t2s8rH84wrm9fpP+GBUQbGYH3JXujipdGPi2iHEOE5Q/lccIC1t/KN43
         m8BcgzRi8xMt6Y1VU9H2HKlq+rfD0BzW1CunT6so8exi40g28Epj5KM4Uvt3p1OFoEA+
         bKmQfOaiOFOElyB645jhedLn0giuzDinsDsg8ix6UxIwsV79tptrL5IcPveU+8wwUKsW
         fFb17pU4zzGFb9I0890v8MCas56A0kUUThgq8cjSMksUmJnJWDzi+pzr79LJuFdrec04
         QWdP4PCtPv8cyMW9XB4Pouv5k9g2vM0RwzSbQ1Qh6c3ccVOI99s8M/rvQMZtzMi/+y7Z
         VjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JLMeuIXQQeN34POqGAAO5rIYW33c9hZG+Jm0WhxHpPs=;
        b=J1YKSwPY1j2t/+R5zsR+rMtNuvydd9gi3250Wwob4im9antZq1ySeGkYlHbkxd8C+/
         qdIzVVnstc5ImS4Pnm5arwDw3dtqXcvRMrQWBZV1mksx4x6+MUHmn+Xm03tWqDXjRuGj
         L2cfhkGqtfkqqxDHJMklheqpLsqzORL3MXcv7h5d0DSaawUnnUXGhoHbGi3+jfYZDMPr
         Fp0LI6NMgIRfDmKeW3CZGnpzgf8FtituDSwVdkWnKz4A76B7fAUV7i8YDYF6S7u7UTQh
         D1qu/qybm361rqgEHrBfgoGEgGEBqCite1qhSuqGMQg5oFApLqlNb2LTkv7a+/TAunNl
         rW9Q==
X-Gm-Message-State: ALoCoQkccj8hjcZmnRzDt18IIrucYtnXfvE+NYICP5fyrI1HdOJnFwIxA5ze4DIVA94XTpddhtRZChg6yejIvR6q7bORoxHfSA==
X-Received: by 10.98.44.66 with SMTP id s63mr49603687pfs.2.1453260889000;
        Tue, 19 Jan 2016 19:34:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id f16sm44695097pff.18.2016.01.19.19.34.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 19:34:48 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
In-Reply-To: <1453260880-628-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284424>

When invocing clone with the groups option,
the repository will be configured to the specified groups.
This has implications for the submodule commands, such as
update.

Having groups configured will imply init for all uninitialized
submodules belonging to at least one of the configured groups,
such that new submodules in the group are initialized
automatically.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 13 +++++++++++
 builtin/clone.c             | 46 +++++++++++++++++++++++++++++++++++---
 t/t7400-submodule-basic.sh  | 54 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6db7b6d..685fb7c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -214,6 +214,19 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--group::
+	After the clone is created, all submodules which are part of the
+	given groups are cloned. To specify multiple groups, you can either
+	give the group argument multiple times or comma separate the groups.
+	This option will be recorded in the `submodule.groups` config,
+	which will affect the behavior of other submodule related commands,
+	such as `git submodule update`.
+	This option implies recursive submodule checkout. If you don't
+	want to recurse into nested submodules, you need to specify
+	`--no-recursive`. The group selection will be passed on recursively,
+	i.e. if a submodule is cloned because of group membership, its
+	submodules will be cloned according to group membership, too.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index b004fb4..72aea3a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,22 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list submodule_groups;
+
+static int groups_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct string_list_item *item;
+	struct string_list sl = STRING_LIST_INIT_DUP;
+
+	if (unset)
+		return -1;
+
+	string_list_split(&sl, arg, ',', -1);
+	for_each_string_list_item(item, &sl)
+		string_list_append((struct string_list *)opt->value, item->string);
+
+	return 0;
+}
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -95,6 +111,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_CALLBACK('g', "group", &submodule_groups, N_("string"),
+			N_("clone specific submodule groups"), groups_cb),
 	OPT_END()
 };
 
@@ -723,9 +741,17 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (err)
+		goto out;
+
+	if (option_recursive || submodule_groups.nr > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", NULL);
+
+		if (option_recursive) {
+			argv_array_pushf(&args, "--init");
+			argv_array_pushf(&args, "--recursive");
+		}
 
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
@@ -733,7 +759,7 @@ static int checkout(void)
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
-
+out:
 	return err;
 }
 
@@ -867,6 +893,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout = 1;
 	}
+	if (option_recursive == -1) {
+		if (submodule_groups.nr > 0)
+			option_recursive = 1; /* submodule groups implies recursive */
+		else
+			option_recursive = 0; /* preserve historical default */
+	}
+	if (submodule_groups.nr > 0) {
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		for_each_string_list_item(item, &submodule_groups) {
+			strbuf_addf(&sb, "submodule.groups=%s", item->string);
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+		}
+	}
 
 	if (!option_origin)
 		option_origin = "origin";
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e6a008c..5ed5250 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1058,4 +1058,58 @@ test_expect_success 'submodule update works with groups implied' '
 	test_cmp actual expected
 '
 
+cat <<EOF > expected
+submodule
+-submodule1
+EOF
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
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+cat <<EOF > expected
+-submodule1
+submoduleA
+submoduleB
+submoduleC
+-submoduleD
+EOF
+
+test_expect_success 'clone with multiple groups works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submoduleA &&
+		git submodule add --group groupB file://"$pwd"/example2 submoduleB &&
+		git submodule add --group groupC file://"$pwd"/example2 submoduleC &&
+		git submodule add --group groupD file://"$pwd"/example2 submoduleD &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with submodules groups"
+	) &&
+	git clone --group groupA,groupB --group groupC super super_clone &&
+	(
+		cd super_clone &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
 test_done
-- 
2.7.0.rc0.41.g89994f2.dirty
