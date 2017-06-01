Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C10E2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 06:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751118AbdFAG1V (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 02:27:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:32955 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbdFAGZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 02:25:16 -0400
Received: (qmail 20689 invoked by uid 109); 1 Jun 2017 06:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 06:25:13 +0000
Received: (qmail 14586 invoked by uid 111); 1 Jun 2017 06:25:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 02:25:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 02:25:12 -0400
Date:   Thu, 1 Jun 2017 02:25:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170601062511.e53kpcmqukaxb5fy@sigill.intra.peff.net>
References: <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
 <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
 <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
 <xmqqshjmc1wm.fsf@gitster.mtv.corp.google.com>
 <20170530061546.tdpuhvq7yk34rvlj@sigill.intra.peff.net>
 <xmqqo9uabhqt.fsf@gitster.mtv.corp.google.com>
 <20170530152756.vs777v6unaxg6otb@sigill.intra.peff.net>
 <xmqqinkg734c.fsf@gitster.mtv.corp.google.com>
 <xmqq7f0w6z7u.fsf@gitster.mtv.corp.google.com>
 <xmqq37bk6ynz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37bk6ynz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 02:54:08PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > For now, I will mix this in when queuing the whole thing in 'pu', as
> > I hate to push out something that does not even work for me to the
> > general public.
> > 
> > -- >8 --
> > Subject: [PATCH] diff- and log- family: handle "git cmd -h" early
> > ...
> 
> And then the check_help_option() thing may look like this.  
> 
> I am not proud of the way it "unifies" the two styles of usage
> strings, obviously.

Heh, I came up with a similar hack. It is pretty nasty.

If we don't mind a one-time pain, I think we can just convert the
existing usage() to something more like usage_with_options(). The patch
below does that (and teaches the latter to handle a NULL options field).

The diff is ugly, and the conversion is mostly mechanical. But I think
some sites can be improved. For example, look at the change in bundle.c,
which now hands a set of strings rather than formatting the whole "or:"
chain manually.

I think we could take this even further and break some of the really
long entries (e.g., index-pack) into:

  static const char *index_pack_usage[] = {
	"git index-pack <pack-file>",
	"git index-pack --stdin",
	"",
	"-v",
	"-o <index-file>",
	etc...
	NULL
  };

With bonus points for actually describing each option (though at that
point it may be as much work to just convert the thing to parse-options,
which would also be fine with me).

That's tedious work which would need attention paid to each individual
command. So I'd probably do a single mechanical patch like this one
(that keeps the output identical), and then let people fix each one up
on top.

> One benefit this patch has is that it makes it easier to highlight
> what it does *not* touch.
> 
>     $ git grep -A2 -E -e 'a(rg)?c [!=]= 2 .*strcmp.*-h'
> 
> shows there are somewhat curious construct
> 
> 	if (argc != 2 || !strcmp(argv[1], "-h"))
> 		usage(...);
> 
> left in the code.  Upon closer inspection, they all happen to be
> doing the right thing for their current set of options and
> arguments, but they are somewhat ugly.

Yeah, I noticed those too while looking for prior art in my "-h" series.
I think they're all sane. And in fact some of them are necessary (and I
think I even added one like what you quoted above) because the arguments
are not otherwise parsed.

So for something that calls parse_options() later, just:

  if (argc == 2 && !strcmp(argv[1], "-h"))
	usage(...);

is sufficient to catch the single funny case, and parse_options()
catches the rest. But for some commands, this is all the parsing they
do. We could split that in two, like:

  /* early "-h" check */
  if (argc == 2 && !strcmp(argv[1], "-h"))
	usage(...);
  /* now check for argument sanity */
  if (argc != 2)
	usage(...);

That would make sense if we wanted to treat "-h" different from a normal
"huh?" response, but we don't currently. I don't know that it's worth
worrying about too much either way.

Anyway, here's the usage[] patch. I based it on the jk/consistent-h
branch, since I added a few new calls there. I won't be surprised if I
missed a NULL terminator somewhere, but it at least passes the big "-h"
loop in t0012. :)

---
diff --git a/builtin.h b/builtin.h
index 9e4a89816..c31fac64f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -8,7 +8,7 @@
 
 #define DEFAULT_MERGE_LOG_LEN 20
 
-extern const char git_usage_string[];
+extern const char *git_usage_string[];
 extern const char git_more_info_string[];
 
 #define PRUNE_PACKED_DRY_RUN 01
diff --git a/builtin/blame.c b/builtin/blame.c
index 1043e5376..58cc1e8e8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -30,10 +30,8 @@
 #include "dir.h"
 #include "progress.h"
 
-static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
-
 static const char *blame_opt_usage[] = {
-	blame_usage,
+	N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>"),
 	"",
 	N_("<rev-opts> are documented in git-rev-list(1)"),
 	NULL
@@ -2865,7 +2863,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		if (parse_range_arg(range_list.items[range_i].string,
 				    nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path))
-			usage(blame_usage);
+			usage(blame_opt_usage);
 		if (lno < top || ((lno || bottom) && lno < bottom))
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
diff --git a/builtin/bundle.c b/builtin/bundle.c
index d0de59b94..2284a2413 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -9,11 +9,13 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char builtin_bundle_usage[] =
-  "git bundle create <file> <git-rev-list args>\n"
-  "   or: git bundle verify <file>\n"
-  "   or: git bundle list-heads <file> [<refname>...]\n"
-  "   or: git bundle unbundle <file> [<refname>...]";
+static const char *builtin_bundle_usage[] = {
+  "git bundle create <file> <git-rev-list args>",
+  "git bundle verify <file>",
+  "git bundle list-heads <file> [<refname>...]",
+  "git bundle unbundle <file> [<refname>...]",
+  NULL
+};
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index eac499450..2d32db294 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -7,9 +7,11 @@
 #include "builtin.h"
 #include "strbuf.h"
 
-static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--normalize] [<options>] <refname>\n"
-"   or: git check-ref-format --branch <branchname-shorthand>";
+static const char *builtin_check_ref_format_usage[] = {
+	"git check-ref-format [--normalize] [<options>] <refname>",
+	"git check-ref-format --branch <branchname-shorthand>",
+	NULL
+};
 
 /*
  * Return a copy of refname but with leading slashes removed and runs
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index f39c2b273..1116a8590 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -10,7 +10,10 @@
 #include "utf8.h"
 #include "gpg-interface.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
+static const char *commit_tree_usage[] = {
+	"git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>",
+	NULL
+};
 
 static const char *sign_commit;
 
diff --git a/builtin/credential.c b/builtin/credential.c
index 879acfbcd..02e2d546f 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -2,8 +2,10 @@
 #include "credential.h"
 #include "builtin.h"
 
-static const char usage_msg[] =
-	"git credential [fill|approve|reject]";
+static const char *usage_msg[] = {
+	"git credential [fill|approve|reject]",
+	NULL
+};
 
 int cmd_credential(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 15c61fd8d..a501196c2 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -10,9 +10,11 @@
 #include "builtin.h"
 #include "submodule.h"
 
-static const char diff_files_usage[] =
+static const char *diff_files_usage[] = {
 "git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]"
-COMMON_DIFF_OPTIONS_HELP;
+COMMON_DIFF_OPTIONS_HELP,
+NULL
+};
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1af373d00..c633b0154 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -5,10 +5,12 @@
 #include "builtin.h"
 #include "submodule.h"
 
-static const char diff_cache_usage[] =
+static const char *diff_cache_usage[] = {
 "git diff-index [-m] [--cached] "
 "[<common-diff-options>] <tree-ish> [<path>...]"
-COMMON_DIFF_OPTIONS_HELP;
+COMMON_DIFF_OPTIONS_HELP,
+NULL
+};
 
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 5ea1c1431..925064e8c 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -79,12 +79,14 @@ static int diff_tree_stdin(char *line)
 	return -1;
 }
 
-static const char diff_tree_usage[] =
+static const char *diff_tree_usage[] = {
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
-COMMON_DIFF_OPTIONS_HELP;
+COMMON_DIFF_OPTIONS_HELP,
+NULL
+};
 
 static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
diff --git a/builtin/diff.c b/builtin/diff.c
index 8c03ddaf5..2ab7a2b44 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -26,8 +26,10 @@ struct blobinfo {
 	unsigned mode;
 };
 
-static const char builtin_diff_usage[] =
-"git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
+static const char *builtin_diff_usage[] = {
+"git diff [<options>] [<commit> [<commit>]] [--] [<path>...]",
+NULL
+};
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f..aad1e470b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -5,10 +5,12 @@
 #include "connect.h"
 #include "sha1-array.h"
 
-static const char fetch_pack_usage[] =
+static const char *fetch_pack_usage[] = {
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
-"[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
+"[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]",
+NULL
+};
 
 static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
 			     const char *name)
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index e21c5416c..33ad8ff1f 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -7,8 +7,10 @@
 #include "builtin.h"
 #include "quote.h"
 
-static const char builtin_get_tar_commit_id_usage[] =
-"git get-tar-commit-id";
+static const char *builtin_get_tar_commit_id_usage[] = {
+"git get-tar-commit-id",
+NULL
+};
 
 /* ustar header + extended global header content */
 #define RECORDSIZE	(512)
diff --git a/builtin/help.c b/builtin/help.c
index 49f7a07f8..b8c65bcfd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -459,7 +459,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all) {
 		git_config(git_help_config, NULL);
-		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
+		printf(_("usage: %s%s"), _(git_usage_string[0]), "\n\n");
 		load_command_list("git-", &main_cmds, &other_cmds);
 		list_commands(colopts, &main_cmds, &other_cmds);
 	}
@@ -476,7 +476,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!argv[0]) {
-		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
+		printf(_("usage: %s%s"), _(git_usage_string[0]), "\n\n");
 		list_common_cmds_help();
 		printf("\n%s\n", _(git_more_info_string));
 		return 0;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0..26477cd84 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -12,8 +12,10 @@
 #include "streaming.h"
 #include "thread-utils.h"
 
-static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+static const char *index_pack_usage[] = {
+	"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])",
+	NULL
+};
 
 struct object_entry {
 	struct pack_idx_entry idx;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 8a6acb0ec..5fef656e9 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -524,7 +524,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			die_errno(_("cannot chdir to %s"), argv[0]);
 		}
 	} else if (0 < argc) {
-		usage(init_db_usage[0]);
+		usage(init_db_usage);
 	}
 	if (is_bare_repository_cfg == 1) {
 		char *cwd = xgetcwd();
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cfb667a59..21d3cc615 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -8,8 +8,10 @@
 #include "strbuf.h"
 #include "mailinfo.h"
 
-static const char mailinfo_usage[] =
-	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
+static const char *mailinfo_usage[] = {
+	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info",
+	NULL
+};
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 664400b81..0e504c104 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -9,8 +9,10 @@
 #include "string-list.h"
 #include "strbuf.h"
 
-static const char git_mailsplit_usage[] =
-"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
+static const char *git_mailsplit_usage[] = {
+"git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]",
+NULL
+};
 
 static int is_from_line(const char *line, int len)
 {
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c99443b09..203b0e5ed 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -65,6 +65,11 @@ static void merge_all(void)
 	}
 }
 
+static const char *usage_msg[] = {
+	"git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])",
+	NULL
+};
+
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0;
@@ -75,7 +80,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage(usage_msg);
 
 	read_cache();
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 684411694..40c520f46 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -10,8 +10,10 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 
-static const char builtin_merge_ours_usage[] =
-	"git merge-ours <base>... -- HEAD <remote>...";
+static const char *builtin_merge_ours_usage[] = {
+	"git merge-ours <base>... -- HEAD <remote>...",
+	NULL
+};
 
 static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "--cached", "HEAD", "--", NULL
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index bad6735c7..3ef220ef9 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -5,7 +5,10 @@
 #include "exec_cmd.h"
 #include "merge-blobs.h"
 
-static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
+static const char *merge_tree_usage[] = {
+	"git merge-tree <base-tree> <branch1> <branch2>",
+	NULL
+};
 
 struct merge_list {
 	struct merge_list *next;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 031b750f0..a57b1d8f3 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -148,13 +148,18 @@ static int verify_tag(char *buffer, unsigned long size)
 	return 0;
 }
 
+static const char *usage_msg[] = {
+	"git mktag",
+	NULL
+};
+
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
-		usage("git mktag");
+		usage(usage_msg);
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die_errno("could not read from stdin");
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index cb1df1c76..d65fc9de8 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -10,8 +10,10 @@
 
 #define BLKSIZE 512
 
-static const char pack_redundant_usage[] =
-"git pack-redundant [--verbose] [--alt-odb] (--all | <filename.pack>...)";
+static const char *pack_redundant_usage[] = {
+"git pack-redundant [--verbose] [--alt-odb] (--all | <filename.pack>...)",
+NULL
+};
 
 static int load_all_packs, verbose, alt_odb;
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 81552e02e..2627ca391 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -162,7 +162,10 @@ static void generate_id_list(int stable)
 	strbuf_release(&line_buf);
 }
 
-static const char patch_id_usage[] = "git patch-id [--stable | --unstable]";
+static const char *patch_id_usage[] = {
+	"git patch-id [--stable | --unstable]",
+	NULL
+};
 
 static int git_patch_id_config(const char *var, const char *value, void *cb)
 {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 920c16dac..a79e4b7d4 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -9,12 +9,18 @@
 #include "reachable.h"
 
 /* NEEDSWORK: switch to using parse_options */
-static const char reflog_expire_usage[] =
-"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
-static const char reflog_delete_usage[] =
-"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
-static const char reflog_exists_usage[] =
-"git reflog exists <ref>";
+static const char *reflog_expire_usage[] = {
+	"git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...",
+	NULL
+};
+static const char *reflog_delete_usage[] = {
+	"git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...",
+	NULL
+};
+static const char *reflog_exists_usage[] = {
+	"git reflog exists <ref>",
+	NULL
+};
 
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
@@ -722,8 +728,10 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
  * main "reflog"
  */
 
-static const char reflog_usage[] =
-"git reflog [ show | expire | delete | exists ]";
+static const char *reflog_usage[] = {
+"git reflog [ show | expire | delete | exists ]",
+NULL
+};
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index bfb21ba7d..5f48a7393 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -3,8 +3,10 @@
 #include "run-command.h"
 #include "pkt-line.h"
 
-static const char usage_msg[] =
-	"git remote-ext <remote> <url>";
+static const char *usage_msg[] = {
+	"git remote-ext <remote> <url>",
+	NULL
+};
 
 /*
  * URL syntax:
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index 91dfe07e0..28a7a99f8 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,8 +1,10 @@
 #include "builtin.h"
 #include "transport.h"
 
-static const char usage_msg[] =
-	"git remote-fd <remote> <url>";
+static const char *usage_msg[] = {
+	"git remote-fd <remote> <url>",
+	NULL
+};
 
 /*
  * URL syntax:
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 718c6059c..f06afd6a5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -11,7 +11,7 @@
 #include "bisect.h"
 #include "progress.h"
 
-static const char rev_list_usage[] =
+static const char *rev_list_usage[] = {
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
@@ -47,8 +47,9 @@ static const char rev_list_usage[] =
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars\n"
-"    --bisect-all"
-;
+"    --bisect-all",
+NULL
+};
 
 static struct progress *progress;
 static unsigned progress_counter;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index efdc14473..7b377cfbf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -530,12 +530,14 @@ static void die_no_single_rev(int quiet)
 		die("Needed a single revision");
 }
 
-static const char builtin_rev_parse_usage[] =
+static const char *builtin_rev_parse_usage[] = {
 N_("git rev-parse --parseopt [<options>] -- [<args>...]\n"
    "   or: git rev-parse --sq-quote [<arg>...]\n"
    "   or: git rev-parse [<options>] [<arg>...]\n"
    "\n"
-   "Run \"git rev-parse --parseopt -h\" for more information on the first usage.");
+   "Run \"git rev-parse --parseopt -h\" for more information on the first usage."),
+NULL
+};
 
 /*
  * Parse "opt" or "opt=<value>", setting value respectively to either
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1b4d2b346..945a1ca8d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -469,10 +469,14 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 static int module_name(int argc, const char **argv, const char *prefix)
 {
+	static const char *usage_msg[] = {
+		N_("git submodule--helper name <path>"),
+		NULL
+	};
 	const struct submodule *sub;
 
 	if (argc != 2)
-		usage(_("git submodule--helper name <path>"));
+		usage(usage_msg);
 
 	gitmodules_config();
 	sub = submodule_from_path(null_sha1, argv[1]);
@@ -1220,9 +1224,13 @@ static struct cmd_struct commands[] = {
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
+	static const char *usage_msg[] = {
+		"git submodule--helper <command>",
+		NULL
+	};
 	int i;
 	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage("git submodule--helper <command>");
+		usage(usage_msg);
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (!strcmp(argv[1], commands[i].cmd)) {
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 6fc6bcdf7..d875802a3 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -20,12 +20,17 @@ static char *create_temp_file(unsigned char *sha1)
 	return path;
 }
 
+static const char *usage_msg[] = {
+	"git unpack-file <sha1>",
+	NULL
+};
+
 int cmd_unpack_file(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
 
 	if (argc != 2 || !strcmp(argv[1], "-h"))
-		usage("git unpack-file <sha1>");
+		usage(usage_msg);
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8bc999776..7fcea5374 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -13,7 +13,10 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
+static const char *unpack_usage[] = {
+	"git unpack-objects [-n] [-q] [-r] [--strict]",
+	NULL
+};
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 84532ae9a..c73b116e8 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -9,8 +9,10 @@
 #include "run-command.h"
 #include "argv-array.h"
 
-static const char upload_archive_usage[] =
-	"git upload-archive <repo>";
+static const char *upload_archive_usage[] = {
+	"git upload-archive <repo>",
+	NULL
+};
 
 static const char deadchild[] =
 "git upload-archive: archiver died with error";
diff --git a/builtin/var.c b/builtin/var.c
index aedbb53a2..7dc0d202c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,7 +5,10 @@
  */
 #include "builtin.h"
 
-static const char var_usage[] = "git var (-l | <variable>)";
+static const char *var_usage[] = {
+	"git var (-l | <variable>)",
+	NULL
+};
 
 static const char *editor(int flag)
 {
diff --git a/daemon.c b/daemon.c
index ac7181a48..6f9030706 100644
--- a/daemon.c
+++ b/daemon.c
@@ -13,7 +13,7 @@ static int verbose;
 static int reuseaddr;
 static int informative_errors;
 
-static const char daemon_usage[] =
+static const char *daemon_usage[] = {
 "git daemon [--verbose] [--syslog] [--export-all]\n"
 "           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
 "           [--strict-paths] [--base-path=<path>] [--base-path-relaxed]\n"
@@ -24,7 +24,9 @@ static const char daemon_usage[] =
 "           [--access-hook=<path>]\n"
 "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
 "                      [--detach] [--user=<user> [--group=<group>]]\n"
-"           [<directory>...]";
+"           [<directory>...]",
+NULL
+};
 
 /* List of acceptable pathname prefixes */
 static const char **ok_paths;
diff --git a/fast-import.c b/fast-import.c
index e69d21968..1abbae35f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3408,8 +3408,10 @@ static void git_pack_config(void)
 	git_config(git_default_config, NULL);
 }
 
-static const char fast_import_usage[] =
-"git fast-import [--date-format=<f>] [--max-pack-size=<n>] [--big-file-threshold=<n>] [--depth=<n>] [--active-branches=<n>] [--export-marks=<marks.file>]";
+static const char *fast_import_usage[] = {
+"git fast-import [--date-format=<f>] [--max-pack-size=<n>] [--big-file-threshold=<n>] [--depth=<n>] [--active-branches=<n>] [--export-marks=<marks.file>]",
+NULL
+};
 
 static void parse_argv(void)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 4b7dcf21a..b109e4686 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -409,7 +409,7 @@ struct strbuf;
 
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
-extern NORETURN void usage(const char *err);
+extern NORETURN void usage(const char * const *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/git.c b/git.c
index 1b8b7f51a..3496f8a23 100644
--- a/git.c
+++ b/git.c
@@ -3,12 +3,14 @@
 #include "help.h"
 #include "run-command.h"
 
-const char git_usage_string[] =
+const char *git_usage_string[] = {
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 	"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
-	"           <command> [<args>]";
+	"           <command> [<args>]",
+	NULL
+};
 
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
@@ -694,7 +696,7 @@ int cmd_main(int argc, const char **argv)
 	} else {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
-		printf("usage: %s\n\n", git_usage_string);
+		printf("usage: %s\n\n", git_usage_string[0]);
 		list_common_cmds_help();
 		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
diff --git a/http-fetch.c b/http-fetch.c
index 3b556d661..fb9da1b98 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,8 +3,11 @@
 #include "http.h"
 #include "walker.h"
 
-static const char http_fetch_usage[] = "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+static const char *http_fetch_usage[] = {
+"git http-fetch "
+"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url",
+NULL
+};
 
 int cmd_main(int argc, const char **argv)
 {
diff --git a/http-push.c b/http-push.c
index 67c4d4b47..bd312358f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -18,8 +18,10 @@
 #include <expat.h>
 #endif
 
-static const char http_push_usage[] =
-"git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
+static const char *http_push_usage[] = {
+"git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]",
+NULL
+};
 
 #ifndef XML_STATUS_OK
 enum XML_Status {
diff --git a/parse-options.c b/parse-options.c
index a23a1e67f..b0cc2a410 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -600,6 +600,9 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		usagestr++;
 	}
 
+	if (!opts)
+		return PARSE_OPT_HELP;
+
 	if (opts->type != OPTION_GROUP)
 		fputc('\n', outfile);
 
diff --git a/remote-testsvn.c b/remote-testsvn.c
index f87bf851b..f5bb153dc 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -284,6 +284,11 @@ static int do_command(struct strbuf *line)
 	return 0;
 }
 
+static const char *testsvn_usage[] = {
+	"git-remote-svn <remote-name> [<url>]",
+	NULL
+};
+
 int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf = STRBUF_INIT, url_sb = STRBUF_INIT,
@@ -294,7 +299,7 @@ int cmd_main(int argc, const char **argv)
 
 	setup_git_directory();
 	if (argc < 2 || argc > 3) {
-		usage("git-remote-svn <remote-name> [<url>]");
+		usage(testsvn_usage);
 		return 1;
 	}
 
diff --git a/show-index.c b/show-index.c
index 1ead41e21..e0356d7fa 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,8 +1,10 @@
 #include "cache.h"
 #include "pack.h"
 
-static const char show_index_usage[] =
-"git show-index";
+static const char *show_index_usage[] = {
+"git show-index",
+NULL
+};
 
 int cmd_main(int argc, const char **argv)
 {
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index f414a3ac6..fadc50f00 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,12 +1,14 @@
 #include "cache.h"
 
-static const char *usage_msg = "\n"
-"  test-date relative [time_t]...\n"
-"  test-date show:<format> [time_t]...\n"
-"  test-date parse [date]...\n"
-"  test-date approxidate [date]...\n"
-"  test-date is64bit\n"
-"  test-date time_t-is64bit\n";
+static const char *usage_msg[] = {
+"test-date relative [time_t]...",
+"test-date show:<format> [time_t]...",
+"test-date parse [date]...",
+"test-date approxidate [date]...",
+"test-date is64bit",
+"test-date time_t-is64bit",
+NULL
+};
 
 static void show_relative_dates(const char **argv, struct timeval *now)
 {
diff --git a/t/helper/test-line-buffer.c b/t/helper/test-line-buffer.c
index 81575fe2a..288c0ab21 100644
--- a/t/helper/test-line-buffer.c
+++ b/t/helper/test-line-buffer.c
@@ -63,7 +63,7 @@ int cmd_main(int argc, const char **argv)
 	else if (argc == 2)
 		filename = argv[1];
 	else
-		usage("test-line-buffer [file | &fd] < script");
+		usagef("test-line-buffer [file | &fd] < script");
 
 	if (buffer_init(&stdin_buf, NULL))
 		die_errno("open error");
diff --git a/t/helper/test-mktemp.c b/t/helper/test-mktemp.c
index 89d9b2f7b..22f56e7df 100644
--- a/t/helper/test-mktemp.c
+++ b/t/helper/test-mktemp.c
@@ -3,10 +3,15 @@
  */
 #include "git-compat-util.h"
 
+static const char *usage_msg[] = {
+	"Expected 1 parameter defining the temporary file template",
+	NULL
+};
+
 int cmd_main(int argc, const char **argv)
 {
 	if (argc != 2)
-		usage("Expected 1 parameter defining the temporary file template");
+		usage(usage_msg);
 
 	xmkstemp(xstrdup(argv[1]));
 
diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index b5ea8a97c..a36917047 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -47,7 +47,7 @@ int cmd_main(int argc, const char **argv)
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
 	else if (argc < 3)
-		usage("test-regex --bug\n"
+		usagef("test-regex --bug\n"
 		      "test-regex <pattern> <string> [<options>]");
 
 	argv++;
diff --git a/t/helper/test-svn-fe.c b/t/helper/test-svn-fe.c
index 7667c0803..a1eb4e378 100644
--- a/t/helper/test-svn-fe.c
+++ b/t/helper/test-svn-fe.c
@@ -8,8 +8,10 @@
 #include "vcs-svn/sliding_window.h"
 #include "vcs-svn/line_buffer.h"
 
-static const char test_svnfe_usage[] =
-	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+static const char *test_svnfe_usage[] = {
+	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)",
+	NULL
+};
 
 static int apply_delta(int argc, const char **argv)
 {
diff --git a/usage.c b/usage.c
index 2f87ca69a..ae81a6cc8 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,7 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#include "parse-options.h"
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
@@ -94,9 +95,9 @@ void NORETURN usagef(const char *err, ...)
 	va_end(params);
 }
 
-void NORETURN usage(const char *err)
+void NORETURN usage(const char * const *err)
 {
-	usagef("%s", err);
+	usage_with_options(err, NULL);
 }
 
 void NORETURN die(const char *err, ...)
