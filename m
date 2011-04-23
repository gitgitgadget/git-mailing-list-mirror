From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 22/23] Introduce git base.
Date: Sat, 23 Apr 2011 17:22:51 +1000
Message-ID: <1303543372-77843-23-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:25:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXDD-0005Iv-JB
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1DWHY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:57 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1DWHYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:53 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gylOs75c/omnWph8iAsBvEEPUSCyR2cvBL0eKp/E/Oo=;
        b=hmMNFouHjnd1NbwIOv38OCGGTJP9wSnwONLiuGK/0wcGKkf80YPZvYd+GPQ665bpPb
         z+1zWaTRbw//24iKQUzS95fe7Jl93lnT9mMgq06rWLen+u+MUcSr82J0brn7DkMpRSlf
         hyjOxAfvyX9O8rqyUAbLze78VuqcqqY2VqSnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pJFYWQMnTHoSX9yEm2N+88frxhMC4xy4/VkS500Y2LUnppPpvHCpiYlVP2lAXpV310
         TFEVd+r9UMesstpCru4eSCAd1boYwS2WXqTENs3v2jP3tNpgKI5yya6QOMsMPAuA9Qee
         FVbLg8u3fIn0GBV0aamqwzk+ZdaaVjjOlSQaQ=
Received: by 10.68.29.230 with SMTP id n6mr3050112pbh.130.1303543493427;
        Sat, 23 Apr 2011 00:24:53 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171975>

git base is intended to provide a way to track the 'base'
of the current branch, where the base is one of several possible
commits that satisfies the following invariant.

The base is reachable from the head the output
git rev-list base..head --merges is empty.

git base is intended to provide a sane way to keep
track of the commit at the base of the current branch
and thereby simplify the process of rebasing, or more
generally, dependency managment.

For example of how it is used, see the following git-work
command.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 .gitignore                 |    1 +
 Documentation/config.txt   |   10 ++
 Documentation/git-base.txt |  216 +++++++++++++++++++++++++
 Makefile                   |    1 +
 git-base.sh                |  378 ++++++++++++++++++++++++++++++++++++++++++++
 t/t3418-base.sh            |  214 +++++++++++++++++++++++++
 6 files changed, 820 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-base.txt
 create mode 100644 git-base.sh
 create mode 100755 t/t3418-base.sh

diff --git a/.gitignore b/.gitignore
index 5efc43c..54fa567 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,7 @@
 /git-archive
 /git-atomic
 /git-atomic-lib
+/git-base
 /git-bisect
 /git-bisect--helper
 /git-blame
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 750c86d..52f149b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -636,6 +636,16 @@ branch.autosetuprebase::
 	branch to track another branch.
 	This option defaults to never.
 
+branch.<name>.baseresetoptions::
+	The options passed to 'git base set' when 'git base' detects
+	that the current base reference is either not set or no longer
+	satisfies the base invariant.
+	See the description of the `init` command in linkgit:git-base[1]
+	for details of how this value is initialized.
+	See the description of the `set` command in linkgit:git-base[1]
+	for details about this value is interpreted.
+	Defaults to --fail unless set.
+
 branch.<name>.remote::
 	When in branch <name>, it tells 'git fetch' and 'git push' which
 	remote to fetch from/push to.  It defaults to `origin` if no remote is
diff --git a/Documentation/git-base.txt b/Documentation/git-base.txt
new file mode 100644
index 0000000..7a7a710
--- /dev/null
+++ b/Documentation/git-base.txt
@@ -0,0 +1,216 @@
+git-base(1)
+===========
+
+NAME
+----
+git-base - display, check, set, clear and reset the base of a working branch
+
+SYNOPSIS
+--------
+[verse]
+'git base' [-b branch] [--as-ref]|[<default-commit>]
+'git base' [-b branch] 'check' <commit>
+'git base' [-b branch] 'set' [-f] <commit>
+'git base' [-b branch] 'clear'
+'git base' [-b branch] 'init' [-d]|[<reset-cmd>]
+'git base' [-b branch] 'reset'
+
+DESCRIPTION
+-----------
+In the discussion that follows, the current branch or the branch specified by -b is referred to by the symbol `<branch>` and the commit at the base of `<branch>` is referred to by the symbol `<base>`. `<head>` is used to refer to the commit at the tip of `<branch>` as distinct from the branch reference itself.
+
+`git base` helps to track the base of a working branch. For the purposes of the exposition here, the base of the working branch is defined as the
+last commit in the history that is not part of your current work - it is the basis of your current work, but is not part of the work itself. Furthermore,
+to be classified as a base, the path from the tip of the branch to the base must not traverse a merge commit. This constraint means that the range
+`<base>..<bramch>` is always a linear series of commits that can be easily rebased and re-organized as required.
+
+COMMANDS
+--------
+Without positional arguments, this command checks whether the base reference satisfies the base invariant. If it does, prints the SHA1 hash of the base commit
+to stdout and exits with a status code of 0.
+
+Otherwise, if `<default-commit>` is specified, calls `set <default-commit>`. If this fails to establish the base invariant or if no `<default-commit>`
+is specified then calls `reset`. If the base reference now satisfies the base invariant, print its SHA1 has to stdout and
+exits with a status code of 0. Otherwise, prints a warning message to stderr and exits with a non-zero status code.
+
+If `--as-ref` is specifed, then the symbolic name of the base reference is printed instead of the SHA1 hash but `reset` is not called, even
+if the base reference does not satisfy the base invariant.
+
+If a `<default-commit>` is specified `set <default-commit>` is called
+
+`init [-d]|[<reset-cmd>]`::
+
+Initializes the command to be used when `reset` is called. It must be one of `set <commit>`, `clear` or `check`.
+`<reset-cmd>` defaults to the `set <upstream-branch>` if there is one or to `set <head>`, otherwise.
+Use a `<reset-cmd>` of `check` to prevent the default `git base` command automatically
+adjusting an inconsistent base reference. Use a `<reset-cmd>` of `clear` to automatically clear an inconsistent base reference.
+
+Use -d to delete the base reference and reset configuration associated with the branch.
+
+`clear`::
+
+Clears the base reference, if any. The status code is always set to a non-zero value and a warning message is printed to stderr. No output is
+printed to stdout.
+
+`set [-f] <commit>`::
+
+Checks that the specified base satisifies the base invariant of `<branch>`, and if so, updates the base reference with the specified commit.
+Otherwise, updates the base reference to the commit closest to both `<commit>` and `<branch>` which does satisfy the base invariant. The selected
+commit will always be reachable from `<branch>` but may not be reachable from `<commit>`. In particular, if the merge base of `<commit>` and `<branch>`
+is hidden by a merge commit, then the selected commit will be (the only) merge commit that satisfies the base invariant of `<branch>`.
++
+The status and output are set/generated as per `git base`.
++
+`-f` can be used to force the update of the base reference to the specified `<commit>` even if the `<commit>` does not satify the base
+invariant. Note: however, that unless the effective `reset` command is set to `check`, this value will not stick beyond the next
+call to `git base`.
+
+`check` [<commit>]::
+
+If `<commit>` is specified, performs the same function as `set` but does not actually update the base reference. The status code and output are set/generated as they would be if `set` had been called.
++
+If `<commit>` is not specified, sets the status code according to whether (0) or not (non-zero) the base reference is well-defined and consistent with the base invariant. The output that is generated is the same output that would be generated if `set` was called with the same arguments.
++
+`check` NEVER adjusts the base reference.
+
+`reset`::
+
+Resets the base reference by calling the git base with the configured `<reset-cmd>` or `clear` if there is no such configuration. The status
+and output are set/generated as per `git base`.
+
+OUTPUT
+------
+Unless --as-ref is used, the only output git base generates is the SHA1 hash of a commit that satisfies the base invariant.  If `git base`, `git base set` or `git check` (without arguments) generate output, then the output will be the current base reference at the time the command completes.  If `git check` is called with an
+argument, then the output is set as if `git set` had been called. If --as-ref is used, the generated output is always the symbolic name of the base reference, whether or not the base reference actually exists or satisfies the base invariant.
+
+EXIT CODE
+---------
+Except for the `init` command, `git base` exits with status code of zero if command has written the SHA1 hash of a commit that satisfies the base invariant to stdout, and exits with a non-zero status code otherwise.
+
+OPTIONS
+-------
+-b,--branch branch::
+	If this option is specified and supported, the commands apply to the specified branch. Otherwise, the commands apply to the current branch.
+-f::
+	Force the update of the base reference even if the specified value does not satisfy the base invariant.
+-q::
+	Use this option to suppress data output, information and warning messages.
+--as-ref::
+	Print the SHA1 hash of the base as a symbolic reference.
+
+CONFIGURATION
+-------------
+branch.<name>.baseresetcmd::
+	Configures the `git base` subcommand used by `git base reset`. Must be one of `set <commit>`, `check` or `clear`. Defaults to `clear`, if not specified.
+
+THE BASE INVARIANT
+------------------
+The base invariant applies to all commits that can be described as a base of a branch.
+
+The invariant is that the base commit is reachable from the head of the branch and that the path between the head of the branch and the base contains no merge commits other than, possibly, the base commit itself.
+
+The head of a branch is also a base commit for the branch. As such, each branch has at least one commit that satisfies the base invariant.
+For any given branch there is at most one merge commit that satisifies the base invariant.
+
+The base invariant is defined as it is because the history between a commit satisifying the base invariant and the head of the branch is, by definition,
+guaranteed to be linear.
+
+BASE REFERENCE
+--------------
+The base reference is semi-automatically managed by the git.
+
+It is explicitly updated by the `set` and `clear` commands and sometimes by the `reset` command, depending on how it has been configured.
+It may be implicitly updated by the default command (via a call to `reset`) but only when it is undefined or does not satisfy the base reference.
+It is never updated by the `check` or `init` commands. Other git tools such as linkgit:git-work[1] use git base to update the base reference as required.
+
+Users may use the `set` command with the -f option to modify the base reference to any value but values that fail to match the base invariant will quickly
+be reset by the automatic operation of `git base` unless the reset operation is configured to be `check`.
+
+A non-empty output from `git base`, `git base reset` or `git base set` is guaranteed to be consistent with the base invariant immediately after the command
+completes.
+
+THE STATE MACHINE VIEW
+----------------------
+A good way to think about `git base` is as the controls of a 3-state state machine: a machine that has the states: UNDEFINED, INCONSISTENT and CONSISTENT
+which correspond to an undefined base reference, a base reference that does not satisfy the base invariant and a base reference that does satisfy
+the base invariant, respectively.
+
+The state machine prefers to be in the CONSISTENT state. `git base` without arguments will leave the state of the base reference unchanged if is CONSISTENT
+or will call `git base reset` otherwise.  `git base reset` uses the `<reset-cmd>` defined with `git base init` to implement the auto-recovery policy
+of the state machine when it finds itself in the INCONSISTENT or UNDEFINED states.
+
+`git base check` tests the state of the base reference, but leaves its state unchanged.
+
+`git base clear` unconditionally clears base reference forcing the state to be UNDEFINED.
+
+`git base set` without a `-f` option is used to force the machine into a CONSISTENT state.
+
+EXAMPLES
+--------
+* Initialize the branch so that the base reference is always reset, when required, relative to upstream/master
++
+----------
+git base init set upstream/master
+----------
+* Display the current base
++
+---------
+git base
+---------
+* Display the current base reference without updating it
++
+---------
+git base check
+---------
+* Display the current base as a symbolic reference
++
+---------
+git base --as-ref
+---------
+* Set the base of the current branch to the 3rd commit from the tip
++
+---------
+git base set HEAD~3
+---------
+* Interactively rebase the current work
++
+---------
+git rebase -i $(git base) HEAD
+---------
+* Perform a rebase, but only if the base reference is currently valid
++
+---------
+git base check -q && git rebase -i $(git base) HEAD
+---------
+* Set the base relative to an upstream branch
++
+---------
+git base set origin/master
+---------
+
+
+FILES
+-----
+
+.git/refs/bases/`<branch>`::
+	Contains the last calculated value of the base for a specific branch. This value is not guaranteed to be correct except immediately after a successful execution of git base. Users that require an accurate value should use the output of git base -b `<branch>`.
+
+.git/refs/BASE::
+	If HEAD is a symbolic reference of the form `refs/heads/<branch>`, then BASE will be a symbolic reference of the form `refs/bases/<branch>`. Otherwise,
+	it contains the base commit corresponding to the detached HEAD, if one has been specified.
+
+SEE ALSO
+--------
+linkgit:git-work[1]
+
+Author
+------
+Written by Jon Seymour <jon.seymour@gmail.com>
+
+Documentation
+-------------
+Documentation by Jon Seymour
+
+GIT
+---
+Part of the linkgit:git[7] suite
diff --git a/Makefile b/Makefile
index 9ed877a..6aee4a8 100644
--- a/Makefile
+++ b/Makefile
@@ -361,6 +361,7 @@ unexport CDPATH
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-atomic.sh
+SCRIPT_SH += git-base.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
diff --git a/git-base.sh b/git-base.sh
new file mode 100644
index 0000000..14c64c9
--- /dev/null
+++ b/git-base.sh
@@ -0,0 +1,378 @@
+#!/bin/sh
+#
+# (c) Copyright Jon Seymour 2010
+#
+USAGE='[help|set|check|reset|init]'
+LONG_USAGE='
+git base [--as-ref]
+        print the SHA1 hash of the base reference or its symbolic name (--as-ref)
+git base set [-f] <commit>
+        set the base of the branch to commit nearest <commit> that satisifies the base invariant.
+git base clear
+        As per set, but never update the base reference.
+git base check <commit>
+        test if the specified commit satisfies the base invariant
+git base init <reset-cmd>
+	Initialise the git base command to be called when git base reset is invoked.
+git base reset
+	Invoke the configured reset command (see git base init) or git base clear, if not such command is configured.
+git base help
+        print this help
+
+Please use "git help base" to get the full man page.'
+
+OPTIONS_SPEC=
+
+SUBDIRECTORY_OK=true
+. git-sh-setup
+require_work_tree
+
+warn()
+{
+    test -n "$QUIET" || echo "$*" 1>&2
+}
+
+info()
+{
+    test -n "$QUIET" || echo "$*" 1>&2
+}
+
+data()
+{
+	if test "$*" != ""
+	then
+		echo "$*"
+		true
+	else
+		false
+	fi
+}
+
+quietly()
+{
+	if test -n "$QUIET"
+	then
+		"$@" >/dev/null 2>/dev/null
+	else
+		"$@"
+	fi
+}
+
+assert_valid_branch()
+{
+	test -n "${VALID_BRANCH}" || die "${BRANCH} is not a branch"
+}
+
+invariant_state()
+{
+	commit=$1
+	if test -z "$commit"
+	then
+		echo "UNDEFINED"
+		false
+	elif ! git rev-parse --quiet --verify "$commit" >/dev/null
+	then
+		echo "INVALID"
+		false
+	elif ! git test -q --reachable $commit $HEAD
+	then
+		echo "UNREACHABLE"
+		false
+	elif ! test -z "$(last_merge $HEAD $commit)"
+	then
+		echo "HIDDEN"
+		false
+	else
+		echo "CONSISTENT"
+		true
+	fi
+}
+
+closest()
+{
+	commit=$1
+	state=${2:-$(invariant_state $commit)}
+	
+	case $state in	
+		UNDEFINED|INVALID)
+			:
+		;;
+		UNREACHABLE)
+			closest $(git merge-base $HEAD $commit)
+		;;
+		HIDDEN)
+			last_merge $HEAD $commit
+		;;
+		CONSISTENT)
+			echo $commit
+		;;
+	esac
+}
+
+describe()
+{
+	commit=$1
+	state=$2
+	
+	case $state in
+		UNDEFINED)
+			echo "No commit specified."
+		;;
+		INVALID)
+			echo "$commit is not a valid reference."
+		;;
+		HIDDEN)
+			echo "The commit $(short_ref $commit) is not a base of ${BRANCH} because it is hidden by the merge commit $(short_ref $(last_merge $HEAD $commit))."
+		;;
+		UNREACHABLE)
+			echo "The commit $(short_ref $commit) is not a base of ${BRANCH} because it is unreachable from $(short_ref $HEAD)."
+		;;
+		CONSISTENT)
+			echo "The commit $(short_ref $commit) satisfies the base invariant of $(short_ref $HEAD)."
+		;;
+	esac
+}
+
+last_merge()
+{
+    head=$1
+    commit=$2
+    data $(git rev-list --max-count=1 --merges ${head} ^$commit)
+}
+
+short_ref()
+{
+    data "($(git rev-parse --short $1))"
+}
+
+base_default()
+{
+	assert_valid_branch
+
+	revs=$(git rev-parse --revs-only "$@")
+
+	if state=$(invariant_state "${BASEREF}")	
+	then
+		if test -z "$ASREF"
+		then
+			git rev-parse ${BASEREF}
+		else
+			echo "${BASEREF}"
+		fi
+	else
+		if test -z "$ASREF"
+		then
+			if test -n "$revs"
+			then
+				base_set $revs && return 0
+			fi
+	
+			describe "${BASEREF}" $state 1>&2
+			base_reset
+		else
+			describe "${BASEREF}" $state 1>&2
+			echo "${BASEREF}"
+			false
+		fi
+	fi
+}
+
+base_init()
+{
+	if test -n "$DELETE"
+	then
+		git update-ref -d ${BASEREF} &&
+		git config branch.${BRANCH}.baseresetcmd clear &&
+		git config --unset branch.${BRANCH}.baseresetcmd
+		return 0
+	fi
+
+	assert_valid_branch
+
+	if test $# -eq 0
+	then
+		set -- $(git config branch.${BRANCH}.merge)
+		MERGE=$1
+		set -- $(git config branch.${BRANCH}.remote)
+		case "$1" in	
+		.)
+			OPTION="set ${MERGE}"
+		;;
+		"")
+			OPTION="set $(git rev-parse ${BRANCH})"
+		;;
+		*)
+			OPTION="set $1/${MERGE#refs/heads/}"
+		;;
+		esac
+		set -- ${OPTION}
+	else
+		case "$1" in	
+			set|clear|check)
+			:
+			;;
+		*)
+			die "$1 is not a valid 'git base' command"
+			;;
+		esac
+	fi
+
+	warn "The reset command for ${BRANCH} is now '$*'."
+	git config branch.${BRANCH}.baseresetcmd "$*" || die "failed to update branch.${BRANCH}.baseresetcmd"
+}
+
+base_reset()
+{
+	assert_valid_branch
+
+	options=$(git config branch.${BRANCH}.baseresetcmd)
+	options=${options:-clear}
+
+	warn "Resetting the base of ${BRANCH} with 'git base ${options}'."
+	git base -b ${BRANCH} ${options}
+}
+
+base_check()
+{
+	assert_valid_branch
+
+	specified=$1
+	commit=${specified:-${BASEREF}}
+
+	if state=$(invariant_state "$commit")
+	then
+		git rev-parse $commit
+	else
+		describe "$commit" $state 1>&2
+		false
+	fi
+}
+
+base_set()
+{
+	assert_valid_branch
+
+	USAGE="usage: git base set [-f] <commit>"
+	test -n "$1" || die "$USAGE"
+
+	commit=$1
+	
+	if state=$(invariant_state "$commit")
+	then
+		git update-ref "${BASEREF}" "$commit" || die "failed to update $BASEREF"
+		echo $(git rev-parse $commit)
+	else
+
+		case $state in	
+			INVALID)
+				die "The specified reference $commit is not a valid."
+			;;
+			HIDDEN|UNREACHABLE)
+				closest=$(closest $commit)
+				describe "$commit" "$state" 1>&2
+				if test -z "$FORCE"
+				then
+					warn "Updating the base of ${BRANCH} to a consistent value $(short_ref $closest)."
+					git update-ref ${BASEREF} $closest || die "failed to update $BASEREF"
+					echo $closest
+					true
+				else
+					warn "Updating the base of ${BRANCH} to an inconsistent value $(short_ref $commit)."
+					git update-ref ${BASEREF} $commit || die "failed to update $BASEREF"
+					false
+				fi
+			;;
+			CONSISTENT)
+				git update-ref ${BASEREF} $commit || die "failed to update $BASEREF"
+				echo $commit
+				true
+			;;
+			*)
+				die "should never happen - invalid state $state"
+			;;
+		esac
+
+	fi
+}
+
+base_clear()
+{
+   git update-ref -d ${BASEREF} >/dev/null || die "failed to clear $BASEREF"
+   warn "The base of ${BRANCH} has been cleared."
+   false
+}
+
+base_help()
+{
+   git base -h "$@"
+}
+
+VALID_BRANCH=
+QUIET=
+POSITIONAL=
+FORCE=
+DELETE=
+
+BRANCHREF=$(git symbolic-ref -q HEAD) || BRANCHREF=HEAD
+BRANCH=${BRANCHREF#refs/heads/}
+VALID_BRANCH=t
+
+while test $# -gt 0
+do
+	arg=$1
+	shift
+
+	case "$arg" in
+	       -b)
+			test -n "$1" || die "-b requires a branch to be specified"
+		        BRANCH=$1 && shift
+			BRANCHREF=$(git rev-parse --quiet --symbolic-full-name --verify "${BRANCH}" --)
+			BRANCH=${BRANCHREF#refs/heads/}
+			test "${BRANCH}" = "${BRANCHREF}" || VALID_BRANCH=t
+			test "${BRANCH}" = "HEAD" && VALID_BRANCH=t
+			test -n "${BRANCHREF}"  || VALID_BRANCH=
+		;;
+		-f)
+			FORCE=-f;
+		;;
+                -d)
+                        DELETE=-d;
+                ;;
+		-q)
+			QUIET=-q
+	        ;;
+		--)
+			break;			
+		;;
+		--as-ref)	
+			ASREF=--as-ref;
+		;;	
+		default|check|clear|init|reset|set|help)
+			if test -z "$CMD"
+			then	
+				CMD=$arg
+			else
+				POSITIONAL="${POSITIONAL}${POSITIONAL:+ }$arg"
+			fi
+		;;
+		*)
+			POSITIONAL="${POSITIONAL}${POSITIONAL:+ }$arg"
+	        ;;
+	esac
+done
+
+CMD=${CMD:-default}
+
+set -- $POSITIONAL
+
+if test "${BRANCH}" = "HEAD"
+then
+	BASEREF=BASE
+else
+	BASEREF=refs/bases/${BRANCH}
+fi
+
+HEAD=$(git rev-parse --quiet --verify ${BRANCHREF})
+BASE=$(git rev-parse --quiet --verify ${BASEREF})
+
+quietly base_$CMD "$@"
diff --git a/t/t3418-base.sh b/t/t3418-base.sh
new file mode 100755
index 0000000..8e2defb
--- /dev/null
+++ b/t/t3418-base.sh
@@ -0,0 +1,214 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='git base tests
+
+Checks that git base implements its specification.
+
+'
+
+#
+#          G
+#         /
+# base - A - M - C - D - master - E
+#     \     / \
+#        B     F
+#
+
+. ./test-lib.sh
+
+GIT_AUTHOR_NAME=author@name
+GIT_AUTHOR_EMAIL=bogus@email@address
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+
+ensure_initial_state()
+{
+    git reset --hard HEAD &&
+    git checkout master &&
+    git reset --hard D && {
+        git update-ref -d refs/bases/master || true
+    } && {
+        git config --unset branch.master.baseresetcmd || true
+    } &&
+    ! git base clear
+}
+
+test_expect_success 'setup' \
+'
+    test_commit base &&
+    test_commit A &&
+    git checkout A^1 &&
+    test_commit B &&
+    git checkout master &&
+    test_merge M B &&
+    test_commit C &&
+    test_commit D &&
+    test_commit E &&
+    git checkout M^0 -- &&
+    test_commit F &&
+    git checkout A^0 -- &&
+    test_commit G &&
+    git checkout master &&
+    git reset --hard D
+'
+
+test_expect_success 'empty check when base missing' \
+'
+	ensure_initial_state &&
+	! git base clear &&
+	! git base check &&
+	! git rev-parse --verify refs/bases/master
+'
+
+test_expect_success 'empty check when base hidden (A)' \
+'
+	ensure_initial_state &&
+	! git base set -f A &&
+	! git base check &&
+	test "$(git base check)" = "" &&
+	git rev-parse --verify refs/bases/master &&
+	test "$(git rev-parse refs/bases/master)" = "$(git rev-parse A)"
+'
+
+test_expect_success 'empty check when base unreachable (E)' \
+'
+	ensure_initial_state &&
+	! git base set -f E &&
+	! git base check &&
+	test "$(git base check)" = "" &&
+	git rev-parse --verify refs/bases/master &&
+	test "$(git rev-parse refs/bases/master)" = "$(git rev-parse E)"
+'
+
+test_expect_success 'empty check when base unreachable and hidden (G)' \
+'
+	ensure_initial_state &&
+	! git base set -f G &&
+	! git base check &&
+	test "$(git base check)" = "" &&
+	git rev-parse --verify refs/bases/master &&
+	test "$(git rev-parse refs/bases/master)" = "$(git rev-parse G)"
+'
+
+test_expect_success 'empty check when base reachable and visible (M)' \
+'
+	ensure_initial_state &&
+	git base set -f M &&
+	git base check &&
+	test "$(git base check)" = "$(git rev-parse M)" &&
+	git rev-parse --verify refs/bases/master &&
+	test "$(git rev-parse refs/bases/master)" = "$(git rev-parse M)"
+'
+
+test_expect_success 'test default commit when clear' \
+'
+	ensure_initial_state &&
+        ! git base clear &&
+	git base M &&
+	test "$(git base check)" = "$(git rev-parse M)"
+'
+
+test_expect_success 'test default commit when set' \
+'
+	ensure_initial_state &&
+        git base set C &&
+	git base M &&
+	test "$(git base check)" = "$(git rev-parse C)"
+'
+
+test_expect_success 'git base - base not set initially' \
+'
+    ensure_initial_state &&
+    ! git base clear &&
+    ! git rev-parse --verify refs/bases/master &&
+    ! git base &&
+    ! git rev-parse --verify refs/bases/master &&
+    test -z "$(git base)"
+'
+test_expect_success 'test default when reference stale' \
+'
+    ensure_initial_state &&
+    ! git base set -f base &&
+    ! git base &&
+    ! git rev-parse --verify refs/bases/master &&
+    test -z "$(git base)"
+'
+
+test_expect_success 'test --as-ref does not create or check reference even when empty or stale' \
+'
+    ! git base clear &&
+    test "$(git base --as-ref)" = "refs/bases/master" &&
+    ! git base check &&
+    ! git base set -f base &&
+    ! git base --as-ref &&
+    test "$(git rev-parse refs/bases/master)" = "$(git rev-parse base)"
+'
+
+test_expect_success 'test set to stale reference ' \
+'
+    ! git base clear &&
+    git base set A &&
+    test "$(git base)" = $(git rev-parse M) &&
+    git base set B &&
+    test $(git base) = $(git rev-parse M) &&
+    git base set F &&
+    test $(git base) = $(git rev-parse M) &&
+    git base set G &&
+    test $(git base) = $(git rev-parse M) &&
+    git base set E &&
+    test $(git base) = $(git rev-parse D)
+'
+
+test_expect_success 'test set to good reference ' \
+'
+    ! git base clear &&
+    git base set C &&
+    test $(git base) = $(git rev-parse C) &&
+    git base set D &&
+    test $(git base) = $(git rev-parse D)
+'
+
+test_expect_success 'exit codes: ! clear && default' \
+'
+    ! git base clear &&
+    ! git base
+'
+
+test_expect_success 'exit codes: ! clear && !check && ! default' \
+'
+    ! git base clear &&
+    ! git base check &&
+    ! git base
+'
+
+test_expect_success 'exit codes: ! clear && ! set && ! default' \
+'
+    ! git base clear &&
+    ! git base set &&
+    ! git base
+'
+
+test_expect_success 'test detached head' \
+'
+    git checkout master^0 &&
+    test "$(git base --as-ref)" = "BASE" &&
+    git base set base &&
+    git base check &&
+    git base set M &&
+    test "$(git base)" = "$(git rev-parse M)"
+'
+
+test_expect_success 'test -b master' \
+'
+    ! git base -b master clear &&
+    git checkout master^0 &&
+    test "$(git base -b master --as-ref)" = "refs/bases/master" &&
+    git base -b master set base &&
+    git base -b master check &&
+    git base -b master set M &&
+    test "$(git base -b master)" = "$(git rev-parse M)"
+'
+
+test_done
-- 
1.7.5.rc1.23.g7f622
