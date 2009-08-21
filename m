From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH] Add tests for rev-list --graph with options that simplify
	history
Date: Fri, 21 Aug 2009 11:20:34 -0700
Message-ID: <20090821182034.GW8147@facebook.com>
References: <1250628954.114121983@192.168.1.201> <20090818211812.GL8147@facebook.com> <7vk5103chi.fsf@alter.siamese.dyndns.org> <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com> <7vhbw41g3f.fsf@alter.siamese.dyndns.org> <7v4os41frm.fsf@alter.siamese.dyndns.org> <20090819225547.GR8147@facebook.com> <20090819225852.GA21187@facebook.com> <7v7hwzt94p.fsf@alter.siamese.dyndns.org>
Reply-To: Adam Simpkins <simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 20:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeYkt-0001gM-Ai
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 20:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbZHUSWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbZHUSWR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 14:22:17 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:50345 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbZHUSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 14:22:16 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.15] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n7LIM98J003664
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 21 Aug 2009 11:22:11 -0700
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.1.393.1; Fri, 21 Aug
 2009 11:20:35 -0700
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1MeYj4-0002vZ-Rf; Fri, 21 Aug 2009 11:20:34 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v7hwzt94p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-08-21_10:2009-08-11,2009-08-21,2009-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0907200000 definitions=main-0908210045
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126740>

These tests help make sure graph_is_interesting() is doing the right
thing.
---
 t/t6016-rev-list-graph-simplify-history.sh |  276 ++++++++++++++++++++++++++++
 1 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100755 t/t6016-rev-list-graph-simplify-history.sh

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
new file mode 100755
index 0000000..5ac8fc9
--- /dev/null
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -0,0 +1,276 @@
+#!/bin/sh
+
+# There's more than one "correct" way to represent the history graphically.
+# These tests depend on the current behavior of the graphing code.  If the
+# graphing code is ever changed to draw the output differently, these tests
+# cases will need to be updated to know about the new layout.
+
+test_description='--graph and simplified history'
+
+. ./test-lib.sh
+
+test_expect_success 'set up rev-list --graph test' '
+	# 3 commits on branch A
+	test_commit A1 foo.txt &&
+	test_commit A2 bar.txt &&
+	test_commit A3 bar.txt &&
+	git branch -m master A &&
+
+	# 2 commits on branch B, started from A1
+	git checkout -b B A1 &&
+	test_commit B1 foo.txt &&
+	test_commit B2 abc.txt &&
+
+	# 2 commits on branch C, started from A2
+	git checkout -b C A2 &&
+	test_commit C1 xyz.txt &&
+	test_commit C2 xyz.txt &&
+
+	# Octopus merge B and C into branch A
+	git checkout A &&
+	git merge B C &&
+	git tag A4
+
+	test_commit A5 bar.txt &&
+
+	# More commits on C, then merge C into A
+	git checkout C &&
+	test_commit C3 foo.txt &&
+	test_commit C4 bar.txt &&
+	git checkout A &&
+	git merge -s ours C &&
+	git tag A6
+
+	test_commit A7 bar.txt &&
+
+	# Store commit names in variables for later use
+	A1=`git rev-list -1 A1` &&
+	A2=`git rev-list -1 A2` &&
+	A3=`git rev-list -1 A3` &&
+	A4=`git rev-list -1 A4` &&
+	A5=`git rev-list -1 A5` &&
+	A6=`git rev-list -1 A6` &&
+	A7=`git rev-list -1 A7` &&
+	B1=`git rev-list -1 B1` &&
+	B2=`git rev-list -1 B2` &&
+	C1=`git rev-list -1 C1` &&
+	C2=`git rev-list -1 C2` &&
+	C3=`git rev-list -1 C3` &&
+	C4=`git rev-list -1 C4`
+	'
+
+test_expect_success '--graph --all' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "| * $C3" >> expected &&
+	echo "* | $A5" >> expected &&
+	echo "| |     " >> expected &&
+	echo "|  \\    " >> expected &&
+	echo "*-. \\   $A4" >> expected &&
+	echo "|\\ \\ \\  " >> expected &&
+	echo "| | |/  " >> expected &&
+	echo "| | * $C2" >> expected &&
+	echo "| | * $C1" >> expected &&
+	echo "| * | $B2" >> expected &&
+	echo "| * | $B1" >> expected &&
+	echo "* | | $A3" >> expected &&
+	echo "| |/  " >> expected &&
+	echo "|/|   " >> expected &&
+	echo "* | $A2" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A1" >> expected &&
+	git rev-list --graph --all > actual &&
+	test_cmp expected actual
+	'
+
+# Make sure the graph_is_interesting() code still realizes
+# that undecorated merges are interesting, even with --simplify-by-decoration
+test_expect_success '--graph --simplify-by-decoration' '
+	rm -f expected &&
+	git tag -d A4
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "| * $C3" >> expected &&
+	echo "* | $A5" >> expected &&
+	echo "| |     " >> expected &&
+	echo "|  \\    " >> expected &&
+	echo "*-. \\   $A4" >> expected &&
+	echo "|\\ \\ \\  " >> expected &&
+	echo "| | |/  " >> expected &&
+	echo "| | * $C2" >> expected &&
+	echo "| | * $C1" >> expected &&
+	echo "| * | $B2" >> expected &&
+	echo "| * | $B1" >> expected &&
+	echo "* | | $A3" >> expected &&
+	echo "| |/  " >> expected &&
+	echo "|/|   " >> expected &&
+	echo "* | $A2" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A1" >> expected &&
+	git rev-list --graph --all --simplify-by-decoration > actual &&
+	test_cmp expected actual
+	'
+
+# Get rid of all decorations on branch B, and graph with it simplified away
+test_expect_success '--graph --simplify-by-decoration prune branch B' '
+	rm -f expected &&
+	git tag -d B2
+	git tag -d B1
+	git branch -d B
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "| * $C3" >> expected &&
+	echo "* | $A5" >> expected &&
+	echo "* |   $A4" >> expected &&
+	echo "|\\ \\  " >> expected &&
+	echo "| |/  " >> expected &&
+	echo "| * $C2" >> expected &&
+	echo "| * $C1" >> expected &&
+	echo "* | $A3" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A2" >> expected &&
+	echo "* $A1" >> expected &&
+	git rev-list --graph --simplify-by-decoration --all > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--graph --full-history -- bar.txt' '
+	rm -f expected &&
+	git tag -d B2
+	git tag -d B1
+	git branch -d B
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "* | $A5" >> expected &&
+	echo "* |   $A4" >> expected &&
+	echo "|\\ \\  " >> expected &&
+	echo "| |/  " >> expected &&
+	echo "* | $A3" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A2" >> expected &&
+	git rev-list --graph --full-history --all -- bar.txt > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
+	rm -f expected &&
+	git tag -d B2
+	git tag -d B1
+	git branch -d B
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "* | $A5" >> expected &&
+	echo "* | $A3" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A2" >> expected &&
+	git rev-list --graph --full-history --simplify-merges --all \
+		-- bar.txt > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--graph -- bar.txt' '
+	rm -f expected &&
+	git tag -d B2
+	git tag -d B1
+	git branch -d B
+	echo "* $A7" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "* $A3" >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A2" >> expected &&
+	git rev-list --graph --all -- bar.txt > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--graph --sparse -- bar.txt' '
+	rm -f expected &&
+	git tag -d B2
+	git tag -d B1
+	git branch -d B
+	echo "* $A7" >> expected &&
+	echo "* $A6" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "* $A4" >> expected &&
+	echo "* $A3" >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "| * $C3" >> expected &&
+	echo "| * $C2" >> expected &&
+	echo "| * $C1" >> expected &&
+	echo "|/  " >> expected &&
+	echo "* $A2" >> expected &&
+	echo "* $A1" >> expected &&
+	git rev-list --graph --sparse --all -- bar.txt > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--graph ^C4' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "* $A6" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "*   $A4" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $B2" >> expected &&
+	echo "| * $B1" >> expected &&
+	echo "* $A3" >> expected &&
+	git rev-list --graph --all ^C4 > actual &&
+	test_cmp expected actual
+	'
+
+test_expect_success '--graph ^C3' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "* $A5" >> expected &&
+	echo "*   $A4" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $B2" >> expected &&
+	echo "| * $B1" >> expected &&
+	echo "* $A3" >> expected &&
+	git rev-list --graph --all ^C3 > actual &&
+	test_cmp expected actual
+	'
+
+# I don't think the ordering of the boundary commits is really
+# that important, but this test depends on it.  If the ordering ever changes
+# in the code, we'll need to update this test.
+test_expect_success '--graph --boundary ^C3' '
+	rm -f expected &&
+	echo "* $A7" >> expected &&
+	echo "*   $A6" >> expected &&
+	echo "|\\  " >> expected &&
+	echo "| * $C4" >> expected &&
+	echo "* | $A5" >> expected &&
+	echo "| |     " >> expected &&
+	echo "|  \\    " >> expected &&
+	echo "*-. \\   $A4" >> expected &&
+	echo "|\\ \\ \\  " >> expected &&
+	echo "| * | | $B2" >> expected &&
+	echo "| * | | $B1" >> expected &&
+	echo "* | | | $A3" >> expected &&
+	echo "o | | | $A2" >> expected &&
+	echo "|/ / /  " >> expected &&
+	echo "o | | $A1" >> expected &&
+	echo " / /  " >> expected &&
+	echo "| o $C3" >> expected &&
+	echo "|/  " >> expected &&
+	echo "o $C2" >> expected &&
+	git rev-list --graph --boundary --all ^C3 > actual &&
+	test_cmp expected actual
+	'
+
+test_done
-- 
1.6.0.4
