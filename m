From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] perf: compare diff algorithms
Date: Wed, 07 Mar 2012 09:45:19 -0800
Message-ID: <7vk42wnw40.fsf@alter.siamese.dyndns.org>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
 <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch> <7vhay1se0g.fsf@alter.siamese.dyndns.org> <87y5rdzbpb.fsf@thomas.inf.ethz.ch> <7vr4x5qvgd.fsf@alter.siamese.dyndns.org> <m31up5tnjw.fsf@localhost.localdomain> <877gywy40l.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Kvb-0003Ro-PF
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 18:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854Ab2CGRp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 12:45:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964847Ab2CGRpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 12:45:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38DE9708A;
	Wed,  7 Mar 2012 12:45:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z6v/mvMweYYNZYVybTFnXaiEBFM=; b=U+pvPU
	oG8tBT03kvimQG5YZMFdi9vdQ1f3kOzPROVfiPvujAvmTyWTtgGOWtCgXH6JbD1P
	VsSpMs86sPeA0H6dAYZmTwOPBXOPtyrq3rr7ByL9XhZuDvndNsjd8v9kl3rrmk/T
	n+53RoS+yz4NqYjaznfFhLSitLd7gltZnQtOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pc/sF7RNEH7vgi9Zq30zsnylnx6DehHu
	uBEmQsrY+UiV/BkxfPOg9E+iuBOw4NE34Fvv3MyUM7eDVvBk/rsBo9BAIGiPxLr9
	I1K2w7ut7MvpDvDmlzd/iNcnf0VIUSo6SDUvD0fDaI1Ho4dZZTyZn7ZBpdXuAfwz
	XLQaxTQmiA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D7287089;
	Wed,  7 Mar 2012 12:45:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 490607088; Wed,  7 Mar 2012
 12:45:21 -0500 (EST)
In-Reply-To: <877gywy40l.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 7 Mar 2012 13:44:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F93C2F0-687D-11E1-A5D1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192466>

Thomas Rast <trast@inf.ethz.ch> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Thomas, take a look at how it is solved in 't/t9700/test.pl', used by
>> 't/t9700-perl-git.sh':
>>
>>   use lib (split(/:/, $ENV{GITPERLLIB}));
>
> Hum.  The problem is that the user may invoke aggregate.perl manually,
> and GITPERLLIB won't be set in that case.

I would equate "manual invocation" with "the user knows what he is doing",
so if that is the only problem, I think we are good.

> Is there a better solution than duplicating the logic that sets
> GITPERLLIB in test-lib.sh within aggregate.perl?

Perhaps the part to figure out the directory layout can and should
be split out of test-lib.sh into test-env.sh or something and be
dot-sourced at the beginning of test-lib.sh; would that help?

 t/test-env.sh |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh |  118 ++++-----------------------------------------------------
 2 files changed, 120 insertions(+), 110 deletions(-)

diff --git a/t/test-env.sh b/t/test-env.sh
new file mode 100644
index 0000000..1159c5a
--- /dev/null
+++ b/t/test-env.sh
@@ -0,0 +1,112 @@
+# figure out the environment a test-related script is being run
+# taken from test-lib.sh, Copyright (c) 2005 Junio C Hamano
+
+# The directory to find other helper pieces e.g. lib-gpg.sh of the
+# test suite; usually t/ in the git source tree.
+if test -z "$TEST_DIRECTORY"
+then
+	# We allow tests to override this, in case they want to run tests
+	# outside of t/, e.g. for running tests on the test library
+	# itself.
+	TEST_DIRECTORY=$(pwd)
+fi
+GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
+GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
+
+if test -n "$valgrind"
+then
+	make_symlink () {
+		test -h "$2" &&
+		test "$1" = "$(readlink "$2")" || {
+			# be super paranoid
+			if mkdir "$2".lock
+			then
+				rm -f "$2" &&
+				ln -s "$1" "$2" &&
+				rm -r "$2".lock
+			else
+				while test -d "$2".lock
+				do
+					say "Waiting for lock on $2."
+					sleep 1
+				done
+			fi
+		}
+	}
+
+	make_valgrind_symlink () {
+		# handle only executables, unless they are shell libraries that
+		# need to be in the exec-path.  We will just use "#!" as a
+		# guess for a shell-script, since we have no idea what the user
+		# may have configured as the shell path.
+		test -x "$1" ||
+		test "#!" = "$(head -c 2 <"$1")" ||
+		return;
+
+		base=$(basename "$1")
+		symlink_target=$GIT_BUILD_DIR/$base
+		# do not override scripts
+		if test -x "$symlink_target" &&
+		    test ! -d "$symlink_target" &&
+		    test "#!" != "$(head -c 2 < "$symlink_target")"
+		then
+			symlink_target=../valgrind.sh
+		fi
+		case "$base" in
+		*.sh|*.perl)
+			symlink_target=../unprocessed-script
+		esac
+		# create the link, or replace it if it is out of date
+		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
+	}
+
+	# override all git executables in TEST_DIRECTORY/..
+	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
+	mkdir -p "$GIT_VALGRIND"/bin
+	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
+	do
+		make_valgrind_symlink $file
+	done
+	# special-case the mergetools loadables
+	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
+	OLDIFS=$IFS
+	IFS=:
+	for path in $PATH
+	do
+		ls "$path"/git-* 2> /dev/null |
+		while read file
+		do
+			make_valgrind_symlink "$file"
+		done
+	done
+	IFS=$OLDIFS
+	PATH=$GIT_VALGRIND/bin:$PATH
+	GIT_EXEC_PATH=$GIT_VALGRIND/bin
+	export GIT_VALGRIND
+elif test -n "$GIT_TEST_INSTALLED" ; then
+	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
+	error "Cannot run git from $GIT_TEST_INSTALLED."
+	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
+	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
+else # normal case, use ../bin-wrappers only unless $with_dashes:
+	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
+	if ! test -x "$git_bin_dir/git" ; then
+		if test -z "$with_dashes" ; then
+			say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
+		fi
+		with_dashes=t
+	fi
+	PATH="$git_bin_dir:$PATH"
+	GIT_EXEC_PATH=$GIT_BUILD_DIR
+	if test -n "$with_dashes" ; then
+		PATH="$GIT_BUILD_DIR:$PATH"
+	fi
+fi
+GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
+
+. "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+
+GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
+
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 30ed4d7..e892368 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -31,6 +31,13 @@ done,*)
 	;;
 esac
 
+# Protect ourselves from common misconfiguration to export
+# CDPATH into the environment
+unset CDPATH
+unset GREP_OPTIONS
+
+. ./test-env.sh
+
 # Keep the original TERM for say_color
 ORIGINAL_TERM=$TERM
 
@@ -72,12 +79,6 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
-# Protect ourselves from common misconfiguration to export
-# CDPATH into the environment
-unset CDPATH
-
-unset GREP_OPTIONS
-
 case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
 	1|2|true)
 		echo "* warning: Some tests will not work if GIT_TRACE" \
@@ -380,117 +381,17 @@ test_done () {
 	esac
 }
 
-# Test the binaries we have just built.  The tests are kept in
-# t/ subdirectory and are run in 'trash directory' subdirectory.
-if test -z "$TEST_DIRECTORY"
-then
-	# We allow tests to override this, in case they want to run tests
-	# outside of t/, e.g. for running tests on the test library
-	# itself.
-	TEST_DIRECTORY=$(pwd)
-fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then
 	# Similarly, override this to store the test-results subdir
 	# elsewhere
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
-if test -n "$valgrind"
-then
-	make_symlink () {
-		test -h "$2" &&
-		test "$1" = "$(readlink "$2")" || {
-			# be super paranoid
-			if mkdir "$2".lock
-			then
-				rm -f "$2" &&
-				ln -s "$1" "$2" &&
-				rm -r "$2".lock
-			else
-				while test -d "$2".lock
-				do
-					say "Waiting for lock on $2."
-					sleep 1
-				done
-			fi
-		}
-	}
-
-	make_valgrind_symlink () {
-		# handle only executables, unless they are shell libraries that
-		# need to be in the exec-path.  We will just use "#!" as a
-		# guess for a shell-script, since we have no idea what the user
-		# may have configured as the shell path.
-		test -x "$1" ||
-		test "#!" = "$(head -c 2 <"$1")" ||
-		return;
-
-		base=$(basename "$1")
-		symlink_target=$GIT_BUILD_DIR/$base
-		# do not override scripts
-		if test -x "$symlink_target" &&
-		    test ! -d "$symlink_target" &&
-		    test "#!" != "$(head -c 2 < "$symlink_target")"
-		then
-			symlink_target=../valgrind.sh
-		fi
-		case "$base" in
-		*.sh|*.perl)
-			symlink_target=../unprocessed-script
-		esac
-		# create the link, or replace it if it is out of date
-		make_symlink "$symlink_target" "$GIT_VALGRIND/bin/$base" || exit
-	}
-
-	# override all git executables in TEST_DIRECTORY/..
-	GIT_VALGRIND=$TEST_DIRECTORY/valgrind
-	mkdir -p "$GIT_VALGRIND"/bin
-	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
-	do
-		make_valgrind_symlink $file
-	done
-	# special-case the mergetools loadables
-	make_symlink "$GIT_BUILD_DIR"/mergetools "$GIT_VALGRIND/bin/mergetools"
-	OLDIFS=$IFS
-	IFS=:
-	for path in $PATH
-	do
-		ls "$path"/git-* 2> /dev/null |
-		while read file
-		do
-			make_valgrind_symlink "$file"
-		done
-	done
-	IFS=$OLDIFS
-	PATH=$GIT_VALGRIND/bin:$PATH
-	GIT_EXEC_PATH=$GIT_VALGRIND/bin
-	export GIT_VALGRIND
-elif test -n "$GIT_TEST_INSTALLED" ; then
-	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
-	error "Cannot run git from $GIT_TEST_INSTALLED."
-	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
-	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
-else # normal case, use ../bin-wrappers only unless $with_dashes:
-	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
-	if ! test -x "$git_bin_dir/git" ; then
-		if test -z "$with_dashes" ; then
-			say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
-		fi
-		with_dashes=t
-	fi
-	PATH="$git_bin_dir:$PATH"
-	GIT_EXEC_PATH=$GIT_BUILD_DIR
-	if test -n "$with_dashes" ; then
-		PATH="$GIT_BUILD_DIR:$PATH"
-	fi
-fi
-GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
 GIT_ATTR_NOSYSTEM=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
+export GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 
@@ -503,9 +404,6 @@ then
 		GIT_TEST_CMP="$DIFF -u"
 	fi
 fi
-
-GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
-export GITPERLLIB
 test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
