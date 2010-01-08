From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 1/3] Populate the cached config options with the defaults
Date: Fri, 08 Jan 2010 12:35:59 +0000
Message-ID: <20100108123559.24161.14842.stgit@pc1117.cambridge.arm.com>
References: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:36:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTE4e-00082t-In
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 13:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab0AHMgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 07:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489Ab0AHMgF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 07:36:05 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40758 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751406Ab0AHMgC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 07:36:02 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o08CZxeI002299;
	Fri, 8 Jan 2010 12:35:59 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 8 Jan 2010 12:35:59 +0000
In-Reply-To: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.15-36-g53e3
X-OriginalArrivalTime: 08 Jan 2010 12:35:59.0521 (UTC) FILETIME=[21B3E110:01CA905F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136428>

The patch pre-populates the cached config options with the default
values. It also removes an unused option (stgit.extensions).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/config.py |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index 796f2c9..811138d 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -28,16 +28,15 @@ class GitConfigException(StgException):
 
 class GitConfig:
     __defaults={
-        'stgit.smtpserver':	'localhost:25',
-        'stgit.smtpdelay':	'5',
-        'stgit.pullcmd':	'git pull',
-        'stgit.fetchcmd':	'git fetch',
-        'stgit.pull-policy':	'pull',
-        'stgit.autoimerge':	'no',
-        'stgit.keepoptimized':	'no',
-        'stgit.extensions':	'.ancestor .current .patched',
-        'stgit.shortnr': '5',
-        'stgit.pager':  'less'
+        'stgit.smtpserver':     ['localhost:25'],
+        'stgit.smtpdelay':      ['5'],
+        'stgit.pullcmd':        ['git pull'],
+        'stgit.fetchcmd':       ['git fetch'],
+        'stgit.pull-policy':    ['pull'],
+        'stgit.autoimerge':     ['no'],
+        'stgit.keepoptimized':  ['no'],
+        'stgit.shortnr':        ['5'],
+        'stgit.pager':          ['less']
         }
 
     __cache = None
@@ -47,7 +46,7 @@ class GitConfig:
         done already."""
         if self.__cache is not None:
             return
-        self.__cache = {}
+        self.__cache = self.__defaults
         lines = Run('git', 'config', '--null', '--list'
                    ).discard_exitcode().raw_output()
         for line in filter(None, lines.split('\0')):
@@ -56,9 +55,10 @@ class GitConfig:
 
     def get(self, name):
         self.load()
-        if name not in self.__cache:
-            self.__cache[name] = [self.__defaults.get(name, None)]
-        return self.__cache[name][-1]
+        try:
+            return self.__cache[name][-1]
+        except KeyError:
+            return None
 
     def getall(self, name):
         self.load()
