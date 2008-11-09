From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK)] gitk: Fix commit encoding support.
Date: Sun, 9 Nov 2008 18:06:07 +0300
Organization: HOME
Message-ID: <200811091806.07550.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 16:09:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzBur-0005XI-Of
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 16:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbYKIPIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 10:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbYKIPIK
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 10:08:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:5262 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbYKIPII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 10:08:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1868170fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 07:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WTlHn+RPLripIocOSLOhn9eA+xG/CfSIf8S84YGpyHg=;
        b=Z0ej4qCnVSxbwdscE/KgHnZY11/on+Z8RVzkEiTLk4mT6K4kts/yNvuXRhaiK8hCQX
         yKJteOIvYIHQi6HalvIK7Vj76uH3ze+ch31Y6qD1YA4lM/yZN4JBfuCk2z6PxMcbKRya
         ivWqYZNiky0sedgxHBZV1pSgTA1UCquEzLcxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Rr5gk3ahp4FOe6BGITvb+FB9p3p+TA5wM2Zj8I/67Pt9/nHg/RZXlEXTCx1Yxgsh09
         YimNiPyCF2BhKF3Vn1AudzDU5c0BiUkFTxE0t5gODlZ0sFHEEpr/srTgImAcg1TgG5g2
         9fQBGDdDQTa4CdV4wmrOA6fESWEtQg1elYudc=
Received: by 10.181.205.15 with SMTP id h15mr1766090bkq.19.1226243286726;
        Sun, 09 Nov 2008 07:08:06 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 22sm8549008fkr.4.2008.11.09.07.08.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 07:08:05 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100448>

This commit fixes two problems with commit encodings:

1) git-log actually uses i18n.logoutputencoding to generate
   its output, and falls back to i18n.commitencoding only
   when that option is not set. Thus, gitk should use its
   value to read the results, if available.

2) The readcommit function did not process encodings at all.
   This led to randomly appearing misconverted commits if
   the commit encoding differed from the current locale.

Now commit messages should be displayed correctly, except
when logoutputencoding is set to an encoding that cannot
represent charecters in the message. For example, it is
impossible to convert Japanese characters from Shift-JIS
to CP-1251 (although the reverse conversion works).

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index ae775b1..3834fc0 100755
--- a/gitk
+++ b/gitk
@@ -1555,9 +1555,27 @@ proc chewcommits {} {
     return 0
 }
 
+proc do_readcommit {id} {
+    global tclencoding
+
+    # Invoke git-log to handle automatic encoding conversion
+    set fd [open [concat | git log --no-color --pretty=raw -1 $id] r]
+    # Read the results using i18n.logoutputencoding
+    fconfigure $fd -translation lf -eofchar {}
+    if {$tclencoding != {}} {
+	fconfigure $fd -encoding $tclencoding
+    }
+    set contents [read $fd]
+    close $fd
+    # Remove the heading line
+    regsub {^commit [0-9a-f]+\n} $contents {} contents
+
+    return $contents
+}
+
 proc readcommit {id} {
-    if {[catch {set contents [exec git cat-file commit $id]}]} return
-    parsecommit $id $contents 0
+    if {[catch {set contents [do_readcommit $id]}]} return
+    parsecommit $id $contents 1
 }
 
 proc parsecommit {id contents listed} {
@@ -10565,6 +10583,9 @@ set gitencoding {}
 catch {
     set gitencoding [exec git config --get i18n.commitencoding]
 }
+catch {
+    set gitencoding [exec git config --get i18n.logoutputencoding]
+}
 if {$gitencoding == ""} {
     set gitencoding "utf-8"
 }
-- 
1.6.0.3.15.gb8d36
