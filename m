From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Add testcase for merging in a CRLF repo
Date: Mon, 9 Jun 2008 22:22:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806092221420.1783@racer>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5orG-0003nv-JQ
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 23:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781AbYFIVX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 17:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755650AbYFIVX6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 17:23:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:54707 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754427AbYFIVX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 17:23:57 -0400
Received: (qmail invoked by alias); 09 Jun 2008 21:23:54 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 09 Jun 2008 23:23:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5sbpZ0bW5nfuHqx+WRqwToHpcB3i53u2jIXvnXJ
	johZ/clvrvAvUa
X-X-Sender: gene099@racer
In-Reply-To: <484D3225.3020900@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84432>


From: Marius Storm-Olsen <marius@trolltech.com>

If you work on a repo with core.autocrlf == true, you would expect
every text file to have CRLF EOLs. However, if you by some operation,
get a conflict, then the conflicted file has LF EOLs.

Now, of course you'd go about resolving the files conflict, and then 'git
add <file>'. When you do that, you'll get the warning saying that LF will
be replaced by CRLF. Then you commit. The end result is that you have a
workingdir with a mix of LF and CRLF files, which after some more
operations may trigger a "whole file changed" diff, due to the workingdir
file now having LF EOLs.

An LF only conflict file results in the resolved file being in LF,
the commit is in LF and a warning saying that LF will be replaced
by CRLF, and the working dir ends up with a mix of CRLF and LF files.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6033-merge-crlf.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100755 t/t6033-merge-crlf.sh

diff --git a/t/t6033-merge-crlf.sh b/t/t6033-merge-crlf.sh
new file mode 100755
index 0000000..ea22837
--- /dev/null
+++ b/t/t6033-merge-crlf.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+append_cr () {
+	sed -e 's/$/Q/' | tr Q '\015'
+}
+
+remove_cr () {
+	tr '\015' Q | sed -e 's/Q$//'
+}
+
+test_description='merge conflict in crlf repo
+
+		b---M
+	       /   /
+	initial---a
+
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.autocrlf true &&
+	echo foo | append_cr >file &&
+	git add file &&
+	git commit -m "Initial" &&
+	git tag initial &&
+	git branch side &&
+	echo line from a | append_cr >file &&
+	git commit -m "add line from a" file &&
+	git tag a &&
+	git checkout side &&
+	echo line from b | append_cr >file &&
+	git commit -m "add line from b" file &&
+	git tag b &&
+	git checkout master
+'
+
+test_expect_success 'Check "ours" is CRLF' '
+	git reset --hard initial &&
+	git merge side -s ours &&
+	cat file | remove_cr | append_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_expect_failure 'Check that conflict file is CRLF' '
+	git reset --hard a &&
+	test_must_fail git merge side &&
+	cat file | remove_cr | append_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_done
-- 
1.5.6.rc1.181.gb439d
