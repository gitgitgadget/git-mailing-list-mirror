From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-applymbox: Remove command
Date: Sun, 20 May 2007 02:10:13 +0200
Message-ID: <20070520001012.5051.38142.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 02:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpZ0E-0003fr-Oe
	for gcvg-git@gmane.org; Sun, 20 May 2007 02:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbXETAKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756759AbXETAKS
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 20:10:18 -0400
Received: from rover.dkm.cz ([62.24.64.27]:36239 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610AbXETAKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 20:10:16 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 294918B711;
	Sun, 20 May 2007 02:10:13 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47785>

I believe noone uses git-applymbox, and noone definitely should, since it
is supposed to be completely superseded and everything by its younger
cousin git-am. The only known person in the universe to use it was Linus
and he declared some time ago that he will try to use git-am instead in his
famous dotest script.

The trouble is that git-applymbox existence creates confusing UI. I'm a bit
like a recycled newbie to the git porcelain and *I* was confused by
git-applymbox primitiveness until I've realized a while later that I'm of
course using the wrong command.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

(Admittelly this patch is a bit brave and maybe we should make applymbox
print some scary messages first for some time. I'm testing the water here
to see if anyone complains. I still think that noone really uses it,
though.)
---

 .gitignore                      |    1 
 Documentation/cmd-list.perl     |    1 
 Documentation/git-am.txt        |    5 +-
 Documentation/git-applymbox.txt |   98 --------------------------------
 Documentation/hooks.txt         |    6 +-
 Makefile                        |    2 -
 git-applymbox.sh                |  121 ---------------------------------------
 7 files changed, 6 insertions(+), 228 deletions(-)

diff --git a/.gitignore b/.gitignore
index d0b67da..16f4aba 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,7 +7,6 @@ git-add--interactive
 git-am
 git-annotate
 git-apply
-git-applymbox
 git-applypatch
 git-archimport
 git-archive
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 443802a..0bca346 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -72,7 +72,6 @@ __DATA__
 git-add                                 mainporcelain
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
-git-applymbox                           ancillaryinterrogators
 git-applypatch                          purehelpers
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ba79773..bf07e43 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -126,8 +126,7 @@ is terminated before the first occurrence of such a line.
 
 When initially invoking it, you give it names of the mailboxes
 to crunch.  Upon seeing the first patch that does not apply, it
-aborts in the middle, just like 'git-applymbox' does.  You can
-recover from this in one of two ways:
+aborts in the middle,.  You can recover from this in one of two ways:
 
 . skip the current patch by re-running the command with '--skip'
   option.
@@ -144,7 +143,7 @@ names.
 
 SEE ALSO
 --------
-gitlink:git-applymbox[1], gitlink:git-applypatch[1], gitlink:git-apply[1].
+gitlink:git-applypatch[1], gitlink:git-apply[1].
 
 
 Author
diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
deleted file mode 100644
index ea919ba..0000000
--- a/Documentation/git-applymbox.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-git-applymbox(1)
-================
-
-NAME
-----
-git-applymbox - Apply a series of patches in a mailbox
-
-
-SYNOPSIS
---------
-'git-applymbox' [-u] [-k] [-q] [-m] ( -c .dotest/<num> | <mbox> ) [ <signoff> ]
-
-DESCRIPTION
------------
-Splits mail messages in a mailbox into commit log message,
-authorship information and patches, and applies them to the
-current branch.
-
-
-OPTIONS
--------
--q::
-	Apply patches interactively.  The user will be given
-	opportunity to edit the log message and the patch before
-	attempting to apply it.
-
--k::
-	Usually the program 'cleans up' the Subject: header line
-	to extract the title line for the commit log message,
-	among which (1) remove 'Re:' or 're:', (2) leading
-	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
-	then prepends "[PATCH] ".  This flag forbids this
-	munging, and is most useful when used to read back 'git
-	format-patch -k' output.
-
--m::
-	Patches are applied with `git-apply` command, and unless
-	it cleanly applies without fuzz, the processing fails.
-	With this flag, if a tree that the patch applies cleanly
-	is found in a repository, the patch is applied to the
-	tree and then a 3-way merge between the resulting tree
-	and the current tree.
-
--u::
-	Pass `-u` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
-	The proposed commit log message taken from the e-mail
-	are re-coded into UTF-8 encoding (configuration variable
-	`i18n.commitencoding` can be used to specify project's
-	preferred encoding if it is not UTF-8).  This used to be
-	optional but now it is the default.
-+
-Note that the patch is always used as-is without charset
-conversion, even with this flag.
-
--n::
-	Pass `-n` flag to `git-mailinfo` (see
-	gitlink:git-mailinfo[1]).
-
--c .dotest/<num>::
-	When the patch contained in an e-mail does not cleanly
-	apply, the command exits with an error message. The
-	patch and extracted message are found in .dotest/, and
-	you could re-run 'git applymbox' with '-c .dotest/<num>'
-	flag to restart the process after inspecting and fixing
-	them.
-
-<mbox>::
-	The name of the file that contains the e-mail messages
-	with patches.  This file should be in the UNIX mailbox
-	format.  See 'SubmittingPatches' document to learn about
-	the formatting convention for e-mail submission.
-
-<signoff>::
-	The name of the file that contains your "Signed-off-by"
-	line.  See 'SubmittingPatches' document to learn what
-	"Signed-off-by" line means.  You can also just say
-	'yes', 'true', 'me', or 'please' to use an automatically
-	generated "Signed-off-by" line based on your committer
-	identity.
-
-
-SEE ALSO
---------
-gitlink:git-am[1], gitlink:git-applypatch[1].
-
-
-Author
-------
-Written by Linus Torvalds <torvalds@osdl.org>
-
-Documentation
---------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the gitlink:git[7] suite
-
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index aabb975..aad1744 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -13,7 +13,7 @@ applypatch-msg
 --------------
 
 This hook is invoked by `git-applypatch` script, which is
-typically invoked by `git-applymbox`.  It takes a single
+typically invoked by `git-am`.  It takes a single
 parameter, the name of the file that holds the proposed commit
 log message.  Exiting with non-zero status causes
 `git-applypatch` to abort before applying the patch.
@@ -30,7 +30,7 @@ pre-applypatch
 --------------
 
 This hook is invoked by `git-applypatch` script, which is
-typically invoked by `git-applymbox`.  It takes no parameter,
+typically invoked by `git-am`.  It takes no parameter,
 and is invoked after the patch is applied, but before a commit
 is made.  Exiting with non-zero status causes the working tree
 after application of the patch not committed.
@@ -45,7 +45,7 @@ post-applypatch
 ---------------
 
 This hook is invoked by `git-applypatch` script, which is
-typically invoked by `git-applymbox`.  It takes no parameter,
+typically invoked by `git-am`.  It takes no parameter,
 and is invoked after the patch is applied and a commit is made.
 
 This hook is meant primarily for notification, and cannot affect
diff --git a/Makefile b/Makefile
index de74851..77d3ad0 100644
--- a/Makefile
+++ b/Makefile
@@ -208,7 +208,7 @@ SCRIPT_SH = \
 	git-repack.sh git-request-pull.sh git-reset.sh \
 	git-sh-setup.sh \
 	git-tag.sh git-verify-tag.sh \
-	git-applymbox.sh git-applypatch.sh git-am.sh \
+	git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh git-quiltimport.sh
diff --git a/git-applymbox.sh b/git-applymbox.sh
deleted file mode 100755
index c18e80f..0000000
--- a/git-applymbox.sh
+++ /dev/null
@@ -1,121 +0,0 @@
-#!/bin/sh
-##
-## "dotest" is my stupid name for my patch-application script, which
-## I never got around to renaming after I tested it. We're now on the
-## second generation of scripts, still called "dotest".
-##
-## Update: Ryan Anderson finally shamed me into naming this "applymbox".
-##
-## You give it a mbox-format collection of emails, and it will try to
-## apply them to the kernel using "applypatch"
-##
-## The patch application may fail in the middle.  In which case:
-## (1) look at .dotest/patch and fix it up to apply
-## (2) re-run applymbox with -c .dotest/msg-number for the current one.
-## Pay a special attention to the commit log message if you do this and
-## use a Signoff_file, because applypatch wants to append the sign-off
-## message to msg-clean every time it is run.
-##
-## git-am is supposed to be the newer and better tool for this job.
-
-USAGE='[-u] [-k] [-q] [-m] (-c .dotest/<num> | mbox) [signoff]'
-. git-sh-setup
-
-git var GIT_COMMITTER_IDENT >/dev/null || exit
-
-keep_subject= query_apply= continue= utf8=-u resume=t
-while case "$#" in 0) break ;; esac
-do
-	case "$1" in
-	-u)	utf8=-u ;;
-	-n)	utf8=-n ;;
-	-k)	keep_subject=-k ;;
-	-q)	query_apply=t ;;
-	-c)	continue="$2"; resume=f; shift ;;
-	-m)	fall_back_3way=t ;;
-	-*)	usage ;;
-	*)	break ;;
-	esac
-	shift
-done
-
-case "$continue" in
-'')
-	rm -rf .dotest
-	mkdir .dotest
-	num_msgs=$(git-mailsplit "$1" .dotest) || exit 1
-	echo "$num_msgs patch(es) to process."
-	shift
-esac
-
-files=$(git-diff-index --cached --name-only HEAD) || exit
-if [ "$files" ]; then
-   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
-   exit 1
-fi
-
-case "$query_apply" in
-t)	touch .dotest/.query_apply
-esac
-case "$fall_back_3way" in
-t)	: >.dotest/.3way
-esac
-case "$keep_subject" in
--k)	: >.dotest/.keep_subject
-esac
-
-signoff="$1"
-set x .dotest/0*
-shift
-while case "$#" in 0) break;; esac
-do
-    i="$1" 
-    case "$resume,$continue" in
-    f,$i)	resume=t;;
-    f,*)	shift
-		continue;;
-    *)
-	    git-mailinfo $keep_subject $utf8 \
-		.dotest/msg .dotest/patch <$i >.dotest/info || exit 1
-	    test -s .dotest/patch || {
-		echo "Patch is empty.  Was it split wrong?"
-		exit 1
-	    }
-	    git-stripspace < .dotest/msg > .dotest/msg-clean
-	    ;;
-    esac
-    while :; # for fixing up and retry
-    do
-	git-applypatch .dotest/msg-clean .dotest/patch .dotest/info "$signoff"
-	case "$?" in
-	0)
-		# Remove the cleanly applied one to reduce clutter.
-		rm -f .dotest/$i
-		;;
-	2)
-		# 2 is a special exit code from applypatch to indicate that
-	    	# the patch wasn't applied, but continue anyway 
-		;;
-	*)
-		ret=$?
-		if test -f .dotest/.query_apply
-		then
-			echo >&2 "* Patch failed."
-			echo >&2 "* You could fix it up in your editor and"
-			echo >&2 "  retry.  If you want to do so, say yes here"
-			echo >&2 "  AFTER fixing .dotest/patch up."
-			echo >&2 -n "Retry [y/N]? "
-			read yesno
-			case "$yesno" in
-			[Yy]*)
-				continue ;;
-		        esac
-		fi
-		exit $ret
-	esac
-	break
-    done
-    shift
-done
-# return to pristine
-rm -fr .dotest
