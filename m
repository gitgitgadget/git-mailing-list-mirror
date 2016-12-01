Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354CF1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933529AbcLAB3F (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:29:05 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34455 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933344AbcLAB3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:29:03 -0500
Received: by mail-pg0-f43.google.com with SMTP id x23so88322145pgx.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aALw8qSM6tAda+nJxIV53K2sRQiQ37xJ+EwzTR3vyhk=;
        b=UZFJDUp3qTAJWe89hWLYSzpvowYSDM7fAcX/z1W8QG8lC9rZHKOq2CW/M/kLS20Xak
         LrdWZfgK/WDhHnpKLRbVieWpWE3Pu+iIiociyw02uyHHaa/vRmrGUDVBsBDyFpYMvJEB
         i7sC9yClcOzdABvz9Htfb6YrA7xonZEt5Tn5gsziyi7H0oE+1aUs4Jg+ZA0EV9XilnBp
         oszqaJSswGJ8f5h227zYXq+f7P52jz5Qol/uxPl/hp1Ewl5Fuq9WNHPjx/7OtsIW5mG/
         m/zVP7W4fXNkttYE9BIxiFdPQX23WJ0DeZDeIU36YVyvItrPZSgBF3AfwBy/QASr95fT
         zFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aALw8qSM6tAda+nJxIV53K2sRQiQ37xJ+EwzTR3vyhk=;
        b=fQHebj4gbJMIvpfA3usXmSBqd/NM+tX1yd1uuHFJ/DzkaE3Vg5kRvKaN26qGsLdSkH
         k5s9OqqZhFHPPkFSYpgF00APbzC43NyUULrKst+eQIt5O6PihEd8WpNd9vhLa/Z9kseh
         1/jX7LHCsYncx568JWoTaawN6TpvH881WrRPB41OYUbx3HknZT6cl5zZUq0Z3vcTaeGV
         4VECrqkuvEXZuBQu1bRus69/N0X+kdG079MbqYofh3ZE3tQdWCAaitGdRmocx1G4Dwyu
         AU1UzLmO44JR4oZm3f10w81h3MNa5EIaagtdwFm1lpnWx+P0giyR4lJToh9bw2DpNmYu
         inBQ==
X-Gm-Message-State: AKaTC013HmTAHhUQNs61ks52SwFPTPyTJL76OVroSbVAl7HtObfF1XUtTvfgxF7z8eZmOOUq
X-Received: by 10.84.217.18 with SMTP id o18mr80008737pli.45.1480555732427;
        Wed, 30 Nov 2016 17:28:52 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id i194sm87872386pgc.46.2016.11.30.17.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:28:51 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v6 5/6] grep: enable recurse-submodules to work on <tree> objects
Date:   Wed, 30 Nov 2016 17:28:33 -0800
Message-Id: <1480555714-186183-6-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480555714-186183-1-git-send-email-bmwill@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach grep to recursively search in submodules when provided with a
<tree> object. This allows grep to search a submodule based on the state
of the submodule that is present in a commit of the super project.

When grep is provided with a <tree> object, the name of the object is
prefixed to all output.  In order to provide uniformity of output
between the parent and child processes the option `--parent-basename`
has been added so that the child can preface all of it's output with the
name of the parent's object instead of the name of the commit SHA1 of
the submodule. This changes output from the command
`git grep -e. -l --recurse-submodules HEAD`

from:
  HEAD:file
  <commit sha1 of submodule>:sub/file

to:
  HEAD:file
  HEAD:sub/file

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-grep.txt         |  13 ++++-
 builtin/grep.c                     |  76 ++++++++++++++++++++++++---
 t/t7814-grep-recurse-submodules.sh | 103 ++++++++++++++++++++++++++++++++++++-
 tree-walk.c                        |  28 ++++++++++
 4 files changed, 211 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 17aa1ba..71f32f3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -26,7 +26,7 @@ SYNOPSIS
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--recurse-submodules]
+	   [--recurse-submodules] [--parent-basename <basename>]
 	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
 
@@ -91,7 +91,16 @@ OPTIONS
 
 --recurse-submodules::
 	Recursively search in each submodule that has been initialized and
-	checked out in the repository.
+	checked out in the repository.  When used in combination with the
+	<tree> option the prefix of all submodule output will be the name of
+	the parent project's <tree> object.
+
+--parent-basename <basename>::
+	For internal use only.  In order to produce uniform output with the
+	--recurse-submodules option, this option can be used to provide the
+	basename of a parent's <tree> object to a submodule so the submodule
+	can prefix its output with the parent's name rather than the SHA1 of
+	the submodule.
 
 -a::
 --text::
diff --git a/builtin/grep.c b/builtin/grep.c
index dca0be6..5918a26 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "pathspec.h"
 #include "submodule.h"
+#include "submodule-config.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -28,6 +29,7 @@ static char const * const grep_usage[] = {
 static const char *super_prefix;
 static int recurse_submodules;
 static struct argv_array submodule_options = ARGV_ARRAY_INIT;
+static const char *parent_basename;
 
 static int grep_submodule_launch(struct grep_opt *opt,
 				 const struct grep_source *gs);
@@ -534,19 +536,53 @@ static int grep_submodule_launch(struct grep_opt *opt,
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status, i;
+	const char *end_of_base;
+	const char *name;
 	struct work_item *w = opt->output_priv;
 
+	end_of_base = strchr(gs->name, ':');
+	if (gs->identifier && end_of_base)
+		name = end_of_base + 1;
+	else
+		name = gs->name;
+
 	prepare_submodule_repo_env(&cp.env_array);
 
 	/* Add super prefix */
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
-			 gs->name);
+			 name);
 	argv_array_push(&cp.args, "grep");
 
+	/*
+	 * Add basename of parent project
+	 * When performing grep on a tree object the filename is prefixed
+	 * with the object's name: 'tree-name:filename'.  In order to
+	 * provide uniformity of output we want to pass the name of the
+	 * parent project's object name to the submodule so the submodule can
+	 * prefix its output with the parent's name and not its own SHA1.
+	 */
+	if (gs->identifier && end_of_base)
+		argv_array_pushf(&cp.args, "--parent-basename=%.*s",
+				 (int) (end_of_base - gs->name),
+				 gs->name);
+
 	/* Add options */
-	for (i = 0; i < submodule_options.argc; i++)
+	for (i = 0; i < submodule_options.argc; i++) {
+		/*
+		 * If there is a tree identifier for the submodule, add the
+		 * rev after adding the submodule options but before the
+		 * pathspecs.  To do this we listen for the '--' and insert the
+		 * sha1 before pushing the '--' onto the child process argv
+		 * array.
+		 */
+		if (gs->identifier &&
+		    !strcmp("--", submodule_options.argv[i])) {
+			argv_array_push(&cp.args, sha1_to_hex(gs->identifier));
+		}
+
 		argv_array_push(&cp.args, submodule_options.argv[i]);
+	}
 
 	cp.git_cmd = 1;
 	cp.dir = gs->path;
@@ -673,12 +709,22 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	enum interesting match = entry_not_interesting;
 	struct name_entry entry;
 	int old_baselen = base->len;
+	struct strbuf name = STRBUF_INIT;
+	int name_base_len = 0;
+	if (super_prefix) {
+		strbuf_addstr(&name, super_prefix);
+		name_base_len = name.len;
+	}
 
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
 
 		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
+			strbuf_addstr(&name, base->buf + tn_len);
+			match = tree_entry_interesting(&entry, &name,
+						       0, pathspec);
+			strbuf_setlen(&name, name_base_len);
+
 			if (match == all_entries_not_interesting)
 				break;
 			if (match == entry_not_interesting)
@@ -690,8 +736,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (S_ISREG(entry.mode)) {
 			hit |= grep_sha1(opt, entry.oid->hash, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
-		}
-		else if (S_ISDIR(entry.mode)) {
+		} else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
@@ -707,12 +752,18 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
 					 check_attr);
 			free(data);
+		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
+			hit |= grep_submodule(opt, entry.oid->hash, base->buf,
+					      base->buf + tn_len);
 		}
+
 		strbuf_setlen(base, old_baselen);
 
 		if (hit && opt->status_only)
 			break;
 	}
+
+	strbuf_release(&name);
 	return hit;
 }
 
@@ -736,6 +787,10 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
 
+		/* Use parent's name as base when recursing submodules */
+		if (recurse_submodules && parent_basename)
+			name = parent_basename;
+
 		len = name ? strlen(name) : 0;
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
@@ -762,6 +817,12 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 		real_obj = deref_tag(list->objects[i].item, NULL, 0);
+
+		/* load the gitmodules file for this rev */
+		if (recurse_submodules) {
+			submodule_free();
+			gitmodules_config_sha1(real_obj->oid.hash);
+		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].path)) {
 			hit = 1;
 			if (opt->status_only)
@@ -902,6 +963,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    N_("ignore files specified via '.gitignore'"), 1),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
 			 N_("recursivley search in each submodule")),
+		OPT_STRING(0, "parent-basename", &parent_basename,
+			   N_("basename"),
+			   N_("prepend parent project's basename to output")),
 		OPT_GROUP(""),
 		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
@@ -1154,7 +1218,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (recurse_submodules && (!use_index || untracked || list.nr))
+	if (recurse_submodules && (!use_index || untracked))
 		die(_("option not supported with --recurse-submodules."));
 
 	if (!show_in_pager && !opt.status_only)
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 1019125..9e93fe7 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -84,6 +84,108 @@ test_expect_success 'grep and multiple patterns' '
 	test_cmp expect actual
 '
 
+test_expect_success 'basic grep tree' '
+	cat >expect <<-\EOF &&
+	HEAD:a:foobar
+	HEAD:b/b:bar
+	HEAD:submodule/a:foobar
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree HEAD^' '
+	cat >expect <<-\EOF &&
+	HEAD^:a:foobar
+	HEAD^:b/b:bar
+	HEAD^:submodule/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD^ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree HEAD^^' '
+	cat >expect <<-\EOF &&
+	HEAD^^:a:foobar
+	HEAD^^:b/b:bar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD^^ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/a:foobar
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- submodule >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/a:foobar
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- "submodule*a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and more pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- "submodul?/a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and more pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- "submodul*/sub/a" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep recurse submodule colon in name' '
+	git init parent &&
+	test_when_finished "rm -rf parent" &&
+	echo "foobar" >"parent/fi:le" &&
+	git -C parent add "fi:le" &&
+	git -C parent commit -m "add fi:le" &&
+
+	git init "su:b" &&
+	test_when_finished "rm -rf su:b" &&
+	echo "foobar" >"su:b/fi:le" &&
+	git -C "su:b" add "fi:le" &&
+	git -C "su:b" commit -m "add fi:le" &&
+
+	git -C parent submodule add "../su:b" "su:b" &&
+	git -C parent commit -m "add submodule" &&
+
+	cat >expect <<-\EOF &&
+	fi:le:foobar
+	su:b/fi:le:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	HEAD:fi:le:foobar
+	HEAD:su:b/fi:le:foobar
+	EOF
+	git -C parent grep -e "foobar" --recurse-submodules HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
@@ -94,6 +196,5 @@ test_incompatible_with_recurse_submodules ()
 
 test_incompatible_with_recurse_submodules --untracked
 test_incompatible_with_recurse_submodules --no-index
-test_incompatible_with_recurse_submodules HEAD
 
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 828f435..ff77605 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1004,6 +1004,19 @@ static enum interesting do_match(const struct name_entry *entry,
 				 */
 				if (ps->recursive && S_ISDIR(entry->mode))
 					return entry_interesting;
+
+				/*
+				 * When matching against submodules with
+				 * wildcard characters, ensure that the entry
+				 * at least matches up to the first wild
+				 * character.  More accurate matching can then
+				 * be performed in the submodule itself.
+				 */
+				if (ps->recursive && S_ISGITLINK(entry->mode) &&
+				    !ps_strncmp(item, match + baselen,
+						entry->path,
+						item->nowildcard_len - baselen))
+					return entry_interesting;
 			}
 
 			continue;
@@ -1040,6 +1053,21 @@ static enum interesting do_match(const struct name_entry *entry,
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
+
+		/*
+		 * When matching against submodules with
+		 * wildcard characters, ensure that the entry
+		 * at least matches up to the first wild
+		 * character.  More accurate matching can then
+		 * be performed in the submodule itself.
+		 */
+		if (ps->recursive && S_ISGITLINK(entry->mode) &&
+		    !ps_strncmp(item, match, base->buf + base_offset,
+				item->nowildcard_len)) {
+			strbuf_setlen(base, base_offset + baselen);
+			return entry_interesting;
+		}
+
 		strbuf_setlen(base, base_offset + baselen);
 
 		/*
-- 
2.8.0.rc3.226.g39d4020

