From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 04/14] Add an expensive test for git-notes
Date: Tue, 08 Sep 2009 04:26:52 +0200
Message-ID: <1252376822-6138-5-git-send-email-johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 04:27:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkqQe-0005Zj-2q
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 04:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbZIHC1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 22:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZIHC1X
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 22:27:23 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34030 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753357AbZIHC1V (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 22:27:21 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM00CY6S5OLI90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:24 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM0072GS5GQN30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:24 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.8.21525
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1252376822-6138-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127953>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

git-notes have the potential of being pretty expensive, so test with
a lot of commits.  A lot.  So to make things cheaper, you have to
opt-in explicitely, by setting the environment variable
GIT_NOTES_TIMING_TESTS.

This patch has been improved by the following contributions:
- Junio C Hamano: tests: fix "export var=val"

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johan Herland <johan@herland.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3302-notes-index-expensive.sh |   98 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100755 t/t3302-notes-index-expensive.sh

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
new file mode 100755
index 0000000..0ef3e95
--- /dev/null
+++ b/t/t3302-notes-index-expensive.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test commit notes index (expensive!)'
+
+. ./test-lib.sh
+
+test -z "$GIT_NOTES_TIMING_TESTS" && {
+	say Skipping timing tests
+	test_done
+	exit
+}
+
+create_repo () {
+	number_of_commits=$1
+	nr=0
+	parent=
+	test -d .git || {
+	git init &&
+	tree=$(git write-tree) &&
+	while [ $nr -lt $number_of_commits ]; do
+		test_tick &&
+		commit=$(echo $nr | git commit-tree $tree $parent) ||
+			return
+		parent="-p $commit"
+		nr=$(($nr+1))
+	done &&
+	git update-ref refs/heads/master $commit &&
+	{
+		GIT_INDEX_FILE=.git/temp; export GIT_INDEX_FILE;
+		git rev-list HEAD | cat -n | sed "s/^[ 	][ 	]*/ /g" |
+		while read nr sha1; do
+			blob=$(echo note $nr | git hash-object -w --stdin) &&
+			echo $sha1 | sed "s/^/0644 $blob 0	/"
+		done | git update-index --index-info &&
+		tree=$(git write-tree) &&
+		test_tick &&
+		commit=$(echo notes | git commit-tree $tree) &&
+		git update-ref refs/notes/commits $commit
+	} &&
+	git config core.notesRef refs/notes/commits
+	}
+}
+
+test_notes () {
+	count=$1 &&
+	git config core.notesRef refs/notes/commits &&
+	git log | grep "^    " > output &&
+	i=1 &&
+	while [ $i -le $count ]; do
+		echo "    $(($count-$i))" &&
+		echo "    note $i" &&
+		i=$(($i+1));
+	done > expect &&
+	git diff expect output
+}
+
+cat > time_notes << \EOF
+	mode=$1
+	i=1
+	while [ $i -lt $2 ]; do
+		case $1 in
+		no-notes)
+			GIT_NOTES_REF=non-existing; export GIT_NOTES_REF
+		;;
+		notes)
+			unset GIT_NOTES_REF
+		;;
+		esac
+		git log >/dev/null
+		i=$(($i+1))
+	done
+EOF
+
+time_notes () {
+	for mode in no-notes notes
+	do
+		echo $mode
+		/usr/bin/time sh ../time_notes $mode $1
+	done
+}
+
+for count in 10 100 1000 10000; do
+
+	mkdir $count
+	(cd $count;
+
+	test_expect_success "setup $count" "create_repo $count"
+
+	test_expect_success 'notes work' "test_notes $count"
+
+	test_expect_success 'notes timing' "time_notes 100"
+	)
+done
+
+test_done
-- 
1.6.4.304.g1365c.dirty
