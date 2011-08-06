From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 01/40] test-cleaner: automate whitespace cleaning of test scripts
Date: Sat,  6 Aug 2011 18:44:15 +1000
Message-ID: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVW-0004qa-DW
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab1HFIpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:08 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1HFIpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:06 -0400
Received: by iye16 with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f+Yrxnxek4qhho6iDcPJm2lrBdjbOAWw4AB/hHGOplU=;
        b=cNtMHc6uXO4hTvEEoQ25wZHZmQKn7pbQspxdmDw2dvlzA+d7YtUbooMUsg3EQWElsS
         r5E1OaTD/En1pu0EqqeidBg3RfFRlBJwgIu3yX2mQ2MBpVJO1sKq21xqG5n4J8lOv7Ak
         Qxcgp0EF0msyeq9PYgDA5kD3a63GRyNGQMlb0=
Received: by 10.231.117.35 with SMTP id o35mr936164ibq.23.1312620306237;
        Sat, 06 Aug 2011 01:45:06 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178832>

This script allows the automated cleaning of test scripts.

Any whitespace fixups of a test script that do not effect the
exit status or output of the test are assumed to be safe
and are automatically committed.

To check the tests for whitespace issues, change into git's
test directory and run:

	test-cleaner.sh check-whitespace t*.sh

This will:

* write one line of the form:

	AUTO<tab><filename>

for each file that can be fixed automatically.

* write one line of the form:

	MANUAL<tab><filename>

for each file that will require manual intervention to fix.

To fix all the automatically correctable errors, run:

	./test-cleaner.sh fix-whitespace-auto t[0-9]*.sh

To generate commits for all the errors that require manual correction, run:

	./test-cleaner.sh fix-whitespace-manual t[0-9]*.sh

To clean a file without running tests or generating commits, run:

	./test-cleaner.sh clean-whitespace foobar.sh

clean-whitespace can be used with files that are not tests.

If no arguments are supplied, file arguments are read from stdin.

The filter itself can be run with:

	./test-cleaner.sh whitespace-filter < file > some-other-file

The resulting series of commits should rebased on both the git master
and pu branches. Commits that cause merge conflicts should be purged
from the series.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/test-cleaner.sh |  185 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100755 t/test-cleaner.sh

diff --git a/t/test-cleaner.sh b/t/test-cleaner.sh
new file mode 100755
index 0000000..9eb260b
--- /dev/null
+++ b/t/test-cleaner.sh
@@ -0,0 +1,185 @@
+#!/bin/sh
+
+USAGE="test-cleaner.sh
+	check-whitespace [<test-file> ...] - report on test files that need cleaning
+	fix_whitespace [<test-file> ...] - generate commits for files that need white space cleaning
+	fix-whitespace-auto [<test-file> ...] - generate commits for files that can be automatically cleaned
+	fix-whitespace-manual [<test-file> ...] - generate commits for files that need manual cleaning
+	clean-whitespace [<file> ...] - applying the cleaner to the specified file without running tests or generating commits
+"
+SUBDIRECTORY_OK=t
+. "$(git --exec-path)/git-sh-setup"
+require_clean_work_tree
+
+cleaner()
+{
+	expand -i | unexpand --first-only | sed "s/ *\$//"
+}
+
+clean_whitespace()
+{
+	rc=0
+	list_files "$@" | while read file
+	do
+		cleaner <"$file" >$$.tmp &&
+		cat $$.tmp >"$file" || rc=1
+		rm -f $$.tmp
+		test $rc = 0
+	done || exit $?
+}
+
+list_files()
+{
+	if test $# -gt 0
+	then
+		for arg in "$@"; do
+		    echo $arg
+		done
+	else
+		cat
+	fi
+}
+
+fix_whitespace_auto()
+{
+	check_whitespace "$@" 2>/dev/null | grep "^AUTO" | fix_whitespace
+}
+
+fix_whitespace_auto()
+{
+	check_whitespace "$@" 2>/dev/null | grep "^MANUAL" | fix_whitespace
+}
+
+fix_whitespace()
+{
+	rc=0
+	check_whitespace "$@" 2>/dev/null | while read status file
+	do
+		case "$status" in
+		AUTO)
+			if  clean_whitespace "$file" &&
+				git diff --exit-code -w -- "$file" >/dev/null
+				git add "$file" &&
+				git diff --exit-code -w HEAD -- "$file" >/dev/null
+			then
+				git commit -F - 1>&2 <<EOF
+whitespace: remediate $file
+
+This file was edited by applying:
+
+	 expand -i | unexpand --first-only | sed "s/ *\$//"
+
+to the file.
+
+No change to test outputs or status code was observed.
+
+Signed-off-by: $(git config user.name) <$(git config user.email)>
+EOF
+				echo "$status	$file"
+			else
+				rc=1
+			fi
+			rm -f $$.tmp
+			;;
+		MANUAL)
+			CLEANER_PREFIX=fixer.
+			check_whitespace "$file" >/dev/null 2>$$.err
+			if  clean_whitespace "$file" &&
+				git diff --exit-code -w -- "$file" >/dev/null
+				git add "$file" &&
+				git diff --exit-code -w HEAD -- "$file" >/dev/null
+			then
+				git commit -F - 1>&2 <<EOF
+FAILED: whitespace: remediate $file
+
+This file was edited by applying:
+
+	 expand -i | unexpand --first-only | sed "s/ *\$//"
+
+to the file.
+
+The following errors were observed:
+
+$(cat $$.err | sed "s/^/   /")
+
+These errors should be fixed before submitting this patch upstream.
+
+Signed-off-by: $(git config user.name) <$(git config user.email)>
+EOF
+				echo "$status	$file"
+			else
+				rc=1
+			fi
+			rm -f $$.tmp $$.err
+			;;
+		*)
+			die "fix-whitespace failed on $file with unexpected output"
+			;;
+		esac
+		test "$rc" = 0
+	done || rc=$?
+	test "$rc" = 0
+}
+
+check_whitespace()
+{
+	list_files "$@" | while read file
+	do
+		cleaner <"$file" >$$.${CLEANER_PREFIX}edited &&
+		cmp "$file" $$.${CLEANER_PREFIX}edited 1>/dev/null
+		rc=$?
+		if test $rc != 0
+		then
+			sh $file >$$.${CLEANER_PREFIX}before.output 2>$$.${CLEANER_PREFIX}before.error </dev/null
+			echo $? > $$.${CLEANER_PREFIX}before.exit
+			sh ./$$.${CLEANER_PREFIX}edited >$$.${CLEANER_PREFIX}after.output 2>$$.${CLEANER_PREFIX}after.error </dev/null
+			echo $? > $$.${CLEANER_PREFIX}after.exit
+
+			if cmp $$.${CLEANER_PREFIX}before.output $$.${CLEANER_PREFIX}after.output 1>/dev/null &&
+				cmp $$.${CLEANER_PREFIX}before.error $$.${CLEANER_PREFIX}after.error 1>/dev/null &&
+				cmp $$.${CLEANER_PREFIX}before.exit $$.${CLEANER_PREFIX}after.exit 1>/dev/null
+			then
+				echo "AUTO	$file"
+			else
+				echo "MANUAL	$file"
+				diff -u $$.${CLEANER_PREFIX}before.output $$.${CLEANER_PREFIX}after.output 1>&2
+				diff -u $$.${CLEANER_PREFIX}before.error $$.${CLEANER_PREFIX}after.error 1>&2
+				diff -u $$.${CLEANER_PREFIX}before.exit $$.${CLEANER_PREFIX}after.exit 1>&2
+			fi
+			looprc=1
+		fi
+		rm -f $$.${CLEANER_PREFIX}edited $$.${CLEANER_PREFIX}after.* $$.${CLEANER_PREFIX}before.*
+		test "$looprc" = 0
+	done
+}
+
+case $# in
+0)
+	usage ;;
+*)
+	cmd=$1
+	shift
+	case "$cmd" in
+	check-whitespace)
+		check_whitespace "$@"
+		;;
+	fix-whitespace)
+		fix_whitespace "$@"
+		;;
+	fix-whitespace-auto)
+		fix_whitespace_auto "$@"
+		;;
+	fix-whitespace-manual)
+		fix_whitespace_manual "$@"
+		;;
+	clean-whitespace)
+		clean_whitespace "$@"
+		;;
+	whitespace-filter)
+		cleaner
+		;;
+	*)
+		usage
+		;;
+	esac
+esac
-- 
1.7.6.362.gf0e6
