From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 4/9] svn-fe: add a test for remote-svn-alpha
Date: Wed, 13 Jul 2011 21:26:48 +0600
Message-ID: <1310570813-16648-5-git-send-email-divanorama@gmail.com>
References: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 17:27:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh1LD-0002iX-PZ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 17:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab1GMP0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 11:26:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56795 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab1GMP0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 11:26:35 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2112143eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SZzE+FIGJquQWddKlb8CexqghaB4acF21lLe0vqUc6U=;
        b=uxHxGkLkX/B8oWenSPHVAA1dhx28X5LReJ9dlCrsP3HdGIbTLQb4Yuwa9NxQU+Uxjk
         13qCcVrjFAW4JXTnCHjI7Hx2LsLg2OVwcllI9i4nfe773Bnp5cmJsLX2kexstBKILSOw
         GaCTmL/vk4+exF3hUgDLuLxACfurZgJTnscmY=
Received: by 10.213.16.208 with SMTP id p16mr375119eba.14.1310570794405;
        Wed, 13 Jul 2011 08:26:34 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id w28sm1969391eea.15.2011.07.13.08.26.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 08:26:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310570813-16648-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177052>

The test creates a few svn repositories from fixed dumps using svnadmin.
Currently it checks for crashes on first time import mostly.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/t/.gitignore                |    3 +
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |  259 ++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 contrib/svn-fe/t/.gitignore
 create mode 100755 contrib/svn-fe/t/t9010-remote-svn-alpha.sh

diff --git a/contrib/svn-fe/t/.gitignore b/contrib/svn-fe/t/.gitignore
new file mode 100644
index 0000000..4e731dc
--- /dev/null
+++ b/contrib/svn-fe/t/.gitignore
@@ -0,0 +1,3 @@
+/trash directory*
+/test-results
+/.prove
diff --git a/contrib/svn-fe/t/t9010-remote-svn-alpha.sh b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
new file mode 100755
index 0000000..92bc4b2
--- /dev/null
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -0,0 +1,259 @@
+#!/bin/sh
+
+test_description='check svn-alpha remote helper'
+
+PATH=$(pwd)/..:$PATH
+TEST_DIRECTORY=$(pwd)/../../../t
+. $TEST_DIRECTORY/test-lib.sh
+
+if command -v svnrdump >/dev/null; then
+	test_set_prereq SVNRDUMP
+fi
+
+deinit_git () {
+	rm -fr .git
+}
+
+reinit_git () {
+	deinit_git &&
+	git init
+}
+
+properties () {
+	while test "$#" -ne 0
+	do
+		property="$1" &&
+		value="$2" &&
+		printf "%s\n" "K ${#property}" &&
+		printf "%s\n" "$property" &&
+		printf "%s\n" "V ${#value}" &&
+		printf "%s\n" "$value" &&
+		shift 2 ||
+		return 1
+	done
+}
+
+text_no_props () {
+	text="$1
+" &&
+	printf "%s\n" "Prop-content-length: 10" &&
+	printf "%s\n" "Text-content-length: ${#text}" &&
+	printf "%s\n" "Content-length: $((${#text} + 10))" &&
+	printf "%s\n" "" "PROPS-END" &&
+	printf "%s\n" "$text"
+}
+
+dump_to_svnrepo () {
+	dump="$1" &&
+	path="$2" &&
+	svnadmin create "$path" &&
+	svnadmin load "$path" < "$dump"
+}
+
+svnurl () {
+	printf "svn-alpha::file://%s/%s" "$(pwd)" "$1"
+}
+
+test_nr_revs () {
+	n=$1 &&
+	repo=$2 &&
+	ref=$3 &&
+	git --git-dir="$repo" log --format=oneline "$ref" >revs &&
+	test_line_count = "$n" revs
+}
+
+test_expect_success 'svnadmin is present' '
+	command -v svnadmin &&
+	test_set_prereq SVNADMIN
+'
+
+test_expect_success SVNADMIN 'create empty svnrepo' '
+	echo "SVN-fs-dump-format-version: 2" > empty.dump &&
+	dump_to_svnrepo empty.dump empty.svn &&
+	test_set_prereq EMPTY_SVN
+'
+
+test_expect_success SVNADMIN 'create tiny svnrepo' '
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		cat <<-EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		EOF
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props &&
+		cat <<-\EOF &&
+
+		Node-path: directory
+		Node-kind: dir
+		Node-action: add
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+		Node-path: directory/somefile
+		Node-kind: file
+		Node-action: add
+		EOF
+		text_no_props hi
+	} >tiny.dump &&
+	dump_to_svnrepo tiny.dump tiny.svn &&
+	test_set_prereq TINY_SVN
+'
+
+test_expect_success SVNADMIN 'create small svndump' '
+	{
+		properties \
+			svn:author author@example.com \
+			svn:date "1999-02-01T00:01:002.000000Z" \
+			svn:log "add directory with some files in it" &&
+		echo PROPS-END
+	} >props &&
+	{
+		echo Prop-content-length: $(wc -c <props) &&
+		echo Content-length: $(wc -c <props) &&
+		echo &&
+		cat props
+	} >props_dump &&
+	cat >small.dump.r0 <<-EOF &&
+	SVN-fs-dump-format-version: 3
+	EOF
+	for x in `seq 1 1 10`; do
+		{
+			echo &&
+			echo "Revision-number: $x" &&
+			cat props_dump &&
+
+			if test "$x" -eq "1"; then
+				cat <<-\EOF
+
+				Node-path: directory
+				Node-kind: dir
+				Node-action: add
+				Prop-content-length: 10
+				Content-length: 10
+
+				PROPS-END
+
+				EOF
+			fi
+			echo "Node-path: directory/somefile$x" &&
+			echo "Node-kind: file" &&
+			echo "Node-action: add" &&
+			text_no_props hi
+		} >small.dump.r$x
+	done &&
+	test_set_prereq SMALL_SVNDUMP
+'
+
+test_expect_success SMALL_SVNDUMP 'create small svnrepo' '
+	rm -rf small.svn* &&
+	svnadmin create small.svn &&
+	for x in `seq 1 1 10`; do
+		cat small.dump.r0 small.dump.r$x >part.dump &&
+		svnadmin load small.svn <part.dump &&
+		cp -r small.svn small.svn.r0-$x
+	done &&
+	test_set_prereq SMALL_SVN
+'
+
+test_expect_failure EMPTY_SVN 'fetch empty' '
+	reinit_git &&
+	url=$(svnurl empty.svn) &&
+	git remote add svn "$url" &&
+	git fetch svn
+'
+
+test_expect_failure TINY_SVN 'clone tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone "$url" tiny1.git &&
+	test_nr_revs 1 tiny1.git refs/remotes/origin/master
+'
+
+test_expect_success TINY_SVN 'clone --mirror tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --mirror "$url" tiny2.git &&
+	test_nr_revs 1 tiny2.git refs/heads/master
+'
+
+test_expect_success TINY_SVN 'clone --bare tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --bare "$url" tiny3.git &&
+	test_nr_revs 1 tiny3.git refs/heads/master
+'
+
+test_expect_success TINY_SVN 'clone -b master tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone -b master "$url" tiny4.git &&
+	test_nr_revs 1 tiny4.git/.git refs/heads/master
+'
+
+test_expect_success SMALL_SVN 'clone -b master small' '
+	deinit_git &&
+	url=$(svnurl small.svn) &&
+	git clone -b master "$url" small.git &&
+	test_nr_revs 10 small.git/.git refs/heads/master
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory &&
+	git clone -b master "$url" small_dir.git &&
+	test_nr_revs 10 small_dir.git/.git refs/heads/master
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path/file' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory/somefile3 &&
+	git clone -b master "$url" small_dir_file.git &&
+	test_nr_revs 10 small_dir_file.git/.git refs/heads/master
+'
+
+test_expect_success SMALL_SVN 'fetch each rev of SMALL separately' '
+	reinit_git &&
+	url=$(svnurl small.svn) &&
+
+	for x in `seq 1 1 10`; do
+		git remote add svn_$x "$url.r0-$x"
+	done &&
+	git remote update &&
+
+	git remote add svn "$url" &&
+	git fetch svn &&
+
+	git rev-parse -s remotes/svn_7/master~5 >ref7_2 &&
+	git rev-parse -s remotes/svn/master~8 >ref_2 &&
+	test_cmp ref7_2 ref_2
+'
+
+test_expect_success SMALL_SVN 'fetch updates from SMALL' '
+	reinit_git &&
+	url=$(svnurl link.svn) &&
+	git remote add svn "$url" &&
+
+	ln -sfn small.svn.r0-5 link.svn &&
+	git fetch svn &&
+	test_nr_revs 5 .git refs/remotes/svn/master &&
+
+	ln -sfn small.svn.r0-10 link.svn &&
+	git fetch svn &&
+	test_nr_revs 10 .git refs/remotes/svn/master &&
+
+	git fetch svn &&
+	test_nr_revs 10 .git refs/remotes/svn/master
+'
+
+test_done
-- 
1.7.3.4
