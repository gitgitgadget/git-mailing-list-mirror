From: Jeff King <peff@peff.net>
Subject: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 04:51:57 -0400
Message-ID: <20120426085156.GB22819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 10:52:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNKR2-0002ti-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 10:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134Ab2DZIwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 04:52:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45090
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754211Ab2DZIwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 04:52:04 -0400
Received: (qmail 12206 invoked by uid 107); 26 Apr 2012 08:52:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 04:52:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 04:51:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196358>

On Thu, Apr 26, 2012 at 02:19:23AM -0400, Jeff King wrote:

> > Modulo s/~/{tilde}/ in the body text (but not in the displayed example),
> > looked good to me, so I queued with two amends.
> 
> Thanks, I forgot about that.
> 
> I'd like to eventually stop building the documentation with
> no-inline-literal. It was an asciidoc7 compatibility thing, but we can
> probably drop that now. However, I suspect that would require us to
> simultaneously convert all of the `{tilde}` uses back into `~`.

I took a look at this.  There were about 200 sites that needed to be
fixed up. It was a pain, but it's now done. The resulting source is much
nicer, and as a bonus, it revealed (and fixed!) a ton of existing
formatting bugs.

The patch is below. I'm slightly nervous because it means topics in
flight will need to have their documentation tweaked, too. But I think
it's worth it in the long run.

This was discussed briefly a month or so ago here:

  http://thread.gmane.org/gmane.comp.version-control.git/191738/focus=191790

where Thomas gave a nice indication that yes, asciidoc 7 is really old
at this point.

-- >8 --
Subject: [PATCH] docs: stop using asciidoc no-inline-literal

In asciidoc 7, backticks like `foo` produced a typographic
effect, but did not otherwise affect the syntax. In asciidoc
8, backticks introduce an "inline literal" inside which markup
is not interpreted. To keep compatibility with existing
documents, asciidoc 8 has a "no-inline-literal" attribute to
keep the old behavior. We enabled this so that the
documentation could be built on either version.

It has been several years now, and asciidoc 7 is no longer
in wide use. We can now decide whether or not we want
inline literals on their own merits, which are:

  1. The source is much easier to read when the literal
     contains punctuation. You can use `master~1` instead
     of `master{tilde}1`.

  2. They are less error-prone. Because of point (1), we
     tend to make mistakes and forget the extra layer of
     quoting.

This patch removes the no-inline-literal attribute from the
Makefile and converts every use of backticks in the
documentation to an inline literal (they must be cleaned up,
or the example above would literally show "{tilde}" in the
output).

Problematic sites were found by grepping for '`.*[{\\]' and
examined and fixed manually. The results were then verified
by comparing the output of "html2text" on the set of
generated html pages. Doing so revealed that in addition to
making the source more readable, this patch fixes several
formatting bugs:

  - HTML rendering used the ellipsis character instead of
    literal "..." in code examples (like "git log A...B")

  - some code examples used the right-arrow character
    instead of '->' because they failed to quote

  - api-config.txt did not quote tilde, and the resulting
    HTML contained a bogus snippet like:

      <tt><sub></tt> foo <tt></sub>bar</tt>

    which caused some parsers to choke and omit whole
    sections of the page.

  - git-commit.txt confused ``foo`` (backticks inside a
    literal) with ``foo'' (matched double-quotes)

  - mentions of `A U Thor <author@example.com>` used to
    erroneously auto-generate a mailto footnote for
    author@example.com

  - the description of --word-diff=plain incorrectly showed
    the output as "[-removed-] and {added}", not "{+added+}".

  - using "prime" notation like:

      commit `C` and its replacement `C'`

    confused asciidoc into thinking that everything between
    the first backtick and the final apostrophe were meant
    to be inside matched quotes

  - asciidoc got confused by the escaping of some of our
    asterisks. In particular,

      `credential.\*` and `credential.<url>.\*`

    properly escaped the asterisk in the first case, but
    literally passed through the backslash in the second
    case.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/Makefile                        |    2 +-
 Documentation/config.txt                      |   36 ++++++++++++-------------
 Documentation/diff-generate-patch.txt         |    2 +-
 Documentation/diff-options.txt                |    2 +-
 Documentation/everyday.txt                    |    4 +--
 Documentation/git-archive.txt                 |    2 +-
 Documentation/git-blame.txt                   |    2 +-
 Documentation/git-bundle.txt                  |    8 +++---
 Documentation/git-check-ref-format.txt        |   12 ++++-----
 Documentation/git-checkout.txt                |    8 +++---
 Documentation/git-cherry-pick.txt             |    4 +--
 Documentation/git-commit.txt                  |    4 +--
 Documentation/git-cvsserver.txt               |    2 +-
 Documentation/git-fast-export.txt             |    2 +-
 Documentation/git-fast-import.txt             |    6 ++---
 Documentation/git-filter-branch.txt           |   34 +++++++++++------------
 Documentation/git-format-patch.txt            |    4 +--
 Documentation/git-gc.txt                      |    2 +-
 Documentation/git-grep.txt                    |    4 +--
 Documentation/git-log.txt                     |    2 +-
 Documentation/git-notes.txt                   |    2 +-
 Documentation/git-pack-refs.txt               |    2 +-
 Documentation/git-pull.txt                    |    2 +-
 Documentation/git-push.txt                    |   14 +++++-----
 Documentation/git-rebase.txt                  |   10 +++----
 Documentation/git-reflog.txt                  |    6 ++---
 Documentation/git-remote-helpers.txt          |    8 +++---
 Documentation/git-remote.txt                  |    6 ++---
 Documentation/git-rerere.txt                  |    6 ++---
 Documentation/git-reset.txt                   |    2 +-
 Documentation/git-rev-parse.txt               |    7 +++--
 Documentation/git-revert.txt                  |    4 +--
 Documentation/git-rm.txt                      |    3 +--
 Documentation/git-shortlog.txt                |    2 +-
 Documentation/git-show-ref.txt                |    2 +-
 Documentation/git-show.txt                    |    4 +--
 Documentation/git-stash.txt                   |   18 ++++++-------
 Documentation/git-status.txt                  |    4 +--
 Documentation/git-tar-tree.txt                |    2 +-
 Documentation/git-whatchanged.txt             |    2 +-
 Documentation/gitcli.txt                      |   12 ++++-----
 Documentation/gitcore-tutorial.txt            |   28 +++++++++----------
 Documentation/gitcredentials.txt              |    4 +--
 Documentation/gitdiffcore.txt                 |   10 +++----
 Documentation/githooks.txt                    |    8 +++---
 Documentation/gitweb.conf.txt                 |   12 ++++-----
 Documentation/gitworkflows.txt                |    4 +--
 Documentation/pretty-formats.txt              |    6 ++---
 Documentation/pull-fetch-param.txt            |    2 +-
 Documentation/rev-list-options.txt            |    6 ++---
 Documentation/technical/api-parse-options.txt |   36 ++++++++++++-------------
 Documentation/technical/protocol-common.txt   |    2 +-
 Documentation/user-manual.txt                 |    8 +++---
 53 files changed, 192 insertions(+), 194 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9fee0b9..14286cb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -82,7 +82,7 @@ endif
 #
 
 ifndef ASCIIDOC7
-ASCIIDOC_EXTRA += -a asciidoc7compatible -a no-inline-literal
+ASCIIDOC_EXTRA += -a asciidoc7compatible
 endif
 ifdef DOCBOOK_XSL_172
 ASCIIDOC_EXTRA += -a git-asciidoc-no-roff
diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb386ab..03efae9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -478,8 +478,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
-	of files which are not meant to be tracked.  "{tilde}/" is expanded
-	to the value of `$HOME` and "{tilde}user/" to the specified user's
+	of files which are not meant to be tracked.  "`~/`" is expanded
+	to the value of `$HOME` and "`~user/`" to the specified user's
 	home directory.  See linkgit:gitignore[5].
 
 core.askpass::
@@ -860,7 +860,7 @@ commit.status::
 
 commit.template::
 	Specify a file to use as the template for new commit messages.
-	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
+	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
 credential.helper::
@@ -985,7 +985,7 @@ format.thread::
 	a boolean value, or `shallow` or `deep`.  `shallow` threading
 	makes every mail a reply to the head of the series,
 	where the head is chosen from the cover letter, the
-	`\--in-reply-to`, and the first patch mail, in this order.
+	`--in-reply-to`, and the first patch mail, in this order.
 	`deep` threading makes every mail a reply to the previous one.
 	A true boolean value is the same as `shallow`, and a false
 	value disables threading.
@@ -1416,7 +1416,7 @@ instaweb.port::
 interactive.singlekey::
 	In interactive commands, allow the user to provide one-letter
 	input with a single key (i.e., without hitting enter).
-	Currently this is used by the `\--patch` mode of
+	Currently this is used by the `--patch` mode of
 	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
 	setting is silently ignored if portable keystroke input
@@ -1424,13 +1424,13 @@ interactive.singlekey::
 
 log.abbrevCommit::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `\--abbrev-commit`. You may
-	override this option with `\--no-abbrev-commit`.
+	linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
+	override this option with `--no-abbrev-commit`.
 
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
-	`\--date` option.  Possible values are `relative`, `local`,
+	`--date` option.  Possible values are `relative`, `local`,
 	`default`, `iso`, `rfc`, and `short`; see linkgit:git-log[1]
 	for details.
 
@@ -1620,18 +1620,18 @@ pack.indexVersion::
 	and this config option ignored whenever the corresponding pack is
 	larger than 2 GB.
 +
-If you have an old git that does not understand the version 2 `{asterisk}.idx` file,
+If you have an old git that does not understand the version 2 `*.idx` file,
 cloning or fetching over a non native protocol (e.g. "http" and "rsync")
-that will copy both `{asterisk}.pack` file and corresponding `{asterisk}.idx` file from the
+that will copy both `*.pack` file and corresponding `*.idx` file from the
 other side may give you a repository that cannot be accessed with your
-older version of git. If the `{asterisk}.pack` file is smaller than 2 GB, however,
+older version of git. If the `*.pack` file is smaller than 2 GB, however,
 you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
-the `{asterisk}.idx` file.
+the `*.idx` file.
 
 pack.packSizeLimit::
 	The maximum size of a pack.  This setting only affects
 	packing to a file when repacking, i.e. the git:// protocol
-	is unaffected.  It can be overridden by the `\--max-pack-size`
+	is unaffected.  It can be overridden by the `--max-pack-size`
 	option of linkgit:git-repack[1]. The minimum size allowed is
 	limited to 1 MiB. The default is unlimited.
 	Common unit suffixes of 'k', 'm', or 'g' are
@@ -1641,8 +1641,8 @@ pager.<cmd>::
 	If the value is boolean, turns on or off pagination of the
 	output of a particular git subcommand when writing to a tty.
 	Otherwise, turns on pagination for the subcommand using the
-	pager specified by the value of `pager.<cmd>`.  If `\--paginate`
-	or `\--no-pager` is specified on the command line, it takes
+	pager specified by the value of `pager.<cmd>`.  If `--paginate`
+	or `--no-pager` is specified on the command line, it takes
 	precedence over this option.  To disable pagination for all
 	commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
@@ -1650,9 +1650,9 @@ pretty.<name>::
 	Alias for a --pretty= format string, as specified in
 	linkgit:git-log[1]. Any aliases defined here can be used just
 	as the built-in pretty formats could. For example,
-	running `git config pretty.changelog "format:{asterisk} %H %s"`
+	running `git config pretty.changelog "format:* %H %s"`
 	would cause the invocation `git log --pretty=changelog`
-	to be equivalent to running `git log "--pretty=format:{asterisk} %H %s"`.
+	to be equivalent to running `git log "--pretty=format:* %H %s"`.
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
 
@@ -1765,7 +1765,7 @@ remote.<name>.push::
 
 remote.<name>.mirror::
 	If true, pushing to this remote will automatically behave
-	as if the `\--mirror` option was given on the command line.
+	as if the `--mirror` option was given on the command line.
 
 remote.<name>.skipDefaultUpdate::
 	If true, this remote will be skipped by default when updating
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index c57460c..55f499a 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -175,7 +175,7 @@ In the above example output, the function signature was changed
 from both files (hence two `-` removals from both file1 and
 file2, plus `++` to mean one line that was added does not appear
 in either file1 nor file2).  Also eight other lines are the same
-from file1 but do not appear in file2 (hence prefixed with `{plus}`).
+from file1 but do not appear in file2 (hence prefixed with `+`).
 
 When shown by `git diff-tree -c`, it compares the parents of a
 merge commit with the merge result (i.e. file1..fileN are the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 378f19f..6cfedd8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -74,7 +74,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
 --numstat::
-	Similar to `\--stat`, but shows number of added and
+	Similar to `--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index ae413e5..048337b 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -98,8 +98,8 @@ you originally wrote.
 <9> switch to the master branch.
 <10> merge a topic branch into your master branch.
 <11> review commit logs; other forms to limit output can be
-combined and include `\--max-count=10` (show 10 commits),
-`\--until=2005-12-10`, etc.
+combined and include `--max-count=10` (show 10 commits),
+`--until=2005-12-10`, etc.
 <12> view only the changes that touch what's in `curses/`
 directory, since `v2.43` tag.
 
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index ac7006e..59d73e5 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -160,7 +160,7 @@ EXAMPLES
 
 	Same as above, but the format is inferred from the output file.
 
-`git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz`::
+`git archive --format=tar --prefix=git-1.4.0/ v1.4.0^{tree} | gzip >git-1.4.0.tar.gz`::
 
 	Create a compressed tarball for v1.4.0 release, but without a
 	global extended pax header.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 9516914..7ee9236 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -160,7 +160,7 @@ introduced the file with:
 	git log --diff-filter=A --pretty=short -- foo
 
 and then annotate the change between the commit and its
-parents, using `commit{caret}!` notation:
+parents, using `commit^!` notation:
 
 	git blame -C -C -f $commit^! -- foo
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 92b01ec2..16a6b0a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -61,7 +61,7 @@ unbundle <file>::
 	A list of arguments, acceptable to 'git rev-parse' and
 	'git rev-list' (and containing a named ref, see SPECIFYING REFERENCES
 	below), that specifies the specific objects and references
-	to transport.  For example, `master{tilde}10..master` causes the
+	to transport.  For example, `master~10..master` causes the
 	current master reference to be packaged along with all objects
 	added since its 10th ancestor commit.  There is no explicit
 	limit to the number of references and objects that may be
@@ -80,12 +80,12 @@ SPECIFYING REFERENCES
 
 'git bundle' will only package references that are shown by
 'git show-ref': this includes heads, tags, and remote heads.  References
-such as `master{tilde}1` cannot be packaged, but are perfectly suitable for
+such as `master~1` cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master{tilde}10`), or implicitly (e.g.
-`master{tilde}10..master`, `--since=10.days.ago master`).
+specified explicitly (e.g. `^master~10`), or implicitly (e.g.
+`master~10..master`, `--since=10.days.ago master`).
 
 It is very important that the basis used be held by the destination.
 It is okay to err on the side of caution, causing the bundle file
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 103e7b1..98009d1 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -40,9 +40,9 @@ git imposes the following rules on how references are named:
 
 . They cannot have ASCII control characters (i.e. bytes whose
   values are lower than \040, or \177 `DEL`), space, tilde `~`,
-  caret `{caret}`, or colon `:` anywhere.
+  caret `^`, or colon `:` anywhere.
 
-. They cannot have question-mark `?`, asterisk `{asterisk}`, or open
+. They cannot have question-mark `?`, asterisk `*`, or open
   bracket `[` anywhere.  See the `--refspec-pattern` option below for
   an exception to this rule.
 
@@ -62,10 +62,10 @@ unquoted (by mistake), and also avoids ambiguities in certain
 reference name expressions (see linkgit:gitrevisions[7]):
 
 . A double-dot `..` is often used as in `ref1..ref2`, and in some
-  contexts this notation means `{caret}ref1 ref2` (i.e. not in
+  contexts this notation means `^ref1 ref2` (i.e. not in
   `ref1` and in `ref2`).
 
-. A tilde `~` and caret `{caret}` are used to introduce the postfix
+. A tilde `~` and caret `^` are used to introduce the postfix
   'nth parent' and 'peel onion' operation.
 
 . A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
@@ -92,9 +92,9 @@ OPTIONS
 --refspec-pattern::
 	Interpret <refname> as a reference name pattern for a refspec
 	(as used with remote repositories).  If this option is
-	enabled, <refname> is allowed to contain a single `{asterisk}`
+	enabled, <refname> is allowed to contain a single `*`
 	in place of a one full pathname component (e.g.,
-	`foo/{asterisk}/bar` but not `foo/bar{asterisk}`).
+	`foo/*/bar` but not `foo/bar*`).
 
 --normalize::
 	Normalize 'refname' by removing any leading slash (`/`)
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c0a96e6..63a2516 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -184,7 +184,7 @@ the conflicted merge in the specified paths.
 +
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
-section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
+section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
@@ -193,11 +193,11 @@ section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 	commit, your HEAD becomes "detached" and you are no longer on
 	any branch (see below for details).
 +
-As a special case, the `"@\{-N\}"` syntax for the N-th last branch
+As a special case, the `"@{-N}"` syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
-`-` which is synonymous with `"@\{-1\}"`.
+`-` which is synonymous with `"@{-1}"`.
 +
-As a further special case, you may use `"A\...B"` as a shortcut for the
+As a further special case, you may use `"A...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fed5097..06a0bfd 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -130,7 +130,7 @@ EXAMPLES
 	Apply the changes introduced by all commits that are ancestors
 	of master but not of HEAD to produce new commits.
 
-`git cherry-pick master{tilde}4 master{tilde}2`::
+`git cherry-pick master~4 master~2`::
 
 	Apply the changes introduced by the fifth and third last
 	commits pointed to by master and create 2 new commits with
@@ -151,7 +151,7 @@ EXAMPLES
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
-`git rev-list --reverse master \-- README | git cherry-pick -n --stdin`::
+`git rev-list --reverse master -- README | git cherry-pick -n --stdin`::
 
 	Apply the changes introduced by all commits on the master
 	branch that touched README to the working tree and index,
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 68abfca..2d695f6 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -42,7 +42,7 @@ The content to be added can be specified in several ways:
 
 5. by using the --interactive or --patch switches with the 'commit' command
    to decide one by one which files or hunks should be part of the commit,
-   before finalizing the operation. See the ``Interactive Mode`` section of
+   before finalizing the operation. See the ``Interactive Mode'' section of
    linkgit:git-add[1] to learn how to operate these modes.
 
 The `--dry-run` option can be used to obtain a
@@ -287,7 +287,7 @@ When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
 called the "index" with 'git add'.  A file can be
 reverted back, only in the index but not in the working tree,
-to that of the last commit with `git reset HEAD \-- <file>`,
+to that of the last commit with `git reset HEAD -- <file>`,
 which effectively reverts 'git add' and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 827bc98..88d814a 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -252,7 +252,7 @@ Configuring database backend
 
 'git-cvsserver' uses the Perl DBI module. Please also read
 its documentation if changing these variables, especially
-about `DBI\->connect()`.
+about `DBI->connect()`.
 
 gitcvs.dbname::
 	Database name. The exact meaning depends on the
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index f37eada..d6487e1 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -104,7 +104,7 @@ marks the same across runs.
 [<git-rev-list-args>...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and references
-       to export.  For example, `master{tilde}10..master` causes the
+       to export.  For example, `master~10..master` causes the
        current master reference to be exported along with all objects
        added since its 10th ancestor commit.
 
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index b52dca5..2620d28 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -479,9 +479,9 @@ current branch value should be written as:
 ----
 	from refs/heads/branch^0
 ----
-The `{caret}0` suffix is necessary as fast-import does not permit a branch to
+The `^0` suffix is necessary as fast-import does not permit a branch to
 start from itself, and the branch is created in memory before the
-`from` command is even read from the input.  Adding `{caret}0` will force
+`from` command is even read from the input.  Adding `^0` will force
 fast-import to resolve the commit through Git's revision parsing library,
 rather than its internal branch table, thereby loading in the
 existing value of the branch.
@@ -979,7 +979,7 @@ Reading from a named tree::
 
 See `filemodify` above for a detailed description of `<path>`.
 
-Output uses the same format as `git ls-tree <tree> {litdd} <path>`:
+Output uses the same format as `git ls-tree <tree> -- <path>`:
 
 ====
 	<mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 0f2f117..81f5823 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -96,8 +96,8 @@ OPTIONS
 --index-filter <command>::
 	This is the filter for rewriting the index.  It is similar to the
 	tree filter but does not check out the tree, which makes it much
-	faster.  Frequently used with `git rm \--cached
-	\--ignore-unmatch ...`, see EXAMPLES below.  For hairy
+	faster.  Frequently used with `git rm --cached
+	--ignore-unmatch ...`, see EXAMPLES below.  For hairy
 	cases, see linkgit:git-update-index[1].
 
 --parent-filter <command>::
@@ -222,11 +222,11 @@ However, if the file is absent from the tree of some commit,
 a simple `rm filename` will fail for that tree and commit.
 Thus you may instead want to use `rm -f filename` as the script.
 
-Using `\--index-filter` with 'git rm' yields a significantly faster
+Using `--index-filter` with 'git rm' yields a significantly faster
 version.  Like with using `rm filename`, `git rm --cached filename`
 will fail if the file is absent from the tree of a commit.  If you
 want to "completely forget" a file, it does not matter when it entered
-history, so we also add `\--ignore-unmatch`:
+history, so we also add `--ignore-unmatch`:
 
 --------------------------------------------------------------------------
 git filter-branch --index-filter 'git rm --cached --ignore-unmatch filename' HEAD
@@ -242,8 +242,8 @@ git filter-branch --subdirectory-filter foodir -- --all
 -------------------------------------------------------
 
 Thus you can, e.g., turn a library subdirectory into a repository of
-its own.  Note the `\--` that separates 'filter-branch' options from
-revision options, and the `\--all` to rewrite all branches and tags.
+its own.  Note the `--` that separates 'filter-branch' options from
+revision options, and the `--all` to rewrite all branches and tags.
 
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
@@ -371,23 +371,23 @@ Checklist for Shrinking a Repository
 ------------------------------------
 
 git-filter-branch is often used to get rid of a subset of files,
-usually with some combination of `\--index-filter` and
-`\--subdirectory-filter`.  People expect the resulting repository to
+usually with some combination of `--index-filter` and
+`--subdirectory-filter`.  People expect the resulting repository to
 be smaller than the original, but you need a few more steps to
 actually make it smaller, because git tries hard not to lose your
 objects until you tell it to.  First make sure that:
 
 * You really removed all variants of a filename, if a blob was moved
-  over its lifetime.  `git log \--name-only \--follow \--all \--
-  filename` can help you find renames.
+  over its lifetime.  `git log --name-only --follow --all -- filename`
+  can help you find renames.
 
-* You really filtered all refs: use `\--tag-name-filter cat \--
-  \--all` when calling git-filter-branch.
+* You really filtered all refs: use `--tag-name-filter cat -- --all`
+  when calling git-filter-branch.
 
 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
 
-* Clone it with `git clone +++file:///path/to/repo+++`.  The clone
+* Clone it with `git clone file:///path/to/repo`.  The clone
   will not have the removed objects.  See linkgit:git-clone[1].  (Note
   that cloning with a plain path just hardlinks everything!)
 
@@ -397,14 +397,14 @@ approach, so *make a backup* or go back to cloning it.  You have been
 warned.
 
 * Remove the original refs backed up by git-filter-branch: say `git
-  for-each-ref \--format="%(refname)" refs/original/ | xargs -n 1 git
+  for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git
   update-ref -d`.
 
-* Expire all reflogs with `git reflog expire \--expire=now \--all`.
+* Expire all reflogs with `git reflog expire --expire=now --all`.
 
-* Garbage collect all unreferenced objects with `git gc \--prune=now`
+* Garbage collect all unreferenced objects with `git gc --prune=now`
   (or if your git-gc is not new enough to support arguments to
-  `\--prune`, use `git repack -ad; git prune` instead).
+  `--prune`, use `git repack -ad; git prune` instead).
 
 GIT
 ---
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6ea9be7..04c7346 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -45,7 +45,7 @@ There are two ways to specify which commits to operate on.
 The first rule takes precedence in the case of a single <commit>.  To
 apply the second rule, i.e., format everything since the beginning of
 history up until <commit>, use the '\--root' option: `git format-patch
-\--root <commit>`.  If you want to format only <commit> itself, you
+--root <commit>`.  If you want to format only <commit> itself, you
 can do this with `git format-patch -1 <commit>`.
 
 By default, each output file is numbered sequentially from 1, and uses the
@@ -134,7 +134,7 @@ include::diff-options.txt[]
 The optional <style> argument can be either `shallow` or `deep`.
 'shallow' threading makes every mail a reply to the head of the
 series, where the head is chosen from the cover letter, the
-`\--in-reply-to`, and the first patch mail, in this order.  'deep'
+`--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.
 +
 The default is `--no-thread`, unless the 'format.thread' configuration
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 815afcb..b370b02 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -84,7 +84,7 @@ The optional configuration variable 'gc.reflogExpireUnreachable'
 can be set to indicate how long historical reflog entries which
 are not part of the current branch should remain available in
 this repository.  These types of entries are generally created as
-a result of using `git commit \--amend` or `git rebase` and are the
+a result of using `git commit --amend` or `git rebase` and are the
 commits prior to the amend or rebase occurring.  Since these changes
 are not part of the current project most users will want to expire
 them sooner.  This option defaults to '30 days'.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 343eadd..4785f1c 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -247,11 +247,11 @@ OPTIONS
 Examples
 --------
 
-`git grep {apostrophe}time_t{apostrophe} \-- {apostrophe}*.[ch]{apostrophe}`::
+`git grep 'time_t' -- '*.[ch]'`::
 	Looks for `time_t` in all tracked .c and .h files in the working
 	directory and its subdirectories.
 
-`git grep -e {apostrophe}#define{apostrophe} --and \( -e MAX_PATH -e PATH_MAX \)`::
+`git grep -e '#define' --and \( -e MAX_PATH -e PATH_MAX \)`::
 	Looks for a line that has `#define` and either `MAX_PATH` or
 	`PATH_MAX`.
 
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 249fc87..1f90620 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -100,7 +100,7 @@ Examples
 	Show all commits since version 'v2.6.12' that changed any file
 	in the include/scsi or drivers/scsi subdirectories
 
-`git log --since="2 weeks ago" \-- gitk`::
+`git log --since="2 weeks ago" -- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index e8319ea..b95aafa 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -70,7 +70,7 @@ copy::
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
 +
-In `\--stdin` mode, take lines in the format
+In `--stdin` mode, take lines in the format
 +
 ----------
 <from-object> SP <to-object> [ SP <rest> ] LF
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index a3c6677..10afd4e 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -32,7 +32,7 @@ Subsequent updates to branches always create new files under
 
 A recommended practice to deal with a repository with too many
 refs is to pack its refs with `--all --prune` once, and
-occasionally run `git pack-refs \--prune`.  Tags are by
+occasionally run `git pack-refs --prune`.  Tags are by
 definition stationary and are not expected to change.  Branch
 heads will be packed with the initial `pack-refs --all`, but
 only the currently active branch heads will become unpacked,
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 0f18ec8..defb544 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -110,7 +110,7 @@ include::merge-options.txt[]
 +
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
-`{litdd}rebase` instead of merging.
+`--rebase` instead of merging.
 +
 [NOTE]
 This is a potentially _dangerous_ mode of operation.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a52b7b1..cb97cc1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -34,7 +34,7 @@ OPTIONS[[OPTIONS]]
 
 <refspec>...::
 	The format of a <refspec> parameter is an optional plus
-	`{plus}`, followed by the source ref <src>, followed
+	`+`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
 	It is used to specify with what <src> object the <dst> ref
 	in the remote repository is to be updated.
@@ -50,7 +50,7 @@ updated.
 +
 The object referenced by <src> is used to update the <dst> reference
 on the remote side, but by default this is only allowed if the
-update can fast-forward <dst>.  By having the optional leading `{plus}`,
+update can fast-forward <dst>.  By having the optional leading `+`,
 you can tell git to update the <dst> ref even when the update is not a
 fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
 EXAMPLES below for details.
@@ -60,7 +60,7 @@ EXAMPLES below for details.
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
-The special refspec `:` (or `{plus}:` to allow non-fast-forward updates)
+The special refspec `:` (or `+:` to allow non-fast-forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
@@ -75,7 +75,7 @@ nor in any Push line of the corresponding remotes file---see below).
 	Remove remote branches that don't have a local counterpart. For example
 	a remote branch `tmp` will be removed if a local branch with the same
 	name doesn't exist any more. This also respects refspecs, e.g.
-	`git push --prune remote refs/heads/{asterisk}:refs/tmp/{asterisk}` would
+	`git push --prune remote refs/heads/*:refs/tmp/*` would
 	make sure that remote `refs/tmp/foo` will be removed if `refs/heads/foo`
 	doesn't exist.
 
@@ -210,7 +210,7 @@ option is used.
 flag::
 	A single character indicating the status of the ref:
 (space);; for a successfully pushed fast-forward;
-`{plus}`;; for a successful forced update;
+`+`;; for a successful forced update;
 `-`;; for a successfully deleted ref;
 `*`;; for a successfully pushed new ref;
 `!`;; for a ref that was rejected or failed to push; and
@@ -220,7 +220,7 @@ summary::
 	For a successfully pushed ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
-	`<old>\...<new>` for forced non-fast-forward updates).
+	`<old>...<new>` for forced non-fast-forward updates).
 +
 For a failed update, more details are given:
 +
@@ -402,7 +402,7 @@ the ones in the examples below) can be configured as the default for
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
-`git push origin {plus}dev:master`::
+`git push origin +dev:master`::
 	Update the origin repository's master branch with the dev branch,
 	allowing non-fast-forward updates.  *This can leave unreferenced
 	commits dangling in the origin repository.*  Consider the
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 520aaa9..b0e13e5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -267,7 +267,7 @@ which makes little sense.
 -X <strategy-option>::
 --strategy-option=<strategy-option>::
 	Pass the <strategy-option> through to the merge strategy.
-	This implies `\--merge` and, if no strategy has been
+	This implies `--merge` and, if no strategy has been
 	specified, `-s recursive`.  Note the reversal of 'ours' and
 	'theirs' as noted in above for the `-m` option.
 
@@ -611,8 +611,8 @@ Easy case: The changes are literally the same.::
 Hard case: The changes are not the same.::
 
 	This happens if the 'subsystem' rebase had conflicts, or used
-	`\--interactive` to omit, edit, squash, or fixup commits; or
-	if the upstream used one of `commit \--amend`, `reset`, or
+	`--interactive` to omit, edit, squash, or fixup commits; or
+	if the upstream used one of `commit --amend`, `reset`, or
 	`filter-branch`.
 
 
@@ -648,7 +648,7 @@ correspond to the ones before the rebase.
 NOTE: While an "easy case recovery" sometimes appears to be successful
       even in the hard case, it may have unintended consequences.  For
       example, a commit that was removed via `git rebase
-      \--interactive` will be **resurrected**!
+      --interactive` will be **resurrected**!
 
 The idea is to manually tell 'git rebase' "where the old 'subsystem'
 ended and your 'topic' began", that is, what the old merge-base
@@ -656,7 +656,7 @@ between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
 * With the 'subsystem' reflog: after 'git fetch', the old tip of
-  'subsystem' is at `subsystem@\{1}`.  Subsequent fetches will
+  'subsystem' is at `subsystem@{1}`.  Subsequent fetches will
   increase the number.  (See linkgit:git-reflog[1].)
 
 * Relative to the tip of 'topic': knowing that your 'topic' has three
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 976dc14..7fe2d22 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -39,13 +39,13 @@ as well).  It is an alias for `git log -g --abbrev-commit --pretty=oneline`;
 see linkgit:git-log[1].
 
 The reflog is useful in various git commands, to specify the old value
-of a reference. For example, `HEAD@\{2\}` means "where HEAD used to be
-two moves ago", `master@\{one.week.ago\}` means "where master used to
+of a reference. For example, `HEAD@{2}` means "where HEAD used to be
+two moves ago", `master@{one.week.ago}` means "where master used to
 point to one week ago", and so on. See linkgit:gitrevisions[7] for
 more details.
 
 To delete single entries from the reflog, use the subcommand "delete"
-and specify the _exact_ entry (e.g. "`git reflog delete master@\{2\}`").
+and specify the _exact_ entry (e.g. "`git reflog delete master@{2}`").
 
 
 OPTIONS
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 674797c..f5836e4 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -87,7 +87,7 @@ to the `capabilities` command (see COMMANDS, below).
 	capability use this.
 +
 A helper advertising the capability
-`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
+`refspec refs/heads/*:refs/svn/origin/branches/*`
 is saying that, when it is asked to `import refs/heads/topic`, the
 stream it outputs will update the `refs/svn/origin/branches/topic`
 ref.
@@ -96,7 +96,7 @@ This capability can be advertised multiple times.  The first
 applicable refspec takes precedence.  The left-hand of refspecs
 advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
-there is an implied `refspec {asterisk}:{asterisk}`.
+there is an implied `refspec *:*`.
 
 Capabilities for Pushing
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -148,7 +148,7 @@ Other frontends may have some other order of preference.
 	This modifies the 'import' capability.
 +
 A helper advertising
-`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
+`refspec refs/heads/*:refs/svn/origin/branches/*`
 in its capabilities is saying that, when it handles
 `import refs/heads/topic`, the stream it outputs will update the
 `refs/svn/origin/branches/topic` ref.
@@ -157,7 +157,7 @@ This capability can be advertised multiple times.  The first
 applicable refspec takes precedence.  The left-hand of refspecs
 advertised with this capability must cover all refs reported by
 the list command.  If no 'refspec' capability is advertised,
-there is an implied `refspec {asterisk}:{asterisk}`.
+there is an implied `refspec *:*`.
 
 INVOCATION
 ----------
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index d376d19..a308f4c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -67,14 +67,14 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch. See also the set-head command.
 +
-When a fetch mirror is created with `\--mirror=fetch`, the refs will not
+When a fetch mirror is created with `--mirror=fetch`, the refs will not
 be stored in the 'refs/remotes/' namespace, but rather everything in
 'refs/' on the remote will be directly mirrored into 'refs/' in the
 local repository. This option only makes sense in bare repositories,
 because a fetch would overwrite any local commits.
 +
-When a push mirror is created with `\--mirror=push`, then `git push`
-will always behave as if `\--mirror` was passed.
+When a push mirror is created with `--mirror=push`, then `git push`
+will always behave as if `--mirror` was passed.
 
 'rename'::
 
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index b43b7c8..a62227f 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -101,15 +101,15 @@ One way to do it is to pull master into the topic branch:
 
 The commits marked with `*` touch the same area in the same
 file; you need to resolve the conflicts when creating the commit
-marked with `{plus}`.  Then you can test the result to make sure your
+marked with `+`.  Then you can test the result to make sure your
 work-in-progress still works with what is in the latest master.
 
 After this test merge, there are two ways to continue your work
 on the topic.  The easiest is to build on top of the test merge
-commit `{plus}`, and when your work in the topic branch is finally
+commit `+`, and when your work in the topic branch is finally
 ready, pull the topic branch into master, and/or ask the
 upstream to pull from you.  By that time, however, the master or
-the upstream might have been advanced since the test merge `{plus}`,
+the upstream might have been advanced since the test merge `+`,
 in which case the final commit graph would look like this:
 
 ------------
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b674866..117e374 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -41,7 +41,7 @@ working tree in one go.
 +
 This means that `git reset -p` is the opposite of `git add -p`, i.e.
 you can use it to selectively reset hunks. See the ``Interactive Mode''
-section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
+section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
 'git reset' --<mode> [<commit>]::
 	This form resets the current branch head to <commit> and
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8023dc0..f63b81a 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -113,15 +113,14 @@ OPTIONS
 +
 If a `pattern` is given, only refs matching the given shell glob are
 shown.  If the pattern does not contain a globbing character (`?`,
-`{asterisk}`, or `[`), it is turned into a prefix match by
-appending `/{asterisk}`.
+`*`, or `[`), it is turned into a prefix match by appending `/*`.
 
 --glob=pattern::
 	Show all refs matching the shell glob pattern `pattern`. If
 	the pattern does not start with `refs/`, this is automatically
 	prepended.  If the pattern does not contain a globbing
-	character (`?`, `{asterisk}`, or `[`), it is turned into a prefix
-	match by appending `/{asterisk}`.
+	character (`?`, `*`, or `[`), it is turned into a prefix
+	match by appending `/*`.
 
 --show-toplevel::
 	Show the absolute path of the top-level directory.
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index b699a34..70152e8 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -27,7 +27,7 @@ throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the '--hard' option.  If
 you want to extract specific files as they were in another commit, you
 should see linkgit:git-checkout[1], specifically the `git checkout
-<commit> \-- <filename>` syntax.  Take care with these alternatives as
+<commit> -- <filename>` syntax.  Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
 OPTIONS
@@ -105,7 +105,7 @@ EXAMPLES
 	Revert the changes specified by the fourth last commit in HEAD
 	and create a new commit with the reverted changes.
 
-`git revert -n master{tilde}5..master{tilde}2`::
+`git revert -n master~5..master~2`::
 
 	Revert the changes done by commits from the fifth last commit
 	in master (included) to the third last commit in master
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 665ad4d..5d31860 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -79,8 +79,7 @@ a file that you have not told git about does not remove that file.
 
 File globbing matches across directory boundaries.  Thus, given
 two directories `d` and `d2`, there is a difference between
-using `git rm {apostrophe}d{asterisk}{apostrophe}` and
-`git rm {apostrophe}d/{asterisk}{apostrophe}`, as the former will
+using `git rm 'd*'` and `git rm 'd/*'`, as the former will
 also remove all of directory `d2`.
 
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index ff3755b..01d8417 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -47,7 +47,7 @@ OPTIONS
 --format[=<format>]::
 	Instead of the commit subject, use some other information to
 	describe each commit.  '<format>' can be any string accepted
-	by the `--format` option of 'git log', such as '{asterisk} [%h] %s'.
+	by the `--format` option of 'git log', such as '* [%h] %s'.
 	(See the "PRETTY FORMATS" section of linkgit:git-log[1].)
 
 	Each pretty-printed commit will be rewrapped before it is shown.
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index fcee000..5dbcd47 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -73,7 +73,7 @@ OPTIONS
 --exclude-existing[=<pattern>]::
 
 	Make 'git show-ref' act as a filter that reads refs from stdin of the
-	form "`{caret}(?:<anything>\s)?<refname>(?:{backslash}{caret}{})?$`"
+	form "`^(?:<anything>\s)?<refname>(?:\^{})?$`"
 	and performs the following actions on each:
 	(1) strip "{caret}{}" at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 1e38819..ae4edcc 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -52,10 +52,10 @@ EXAMPLES
 	Shows the tag `v1.0.0`, along with the object the tags
 	points at.
 
-`git show v1.0.0^\{tree\}`::
+`git show v1.0.0^{tree}`::
 	Shows the tree pointed to by the tag `v1.0.0`.
 
-`git show -s --format=%s v1.0.0^\{commit\}`::
+`git show -s --format=%s v1.0.0^{commit}`::
 	Shows the subject of the commit pointed to by the
 	tag `v1.0.0`.
 
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 43af38a..0aa4e20 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -36,8 +36,8 @@ you create one.
 
 The latest stash you created is stored in `refs/stash`; older
 stashes are found in the reflog of this reference and can be named using
-the usual reflog syntax (e.g. `stash@\{0}` is the most recently
-created stash, `stash@\{1}` is the one before it, `stash@\{2.hours.ago}`
+the usual reflog syntax (e.g. `stash@{0}` is the most recently
+created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible).
 
 OPTIONS
@@ -66,7 +66,7 @@ constructed such that its index state is the same as the index state
 of your repository, and its worktree contains only the changes you
 selected interactively.  The selected changes are then rolled back
 from your worktree. See the ``Interactive Mode'' section of
-linkgit:git-add[1] to learn how to operate the `\--patch` mode.
+linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
@@ -74,7 +74,7 @@ The `--patch` option implies `--keep-index`.  You can use
 list [<options>]::
 
 	List the stashes that you currently have.  Each 'stash' is listed
-	with its name (e.g. `stash@\{0}` is the latest stash, `stash@\{1}` is
+	with its name (e.g. `stash@{0}` is the latest stash, `stash@{1}` is
 	the one before, etc.), the name of the branch that was current when the
 	stash was made, and a short description of the commit the stash was
 	based on.
@@ -93,7 +93,7 @@ show [<stash>]::
 	stashed state and its original parent. When no `<stash>` is given,
 	shows the latest one. By default, the command shows the diffstat, but
 	it will accept any format known to 'git diff' (e.g., `git stash show
-	-p stash@\{1}` to view the second most recent stash in patch form).
+	-p stash@{1}` to view the second most recent stash in patch form).
 
 pop [--index] [-q|--quiet] [<stash>]::
 
@@ -111,8 +111,8 @@ tree's changes, but also the index's ones. However, this can fail, when you
 have conflicts (which are stored in the index, where you therefore can no
 longer apply the changes as they were originally).
 +
-When no `<stash>` is given, `stash@\{0}` is assumed, otherwise `<stash>` must
-be a reference of the form `stash@\{<revision>}`.
+When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
+be a reference of the form `stash@{<revision>}`.
 
 apply [--index] [-q|--quiet] [<stash>]::
 
@@ -143,9 +143,9 @@ clear::
 drop [-q|--quiet] [<stash>]::
 
 	Remove a single stashed state from the stash list. When no `<stash>`
-	is given, it removes the latest one. i.e. `stash@\{0}`, otherwise
+	is given, it removes the latest one. i.e. `stash@{0}`, otherwise
 	`<stash>` must a valid stash log reference of the form
-	`stash@\{<revision>}`.
+	`stash@{<revision>}`.
 
 create::
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 3d51717..a29aae6 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -98,12 +98,12 @@ In the short-format, the status of each path is shown as
 
 	XY PATH1 -> PATH2
 
-where `PATH1` is the path in the `HEAD`, and the ` \-> PATH2` part is
+where `PATH1` is the path in the `HEAD`, and the " `-> PATH2`" part is
 shown only when `PATH1` corresponds to a different path in the
 index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
 status code.
 
-The fields (including the `\->`) are separated from each other by a
+The fields (including the `->`) are separated from each other by a
 single space. If a filename contains whitespace or other nonprintable
 characters, that field will be quoted in the manner of a C string
 literal: surrounded by ASCII double quote (34) characters, and with
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 346e7a2..f7362dc 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -63,7 +63,7 @@ EXAMPLES
 
 	Create a tarball for v1.4.0 release.
 
-`git tar-tree v1.4.0{caret}\{tree\} git-1.4.0 | gzip >git-1.4.0.tar.gz`::
+`git tar-tree v1.4.0^{tree} git-1.4.0 | gzip >git-1.4.0.tar.gz`::
 
 	Create a tarball for v1.4.0 release, but without a
 	global extended pax header.
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 76c7f7e..6c8f510 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -58,7 +58,7 @@ Examples
 	Show as patches the commits since version 'v2.6.12' that changed
 	any file in the include/scsi or drivers/scsi subdirectories
 
-`git whatchanged --since="2 weeks ago" \-- gitk`::
+`git whatchanged --since="2 weeks ago" -- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
 	The "--" is necessary to avoid confusion with the *branch* named
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index f734f97..ea17f7a 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -25,22 +25,22 @@ arguments.  Here are the rules:
    are paths.
 
  * When an argument can be misunderstood as either a revision or a path,
-   they can be disambiguated by placing `\--` between them.
-   E.g. `git diff \-- HEAD` is, "I have a file called HEAD in my work
+   they can be disambiguated by placing `--` between them.
+   E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the index
    and what I have in the work tree for that file". not "show difference
    between the HEAD commit and the work tree as a whole".  You can say
-   `git diff HEAD \--` to ask for the latter.
+   `git diff HEAD --` to ask for the latter.
 
- * Without disambiguating `\--`, git makes a reasonable guess, but errors
+ * Without disambiguating `--`, git makes a reasonable guess, but errors
    out and asking you to disambiguate when ambiguous.  E.g. if you have a
    file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
-   you have to say either `git diff HEAD \--` or `git diff \-- HEAD` to
+   you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
 
 When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
-disambiguating `\--` at appropriate places.
+disambiguating `--` at appropriate places.
 
 Here are the rules regarding the "flags" that you should follow when you are
 scripting git:
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index fb0d569..f5074a8 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -151,8 +151,8 @@ to your working tree, you use the 'git update-index' program. That
 program normally just takes a list of filenames you want to update, but
 to avoid trivial mistakes, it refuses to add new entries to the index
 (or remove existing ones) unless you explicitly tell it that you're
-adding a new entry with the `\--add` flag (or removing an entry with the
-`\--remove`) flag.
+adding a new entry with the `--add` flag (or removing an entry with the
+`--remove`) flag.
 
 So to populate the index with the two files you just created, you can do
 
@@ -399,10 +399,10 @@ $ git diff HEAD
 which ends up doing the above for you.
 
 In other words, 'git diff-index' normally compares a tree against the
-working tree, but when given the `\--cached` flag, it is told to
+working tree, but when given the `--cached` flag, it is told to
 instead compare against just the index cache contents, and ignore the
 current working tree state entirely. Since we just wrote the index
-file to HEAD, doing `git diff-index \--cached -p HEAD` should thus return
+file to HEAD, doing `git diff-index --cached -p HEAD` should thus return
 an empty set of differences, and that's exactly what it does.
 
 [NOTE]
@@ -411,7 +411,7 @@ an empty set of differences, and that's exactly what it does.
 comparisons, and saying that it compares a tree against the working
 tree is thus not strictly accurate. In particular, the list of
 files to compare (the "meta-data") *always* comes from the index file,
-regardless of whether the `\--cached` flag is used or not. The `\--cached`
+regardless of whether the `--cached` flag is used or not. The `--cached`
 flag really only determines whether the file *contents* to be compared
 come from the working tree or not.
 
@@ -433,7 +433,7 @@ update the index cache:
 $ git update-index hello
 ------------------------------------------------
 
-(note how we didn't need the `\--add` flag this time, since git knew
+(note how we didn't need the `--add` flag this time, since git knew
 about the file already).
 
 Note what happens to the different 'git diff-{asterisk}' versions here.
@@ -560,7 +560,7 @@ short history.
 When using the above two commands, the initial commit will be shown.
 If this is a problem because it is huge, you can hide it by setting
 the log.showroot configuration variable to false. Having this, you
-can still show it for each command just adding the `\--root` option,
+can still show it for each command just adding the `--root` option,
 which is a flag for 'git diff-tree' accepted by both commands.
 
 With that, you should now be having some inkling of what git does, and
@@ -881,7 +881,7 @@ helps you view what's going on:
 $ gitk --all
 ----------------
 
-will show you graphically both of your branches (that's what the `\--all`
+will show you graphically both of your branches (that's what the `--all`
 means: normally it will just show you your current `HEAD`) and their
 histories. You can also see exactly how they came to be from a common
 source.
@@ -935,7 +935,7 @@ which will very loudly warn you that you're now committing a merge
 (which is correct, so never mind), and you can write a small merge
 message about your adventures in 'git merge'-land.
 
-After you're done, start up `gitk \--all` to see graphically what the
+After you're done, start up `gitk --all` to see graphically what the
 history looks like. Notice that `mybranch` still exists, and you can
 switch to it, and continue to work with it if you want to. The
 `mybranch` branch will not contain the merge, but next time you merge it
@@ -958,11 +958,11 @@ $ git show-branch --topo-order --more=1 master mybranch
 The first two lines indicate that it is showing the two branches
 and the first line of the commit log message from their
 top-of-the-tree commits, you are currently on `master` branch
-(notice the asterisk `{asterisk}` character), and the first column for
+(notice the asterisk `*` character), and the first column for
 the later output lines is used to show commits contained in the
 `master` branch, and the second column for the `mybranch`
 branch. Three commits are shown along with their log messages.
-All of them have non blank characters in the first column (`{asterisk}`
+All of them have non blank characters in the first column (`*`
 shows an ordinary commit on the current branch, `-` is a merge commit), which
 means they are now part of the `master` branch. Only the "Some
 work" commit has the plus `+` character in the second column,
@@ -1013,7 +1013,7 @@ not actually do a merge. Instead, it just updated the top of
 the tree of your branch to that of the `master` branch. This is
 often called 'fast-forward' merge.
 
-You can run `gitk \--all` again to see how the commit ancestry
+You can run `gitk --all` again to see how the commit ancestry
 looks like, or run 'show-branch', which tells you this.
 
 ------------------------------------------------
@@ -1257,7 +1257,7 @@ this 'collapsing' tends to trivially merge most of the paths
 fairly quickly, leaving only a handful of real changes in non-zero
 stages.
 
-To look at only non-zero stages, use `\--unmerged` flag:
+To look at only non-zero stages, use `--unmerged` flag:
 
 ------------
 $ git ls-files --unmerged
@@ -1420,7 +1420,7 @@ packed, and stores the packed file in `.git/objects/pack`
 directory.
 
 [NOTE]
-You will see two files, `pack-{asterisk}.pack` and `pack-{asterisk}.idx`,
+You will see two files, `pack-*.pack` and `pack-*.idx`,
 in `.git/objects/pack` directory. They are closely related to
 each other, and if you ever copy them by hand to a different
 repository for whatever reason, you should make sure you copy
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 066f825..7dfffc0 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -143,8 +143,8 @@ CONFIGURATION OPTIONS
 ---------------------
 
 Options for a credential context can be configured either in
-`credential.\*` (which applies to all credentials), or
-`credential.<url>.\*`, where <url> matches the context as described
+`credential.*` (which applies to all credentials), or
+`credential.<url>.*`, where <url> matches the context as described
 above.
 
 The following options are available in either location:
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 370624c..daf1782 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -168,11 +168,11 @@ a similarity score different from the default of 50% by giving a
 number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
 8/10 = 80%).
 
-Note.  When the "-C" option is used with `\--find-copies-harder`
+Note.  When the "-C" option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
 detector consider unmodified files as copy source candidates at
-the expense of making it slower.  Without `\--find-copies-harder`,
+the expense of making it slower.  Without `--find-copies-harder`,
 'git diff-{asterisk}' commands can detect copies only if the file that was
 copied happened to have been modified in the same changeset.
 
@@ -224,7 +224,7 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation is used to find filepairs that represent
 changes that touch a specified string, and is controlled by the
--S option and the `\--pickaxe-all` option to the 'git diff-{asterisk}'
+-S option and the `--pickaxe-all` option to the 'git diff-*'
 commands.
 
 When diffcore-pickaxe is in use, it checks if there are
@@ -233,9 +233,9 @@ different number of specified string.  Such a filepair represents
 "the string appeared in this changeset".  It also checks for the
 opposite case that loses the specified string.
 
-When `\--pickaxe-all` is not in effect, diffcore-pickaxe leaves
+When `--pickaxe-all` is not in effect, diffcore-pickaxe leaves
 only such filepairs that touch the specified string in its
-output.  When `\--pickaxe-all` is used, diffcore-pickaxe leaves all
+output.  When `--pickaxe-all` is used, diffcore-pickaxe leaves all
 filepairs intact if there is such a filepair, or makes the
 output empty otherwise.  The latter behaviour is designed to
 make reviewing of the changes in the context of the whole
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 28edefa..b9003fe 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -73,7 +73,7 @@ pre-commit
 ~~~~~~~~~~
 
 This hook is invoked by 'git commit', and can be bypassed
-with `\--no-verify` option.  It takes no parameter, and is
+with `--no-verify` option.  It takes no parameter, and is
 invoked before obtaining the proposed commit log message and
 making a commit.  Exiting with non-zero status from this script
 causes the 'git commit' to abort.
@@ -99,12 +99,12 @@ given); `template` (if a `-t` option was given or the
 configuration option `commit.template` is set); `merge` (if the
 commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
 (if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
-a commit SHA1 (if a `-c`, `-C` or `\--amend` option was given).
+a commit SHA1 (if a `-c`, `-C` or `--amend` option was given).
 
 If the exit status is non-zero, 'git commit' will abort.
 
 The purpose of the hook is to edit the message file in place, and
-it is not suppressed by the `\--no-verify` option.  A non-zero exit
+it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
 be used as replacement for pre-commit hook.
 
@@ -115,7 +115,7 @@ commit-msg
 ~~~~~~~~~~
 
 This hook is invoked by 'git commit', and can be bypassed
-with `\--no-verify` option.  It takes a single parameter, the
+with `--no-verify` option.  It takes a single parameter, the
 name of the file that holds the proposed commit log message.
 Exiting with non-zero status causes the 'git commit' to
 abort.
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 7aba497..1cea8cb 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -749,14 +749,14 @@ Project specific override is not supported.
 forks::
 	If this feature is enabled, gitweb considers projects in
 	subdirectories of project root (basename) to be forks of existing
-	projects.  For each project `$projname.git`, projects in the
-	`$projname/` directory and its subdirectories will not be
-	shown in the main projects list.  Instead, a \'+' mark is shown
-	next to `$projname`, which links to a "forks" view that lists all
-	the forks (all projects in `$projname/` subdirectory).  Additionally
+	projects.  For each project +$projname.git+, projects in the
+	+$projname/+ directory and its subdirectories will not be
+	shown in the main projects list.  Instead, a \'\+' mark is shown
+	next to +$projname+, which links to a "forks" view that lists all
+	the forks (all projects in +$projname/+ subdirectory).  Additionally
 	a "forks" view for a project is linked from project summary page.
 +
-If the project list is taken from a file (`$projects_list` points to a
+If the project list is taken from a file (+$projects_list+ points to a
 file), forks are only recognized if they are listed after the main project
 in that file.
 +
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 5e4f362..8b8c6ae 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -39,8 +39,8 @@ To achieve this, try to split your work into small steps from the very
 beginning. It is always easier to squash a few commits together than
 to split one big commit into several.  Don't be afraid of making too
 small or imperfect steps along the way. You can always go back later
-and edit the commits with `git rebase \--interactive` before you
-publish them.  You can use `git stash save \--keep-index` to run the
+and edit the commits with `git rebase --interactive` before you
+publish them.  You can use `git stash save --keep-index` to run the
 test suite independent of other uncommitted changes; see the EXAMPLES
 section of linkgit:git-stash[1].
 
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 880b6f2..e3d8a83 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -130,8 +130,8 @@ The placeholders are:
 - '%b': body
 - '%B': raw body (unwrapped subject and body)
 - '%N': commit notes
-- '%gD': reflog selector, e.g., `refs/stash@\{1\}`
-- '%gd': shortened reflog selector, e.g., `stash@\{1\}`
+- '%gD': reflog selector, e.g., `refs/stash@{1}`
+- '%gd': shortened reflog selector, e.g., `stash@{1}`
 - '%gn': reflog identity name
 - '%gN': reflog identity name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ge': reflog identity email
@@ -155,7 +155,7 @@ insert an empty string unless we are traversing reflog entries (e.g., by
 `git log -g`). The `%d` placeholder will use the "short" decoration
 format if `--decorate` was not already provided on the command line.
 
-If you add a `{plus}` (plus sign) after '%' of a placeholder, a line-feed
+If you add a `+` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
 
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 5dd6e5a..94a9d32 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -13,7 +13,7 @@ endif::git-pull[]
 
 <refspec>::
 	The format of a <refspec> parameter is an optional plus
-	`{plus}`, followed by the source ref <src>, followed
+	`+`, followed by the source ref <src>, followed
 	by a colon `:`, followed by the destination ref <dst>.
 +
 The remote ref that matches <src>
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 6a4b635..1ae3c89 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -198,7 +198,7 @@ excluded from the output.
 +
 For example, `--cherry-pick --right-only A...B` omits those
 commits from `B` which are in `A` or are patch-equivalent to a commit in
-`A`. In other words, this lists the `{plus}` commits from `git cherry A B`.
+`A`. In other words, this lists the `+` commits from `git cherry A B`.
 More precisely, `--cherry-pick --right-only --no-merges` gives the exact
 list.
 
@@ -455,7 +455,7 @@ The effect of this is best shown by way of comparing to
 	  `---------'
 -----------------------------------------------------------------------
 +
-Note the major differences in `N` and `P` over '\--full-history':
+Note the major differences in `N` and `P` over '--full-history':
 +
 --
 * `N`'s parent list had `I` removed, because it is an ancestor of the
@@ -494,7 +494,7 @@ of course).
 When we want to find out what commits in `M` are contaminated with the
 bug introduced by `D` and need fixing, however, we might want to view
 only the subset of 'D..M' that are actually descendants of `D`, i.e.
-excluding `C` and `K`. This is exactly what the '\--ancestry-path'
+excluding `C` and `K`. This is exactly what the '--ancestry-path'
 option does. Applied to the 'D..M' range, it results in:
 +
 -----------------------------------------------------------------------
diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 2527b7e..3062389 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -21,7 +21,7 @@ that allow to change the behavior of a command.
 * There are basically two forms of options:
   'Short options' consist of one dash (`-`) and one alphanumeric
   character.
-  'Long options' begin with two dashes (`\--`) and some
+  'Long options' begin with two dashes (`--`) and some
   alphanumeric characters.
 
 * Options are case-sensitive.
@@ -31,7 +31,7 @@ The parse-options API allows:
 
 * 'sticked' and 'separate form' of options with arguments.
   `-oArg` is sticked, `-o Arg` is separate form.
-  `\--option=Arg` is sticked, `\--option Arg` is separate form.
+  `--option=Arg` is sticked, `--option Arg` is separate form.
 
 * Long options may be 'abbreviated', as long as the abbreviation
   is unambiguous.
@@ -39,12 +39,12 @@ The parse-options API allows:
 * Short options may be bundled, e.g. `-a -b` can be specified as `-ab`.
 
 * Boolean long options can be 'negated' (or 'unset') by prepending
-  `no-`, e.g. `\--no-abbrev` instead of `\--abbrev`. Conversely,
+  `no-`, e.g. `--no-abbrev` instead of `--abbrev`. Conversely,
   options that begin with `no-` can be 'negated' by removing it.
 
-* Options and non-option arguments can clearly be separated using the `\--`
-  option, e.g. `-a -b \--option \-- \--this-is-a-file` indicates that
-  `\--this-is-a-file` must not be processed as an option.
+* Options and non-option arguments can clearly be separated using the `--`
+  option, e.g. `-a -b --option -- --this-is-a-file` indicates that
+  `--this-is-a-file` must not be processed as an option.
 
 Steps to parse options
 ----------------------
@@ -76,7 +76,7 @@ before the full parser, which in turn shows the full help message.
 Flags are the bitwise-or of:
 
 `PARSE_OPT_KEEP_DASHDASH`::
-	Keep the `\--` that usually separates options from
+	Keep the `--` that usually separates options from
 	non-option arguments.
 
 `PARSE_OPT_STOP_AT_NON_OPTION`::
@@ -114,22 +114,22 @@ say `static struct option builtin_add_options[]`.
 There are some macros to easily define options:
 
 `OPT__ABBREV(&int_var)`::
-	Add `\--abbrev[=<n>]`.
+	Add `--abbrev[=<n>]`.
 
 `OPT__COLOR(&int_var, description)`::
-	Add `\--color[=<when>]` and `--no-color`.
+	Add `--color[=<when>]` and `--no-color`.
 
 `OPT__DRY_RUN(&int_var, description)`::
-	Add `-n, \--dry-run`.
+	Add `-n, --dry-run`.
 
 `OPT__FORCE(&int_var, description)`::
-	Add `-f, \--force`.
+	Add `-f, --force`.
 
 `OPT__QUIET(&int_var, description)`::
-	Add `-q, \--quiet`.
+	Add `-q, --quiet`.
 
 `OPT__VERBOSE(&int_var, description)`::
-	Add `-v, \--verbose`.
+	Add `-v, --verbose`.
 
 `OPT_GROUP(description)`::
 	Start an option group. `description` is a short string that
@@ -216,10 +216,10 @@ The last element of the array must be `OPT_END()`.
 If not stated otherwise, interpret the arguments as follows:
 
 * `short` is a character for the short option
-  (e.g. `{apostrophe}e{apostrophe}` for `-e`, use `0` to omit),
+  (e.g. `'e'` for `-e`, use `0` to omit),
 
 * `long` is a string for the long option
-  (e.g. `"example"` for `\--example`, use `NULL` to omit),
+  (e.g. `"example"` for `--example`, use `NULL` to omit),
 
 * `int_var` is an integer variable,
 
@@ -243,10 +243,10 @@ The function must be defined in this form:
 The callback mechanism is as follows:
 
 * Inside `func`, the only interesting member of the structure
-  given by `opt` is the void pointer `opt\->value`.
-  `\*opt\->value` will be the value that is saved into `var`, if you
+  given by `opt` is the void pointer `opt->value`.
+  `*opt->value` will be the value that is saved into `var`, if you
   use `OPT_CALLBACK()`.
-  For example, do `*(unsigned long *)opt\->value = 42;` to get 42
+  For example, do `*(unsigned long *)opt->value = 42;` to get 42
   into an `unsigned long` variable.
 
 * Return value `0` indicates success and non-zero return
diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
index d30a1b9..fb7ff08 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -36,7 +36,7 @@ More specifically, they:
 
 . They cannot have ASCII control characters (i.e. bytes whose
   values are lower than \040, or \177 `DEL`), space, tilde `~`,
-  caret `{caret}`, colon `:`, question-mark `?`, asterisk `*`,
+  caret `^`, colon `:`, question-mark `?`, asterisk `*`,
   or open bracket `[` anywhere.
 
 . They cannot end with a slash `/` nor a dot `.`.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6c7fee7..1b94207 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1611,7 +1611,7 @@ Recovering lost changes
 Reflogs
 ^^^^^^^
 
-Say you modify a branch with `linkgit:git-reset[1] --hard`, and then
+Say you modify a branch with +linkgit:git-reset[1] \--hard+, and then
 realize that the branch was the only reference you had to that point in
 history.
 
@@ -4207,7 +4207,7 @@ commits one by one with the function `get_revision()`.
 
 If you are interested in more details of the revision walking process,
 just have a look at the first implementation of `cmd_log()`; call
-`git show v1.3.0{tilde}155^2{tilde}4` and scroll down to that function (note that you
+`git show v1.3.0~155^2~4` and scroll down to that function (note that you
 no longer need to call `setup_pager()` directly).
 
 Nowadays, `git log` is a builtin, which means that it is _contained_ in the
@@ -4270,9 +4270,9 @@ Two things are interesting here:
   negative numbers in case of different errors--and 0 on success.
 
 - the variable `sha1` in the function signature of `get_sha1()` is `unsigned
-  char {asterisk}`, but is actually expected to be a pointer to `unsigned
+  char *`, but is actually expected to be a pointer to `unsigned
   char[20]`.  This variable will contain the 160-bit SHA-1 of the given
-  commit.  Note that whenever a SHA-1 is passed as `unsigned char {asterisk}`, it
+  commit.  Note that whenever a SHA-1 is passed as `unsigned char *`, it
   is the binary representation, as opposed to the ASCII representation in
   hex characters, which is passed as `char *`.
 
-- 
1.7.9.6.11.gd9951
