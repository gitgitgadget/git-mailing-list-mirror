From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/5] svn-fe: add a test for remote-svn-alpha
Date: Tue,  5 Jul 2011 22:45:48 +0600
Message-ID: <1309884350-13415-4-git-send-email-divanorama@gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 18:45:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qe8kH-0002tr-8m
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 18:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab1GEQot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 12:44:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48448 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022Ab1GEQoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 12:44:39 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4899837bwd.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=URuLOG0OTEdlDfgFG10ozxS59vxMx8c1PkoN5pNrAi8=;
        b=dua9HdN5l07iPMazpLn+LeV25M2lP9CtsoV3jsDMZy/TqW4FPNpNltUuJZrvdx/zrQ
         Gv63PYVWa0UGiIC0nKt8ncTDwSV5VQ//P19/Ca41b+YSL2dnrkVyhm3Ckq36R0RZviTB
         OsQh7VUEamlaOpAWonzSdhfNrjbQaPt1NWhSc=
Received: by 10.204.42.18 with SMTP id q18mr1524729bke.46.1309884278325;
        Tue, 05 Jul 2011 09:44:38 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id l24sm6696272bkw.15.2011.07.05.09.44.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 09:44:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176616>

The test creates a few svn repositories from fixed dumps using svnadmin.
Currently it checks for crashes on first time import mostly.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/t/.gitignore                |    3 +
 contrib/svn-fe/t/t9010-remote-svn-alpha.sh |  229 ++++++++++++++++++++++++++++
 2 files changed, 232 insertions(+), 0 deletions(-)
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
index 0000000..30dc726
--- /dev/null
+++ b/contrib/svn-fe/t/t9010-remote-svn-alpha.sh
@@ -0,0 +1,229 @@
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
+dump_to_svnrepo_uuid () {
+	dump="$1" &&
+	path="$2" &&
+	uuid="$3" &&
+	svnadmin create "$path" &&
+	svnadmin load "$path" < "$dump" &&
+	eval "svnadmin setuuid \"$path\" $uuid"
+}
+
+dump_to_svnrepo () {
+	dump_to_svnrepo_uuid "$1" "$2" ""
+}
+
+svnurl () {
+	printf "svn-alpha::file://%s/%s" "$(pwd)" "$1"
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
+	cat >small.dump.r0 <<-EOF &&
+	SVN-fs-dump-format-version: 3
+	EOF
+	for x in `seq 1 1 10`; do
+		{
+			echo &&
+			echo "Revision-number: $x" &&
+			echo Prop-content-length: $(wc -c <props) &&
+			echo Content-length: $(wc -c <props) &&
+			echo &&
+			cat props &&
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
+	uuid="19fe5d53-e0aa-44a8-8179-255e62a5445c" &&
+	cat small.dump.r0 >small.dump &&
+	for x in `seq 1 1 10`; do
+		cat small.dump.r$x >>small.dump &&
+		dump_to_svnrepo_uuid small.dump small.svn.r0-$x "$uuid"
+	done &&
+	dump_to_svnrepo_uuid small.dump small.svn "$uuid" &&
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
+	git clone "$url" tiny1.git
+'
+
+test_expect_success TINY_SVN 'clone --mirror tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --mirror "$url" tiny2.git
+'
+
+test_expect_success TINY_SVN 'clone --bare tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone --mirror "$url" tiny3.git
+'
+
+test_expect_success TINY_SVN 'clone -b master tiny' '
+	deinit_git &&
+	url=$(svnurl tiny.svn) &&
+	git clone -b master "$url" tiny4.git
+'
+
+test_expect_success SMALL_SVN 'clone -b master small' '
+	deinit_git &&
+	url=$(svnurl small.svn) &&
+	git clone -b master "$url" small.git
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory &&
+	git clone -b master "$url" small_dir.git
+'
+
+test_expect_success TINY_SVN,SVNRDUMP 'no crash on clone url/path/file' '
+	deinit_git &&
+	url=$(svnurl small.svn)/directory/somefile3 &&
+	git clone -b master "$url" small_dir_file.git
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
+test_done
-- 
1.7.3.4
