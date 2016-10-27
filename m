Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85ABC20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943049AbcJ0WjT (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:39:19 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33473 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943004AbcJ0WjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:39:16 -0400
Received: by mail-pf0-f181.google.com with SMTP id 197so25249835pfu.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mre3Yz0Qc8yJEfm5jyiPiLu6877yE2JDU2E6Ss5oQwI=;
        b=TzCELL1Eo29nk2HqQUN0aTQbwx39pQKfxJuY+gjFkb4o0QeDlDhUqq70CcUK4AN+jH
         9+LSmm9Wzpb2lvY0iUMfoR094hl7+Yo3aUZnmIIrMoasWtI1CtbwVOD1C4hZMo0DRmMX
         j2xax93LuTUp2QZA/cIDLOnJtxfndTqo+mjK12lkx9TarBKiZHzZU/H9j+akqBvn6afd
         mXhZ1zIOE6Lu1cBF810fDrJAb69Vmipg0Th7IEWBzWEeFNM23rrA4P1MazBAs+lH7nw3
         ucCLISEa8TnvuXgLPqB/Gj1xayG5QM4iNDfHTJlSQrtYDjAR9mZF8tVjTWY/beu7VLAK
         iYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mre3Yz0Qc8yJEfm5jyiPiLu6877yE2JDU2E6Ss5oQwI=;
        b=ch/j+xW8UT0l3C2ei8otYpO+Zjq5rdqMwVuRLA+M8gnYt/0KkVS5UT8WGMrDCRVedg
         hs8wqLeCogKItUbzuKpso5jCOxRukjM9QNIm5/bop3T+hOKeXc32yRGKI5QmlIUabTlA
         xacArFRIB4+S6lOqyGh+UNMasGgoUqDbNjHCMWN4Ewbvb89awdwO9OpDOrdYeCRg1HiK
         ztyQbU8Yn4sjbMdrCS/NDsqIIK2ODGqXYvIuFDlLRaK410xBupPDTdA35vdYMYW88+IH
         kOBfBIQaL2quml7A04C3tYOl/Uhm8w7K6oi2IwV+6jKJaHP7D5yikqik1XXCSF5gtDze
         xAUg==
X-Gm-Message-State: ABUngvdCPeef9gugPGL4b8b6987bbP9bQe0ldMstxsj2mEAhs87vAGKQwwAneaGmyi4aMIt9
X-Received: by 10.98.67.75 with SMTP id q72mr18641421pfa.99.1477607950483;
        Thu, 27 Oct 2016 15:39:10 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.37.191])
        by smtp.gmail.com with ESMTPSA id d2sm8129400pfd.38.2016.10.27.15.39.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 Oct 2016 15:39:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 5/5] grep: enable recurse-submodules to work on <tree> objects
Date:   Thu, 27 Oct 2016 15:38:34 -0700
Message-Id: <20161027223834.35312-6-bmwill@google.com>
X-Mailer: git-send-email 2.10.1.613.g6021889
In-Reply-To: <20161027223834.35312-1-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
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
`git grep -e. -l --recurse-submodules HEAD` from:
HEAD:file
<commit sha1 of submodule>:sub/file

to:
HEAD:file
HEAD:sub/file

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/git-grep.txt         | 13 ++++++--
 builtin/grep.c                     | 67 +++++++++++++++++++++++++++++++++++---
 t/t7814-grep-recurse-submodules.sh | 44 ++++++++++++++++++++++++-
 tree-walk.c                        | 17 +++++-----
 4 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 17aa1ba70..386a868c6 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -26,7 +26,7 @@ SYNOPSIS
 	   [--threads <num>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--recurse-submodules]
+	   [--recurse-submodules] [--parent-basename]
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
+--parent-basename::
+	For internal use only.  In order to produce uniform output with the
+	--recurse-submodules option, this option can be used to provide the
+	basename of a parent's <tree> object to a submodule so the submodule
+	can prefix its output with the parent's name rather than the SHA1 of
+	the submodule.
 
 -a::
 --text::
diff --git a/builtin/grep.c b/builtin/grep.c
index f34f16df9..bdf1b9089 100644
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
@@ -535,6 +537,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status, i;
+	const char *end_of_base;
 	struct work_item *w = opt->output_priv;
 
 	prepare_submodule_repo_env(&cp.env_array);
@@ -545,9 +548,36 @@ static int grep_submodule_launch(struct grep_opt *opt,
 			 gs->path);
 	argv_array_push(&cp.args, "grep");
 
+	/*
+	 * Add basename of parent project
+	 * When performing grep on a <tree> object the filename is prefixed
+	 * with the object's name: '<tree-name>:filename'.  In order to
+	 * provide uniformity of output we want to pass the name of the
+	 * parent project's object name to the submodule so the submodule can
+	 * prefix its output with the parent's name and not its own SHA1.
+	 */
+	end_of_base = strchr(gs->name, ':');
+	if (end_of_base)
+		argv_array_pushf(&cp.args, "--parent-basename=%.*s",
+				 (int) (end_of_base - gs->name),
+				 gs->name);
+
 	/* Add options */
-	for (i = 0; i < submodule_options.argc; i++)
+	for (i = 0; i < submodule_options.argc; i++) {
+		/*
+		 * If there is a <tree> identifier for the submodule, add the
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
@@ -672,12 +702,21 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	enum interesting match = entry_not_interesting;
 	struct name_entry entry;
 	int old_baselen = base->len;
+	struct strbuf name = STRBUF_INIT;
+	int name_base_len = 0;
+	if (super_prefix) {
+		name_base_len = strlen(super_prefix);
+		strbuf_addstr(&name, super_prefix);
+	}
 
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
 
 		if (match != all_entries_interesting) {
-			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
+			strbuf_setlen(&name, name_base_len);
+			strbuf_addstr(&name, base->buf + tn_len);
+			match = tree_entry_interesting(&entry, &name,
+						       0, pathspec);
 			if (match == all_entries_not_interesting)
 				break;
 			if (match == entry_not_interesting)
@@ -689,8 +728,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (S_ISREG(entry.mode)) {
 			hit |= grep_sha1(opt, entry.oid->hash, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
-		}
-		else if (S_ISDIR(entry.mode)) {
+		} else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
 			void *data;
@@ -706,12 +744,18 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
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
 
@@ -735,6 +779,10 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (!data)
 			die(_("unable to read tree (%s)"), oid_to_hex(&obj->oid));
 
+		/* Use parent's name as base when recursing submodules */
+		if (recurse_submodules && parent_basename)
+			name = parent_basename;
+
 		len = name ? strlen(name) : 0;
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
@@ -761,6 +809,12 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
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
@@ -901,6 +955,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    N_("ignore files specified via '.gitignore'"), 1),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
 			 N_("recursivley search in each submodule")),
+		OPT_STRING(0, "parent-basename", &parent_basename,
+			   N_("basename"),
+			   N_("prepend parent project's basename to output")),
 		OPT_GROUP(""),
 		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
@@ -1153,7 +1210,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (recurse_submodules && (!use_index || untracked || list.nr))
+	if (recurse_submodules && (!use_index || untracked))
 		die(_("option not supported with --recurse-submodules."));
 
 	if (!show_in_pager && !opt.status_only)
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index b670c70cb..3d1892dd7 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -84,6 +84,49 @@ test_expect_success 'grep and multiple patterns' '
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
+	git grep -e "bar" --recurse-submodules HEAD > actual &&
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
+	git grep -e "bar" --recurse-submodules HEAD^ > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree HEAD^^' '
+	cat >expect <<-\EOF &&
+	HEAD^^:a:foobar
+	HEAD^^:b/b:bar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD^^ > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep tree and pathspecs' '
+	cat >expect <<-\EOF &&
+	HEAD:submodule/a:foobar
+	HEAD:submodule/sub/a:foobar
+	EOF
+
+	git grep -e "bar" --recurse-submodules HEAD -- submodule > actual &&
+	test_cmp expect actual
+'
+
 test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
@@ -94,6 +137,5 @@ test_incompatible_with_recurse_submodules ()
 
 test_incompatible_with_recurse_submodules --untracked
 test_incompatible_with_recurse_submodules --no-index
-test_incompatible_with_recurse_submodules HEAD
 
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 828f4356b..b3f996174 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -999,10 +999,11 @@ static enum interesting do_match(const struct name_entry *entry,
 					return entry_interesting;
 
 				/*
-				 * Match all directories. We'll try to
-				 * match files later on.
+				 * Match all directories and gitlinks. We'll
+				 * try to match files later on.
 				 */
-				if (ps->recursive && S_ISDIR(entry->mode))
+				if (ps->recursive && (S_ISDIR(entry->mode) ||
+						      S_ISGITLINK(entry->mode)))
 					return entry_interesting;
 			}
 
@@ -1043,13 +1044,13 @@ static enum interesting do_match(const struct name_entry *entry,
 		strbuf_setlen(base, base_offset + baselen);
 
 		/*
-		 * Match all directories. We'll try to match files
-		 * later on.
-		 * max_depth is ignored but we may consider support it
-		 * in future, see
+		 * Match all directories and gitlinks. We'll try to match files
+		 * later on.  max_depth is ignored but we may consider support
+		 * it in future, see
 		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/focus=163840
 		 */
-		if (ps->recursive && S_ISDIR(entry->mode))
+		if (ps->recursive && (S_ISDIR(entry->mode) ||
+				      S_ISGITLINK(entry->mode)))
 			return entry_interesting;
 	}
 	return never_interesting; /* No matches */
-- 
2.10.1.613.g6021889

