From: Jonathan McCrohan <jmccrohan@gmail.com>
Subject: [PATCH] git-instaweb: add support for Apache 2.4
Date: Tue, 27 May 2014 02:18:10 +0100
Message-ID: <1401153490-6567-1-git-send-email-jmccrohan@gmail.com>
Cc: Jonathan McCrohan <jmccrohan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 03:35:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp6IK-0003vM-26
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 03:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaE0BfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 21:35:07 -0400
Received: from fep20.mx.upcmail.net ([62.179.121.40]:49438 "EHLO
	fep20.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaE0BfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 21:35:06 -0400
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 May 2014 21:35:06 EDT
Received: from edge02.upcmail.net ([192.168.13.237])
          by viefep13-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20140527011820.GTEY1329.viefep13-int.chello.at@edge02.upcmail.net>;
          Tue, 27 May 2014 03:18:20 +0200
Received: from lambda.dereenigne.org ([188.141.43.74])
	by edge02.upcmail.net with edge
	id 6pJJ1o00d1c0xrw02pJJev; Tue, 27 May 2014 03:18:20 +0200
X-SourceIP: 188.141.43.74
Received: from localhost.dereenigne.org ([127.0.0.1] helo=lambda.dereenigne.org)
	by lambda.dereenigne.org with esmtp (Exim 4.82)
	(envelope-from <jmccrohan@gmail.com>)
	id 1Wp61y-0001jA-LM; Tue, 27 May 2014 02:18:18 +0100
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250135>

Detect available Apache MPMs and use first available according to
following order of precedence:
mpm_event
mpm_prefork
mpm_worker

Add authz_core module if available to avoid HTTP Error 500 errors.

Signed-off-by: Jonathan McCrohan <jmccrohan@gmail.com>
---
 git-instaweb.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 4aa3eb8..513efa6 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -345,7 +345,17 @@ PidFile "$fqgitdir/pid"
 Listen $bind$port
 EOF
 
-	for mod in mime dir env log_config
+	for mod in mpm_event mpm_prefork mpm_worker
+	do
+		if test -e $module_path/mod_${mod}.so
+		then
+			echo "LoadModule ${mod}_module " \
+			     "$module_path/mod_${mod}.so" >> "$conf"
+			# only one mpm module permitted
+			break
+		fi
+	done
+	for mod in mime dir env log_config authz_core
 	do
 		if test -e $module_path/mod_${mod}.so
 		then
-- 
2.0.0.rc2
