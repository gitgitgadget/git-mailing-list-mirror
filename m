From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] Import git show output easily
Date: Wed, 02 Sep 2009 18:50:55 +0100
Message-ID: <20090902175039.21633.25294.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 19:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mitzg-0005Br-9v
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbZIBRvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbZIBRvD
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:51:03 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:64307 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753113AbZIBRvB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 13:51:01 -0400
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n82HoueI028383;
	Wed, 2 Sep 2009 18:50:56 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 2 Sep 2009 18:50:56 +0100
User-Agent: StGit/0.15-rc2-4-g5ab0-dirty
X-OriginalArrivalTime: 02 Sep 2009 17:50:56.0175 (UTC) FILETIME=[EC1C73F0:01CA2BF5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127612>

This patch modifies the import command to check for standard 'git show'
output and parse it accordingly.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/common.py |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index d38d263..0d39148 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -355,6 +355,7 @@ def __parse_description(descr):
 
     lasthdr = 0
     end = len(descr_lines)
+    descr_strip = 0
 
     # Parse the patch header
     for pos in range(0, end):
@@ -374,12 +375,16 @@ def __parse_description(descr):
         if subject:
             break
         # get the subject
-        subject = descr_lines[pos]
+        subject = descr_lines[pos][descr_strip:]
+        if re.match('commit [\da-f]{40}$', subject):
+            # 'git show' output, look for the real subject
+            subject = ''
+            descr_strip = 4
         lasthdr = pos + 1
 
     # get the body
     if lasthdr < end:
-        body = reduce(lambda x, y: x + '\n' + y, descr_lines[lasthdr:], '')
+        body = '\n' + '\n'.join(l[descr_strip:] for l in descr_lines[lasthdr:])
 
     return (subject + body, authname, authemail, authdate)
 
