From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Look for a commit's parents in the standard way.
Date: Mon, 14 Aug 2006 18:55:44 +0200
Message-ID: <20060814165544.20350.41590.stgit@gandelf.nowhere.earth>
References: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 18:56:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCfiq-0005Fw-4k
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 18:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWHNQzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 12:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHNQzY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 12:55:24 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:64235 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932161AbWHNQzX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 12:55:23 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id C6322549AB;
	Mon, 14 Aug 2006 18:55:22 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1GCfjF-00060a-Dw; Mon, 14 Aug 2006 18:55:53 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25364>


This has the direct effect of taking info/grafts into account, since
ignoring it only causes confusion.

My original implementation was pasted from the same fix applied to
cogito some time ago.  That one is hopefully more pythonic, but it
looks like split() is deprecated for some reason, and I don't know
what should be used instead.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/git.py |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index c8b7b8f..68b547c 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -19,6 +19,7 @@ Foundation, Inc., 59 Temple Place, Suite
 """
 
 import sys, os, popen2, re, gitmergeonefile
+from string import split
 
 from stgit import basedir
 from stgit.utils import *
@@ -47,12 +48,13 @@ class Commit:
             field = line.strip().split(' ', 1)
             if field[0] == 'tree':
                 self.__tree = field[1]
-            elif field[0] == 'parent':
-                self.__parents.append(field[1])
-            if field[0] == 'author':
+            #elif field[0] == 'parent':
+                #self.__parents.append(field[1])
+            elif field[0] == 'author':
                 self.__author = field[1]
-            if field[0] == 'committer':
+            elif field[0] == 'committer':
                 self.__committer = field[1]
+        self.__parents = split(_output_lines('git-rev-list --parents --max-count=1 %s' % id_hash)[0])[1:]
         self.__log = ''.join(lines[i+1:])
 
     def get_id_hash(self):
