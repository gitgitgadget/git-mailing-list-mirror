From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Fri, 07 Jul 2006 17:37:25 -0700
Message-ID: <7vlkr5szi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jul 08 02:37:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz0p9-0007wS-BT
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 02:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWGHAh2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Jul 2006 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWGHAh1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 20:37:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53182 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932459AbWGHAh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 20:37:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708003726.IKYX19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 20:37:26 -0400
To: git@vger.kernel.org
X-maint-at: 8fced61cbc32f0c4b81a3dcecfeb40b7d96339ce
X-master-at: 6bdca8905764affcab0c92a60a6a319080d76652
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23470>

Many fixes came in since 1.4.1 was done.  Please see the
short-log for what's new in "master".

In the "next" branch, these are cooking:

 - Early parts of Perly Git by Petr Baudis with help from others
   are merged to "next".  Please report breakages before other
   Perl scripts are converted to use this.

 - "diff --text" by Stephan Feder.  I think this one is correct
   and should be very safe, but bugs happen to "obvious" code
   too, so I have not merged it to "master" yet.
=20
 - Move git-svn by Eric Wong out of contrib to make it a
   first-class citizen.

 - "git-merge-tree" improvements by Linus.  I may want to update
   this to use our diff routines, but probably after OLS.

In "pu", there are a few more:

 - An updated result minimization code in merge-base.  I think
   this is correct and is not too expensive.  I'd like to run a
   few more test on this and merge it to "next".

 - Updated upload-pack to avoid letting the downloader to
   traverse commits from a branch all the way down to root in
   vain, when that root is knot known to upload-pack.  This
   needs another round of test with something like Linus's 2.6
   repository and MIPS repository, which costs me quite a lot of
   time so I am postponing it right now.

 - Built-in git-prune by Linus.  I have read the code and did
   not spot problems, and it indeed is a lot faster.  But this
   is git-prune, so I am playing it a bit more cautiously than I
   usually do.

 - GIT_TRACE by Matthias Lederhofer.  What it lets you do is
   interesting (although I personally do not foresee myself
   using it), and I am in favor of its inclusion.  The issue
   that the mechanism does not let you trace some commands
   (scripts) raised on the list has stalled this topic branch.
   I'd either want people to agree that it is not a problem, or
   if they feel it is a problem, have a fix for that, before
   merging this to "next".

 - Auto configuration by Pasky and Jakub.  This deserves a fresh
   paragraph.

The first patch to use autoconf to build ./configure by Jakub
Narebski is in "pu".  I am not against an autoconfiguration
mechanism to maintain config.mak.gen mechanically as an _option_,
and if we are going to have a ./configure script, it would be
better to avoid reinventing the tests autoconf people worked for
a long time to make robust and portable. =20

I hope further patches to this series will be added soon to
autodetect the following in our Makefile (from "pu"):

        NO_D_INO_IN_DIRENT
        NO_D_TYPE_IN_DIRENT
        NO_STRCASESTR
        NO_STRLCPY
        NO_SETENV
        USE_PIC
        NEEDS_SSL_WITH_CRYPTO
        NEEDS_LIBICONV
        NEEDS_SOCKET
        WITH_OWN_SUBPROCESS_PY
        NO_IPV6
        NO_SOCKADDR_STORAGE
        NO_ICONV

These are not something you can change without replacing libc
(or installed Python) wholesale, so autodetection would be
always correct.

Also the following would be nice if autodetection worked for
most of the users with ./configure command line override:

	CC
        AR
	TAR
        INSTALL
	SHELL_PATH
        PERL_PATH
        PYTHON_PATH
	BASIC_CFLAGS 	mostly for -I include paths
        BASIC_LDFLAGS	mostly for -L library paths
	ALL_LDFLAGS
	NO_OPENSSL
        MOZILLA_SHA1
        PPC_SHA1
        ARM_SHA1
        NO_CURL
        NO_EXPAT
        CURLDIR
        OPENSSLDIR
        ICONVDIR
        EXPATDIR (we do not have one, but I think it should be there
		  to allow -lexpat installed elsewhere just like
                  we have CURLDIR and OPENSSLDIR)

Note that I listed NO_OPENSSL, NO_CURL, and NO_EXPAT here not
with the first category, because you may not want to build git
with them even when you do have these libraries.

The directories our stuff will go is builder's policy, so I do
not think automating it is particularly useful, but I am not
opposed if ./configure allowed people to say --prefix=3Dblah.

Because the autodetection of non-policy part is what I primarily
want from ./configure, people who run ./configure without giving
particular --prefix and friends to it should not be burned by
the choice ./configure makes by default.  I presume they can
have their own customized prefix and friends in config.mak which
will be included after config.mak.gen so hopefully that is a
non-issue.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement.

   Dennis Stosberg:
      gitweb: Declare global variables with "our"

   Eric Wong:
      Add git-instaweb, instantly browse the working repo with gitweb
      instaweb: fix unportable ';' usage in sed
      t8001-annotate: fix a bash-ism in this test
      git-svn: avoid fetching files outside of the URL we're tracking
      builtin-log: respect diff configuration options

   Jakub Narebski:
      send-email: format 2822 datestring ourselves.

   Joachim B Haga:
      Make zlib compression level configurable, and change default.
      core.compression documentation formatting fix.

   Johannes Schindelin:
      refactor merge_bases() as preparation to libify merge-base
      move get_merge_bases() to core lib.
      Makefile: replace ugly and unportable sed invocation
      Make git-fmt-merge-msg a builtin

   Junio C Hamano:
      Makefile: add framework to verify and bench sha1 implementations.
      test-sha1: test hashing large buffer
      t4013: add tests for diff/log family output options.
      t4013: add more tests around -c and --cc
      Fix some more diff options changes.
      t4013 test updates for new output code.
      combine-diff.c: type sanity.
      format-patch: fix diff format option implementation
      t4013: add format-patch tests.
      t4013: note improvements brought by the new output code.
      gitweb: optimize per-file history generation
      t4013: add "diff" UI program tests.
      builtin-diff: turn recursive on when defaulting to --patch format=
=2E
      commit.c: do not redefine UNINTERESTING bit.
      Makefile: tighten git-http-{fetch,push} dependencies
      get_merge_bases: clean up even when there is no common commit.
      revert clear-commit-marks for now.
      boolean: accept yes and no as well
      send-email: do not barf when Term::ReadLine does not like your te=
rminal
      t6200: fmt-merge-msg test.
      git-grep: fix parsing of pathspec separator '--'
      git-grep: fix exit code when we use external grep.
      git-grep: use a bit more specific error messages.
      Re-fix clear_commit_marks().
      git-reset: complain and exit upon seeing an unknown parameter.
      builtin-rev-parse.c: constness tightening
      show-branch: match documentation and usage
      rev-parse documentation: talk about range notation.

   Linus Torvalds:
      revision.c: fix "dense" under --remove-empty
      Improve git-peek-remote

   Luben Tuikov:
      gitweb: Enable tree (directory) history display

   Rene Scharfe:
      Add get_merge_bases_clean()
      Add '...' operator for revisions
      Make clear_commit_marks() clean harder
      Fold get_merge_bases_clean() into get_merge_bases()
      rev-list: free commit_list in ... handler

   Robin Rosenberg:
      Empty author may be presented by svn as an empty string or a null=
 value.

   Ryan Anderson:
      annotate: Support annotation of files on other revisions.
      annotate: Correct most merge following to annotate correctly.

   Santi B=E9jar:
      Teach rev-parse the ... syntax.

   Stephan Feder:
      Do not drop data from '\0' until eol in patch output

   Timo Hirvonen:
      Merge with_raw, with_stat and summary variables to output_format
      Make --raw option available for all diff commands
      Set default diff output format after parsing command line
      DIFF_FORMAT_RAW is not default anymore
      Add msg_sep to diff_options
      Don't xcalloc() struct diffstat_t
      whatchanged: Default to DIFF_FORMAT_RAW
      Print empty line between raw, stat, summary and patch
      diff-tree: Use ---\n as a message separator
      log --raw: Don't descend into subdirectories by default
      Fix diff-tree -s

   Unknown:
      A better-scheduled PPC SHA-1 implementation.

   Ville Skytt=E4:
      Fix print-log and diff compatibility with recent vc versions


* The 'next' branch, in addition, has these.

   Dennis Stosberg:
      "test" in Solaris' /bin/sh does not support -e
      Makefile fix for Solaris
      Add possibility to pass CFLAGS and LDFLAGS specific to the perl s=
ubdir

   Eric Wong:
      git-svn: migrate out of contrib
      git-svn: migrate out of contrib (follow-up)
      diff.c: respect diff.renames config option

   Jakub Narebski:
      Allow INSTALL, bindir, mandir to be set in main Makefile
      Rename man1 and man7 variables to man1dir and man7dir

   Johannes Schindelin:
      Git.xs: older perl do not know const char *
      Makefile: export NO_SVN_TESTS

   Junio C Hamano:
      Perl interface: add build-time configuration to allow building wi=
th -fPIC
      Perl interface: make testsuite work again.
      perl: fix make clean
      Git.pm: tentative fix to test the freshly built Git.pm
      Perly Git: arrange include path settings properly.
      Makefile: Set USE_PIC on x86-64
      Perly git: work around buggy make implementations.
      Git.pm: clean generated files.
      Perly Git: make sure we do test the freshly built one.
      INSTALL: a tip for running after building but without installing.
      git-grep: boolean expression on pattern matching.
      mailinfo: assume input is latin-1 on the header as we do for the =
body
      diffcore-rename: try matching up renames without populating files=
pec first.
      diff.c: --no-color to defeat diff.color configuration.
      Update diff-options and config documentation.
      git log -p --merge [[--] paths...]

   Linus Torvalds:
      xdiff: generate "anti-diffs" aka what is common to two files
      Prepare "git-merge-tree" for future work
      Improved three-way blob merging code

   Pavel Roskin:
      Fix probing for already installed Error.pm
      Delete manuals if compiling without docs
      Make perl interface a separate package

   Petr Baudis:
      Introduce Git.pm (v4)
      Git.pm: Implement Git::exec_path()
      Git.pm: Call external commands using execv_git_cmd()
      Git.pm: Implement Git::version()
      Add Error.pm to the distribution
      Git.pm: Better error handling
      Git.pm: Handle failed commands' output
      Git.pm: Enhance the command_pipe() mechanism
      Git.pm: Implement options for the command interface
      Git.pm: Add support for subdirectories inside of working copies
      Convert git-mv to use Git.pm
      Git.pm: assorted build related fixes.
      Git.pm: Try to support ActiveState output pipe
      Git.pm: Swap hash_object() parameters
      Git.pm: Fix Git->repository("/somewhere/totally/elsewhere")
      Git.pm: Support for perl/ being built by a different compiler
      Git.pm: Remove PerlIO usage from Git.xs
      Git.pm: Avoid ppport.h
      Git.pm: Don't #define around die
      Use $GITPERLLIB instead of $RUNNING_GIT_TESTS and centralize @INC=
 munging
      Git.pm: Add config() method
      Convert git-send-email to use Git.pm
      Git.pm: Introduce ident() and ident_person() methods

   Stephan Feder:
      Teach --text option to diff
      Teach diff -a as shorthand for --text
      Add -a and --text to common diff options help
      diff-options: Explain --text and -a

   Timo Hirvonen:
      --name-only, --name-status, --check and -s are mutually exclusive


* The 'pu' branch, in addition, has these.

   A Large Angry SCM:
      Additional merge-base tests (revised)

   Jakub Narebski:
      autoconf: Use autoconf to write installation directories to confi=
g.mak.autogen

   Junio C Hamano:
      merge-base: update the clean-up postprocessing
      upload-pack: use object pointer not copy of sha1 to keep track of=
 has/needs.
      upload-pack: lift MAX_NEEDS and MAX_HAS limitation
      upload-pack: minor clean-up in multi-ack logic
      upload-pack: stop the other side when they have more roots than w=
e do.
      Work around sed and make interactions on the backslash at the end=
 of line.

   Linus Torvalds:
      builtin "git prune"

   Matthias Lederhofer:
      GIT_TRACE: show which built-in/external commands are executed

   Peter Baumann:
      git-cvsexportcommit can't handle merge commits correctly

   Petr Baudis:
      Make it possible to set up libgit directly (instead of from the e=
nvironment)
      Git.pm: Introduce fast get_object() method
      Convert git-annotate to use Git.pm

   Timo Hirvonen:
      Remove awkward compatibility warts
      GIT_TRACE: fix a mixed declarations and code warning
