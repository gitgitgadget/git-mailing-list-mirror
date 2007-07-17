From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Add tests for cherry-pick d/f conflict which should be
 none
Date: Tue, 17 Jul 2007 18:14:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707171814330.14781@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site> <7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
 <7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081353560.4248@racer.site>
 <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:15:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqeC-0000t2-O8
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349AbXGQRPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 13:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbXGQRPO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:15:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50889 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755257AbXGQRPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 13:15:11 -0400
Received: (qmail invoked by alias); 17 Jul 2007 17:15:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 17 Jul 2007 19:15:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18azrliYJUa/qFwAj6/8Spxa18jsR3Ae62hdJbeOC
	pGWDhke4BolmPd
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52781>


This tests that we fixed the problem when a directory was renamed,
and a symlink was added in its place (or for that matter, if
the type changed in one branch, and the name in another).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The last test checks that also a file/symlink conflict does
	not break cherry-pick, if one side had a clean rename.

 t/t3502-cherry-pick.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100755 t/t3502-cherry-pick.sh

diff --git a/t/t3502-cherry-pick.sh b/t/t3502-cherry-pick.sh
new file mode 100755
index 0000000..9921de5
--- /dev/null
+++ b/t/t3502-cherry-pick.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='test cherry-pick'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo foo > file &&
+	ln -s dangling link &&
+	git add file link &&
+	test_tick &&
+	git commit -m foo &&
+	git checkout -b branch &&
+	git rm link &&
+	test_tick &&
+	git commit -m "remove link" &&
+	mkdir link &&
+	echo bar > link/file &&
+	git add link/file &&
+	test_tick &&
+	git commit -m "add dir" &&
+	echo bar > file &&
+	git commit -m "change file" file &&
+	git checkout master
+'
+
+test_expect_success 'cherry-pick ignores unrelated dir/symlink conflict' '
+	git cherry-pick branch
+'
+
+test_expect_success 'cherry-pick ignores unrelated file/symlink conflict' '
+	git checkout -b branch2 master^ &&
+	git rm link &&
+	test_tick &&
+	git commit -m "remove link" &&
+	: > link &&
+	git add link &&
+	test_tick &&
+	git commit -m "add file" &&
+	git cherry-pick master
+'
+
+test_done
-- 
1.5.3.rc1.16.g9d6f-dirty
