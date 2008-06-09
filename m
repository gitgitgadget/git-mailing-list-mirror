From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add testcase for merging in a CRLF repo, showing that conflict file is in LF only
Date: Mon, 9 Jun 2008 13:40:32 +0200
Message-ID: <26299.4828321554$1213013668@news.gmane.org>
References: <"Storm-Olsen*"@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 14:14:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5gFu-0007Ns-Te
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 14:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbYFIMMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 08:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756195AbYFIMMx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 08:12:53 -0400
Received: from hoat.troll.no ([62.70.27.150]:49291 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754917AbYFIMMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2008 08:12:53 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9CF6120AFF;
	Mon,  9 Jun 2008 14:12:47 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 7F87720AF0;
	Mon,  9 Jun 2008 14:12:47 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84378>

An LF only conflict file results in the resolved file being in LF,
the commit is in LF and a warning saying that LF will be replaced
by CRLF, and the working dir ends up with a mix of CRLF and LF files.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 (Resend due to "git reset --hard initial" instead of "git reset
 --hard a", in the first testcase)
 
 Sorry, no patch to actually *fix* the problem.
 Someone who knows the code in question will probably find the solution in a
 fraction of the time that I would.
 Also note that :1:file, :2:file and :3:file all are also in LF format, and not
 CRLF, which you would want if core.autocrlf == true.

 t/t6033-merge-crlf.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100755 t/t6033-merge-crlf.sh

diff --git a/t/t6033-merge-crlf.sh b/t/t6033-merge-crlf.sh
new file mode 100755
index 0000000..8bff2f4
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
+	git reset --hard a &&
+	git merge side -s ours &&
+	cat file | remove_cr | append_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_expect_success 'Check that conflict file is CRLF' '
+	git reset --hard a &&
+	! git merge side &&
+	cat file | remove_cr | append_cr >file.temp &&
+	test_cmp file file.temp
+'
+
+test_done
-- 
1.5.6.rc0.162.gaeac2.dirty
