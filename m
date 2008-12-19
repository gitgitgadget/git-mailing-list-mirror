From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/4] Add an expensive test for git-notes
Date: Sat, 20 Dec 2008 00:37:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812200035590.30769@pacific.mpi-cbg.de>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDoo1-0005sq-KI
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbYLSX3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYLSX3P
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:29:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:57330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752277AbYLSX3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:29:14 -0500
Received: (qmail invoked by alias); 19 Dec 2008 23:29:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 20 Dec 2008 00:29:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FCZZzx8AFBTH88JToqpLmESsCRic/hw3NxclCtZ
	X3Awab4ukkeOxr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103604>


git-notes have the potential of being pretty expensive, so test with
a lot of commits.  A lot.  So to make things cheaper, you have to
opt-in explicitely, by setting the environment variable
GIT_NOTES_TIMING_TESTS.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I would appreciate other people running the tests, and maybe 
	profiling the code.

	However, I will not be really online the next two weeks, so if you 
	feel like working on this series, go ahead.

	Merry Christmas.

 t/t3302-notes-index-expensive.sh |   98 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100755 t/t3302-notes-index-expensive.sh

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
new file mode 100755
index 0000000..00d27bf
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
+		export GIT_INDEX_FILE=.git/temp;
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
+			export GIT_NOTES_REF=non-existing
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
1.6.1.rc3.368.g63acc
