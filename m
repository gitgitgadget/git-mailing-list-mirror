From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] Documentation: add a script to generate a (long/short) options overview
Date: Fri,  1 Nov 2013 00:04:42 +0100
Message-ID: <1383260682-12364-1-git-send-email-stefanbeller@googlemail.com>
References: <5272E1B9.6000705@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: tr@thomasrast.ch, mhagger@alum.mit.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 00:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc1I4-0000xA-KM
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 00:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab3JaXEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 19:04:33 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49153 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab3JaXEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 19:04:32 -0400
Received: by mail-ee0-f46.google.com with SMTP id c1so1686227eek.5
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XbMGCOBk4EshJKYdCdYwsk054ocAER/i4ZePZtV15Q=;
        b=ZrRh4vNJPAct32UvGLlDDNRA9UD9kFsq3KwEMsws7qvZ7zaxIh/+fNN3FVNPJJ8Iri
         IPmqKKSN2oqi0zD7LwkEq/w2W31zulvD3/ocDxysVyvdRckDo+z30yZGkWSdrVW9a3V6
         Kc2JDzeBCztqlmCHOhJ+omar2MPgljTVp2NBzVxcUbL03G0wsauObJEEEGsF4+xqBgYD
         jKrZf6pL6tYCvAhbvpMliCYEUiPu0bEqAem5XpRESV1bt5dPxEF/hhcyu+5tC8SB/xyT
         9JKe+r/1kv2VrzhwT5ktaWMIs0WY4htYc+LtsWbHX8Ozhk9lhjf9OtnPZfgFm/dTWuZX
         bdrw==
X-Received: by 10.14.104.5 with SMTP id h5mr99767eeg.58.1383260671021;
        Thu, 31 Oct 2013 16:04:31 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d7sm141500eem.8.2013.10.31.16.04.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Oct 2013 16:04:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.605.g23c6912
In-Reply-To: <5272E1B9.6000705@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237192>

Recently a discussion started on the mailing list, which short option
shall be best for a long option. (-f being always --force and therefore
should not be reassigned another meaning in one particular command)
See http://www.mail-archive.com/git@vger.kernel.org/msg38456.html

For discussions as these we need a script to easily generate an
overview of all available one letter options, and their long option
equivalents.

As the list of options was not retrieved fully automated,
there might be minor errors or missing items.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 Documentation/generateShortOptions.py | 460 ++++++++++++++++++++++++++++++++++
 1 file changed, 460 insertions(+)
 create mode 100644 Documentation/generateShortOptions.py

diff --git a/Documentation/generateShortOptions.py b/Documentation/generateShortOptions.py
new file mode 100644
index 0000000..1d326f9
--- /dev/null
+++ b/Documentation/generateShortOptions.py
@@ -0,0 +1,460 @@
+#!/usr/bin/python
+# This script generates a table, which should help you getting a
+# better overview of the existing long and short options of the
+# various git commands. This script actually is only suited for
+# generating the table itself, as the collection of the options of
+# the git commands needs to be done manually.
+# For the majority of commands, which are written in C, a small patch
+# such as the following helps to extract the relevant cases for this
+# script. However you still need to go through the shell commands
+# manually.
+# diff --git a/parse-options.c b/parse-options.c
+# index 62e9b1c..b356ca9 100644
+# --- a/parse-options.c
+# +++ b/parse-options.c
+# @@ -500,6 +500,12 @@ int parse_options(int argc, const char **argv, const char *prefix,
+#  {
+#  	struct parse_opt_ctx_t ctx;
+#
+# +	for (; options->type != OPTION_END; options++) {
+# +		if (options->long_name && options->short_name)
+# +			printf("%s,  %c, %s\n", argv[0], options->short_name, options->long_name);
+# +	}
+# +	exit(1);
+# +
+#  	parse_options_start(&ctx, argc, argv, prefix, options, flags);
+#  	switch (parse_options_step(&ctx, options, usagestr)) {
+#  	case PARSE_OPT_HELP:
+# --
+
+
+# Command, short option, long option
+cmd_results="""add,  n, dry-run
+add,  v, verbose
+add,  i, interactive
+add,  p, patch
+add,  e, edit
+add,  f, force
+add,  u, update
+add,  N, intent-to-add
+add,  A, all
+
+am, i, interactive
+am, 3, 3way
+am, q, quiet
+am, s, signoff
+am, u, utf8
+am, k, keep
+
+annotate, p, porcelain
+
+apply,  3, 3way
+apply,  R, reverse
+apply,  v, verbose
+
+archive,  o, output
+
+blame, p, porcelain
+blame, f, show-name
+blame, n, show-number
+blame, e, show-email
+
+branch,  v, verbose
+branch,  q, quiet
+branch,  t, track
+branch,  u, set-upstream-to
+branch,  r, remotes
+branch,  a, all
+branch,  d, delete
+branch,  m, move
+branch,  l, create-reflog
+branch,  f, force
+
+check-attr,  a, all
+
+check-ignore,  q, quiet
+check-ignore,  v, verbose
+check-ignore,  n, non-matching
+
+checkout,  q, quiet
+checkout,  t, track
+checkout,  2, ours
+checkout,  3, theirs
+checkout,  f, force
+checkout,  m, merge
+checkout,  p, patch
+
+checkout-index,  a, all
+checkout-index,  f, force
+checkout-index,  q, quiet
+checkout-index,  n, no-create
+checkout-index,  u, index
+
+cherry,  v, verbose
+
+cherry-pick,  n, no-commit
+cherry-pick,  e, edit
+cherry-pick,  s, signoff
+cherry-pick,  m, mainline
+cherry-pick,  X, strategy-option
+
+clean,  q, quiet
+clean,  n, dry-run
+clean,  f, force
+clean,  i, interactive
+clean,  e, exclude
+
+clone,  v, verbose
+clone,  q, quiet
+clone,  n, no-checkout
+clone,  l, local
+clone,  s, shared
+clone,  o, origin
+clone,  b, branch
+clone,  u, upload-pack
+clone,  c, config
+
+commit,  q, quiet
+commit,  v, verbose
+commit,  F, file
+commit,  m, message
+commit,  c, reedit-message
+commit,  C, reuse-message
+commit,  s, signoff
+commit,  t, template
+commit,  e, edit
+commit,  S, gpg-sign
+commit,  a, all
+commit,  i, include
+commit,  p, patch
+commit,  o, only
+commit,  n, no-verify
+commit,  z, null
+commit,  u, untracked-files
+
+config,  f, file
+config,  l, list
+config,  e, edit
+config,  z, null
+
+count-objects,  v, verbose
+count-objects,  H, human-readable
+
+diff, u, patch
+diff, p, patch
+diff, U, unified
+diff, B, break-rewrites
+diff, M, find-renames
+diff, C, find-copies
+diff, D, irreversible-delete
+diff, a, text
+diff, b, ignore-space-change
+diff, w, ignore-all-space
+diff, W, function-context
+
+diff-files, u, patch
+diff-files, p, patch
+diff-files, U, unified
+diff-files, B, break-rewrites
+diff-files, M, find-renames
+diff-files, C, find-copies
+diff-files, D, irreversible-delete
+diff-files, a, text
+diff-files, b, ignore-space-change
+diff-files, w, ignore-all-space
+diff-files, W, function-context
+diff-files, c, cc
+# diff-index and diff-tree similar, to be done
+
+fetch,  v, verbose
+fetch,  q, quiet
+fetch,  a, append
+fetch,  f, force
+fetch,  m, multiple
+fetch,  t, tags
+fetch,  p, prune
+fetch,  k, keep
+fetch,  u, update-head-ok
+
+filter-branch, f, force
+
+fmt-merge-msg,  m, message
+fmt-merge-msg,  F, file
+
+for-each-ref,  s, shell
+for-each-ref,  p, perl
+
+format-patch,  n, numbered
+format-patch,  N, no-numbered
+format-patch,  s, signoff
+format-patch,  v, reroll-count
+format-patch,  o, output-directory
+format-patch,  k, keep-subject
+format-patch,  p, no-stat
+format-patch,  q, quiet
+
+fsck,  v, verbose
+
+fsck-objects,  v, verbose
+
+gc,  q, quiet
+
+grep,  v, invert-match
+grep,  i, ignore-case
+grep,  w, word-regexp
+grep,  a, text
+grep,  E, extended-regexp
+grep,  G, basic-regexp
+grep,  F, fixed-strings
+grep,  P, perl-regexp
+grep,  n, line-number
+grep,  l, files-with-matches
+grep,  L, files-without-match
+grep,  z, null
+grep,  c, count
+grep,  C, context
+grep,  B, before-context
+grep,  A, after-context
+grep,  p, show-function
+grep,  W, function-context
+grep,  q, quiet
+grep,  O, open-files-in-pager
+
+help,  a, all
+help,  g, guides
+help,  m, man
+help,  w, web
+help,  i, info
+
+init,  q, quiet
+
+init-db,  q, quiet
+
+insta-web, l, local
+insta-web, d, httpd
+insta-web, m, module-path
+insta-web, p, port
+insta-web, b, browser
+
+log,  q, quiet
+
+ls-files,  c, cached
+ls-files,  d, deleted
+ls-files,  m, modified
+ls-files,  o, others
+ls-files,  i, ignored
+ls-files,  s, stage
+ls-files,  k, killed
+ls-files,  u, unmerged
+ls-files,  x, exclude
+ls-files,  X, exclude-from
+
+ls-tree,  l, long
+
+ls-remotes, h, heads
+ls-remotes, t, tags
+ls-remotes, u, upload-pack
+
+merge,  e, edit
+merge,  s, strategy
+merge,  X, strategy-option
+merge,  m, message
+merge,  n, no-stat
+merge,  v, verbose
+merge,  q, quiet
+merge,  S, gpg-sign
+merge,  s, strategy
+merge,  X, strategy-option
+
+merge-base,  a, all
+
+merge-file,  p, stdout
+merge-file,  q, quiet
+
+mv,  v, verbose
+mv,  n, dry-run
+mv,  f, force
+
+pack-objects,  q, quiet
+
+prune,  n, dry-run
+prune,  v, verbose
+
+prune-packed,  n, dry-run
+prune-packed,  q, quiet
+
+pull, a, append
+pull, f, force
+pull, k, keep
+pull, u, update-head-ok
+pull, n, no-stat
+pull, q, quiet
+pull, v, verbose
+pull, r, rebase
+pull,  s, strategy
+pull,  X, strategy-option
+
+push,  v, verbose
+push,  q, quiet
+push,  n, dry-run
+push,  f, force
+push,  u, set-upstream
+
+quilt-import, n, dry-run
+
+rebase, f, force-rebase
+rebase, i, interactive
+rebase, p, preserve-merges
+rebase, m, merge
+rebase, n, no-stat
+rebase, v, verbose
+rebase, r, rebase
+rebase,  s, strategy
+rebase,  X, strategy-option
+rebase, x, exec
+
+read-tree,  v, verbose
+read-tree,  n, dry-run
+
+reflog,  q, quiet
+
+rev-list, n, max-count
+rev-list, i, regexp-ignore-case
+rev-list, E, extended-regexp
+rev-list, F, fixed-strings
+rev-list, g, walk-reflogs
+
+remote,  v, verbose
+
+repack,  q, quiet
+repack,  l, local
+
+replace,  l, list
+replace,  d, delete
+replace,  f, force
+
+reset,  q, quiet
+reset,  p, patch
+
+revert,  n, no-commit
+revert,  e, edit
+revert,  s, signoff
+revert,  m, mainline
+revert,  X, strategy-option
+
+rm,  n, dry-run
+rm,  q, quiet
+rm,  f, force
+
+show,  q, quiet
+
+show-branch,  a, all
+show-branch,  r, remotes
+show-branch,  g, reflog
+
+show-ref,  d, dereference
+show-ref,  s, hash
+show-ref,  q, quiet
+
+shortlog, n, numbered
+shortlog, s, summary
+shortlog, e, email
+
+stash, p, patch
+stash, u, include-untracked
+stash, a, all
+stash, q, quiet
+
+stage,  n, dry-run
+stage,  v, verbose
+stage,  i, interactive
+stage,  p, patch
+stage,  e, edit
+stage,  f, force
+stage,  u, update
+stage,  N, intent-to-add
+stage,  A, all
+
+status,  v, verbose
+status,  s, short
+status,  b, branch
+status,  z, null
+status,  u, untracked-files
+
+stripspace, s, strip-comments
+stripspace, c, comment-lines
+
+submodule, q, quiet
+submodule, b, branch
+submodule, f, force
+submodule, n, summary-limit
+submodule, N, no-fetch
+
+symbolic-ref,  q, quiet
+symbolic-ref,  d, delete
+
+tag,  l, list
+tag,  d, delete
+tag,  v, verify
+tag,  a, annotate
+tag,  m, message
+tag,  F, file
+tag,  s, sign
+tag,  u, local-user
+tag,  f, force
+
+update-server-info,  f, force
+
+verify-pack,  v, verbose
+verify-pack,  s, stat-only
+
+verify-tag,  v, verbose
+
+whatchanged,  q, quiet"""
+
+import subprocess
+
+column_len = {}
+column_count = {}
+cmdoptions={}
+
+for line in cmd_results.split("\n"):
+	if not len(line) or line.startswith('#'):
+		continue
+	name, short, long = line.split(",")
+
+	if not short in column_len:
+		column_len[short] = len(long)
+		column_count[short] = 0
+	column_len[short] = max(column_len[short], len(long))
+	column_count[short] += 1
+
+	if not name in cmdoptions:
+		cmdoptions[name] = {}
+	cmdoptions[name][short] = long
+
+longest_cmd = 0
+for cmd in cmdoptions:
+	longest_cmd = max(longest_cmd, len(cmd))
+
+print " "*(longest_cmd-len("Name\\short")), "Name\\short",
+
+# let's sort the columns in a way, we can see most of the options on the left hand side
+columns = []
+for key, value in sorted(column_count.iteritems(), key=lambda (k,v): (-v,k)):
+	columns += [key]
+
+# print head line
+for short in columns:
+	print "|" + " "*(1+column_len[short]-len(short)) + short,
+print
+
+# print line for each command
+for cmd in sorted(cmdoptions):
+	print " "*(longest_cmd-len(cmd)), cmd,
+	for short in columns:
+		s = ""
+		if short in cmdoptions[cmd]:
+			s = cmdoptions[cmd][short]
+		print "|" + " "*(1+column_len[short]-len(s)) + s,
+	print "  ", cmd
-- 
1.8.4.1.605.g23c6912
