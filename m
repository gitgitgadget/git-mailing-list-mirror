Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D1820282
	for <e@80x24.org>; Tue, 13 Jun 2017 09:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbdFMJYT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 05:24:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:38921 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbdFMJYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 05:24:16 -0400
Received: (qmail 21302 invoked by uid 109); 13 Jun 2017 09:24:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 09:24:10 +0000
Received: (qmail 21922 invoked by uid 111); 13 Jun 2017 09:24:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 05:24:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 05:24:08 -0400
Date:   Tue, 13 Jun 2017 05:24:08 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 1/2] add: warn when adding an embedded repository
Message-ID: <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's an easy mistake to add a repository inside another
repository, like:

  git clone $url
  git add .

The resulting entry is a gitlink, but there's no matching
.gitmodules entry. Trying to use "submodule init" (or clone
with --recursive) doesn't do anything useful. Prior to
v2.13, such an entry caused git-submodule to barf entirely.
In v2.13, the entry is considered "inactive" and quietly
ignored. Either way, no clone of your repository can do
anything useful with the gitlink without the user manually
adding the submodule config.

In most cases, the user probably meant to either add a real
submodule, or they forgot to put the embedded repository in
their .gitignore file.

Let's issue a warning when we see this case. There are a few
things to note:

  - the warning will go in the git-add porcelain; anybody
    wanting to do low-level manipulation of the index is
    welcome to create whatever funny states they want.

  - we detect the case by looking for a newly added gitlink;
    updates via "git add submodule" are perfectly reasonable,
    and this avoids us having to investigate .gitmodules
    entirely

  - there's a command-line option to suppress the warning.
    This is needed for git-submodule itself (which adds the
    entry before adding any submodule config), but also
    provides a mechanism for other scripts doing
    submodule-like things.

We could make this a hard error instead of a warning.
However, we do add lots of sub-repos in our test suite. It's
not _wrong_ to do so. It just creates a state where users
may be surprised. Pointing them in the right direction with
a gentle hint is probably the best option.

There is a config knob that can disable the (long) hint. But
I intentionally omitted a config knob to disable the warning
entirely. Whether the warning is sensible or not is
generally about context, not about the user's preferences.
If there's a tool or workflow that adds gitlinks without
matching .gitmodules, it should probably be taught about the
new command-line option, rather than blanket-disabling the
warning.

Signed-off-by: Jeff King <peff@peff.net>
---
The check for "is this a gitlink" is done by looking for a
trailing "/" in the added path. This feels kind of hacky,
but actually seems to work well in practice. We've already
expanded the pathspecs to real filenames via dir.c, and that
omits trees. So anything with a trailing slash must be a
gitlink.

And I really didn't want to incur any extra cost in the
common case here (e.g., checking for "path/.git"). We could
do it at zero-cost by pushing the check much further down
(i.e., when we'd realize anyway that it's a gitlink), but I
didn't want to pollute read-cache.c with what is essentially
a porcelain warning. The actual check done there seems to be
checking S_ISDIR, but I didn't even want to incur an extra
stat per-file.

I also waffled on whether we should ask the submodule code
whether it knows about a particular path. Technically:

  git config submodule.foo.path foo
  git config submodule.foo.url git://...
  git add foo

is legal, but would still warn with this patch. I don't know
how much we should care (it would also be easy to do on
top).

 Documentation/config.txt      |  3 +++
 Documentation/git-add.txt     |  7 +++++++
 advice.c                      |  2 ++
 advice.h                      |  1 +
 builtin/add.c                 | 45 ++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh              |  5 +++--
 t/t7414-submodule-mistakes.sh | 40 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 100 insertions(+), 3 deletions(-)
 create mode 100755 t/t7414-submodule-mistakes.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd4beec39..e909239bc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -348,6 +348,9 @@ advice.*::
 	rmHints::
 		In case of failure in the output of linkgit:git-rm[1],
 		show directions on how to proceed from the current state.
+	addEmbeddedRepo::
+		Advice on what to do when you've accidentally added one
+		git repo inside of another.
 --
 
 core.fileMode::
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 7ed63dce0..f4169fb1e 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -165,6 +165,13 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
+--no-warn-embedded-repo::
+	By default, `git add` will warn when adding an embedded
+	repository to the index without using `git submodule add` to
+	create an entry in `.gitmodules`. This option will suppress the
+	warning (e.g., if you are manually performing operations on
+	submodules).
+
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
diff --git a/advice.c b/advice.c
index b84ae4960..e0611d52b 100644
--- a/advice.c
+++ b/advice.c
@@ -15,6 +15,7 @@ int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
 int advice_rm_hints = 1;
+int advice_add_embedded_repo = 1;
 
 static struct {
 	const char *name;
@@ -35,6 +36,7 @@ static struct {
 	{ "setupstreamfailure", &advice_set_upstream_failure },
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
+	{ "addembeddedrepo", &advice_add_embedded_repo },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index b341a55ce..c84a44531 100644
--- a/advice.h
+++ b/advice.h
@@ -18,6 +18,7 @@ extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
+extern int advice_add_embedded_repo;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/add.c b/builtin/add.c
index d9a2491e4..ea88db281 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -249,6 +249,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
+static int warn_on_embedded_repo = 1;
 
 #define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
@@ -282,6 +283,8 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
 	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
+	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
+			N_("warn when adding an embedded repository")),
 	OPT_END(),
 };
 
@@ -295,6 +298,44 @@ static int add_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static const char embedded_advice[] = N_(
+"You've added another git repository inside your current repository.\n"
+"Clones of the outer repository will not also contain the contents of\n"
+"the embedded repository. If you meant to add a submodule, use:\n"
+"\n"
+"	git submodule add <url> %s\n"
+"\n"
+"If you added this path by mistake, you can remove it from the\n"
+"index with:\n"
+"\n"
+"	git rm --cached %s\n"
+"\n"
+"See \"git help submodule\" for more information."
+);
+
+static void check_embedded_repo(const char *path)
+{
+	struct strbuf name = STRBUF_INIT;
+
+	if (!warn_on_embedded_repo)
+		return;
+	if (!ends_with(path, "/"))
+		return;
+
+	/* Drop trailing slash for aesthetics */
+	strbuf_addstr(&name, path);
+	strbuf_strip_suffix(&name, "/");
+
+	warning(_("adding embedded git repository: %s"), name.buf);
+	if (advice_add_embedded_repo) {
+		advise(embedded_advice, name.buf, name.buf);
+		/* there may be multiple entries; advise only once */
+		advice_add_embedded_repo = 0;
+	}
+
+	strbuf_release(&name);
+}
+
 static int add_files(struct dir_struct *dir, int flags)
 {
 	int i, exit_status = 0;
@@ -307,12 +348,14 @@ static int add_files(struct dir_struct *dir, int flags)
 		exit_status = 1;
 	}
 
-	for (i = 0; i < dir->nr; i++)
+	for (i = 0; i < dir->nr; i++) {
+		check_embedded_repo(dir->entries[i]->name);
 		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status = 1;
 		}
+	}
 	return exit_status;
 }
 
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..e131760ee 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -213,7 +213,8 @@ cmd_add()
 		die "$(eval_gettext "'\$sm_path' already exists in the index and is not a submodule")"
 	fi
 
-	if test -z "$force" && ! git add --dry-run --ignore-missing "$sm_path" > /dev/null 2>&1
+	if test -z "$force" &&
+		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" > /dev/null 2>&1
 	then
 		eval_gettextln "The following path is ignored by one of your .gitignore files:
 \$sm_path
@@ -267,7 +268,7 @@ or you are unsure what this means choose another name with the '--name' option."
 	fi
 	git config submodule."$sm_name".url "$realrepo"
 
-	git add $force "$sm_path" ||
+	git add --no-warn-embedded-repo $force "$sm_path" ||
 	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
 
 	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
new file mode 100755
index 000000000..8059bcb7f
--- /dev/null
+++ b/t/t7414-submodule-mistakes.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='handling of common mistakes people may make with submodules'
+. ./test-lib.sh
+
+test_expect_success 'create embedded repository' '
+	git init embed &&
+	(
+		cd embed &&
+		test_commit one
+	)
+'
+
+test_expect_success 'git-add on embedded repository warns' '
+	test_when_finished "git rm --cached -f embed" &&
+	git add embed 2>stderr &&
+	test_i18ngrep warning stderr
+'
+
+test_expect_success '--no-warn-embedded-repo suppresses warning' '
+	test_when_finished "git rm --cached -f embed" &&
+	git add --no-warn-embedded-repo embed 2>stderr &&
+	test_i18ngrep ! warning stderr
+'
+
+test_expect_success 'no warning when updating entry' '
+	test_when_finished "git rm --cached -f embed" &&
+	git add embed &&
+	git -C embed commit --allow-empty -m two &&
+	git add embed 2>stderr &&
+	test_i18ngrep ! warning stderr
+'
+
+test_expect_success 'submodule add does not warn' '
+	test_when_finished "git rm -rf submodule .gitmodules" &&
+	git submodule add ./embed submodule 2>stderr &&
+	test_i18ngrep ! warning stderr
+'
+
+test_done
-- 
2.13.1.675.g57c06d071

