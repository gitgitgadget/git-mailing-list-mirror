From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-clean: Fix error message if clean.requireForce is not
 set.
Date: Mon, 12 Nov 2007 09:27:35 +0100
Message-ID: <47380E77.9040205@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrUeH-0007R6-6Z
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 09:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbXKLI1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 03:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXKLI1o
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 03:27:44 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62557 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbXKLI1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 03:27:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrUdN-0007lu-63; Mon, 12 Nov 2007 09:27:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D9E3D54D; Mon, 12 Nov 2007 09:27:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64574>

It was distracting to see this error message:

     clean.requireForce set and -n or -f not given; refusing to clean

even though clean.requireForce was not set at all. This patch distinguishes
the cases and gives a different message depending on whether the
configuration variable is not set or set to true.

While we are here, we also divert the error messages to stderr.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
  git-clean.sh |   24 +++++++++++++++---------
  1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/git-clean.sh b/git-clean.sh
index f4965b8..7138fae 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -25,10 +25,7 @@ rmrf="rm -rf --"
  rm_refuse="echo Not removing"
  echo1="echo"

-# requireForce used to default to false but now it defaults to true.
-# IOW, lack of explicit "clean.requireForce = false" is taken as
-# "clean.requireForce = true".
-disabled=$(git config --bool clean.requireForce || echo true)
+disabled=$(git config --bool clean.requireForce)

  while test $# != 0
  do
@@ -37,10 +34,10 @@ do
  		cleandir=1
  		;;
  	-f)
-		disabled=
+		disabled=false
  		;;
  	-n)
-		disabled=
+		disabled=false
  		rmf="echo Would remove"
  		rmrf="echo Would remove"
  		rm_refuse="echo Would not remove"
@@ -68,10 +65,19 @@ do
  	shift
  done

-if [ "$disabled" = true ]; then
-	echo "clean.requireForce set and -n or -f not given; refusing to clean"
+# requireForce used to default to false but now it defaults to true.
+# IOW, lack of explicit "clean.requireForce = false" is taken as
+# "clean.requireForce = true".
+case "$disabled" in
+"")
+	echo >&2 "clean.requireForce not set and -n or -f not given; refusing to clean"
  	exit 1
-fi
+	;;
+"true")
+	echo >&2 "clean.requireForce set and -n or -f not given; refusing to clean"
+	exit 1
+	;;
+esac

  case "$ignored,$ignoredonly" in
  	1,1) usage;;
-- 
1.5.3.5.1368.g3cabf
