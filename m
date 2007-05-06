From: Michael Spang <mspang@uwaterloo.ca>
Subject: [PATCH/RFD 4/3] t7300: Tests for git-clean using filenames with spaces/punctuation
Date: Sun, 06 May 2007 14:09:58 -0400
Message-ID: <463E19F6.9000906@uwaterloo.ca>
References: <463E1705.2090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 20:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HklBx-0006J3-4c
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbXEFSKL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 14:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbXEFSKL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:10:11 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:63903 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754888AbXEFSKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 14:10:09 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46IA4gP023599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 14:10:05 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <463E1705.2090201@gmail.com>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 14:10:06 -0400 (EDT)
X-Miltered: at mailchk-m03 with ID 463E19FC.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 6a454154-d821-42fc-a875-9bfce891aae0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46356>

Signed-off-by: Michael Spang <mspang@uwaterloo.ca>
---

This isn't meant for applying, at least until this flaw is fixed.

These tests are failing because ls-files does escaping and clean does
not unescape. Does anyone know of a solution to this?

sed could be used to remove the double quotes and replace escaped characters,
but doing many replacements happens in multiple passes and hence does not
always work as desired.

Is this even properly solvable without making clean a builtin or
writing git-unescape?


 t/t7300-clean.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 1fb3850..3792221 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -7,6 +7,8 @@ test_description='git-clean basic tests'
 
 . ./test-lib.sh
 
+TAB="	"
+
 test_expect_success \
     'setup' \
     "mkdir -p src &&
@@ -123,6 +125,27 @@ test_expect_success \
     test ! -e obj.o &&
     test ! -e build"
 
+test_expect_success \
+    'filenames with spaces' \
+    'touch abc\ def &&
+    touch 123 123\  &&
+    git-add 123 &&
+    git-clean &&
+    test ! -e abc\ def &&
+    test ! -e 123\  &&
+    test -e 123'
+
+test_expect_success \
+    'filenames with escaped characters' \
+    'touch "'"$TAB"'" " " \\ \" \\\\\" \\t &&
+    git-clean &&
+    test ! -e "'"$TAB"'" &&
+    test ! -e " " &&
+    test ! -e \\ &&
+    test ! -e \" &&
+    test ! -e \\\\\" &&
+    test ! -e \\t'
+
 test_expect_failure \
     'clean.requireForce' \
     "mkdir -p build docs &&
