From: Jim Klimov <jim@jimklimov.com>
Subject: [PATCH 4/6] gitweb.perl support for snapshots with lists of specified
 files is now tested
Date: Fri, 11 Mar 2016 14:24:47 +0100
Message-ID: <1457702689-9084-4-git-send-email-jim@jimklimov.com>
References: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
Content-Transfer-Encoding: 7BIT
Cc: Jim Klimov <jim@jimklimov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 14:30:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeN9K-0000qY-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 14:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbcCKNag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 08:30:36 -0500
Received: from relay-mtc.cos.ru ([81.5.113.8]:54710 "EHLO relay-mtc.cos.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbcCKNaa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 08:30:30 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Mar 2016 08:30:29 EST
Received: from sunmail.cos.ru (mail.cos.ru [81.5.113.73])
	by relay-mta.cos.ru (8.14.3+Sun/8.14.3) with ESMTP id u2BDOxJp025365
	for <git@vger.kernel.org>; Fri, 11 Mar 2016 16:25:07 +0300 (MSK)
Received: from debian8.roz.lab.etn.com. ([31.7.243.238])
 by sunmail.cos.ru (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26
 2008; 64bit)) with ESMTPA id <0O3V0013IMPRKC00@sunmail.cos.ru> for
 git@vger.kernel.org; Fri, 11 Mar 2016 16:27:35 +0300 (MSK)
X-Mailer: git-send-email 2.8.0.rc1.4.ge2bf47e.dirty
In-reply-to: <1457702689-9084-1-git-send-email-jim@jimklimov.com>
X-Greylist-Inspected: inspected by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:08 +0300 (MSK) for IP:'81.5.113.73' DOMAIN:'mail.cos.ru' HELO:'sunmail.cos.ru' FROM:'jim@jimklimov.com'
X-Greylist: Sender IP whitelisted, ACL 386 matched, not delayed by milter-greylist-4.5.12-COS (relay-mta.cos.ru [93.175.31.8]); Fri, 11 Mar 2016 16:25:08 +0300 (MSK)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288682>

---
 t/t9502-gitweb-standalone-parse-output.sh | 156 ++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 8 deletions(-)

diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index 0796a43..11a116f 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -27,25 +27,46 @@ $known_snapshot_formats{'tar'} = {
 $feature{'snapshot'}{'default'} = ['tar'];
 EOF
 
-# Call check_snapshot with the arguments "<basename> [<prefix>]"
+# Call list_snapshot with the argument "<basename>"
 #
 # This will check that gitweb HTTP header contains proposed filename
-# as <basename> with '.tar' suffix added, and that generated tarfile
-# (gitweb message body) has <prefix> as prefix for al files in tarfile
+# as <basename> with '.tar' suffix added, and lists its content to
+# stdout of this routine (in "tar test" default listing format)
 #
-# <prefix> default to <basename>
-check_snapshot () {
-	basename=$1
-	prefix=${2:-"$1"}
+# <prefix> defaults to <basename>
+#
+list_snapshot () {
+	basename="`echo "$1" | sed 's,\/,\.,g'`"
 	echo "basename=$basename"
 	grep "filename=.*$basename.tar" gitweb.headers >/dev/null 2>&1 &&
-	"$TAR" tf gitweb.body >file_list &&
+	"$TAR" tf gitweb.body >file_list
+}
+
+#
+# Call check_snapshot with the arguments "<basename> [<prefix>]"
+#
+# This uses list_snapshot() above to list the tarfile <basename>.tar received
+# from gitweb, and that this generated tarfile (gitweb message body) has
+# <prefix> prepended as prefix for all objects in the tarfile
+# The tarfile listing is exchanged via the "file_list" temporary file
+#
+# <prefix> defaults to <basename>
+#
+check_snapshot () {
+	basename="$1"
+	prefix=${2:-"$1"}
+	list_snapshot "$basename" &&
 	! grep -v -e "^$prefix$" -e "^$prefix/" -e "^pax_global_header$" file_list
 }
 
+# Note: the "xx/test" branch only contains file "foo"; others land in "master"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 test_expect_success setup '
 	test_commit first foo &&
+	mkdir -p dir1 && test_commit bar dir1/second bar second &&
 	git branch xx/test &&
+	mkdir -p dir2 && test_commit pif dir2/third pif third &&
+	test_commit wow dir2/"fourth file" wow wow &&
 	FULL_ID=$(git rev-parse --verify HEAD) &&
 	SHORT_ID=$(git rev-parse --verify --short=7 HEAD)
 '
@@ -112,6 +133,125 @@ test_expect_success 'snapshot: hierarchical branch name (xx/test)' '
 '
 test_debug 'cat gitweb.headers'
 
+test_expect_success 'snapshot sanity: have expected content in xx/test branch - do not have /first file in full snapshot' '
+	rm -f gitweb.body file_list &&
+	BRANCH=xx/test &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar" &&
+	ID=$(git rev-parse --verify --short=7 "$BRANCH") &&
+	list_snapshot ".git-$BRANCH-$ID" &&
+	! grep "first" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in master branch - only those under subdir dir2/ and not others' '
+	rm -f gitweb.body file_list &&
+	BRANCH=master &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir2" &&
+	ID=$(git rev-parse --verify --short=7 "$BRANCH") &&
+	list_snapshot ".git-$BRANCH-$ID" &&
+	! grep "foo" file_list &&
+	! grep "dir1/second" file_list &&
+	grep "dir2/third" file_list &&
+	grep "dir2/fourth file" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in master branch - subdir name is required in requested nested path (bad path - empty output)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=master &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=third" &&
+	[ ! -s gitweb.body ]
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in master branch - correct subdir name is required in requested nested path (bad path - empty output)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=master &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir1/third" &&
+	[ ! -s gitweb.body ]
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in master branch - can request filenames with spaces (backslash + HTML-escape)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=master &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir2/fourth\%20file" &&
+	ID=$(git rev-parse --verify --short=7 "$BRANCH") &&
+	list_snapshot ".git-$BRANCH-$ID" &&
+	! grep "foo" file_list &&
+	! grep "dir1/second" file_list &&
+	! grep "dir2/third" file_list &&
+	grep "dir2/fourth file" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in master branch - can request list of filenames separated by HTML-escaped spaces' '
+	rm -f gitweb.body file_list &&
+	BRANCH=master &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir1/second%20dir2/third" &&
+	ID=$(git rev-parse --verify --short=7 "$BRANCH") &&
+	list_snapshot ".git-$BRANCH-$ID" &&
+	! grep "foo" file_list &&
+	grep "dir1/second" file_list &&
+	grep "dir2/third" file_list &&
+	! grep "dir2/fourth file" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in master branch - can request list of filenames separated by HTML-escaped spaces including a filename with spaces (backslash + HTML-escape)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=master &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=foo%20dir2/fourth\%20file%20dir1/second" &&
+	ID=$(git rev-parse --verify --short=7 "$BRANCH") &&
+	list_snapshot ".git-$BRANCH-$ID" &&
+	grep "foo" file_list &&
+	grep "dir1/second" file_list &&
+	! grep "dir2/third" file_list &&
+	grep "dir2/fourth file" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have only expected content in refs/tags/second full tag' '
+	rm -f gitweb.body file_list &&
+	BRANCH=second &&
+	gitweb_run "p=.git;a=snapshot;h=refs/tags/$BRANCH;sf=tar;f=dir1/second" &&
+	list_snapshot ".git-$BRANCH" &&
+	! grep "foo" file_list &&
+	grep "dir1/second" file_list &&
+	! grep "dir2/third" file_list &&
+	! grep "dir2/fourth file" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
+test_expect_success 'snapshot certain objects: have expected content in xx/test branch - request for only absent subdir dir2/ fails (empty output)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=xx/test &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir2" &&
+        [ ! -s "gitweb.body" ]
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'snapshot certain objects: have expected content in xx/test branch - request for file /foo and absent subdir dir2/ also fails (empty output)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=xx/test &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=dir2%20foo" &&
+        [ ! -s "gitweb.body" ]
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'snapshot certain objects: have expected content in xx/test branch - have /foo file (and only it)' '
+	rm -f gitweb.body file_list &&
+	BRANCH=xx/test &&
+	gitweb_run "p=.git;a=snapshot;h=$BRANCH;sf=tar;f=foo" &&
+	ID=$(git rev-parse --verify --short=7 "$BRANCH") &&
+	list_snapshot ".git-$BRANCH-$ID" &&
+	grep "foo" file_list &&
+	! grep "dir1/second" file_list &&
+	! grep "dir2/third" file_list &&
+	! grep "dir2/fourth file" file_list
+'
+test_debug 'cat gitweb.headers && cat file_list'
+
 # ----------------------------------------------------------------------
 # forks of projects
 
-- 
2.1.4
