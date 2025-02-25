Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [217.11.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2CCDF59
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517006; cv=none; b=bjVUYlYdppmffIegcrb+e3tkPTDPG+5agdSuReatMjmJhG68pEJrKtRnLZD8wXNzZM9nc3VoONZLEbiarhL7o/PVphxFSoLYLkShXh3rHFTwuTWEVdIrGBvktGIYnXjA6hJaxp7kiw+Nw8uXXFM4VXZ09NdaUYPdiZtMSNjr6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517006; c=relaxed/simple;
	bh=65QLimZuCRHKUU/ADNa8+v5h0+N7XqzWl0KK29N1PDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eMpqr4dOe5+1KP5fSgIUmENWL9/ZW99h2PfMktV+jf06mZ53DJzSx/MPdTeNa73lo1XpFVT/G77TKFru1ayrtmWG7Q75pzFOp6h4nuMaYKAcNSQuildOS42zw3qjLDVkjfHfaOVN0/JWx2Yo5qmsfKDsn/vwUU5+4u57Y6jBOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; arc=none smtp.client-ip=217.11.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [BUG/WIP PATCH] unit-tests: use clean test environment
Date: Tue, 25 Feb 2025 21:48:47 +0100
Message-ID: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, unit-tests are run in the user's environment, in particular with
the user's git config which can influence test runs.

Set up the same clean test environment which we use for the other tests.
---
Hi there,

I finally got around to checking whether the last test in t-trailer fails
for me: one of the trailers is present in my git config, messing up the
test assumption. The reasons is a systematic problem in the way we run
unit-tests.

The attached patch is more POC than WIP - it makes t-trailer work again
for me, at least.

unittest-lib.sh is a trimmed down version of test-lib.sh, and I'm sure
it can be trimmed down even more, maybe to the extent of being included
in run-test.sh.

Also, I'm not sute the Makefile change catches all invocations of
unit-tests. (It certainly does not cover direct invocations, of course.)

None of this matters in CI, but it does for local development.

 t/Makefile        |   2 +-
 t/run-test.sh     |   1 +
 t/unittest-lib.sh | 385 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+), 1 deletion(-)
 create mode 100644 t/unittest-lib.sh

diff --git a/t/Makefile b/t/Makefile
index 2994eb5fa9..1222b22440 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -74,7 +74,7 @@ prove: pre-clean check-chainlint $(TEST_LINT)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
-	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' ./run-test.sh $@ $(GIT_TEST_OPTS)
 
 $(UNIT_TESTS):
 	@echo "*** $@ ***"; $@
diff --git a/t/run-test.sh b/t/run-test.sh
index 63328ac630..216c039641 100755
--- a/t/run-test.sh
+++ b/t/run-test.sh
@@ -13,6 +13,7 @@ case "$1" in
 	exec "${TEST_SHELL_PATH}" "$@" ${TEST_OPTIONS}
 	;;
 *)
+	. ./unittest-lib.sh
 	exec "$@"
 	;;
 esac
diff --git a/t/unittest-lib.sh b/t/unittest-lib.sh
new file mode 100644
index 0000000000..d53757f18b
--- /dev/null
+++ b/t/unittest-lib.sh
@@ -0,0 +1,385 @@
+# Test framework for git.  See t/README for usage.
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see https://www.gnu.org/licenses/ .
+
+# Test the binaries we have just built.  The tests are kept in
+# t/ subdirectory and are run in 'trash directory' subdirectory.
+if test -z "$TEST_DIRECTORY"
+then
+	# ensure that TEST_DIRECTORY is an absolute path so that it
+	# is valid even if the current working directory is changed
+	TEST_DIRECTORY=$(pwd)
+else
+	# The TEST_DIRECTORY will always be the path to the "t"
+	# directory in the git.git checkout. This is overridden by
+	# e.g. t/lib-subtest.sh, but only because its $(pwd) is
+	# different. Those tests still set "$TEST_DIRECTORY" to the
+	# same path.
+	#
+	# See use of "$GIT_BUILD_DIR" and "$TEST_DIRECTORY" below for
+	# hard assumptions about "$GIT_BUILD_DIR/t" existing and being
+	# the "$TEST_DIRECTORY", and e.g. "$TEST_DIRECTORY/helper"
+	# needing to exist.
+	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
+fi
+GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
+if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
+then
+	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
+	exit 1
+fi
+if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+then
+	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+	# On Windows, we must convert Windows paths lest they contain a colon
+	case "$(uname -s)" in
+	*MINGW*)
+		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
+		;;
+	esac
+fi
+
+
+if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+then
+	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
+	exit 1
+fi
+. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+export PERL_PATH SHELL_PATH
+
+if test -z "$TEST_OUTPUT_DIRECTORY"
+then
+	# Similarly, override this to store the test-results subdir
+	# elsewhere
+	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
+fi
+
+# Explicitly set the default branch name for testing, to avoid the
+# transitory "git init" warning under --verbose.
+: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+################################################################
+# It appears that people try to run tests without building...
+"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
+if test $? != 1
+then
+	if test -n "$GIT_TEST_INSTALLED"
+	then
+		echo >&2 "error: there is no working Git at '$GIT_TEST_INSTALLED'"
+	else
+		echo >&2 'error: you do not seem to have built git yet.'
+	fi
+	exit 1
+fi
+
+TRASH_DIRECTORY="trash directory.unit-tests"
+test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
+case "$TRASH_DIRECTORY" in
+/*) ;; # absolute path is good
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
+esac
+
+# Since bash 5.0, checkwinsize is enabled by default which does
+# update the COLUMNS variable every time a non-builtin command
+# completes, even for non-interactive shells.
+# Disable that since we are aiming for repeatability.
+test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
+
+# For repeatability, reset the environment to known value.
+# TERM is sanitized below, after saving color control sequences.
+LANG=C
+LC_ALL=C
+PAGER=cat
+TZ=UTC
+COLUMNS=80
+export LANG LC_ALL PAGER TZ COLUMNS
+EDITOR=:
+
+# A call to "unset" with no arguments causes at least Solaris 10
+# /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
+# deriving from the command substitution clustered with the other
+# ones.
+unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
+	my @env = keys %ENV;
+	my $ok = join("|", qw(
+		TRACE
+		DEBUG
+		TEST
+		.*_TEST
+		PROVE
+		VALGRIND
+		UNZIP
+		PERF_
+		CURL_VERBOSE
+		TRACE_CURL
+		BUILD_DIR
+	));
+	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
+	print join("\n", @vars);
+')
+unset XDG_CACHE_HOME
+unset XDG_CONFIG_HOME
+unset GITPERLLIB
+unset GIT_TRACE2_PARENT_NAME
+unset GIT_TRACE2_PARENT_SID
+TEST_AUTHOR_LOCALNAME=author
+TEST_AUTHOR_DOMAIN=example.com
+GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
+GIT_AUTHOR_NAME='A U Thor'
+GIT_AUTHOR_DATE='1112354055 +0200'
+TEST_COMMITTER_LOCALNAME=committer
+TEST_COMMITTER_DOMAIN=example.com
+GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
+GIT_COMMITTER_NAME='C O Mitter'
+GIT_COMMITTER_DATE='1112354055 +0200'
+GIT_MERGE_VERBOSITY=5
+GIT_MERGE_AUTOEDIT=no
+export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
+export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
+export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
+export EDITOR
+
+GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
+export GIT_DEFAULT_HASH
+GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+export GIT_DEFAULT_REF_FORMAT
+GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
+export GIT_TEST_MERGE_ALGORITHM
+
+# Use specific version of the index file format
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
+then
+	GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
+	export GIT_INDEX_VERSION
+fi
+
+if test -n "$GIT_TEST_PERL_FATAL_WARNINGS"
+then
+	GIT_PERL_FATAL_WARNINGS=1
+	export GIT_PERL_FATAL_WARNINGS
+fi
+
+# Protect ourselves from common misconfiguration to export
+# CDPATH into the environment
+unset CDPATH
+
+unset GREP_OPTIONS
+unset UNZIP
+
+case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+1|2|true)
+	GIT_TRACE=4
+	;;
+esac
+
+# Line feed
+LF='
+'
+
+# Single quote
+SQ=\'
+
+# UTF-8 ZERO WIDTH NON-JOINER, which HFS+ ignores
+# when case-folding filenames
+u200c=$(printf '\342\200\214')
+
+export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
+
+test "x$TERM" != "xdumb" && (
+		test -t 1 &&
+		tput bold >/dev/null 2>&1 &&
+		tput setaf 1 >/dev/null 2>&1 &&
+		tput sgr0 >/dev/null 2>&1
+	) &&
+	color=t
+
+if test -n "$color"
+then
+	# Save the color control sequences now rather than run tput
+	# each time say_color() is called.  This is done for two
+	# reasons:
+	#   * TERM will be changed to dumb
+	#   * HOME will be changed to a temporary directory and tput
+	#     might need to read ~/.terminfo from the original HOME
+	#     directory to get the control sequences
+	# Note:  This approach assumes the control sequences don't end
+	# in a newline for any terminal of interest (command
+	# substitutions strip trailing newlines).  Given that most
+	# (all?) terminals in common use are related to ECMA-48, this
+	# shouldn't be a problem.
+	say_color_error=$(tput bold; tput setaf 1) # bold red
+	say_color_skip=$(tput setaf 4) # blue
+	say_color_warn=$(tput setaf 3) # brown/yellow
+	say_color_pass=$(tput setaf 2) # green
+	say_color_info=$(tput setaf 6) # cyan
+	say_color_reset=$(tput sgr0)
+	say_color_="" # no formatting for normal text
+	say_color () {
+		test -z "$1" && test -n "$quiet" && return
+		eval "say_color_color=\$say_color_$1"
+		shift
+		printf "%s\\n" "$say_color_color$*$say_color_reset"
+	}
+else
+	say_color() {
+		test -z "$1" && test -n "$quiet" && return
+		shift
+		printf "%s\n" "$*"
+	}
+fi
+
+USER_TERM="$TERM"
+TERM=dumb
+export TERM USER_TERM
+
+_error_exit () {
+	GIT_EXIT_OK=t
+	exit 1
+}
+
+error () {
+	say_color error "error: $*"
+	_error_exit
+}
+
+BUG () {
+	error >&7 "bug in the test script: $*"
+}
+
+BAIL_OUT () {
+	test $# -ne 1 && BUG "1 param"
+
+	# Do not change "Bail out! " string. It's part of TAP syntax:
+	# https://testanything.org/tap-specification.html
+	local bail_out="Bail out! "
+	local message="$1"
+
+	say_color >&5 error $bail_out "$message"
+	_error_exit
+}
+
+say () {
+	say_color info "$*"
+}
+
+die () {
+	code=$?
+	if test -n "$GIT_EXIT_OK"
+	then
+		exit $code
+	else
+		echo >&52"FATAL: Unexpected exit with code $code"
+		exit 1
+	fi
+}
+
+GIT_EXIT_OK=
+trap 'die' EXIT
+# Disable '-x' tracing, because with some shells, notably dash, it
+# prevents running the cleanup commands when a test script run with
+# '--verbose-log -x' is interrupted.
+trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
+
+if test -n "$GIT_TEST_INSTALLED"
+then
+	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
+	error "Cannot run git from $GIT_TEST_INSTALLED."
+	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
+	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
+else # normal case, use ../bin-wrappers only unless $with_dashes:
+	if test -n "$no_bin_wrappers"
+	then
+		with_dashes=t
+	else
+		git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
+		if ! test -x "$git_bin_dir/git"
+		then
+			if test -z "$with_dashes"
+			then
+				say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
+			fi
+			with_dashes=t
+		fi
+		PATH="$git_bin_dir:$PATH"
+	fi
+	GIT_EXEC_PATH=$GIT_BUILD_DIR
+	if test -n "$with_dashes"
+	then
+		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
+	fi
+fi
+GIT_TEMPLATE_DIR="$GIT_TEST_TEMPLATE_DIR"
+GIT_CONFIG_NOSYSTEM=1
+GIT_ATTR_NOSYSTEM=1
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.."
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM GIT_CEILING_DIRECTORIES
+
+GITPERLLIB="$GIT_TEST_GITPERLLIB"
+export GITPERLLIB
+test -d "$GIT_TEMPLATE_DIR" || {
+	BAIL_OUT "You haven't built things yet, have you?"
+}
+
+if ! test -x "$GIT_BUILD_DIR"/t/helper/test-tool$X
+then
+	BAIL_OUT 'You need to build test-tool; Run "make t/helper/test-tool" in the source (toplevel) directory'
+fi
+
+# Last-minute variable setup
+USER_HOME="$HOME"
+HOME="$TRASH_DIRECTORY"
+GNUPGHOME="$HOME/gnupg-home-not-used"
+export HOME GNUPGHOME USER_HOME
+
+# "rm -rf" existing trash directory, even if a previous run left it
+# with bad permissions.
+remove_trash_directory () {
+	dir="$1"
+	if ! rm -rf "$dir" 2>/dev/null
+	then
+		chmod -R u+rwx "$dir"
+		rm -rf "$dir"
+	fi
+	! test -d "$dir"
+}
+
+# Test repository
+remove_trash_directory "$TRASH_DIRECTORY" || {
+	BAIL_OUT 'cannot prepare test area'
+}
+
+remove_trash=t
+if test -z "$TEST_NO_CREATE_REPO"
+then
+	git init \
+	    ${TEST_CREATE_REPO_NO_TEMPLATE:+--template=} \
+	    "$TRASH_DIRECTORY" ||
+	error "cannot run git init"
+else
+	mkdir -p "$TRASH_DIRECTORY"
+fi
+
+
+# Ensure that no test accidentally triggers a Git command
+# that runs the actual maintenance scheduler, affecting a user's
+# system permanently.
+# Tests that verify the scheduler integration must set this locally
+# to avoid errors.
+GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+export GIT_TEST_MAINT_SCHEDULER
-- 
2.48.1.749.g66b74ae094

