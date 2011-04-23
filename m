From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 01/23] Introduce git-test.sh and git-test-lib.sh
Date: Sat, 23 Apr 2011 17:22:30 +1000
Message-ID: <1303543372-77843-2-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCC-0004YJ-CP
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab1DWHX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:23:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39715 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab1DWHXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:23:48 -0400
Received: by pzk9 with SMTP id 9so584380pzk.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=wDk83oouemHTr+G2QTelbd4bMQjSjmYp4pYzRS0ucyI=;
        b=U/jo35MksEZBZOM96ZkJnNugK5ToabyrwBEKY8E9XJomBcQXoRYMq17kmvxkO+Lsg+
         VCN/2TIj+aQIzblTWNz8B2gQYCTQs0GJLtFm76aXOG8CUYaxeSPalJVdwADbkqCGPevt
         7SnTcdKqrdvWLHQRoQJCM1UhOwqOyY7KhfDCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WcMqui+PkZuMQlAvwwoK0PwSWmNQm3MZuNmebIx8DVtXHSC9yxNAS5dIeavgVB8Z8B
         vgTaFztxBP3jlI0JMWtT0uZXjfc6oOoP/O6xlYgDo4lp8pRq2/smgvf4ONF6Szv+gNOc
         6WYg9/UOjF/5Hopt+AiM2DxfiH/4BOMtbngGs=
Received: by 10.68.17.232 with SMTP id r8mr156452pbd.91.1303543427593;
        Sat, 23 Apr 2011 00:23:47 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:23:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171955>

This command is intended provide a uniform command line interface
to a suite of assertions that can be made about the state of
the working tree, index and repository.

This commit introduces the core assert infrastructure. Subsequent
commits will introduce check functions that extend the infrastructure
in a modular way with additional tests.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

Replace environment with git configuration.

test_must_fail: core
---
 .gitignore                 |    3 +
 Documentation/git-test.txt |  154 ++++++++++++++++++++++++++++++++++++
 Makefile                   |    3 +
 git-conditions-lib.sh      |   12 +++
 git-test-lib.sh            |  187 ++++++++++++++++++++++++++++++++++++++++++++
 git-test.sh                |   11 +++
 t/t1520-test.sh            |  185 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 555 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-test.txt
 create mode 100644 git-conditions-lib.sh
 create mode 100644 git-test-lib.sh
 create mode 100755 git-test.sh
 create mode 100755 t/t1520-test.sh

diff --git a/.gitignore b/.gitignore
index 2cf3ca5..aa0eb8fb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,6 +27,7 @@
 /git-clone
 /git-commit
 /git-commit-tree
+/git-conditions-lib
 /git-config
 /git-count-objects
 /git-cvsexportcommit
@@ -141,6 +142,8 @@
 /git-symbolic-ref
 /git-tag
 /git-tar-tree
+/git-test
+/git-test-lib
 /git-unpack-file
 /git-unpack-objects
 /git-update-index
diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
new file mode 100644
index 0000000..1792c4e
--- /dev/null
+++ b/Documentation/git-test.txt
@@ -0,0 +1,154 @@
+git-test(1)
+===========
+
+NAME
+----
+git-test - evaluates one or more conditions about the state of the git working tree, index or repository
+
+SYNOPSIS
+--------
+The git test API is available in the form of a command and also as a shell library. 
+
+COMMAND SYNOPSIS
+----------------
+[verse]
+'git test' [-q] [--message message] [--<condition> [ arg ... ]] ...
+
+LIBRARY SYNOPSIS
+----------------
+[verse]
+'assert' [-q] [--message message] [--<condition> [ arg ... ]] ...
+'test_condition' [--<condition> [ arg ... ]] ...
+'require_condition_libs'
+
+
+DESCRIPTION
+-----------
+`git test` provides a uniform, extensible API for evaluating various conditions that
+pertain to the state of a git working tree, index and repository.
+
+Specified conditions are evaluated from left to right. If any condition evaluates to false, 
+the command conditionally prints a diagnostic message to stderr and sets a 
+non-zero status code. Otherwise, sets a status code of zero. 
+
+The message used to report a assertion failure may be overidden by specifying the --message option.
+
+Diagnostic output resulting from an assertion failure may be suppressed with the -q option. 
+Note that the -q option does not suppress diagnostic output that results from the failure to 
+successfully parse the arguments that configure the test API.
+
+The `assert` and `test_condition` functions differ according to how they handle failing conditions. 
+
+The `assert` function behaves like the test command but assertion failures will cause 
+the current shell to exit with a non-zero status code. To prevent this occurring, invoke
+the `assert` function within a subshell or use the `test_condition` function instead.
+
+The `test_condition` function will not exit the current shell in the event that an assertion failure
+is detected nor will it generate diagnostic relating to an assertion failure to stderr. 
+
+Note, however, that `test_condition` may still exit the current shell with a non-zero status code 
+if it is unable to successfully parse the arguments presented to it. Callers who need to protect 
+against this possibility either guarantee that the required arguments are available or 
+imbed calls to `test_condition` within a subshell.
+
+The `require_condition_libs` function may be used to include any condition libs listed
+in condition.lib variables of the the git configuration.
+
+
+OPTIONS
+-------
+'--message'::
+	The message to be used to report a failure if an assertion fails.
+'-q'::	
+        Suppress assertion messages.
+
+CONDITIONS
+----------
+
+EXTENDING THE CONDITION LIBRARY
+-------------------------------
+The library of conditions that the assert API can process may be extended by 
+adding functions of the form check_\{dehyphenated_condition_name\}_N to the 
+shell environment, where \{dehyphenated_condition_name\} is the result of 
+replacing any occurrence of \'-\' in the condition name with \'_\' and 
+N is the number of arguments that need to be passed to the function.
+
+For example, suppose you are writing a script, foo.sh, that includes the git test library 
+and that you want to add a new, 1-argument, condition, foo-X to the library of 
+conditions that can be tested by the git testion framework. 
+
+---------
+#/bin/sh
+. $(git --exec-path)/git-test-lib
+
+check_foo_X_1()
+{
+    if # some test of $1
+    then
+	echo "foo-X is true"
+    else
+	echo "foo-X is false"
+	false
+    fi
+}
+
+assert --foo-X "somearg"
+--------
+If its condition holds, the condition function must set a status
+code of zero and write a non-empty message describing the condition to stdout.
+If its condition does not hold, the condition function must set a non-zero
+status code of zero and write a non-empty message describing the condition
+that does hold to stdout.
+
+It is an error, and is reported as such, if a condition function
+executes without generating any output on stdout. The resulting
+state will then be interpreted as condition evaluation failure
+rather than an assertion failure.
+
+To make such conditions available to the git test command line, put the 
+function in a file called ~/foo-lib,sh add a reference 
+to the library to the git configuration, like so:
+
+---------
+git config --add condition.lib ~/foo-lib.sh
+git test --foo-X one-arg                     # now use foo-X from the git test command line
+---------
+
+CONFIGURATION
+-------------
+condition.lib::
+	Specifies a shell library that contains definitions of one or more
+	condition check functions that can be used to extend the range
+	of conditions that can be used with the git test API.
+
+EXAMPLES
+--------
+* Reset the working tree to the specified commit, but only the current HEAD is tree-same with that commit
+! git assert -q --tree-same HEAD upstream/master || git reset --hard upstream/master
+* Reset the working tree, but only if there are no staged or unstaged changes
++
+-----------
+git test --not-staged --not-unstaged && git reset --hard another-commit
+-----------
+* Import the git-test-lib library into another script
++
+-----------
+. $(git --exec-path)/git-test-lib
+assert --not-staged   	      	                              # die if there are any staged files
+assert --message "there are staged files" --not-staged	      # die with an alternative message 
+                                                              # if there are any staged files
+test_condition --not-staged || echo "there are staged files"  # check whether there are staged files, 
+                                                              # but do not die if there are
+-----------
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
index 92c1c5e..93ff6c6 100644
--- a/Makefile
+++ b/Makefile
@@ -376,11 +376,14 @@ SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
+SCRIPT_SH += git-test.sh
 SCRIPT_SH += git-web--browse.sh
 
+SCRIPT_LIB += git-conditions-lib
 SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-sh-setup
+SCRIPT_LIB += git-test-lib
 
 SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
new file mode 100644
index 0000000..f462e22
--- /dev/null
+++ b/git-conditions-lib.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+#
+# (c) Copyright Jon Seymour 2010
+#
+if test -z "${__GIT_CONDITIONS_LIB_INCLUDED}"
+then
+__GIT_CONDITIONS_LIB_INCLUDED=t
+#
+# Provides a function that enables the evaluation of assertions.
+#
+
+fi
diff --git a/git-test-lib.sh b/git-test-lib.sh
new file mode 100644
index 0000000..159cea6
--- /dev/null
+++ b/git-test-lib.sh
@@ -0,0 +1,187 @@
+#!/bin/sh
+#
+# (c) Copyright Jon Seymour 2010
+#
+if test -z "${__GIT_ASSERT_LIB_INCLUDED}"
+then
+__GIT_ASSERT_LIB_INCLUDED=t
+
+. $(git --exec-path)/git-conditions-lib
+
+is_a_function()
+{
+    test "$(type $1 2>/dev/null | sed -n "s/is a .*function/is a function/p")" == "$1 is a function"
+}
+
+if ! is_a_function die
+then
+die() {
+	echo >&2 "$@"
+	exit 1
+}
+fi
+
+require_lib()
+{
+	if test -f "$1"
+	then
+		. "$1" || die "failed to read: '$1'"
+	else
+		echo "warning: condition library '$1' does not exist" 1>&2
+	fi
+}
+
+require_condition_libs() {
+	eval $(
+		git config --get-all condition.lib | while read lib
+		do 
+			echo "require_lib \"$lib\" \;"
+		done	
+	)
+}
+
+assertion_failed() {
+	rc=$1
+	shift 
+	message="${MESSAGE:-$*}"
+	if ! ${QUIET:-false}
+	then
+		echo "${message}" 1>&2
+	fi
+
+	if test -z "${EXIT_ON_FAILURE}"
+	then
+		return $rc
+	else
+		exit $rc;
+	fi
+}
+
+evaluation_failed() {
+	rc=$1
+	shift
+	echo "fatal: condition evaluation failed for $*" 1>&2
+	exit $rc
+}
+
+not() {
+	! "$@"
+}
+
+#
+# reviewers: is there a more concise way to express this in POSIX?
+#
+replace() {
+	word=$1
+	from=$2
+	to=$3
+	
+	prefix=${word%${from}*}
+	suffix=${word#${prefix}${from}}
+
+	if test "$prefix" = "$word"
+	then
+		echo $word
+	else
+		echo "$(replace ${prefix} '-' '_')${to}${suffix}"
+	fi
+}
+
+impl() {
+	MESSAGE=
+	QUIET=false
+	QUEUE=""
+	exprs=""
+	while test $# -gt 0
+	do
+		word=$1
+		shift
+		case $word in
+			--message)
+			MESSAGE=$1
+			shift
+			continue
+			;;
+			--include)
+				test $# -gt 0 || die "can't shift 1 argument for --include option"
+				test -f "$1" || die "'$1' must be a file"
+				require_lib "$1"
+				shift 
+				continue
+			;;
+			-q)
+			QUIET=true
+			continue;
+			;;
+			--not-*)
+			negation='not'
+			condition=${word#--not-}
+			;;
+			--*)
+			negation=''
+			condition=${word#--}
+			;;
+			*)
+			die "argument not recognised: $word"
+			;;
+		esac
+
+		dehyphenated=$(replace "$condition" "-" "_")
+
+		expr=
+		args=
+		try=0
+
+		while ! is_a_function check_${dehyphenated}_$try
+		do	
+			test -n "$1" || die "condition $condition is not supported or insufficient arguments were supplied"
+			test "${1#--}" = "$1" || die "condition $condition is not supported or insufficient arguments were supplied"
+			args="${args}${args:+ }$(git rev-parse --sq-quote $1)"
+			shift
+			try=$((try+1))
+		done
+
+		exprs="${exprs}${exprs:+ }${negation}${negation:+ }$word $try check_${dehyphenated}_$try $args"
+
+	done 
+
+	set -- $exprs
+	while test $# -gt 0
+	do
+		if test "$1" = "not"
+		then
+			negation=not
+			shift
+		else
+			negation=
+		fi
+		word=$1
+		nargs=$2
+		shift 2
+		message=$(eval $negation "$@") 
+		rc=$?
+		if test $rc -ne 0
+		then
+			if test -n "$message"
+			then
+				assertion_failed $rc "$message"
+			else
+				evaluation_failed $rc "$word $2 ..."
+			fi
+			return $rc
+		fi
+		shift $((nargs+1))
+	done
+}
+
+assert() {
+	EXIT_ON_FAILURE=t
+	impl "$@"
+}
+
+test_condition() {
+	EXIT_ON_FAILURE=
+	impl "$@" 2>/dev/null
+}
+
+fi
diff --git a/git-test.sh b/git-test.sh
new file mode 100755
index 0000000..4070ae5
--- /dev/null
+++ b/git-test.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+#
+# (c) Copyright Jon Seymour 2010
+#
+SUBDIRECTORY_OK=true
+. git-sh-setup
+. git-test-lib
+
+require_condition_libs
+
+assert "$@"
diff --git a/t/t1520-test.sh b/t/t1520-test.sh
new file mode 100755
index 0000000..9e3abe6
--- /dev/null
+++ b/t/t1520-test.sh
@@ -0,0 +1,185 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='git-test tests
+
+Checks that the git-test conditions are correctly evaluated.
+'
+
+. ./test-lib.sh
+. $(git --exec-path)/git-test-lib.sh
+
+cat >test-assertions-lib.sh <<EOF
+check_always_fails_0_0()
+{
+	echo "always-fails-0"
+	false
+}
+
+check_always_fails_1_1()
+{
+	echo "always-fails-1 \$1"
+	false
+}
+
+check_never_fails_0_0()
+{
+	echo "never-fails-0"
+	true
+}
+
+check_never_fails_1_1()
+{
+	echo "never-fails-1 \$1"
+	true
+}
+EOF
+cat >empty-assertions-lib.sh <<EOF
+EOF
+
+git config condition.lib "$(pwd)/test-assertions-lib.sh"
+git config --add condition.lib "$(pwd)/empty-assertions-lib.sh"
+
+test_expect_assertion_failure()
+{
+	test=$1
+	message=$2
+	shift 
+	test_expect_success $1 \
+"
+	! actual_message=$(git test "$@" 1>&2) &&
+	test "$message" = "$actual_message"
+"
+}
+
+#        G
+#       /
+# base-A---M--C--D--D1--E
+#     \   / \
+#      -B-   -F
+
+test_expect_success 'setup' \
+'
+	git add test-assertions-lib.sh empty-assertions-lib.sh && 
+	test_commit base &&
+	test_commit A &&
+	git checkout A^1 &&
+	test_commit B && 
+	git checkout master &&
+	test_merge M B &&
+	echo C >> B.t &&
+	git tag STASH_UNSTAGED $(git stash create) &&
+	git add B.t &&
+	git tag STASH_STAGED $(git stash create) &&
+	test_commit C &&
+	test_commit D &&
+	git commit -m "allow-empty" --allow-empty &&
+	git tag D1 &&
+	test_commit E &&
+	git checkout M^0 -- &&
+        echo F >> B.t &&
+        git add B.t &&
+	test_commit F &&
+	git checkout A^0 -- &&
+	test_commit G &&
+	git checkout master &&
+	git reset --hard D     
+'
+
+test_expect_success 'git test # no arguments' \
+'
+	git test &&
+	test -z "$(git test)"
+'
+
+test_expect_success 'git test -q # -q only' \
+'
+	git test -q &&
+	test -z "$(git test)"
+'
+
+test_expect_success 'git test --message msg # with a message' \
+'
+	git test --message msg &&
+	test -z "$(git test)"
+'
+
+test_expect_success 'git test --message "" # with an empty message' \
+'
+	git test --message "" &&
+	test -z "$(git test)"
+'
+
+test_expect_success 'git test --message # should fail' \
+'
+	test_must_fail git test --message
+'
+
+test_expect_success 'git test --invalid-condition # should fail' \
+'
+	test_must_fail git test --invalid-condition
+'
+
+test_expect_success 'git test --not-invalid-condition # should fail' \
+'
+	test_must_fail git test --not-invalid-condition
+'
+
+test_expect_success 'git test --invalid-condition --never-fails-0 # should fail' \
+'
+	test_must_fail git test --invalid-condition --never-fails-0
+'
+
+test_expect_success 'git test --invalid-condition one-arg --never-fails-0 #should fail' \
+'
+	test_must_fail git test --invalid-condition one-arg --never-fails-0
+'
+
+test_expect_success 'git test --never-fails-0' \
+'
+	git test --never-fails-0
+'
+
+test_expect_success 'git test --never-fails-1 # missing argument - should fail' \
+'
+	test_must_fail git test --never-fails-1
+'
+
+test_expect_success 'git test --never-fails-1 one-arg' \
+'
+	git test --never-fails-1 one-arg
+'
+
+test_expect_success 'git test --not-never-fails-0 # should fail' \
+'
+	test_must_fail git test --not-never-fails-0
+'
+
+test_expect_success 'git test --always-fails-0 # should fail' \
+'
+	test_must_fail git test --always-fails-0
+'
+
+test_expect_success 'git test --always-fails-1 # should fail' \
+'
+	test_must_fail git test --always-fails-1 one-arg
+'
+
+test_expect_success 'git test --not-always-fails-1 one-arg' \
+'
+	git test --not-always-fails-1 one-arg
+'
+
+test_expect_success 'git test --not-always-fails-1 # should fail' \
+'
+	test_must_fail git test --not-always-fails-1
+'
+
+test_expect_success 'git test --not-always-fails-0' \
+'
+	git test --not-always-fails-0
+'
+'
+test_done
-- 
1.7.5.rc1.23.g7f622
