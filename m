From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] stgit: fix clone
Date: Wed, 11 Jan 2006 17:19:26 -0500
Message-ID: <1137017966.10975.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 11 23:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwoJu-0005DG-Kb
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 23:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWAKWTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 17:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWAKWTu
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 17:19:50 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:14015 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932280AbWAKWTs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 17:19:48 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EwoHR-00067g-J5
	for git@vger.kernel.org; Wed, 11 Jan 2006 17:17:26 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1EwoJS-00034X-Kk; Wed, 11 Jan 2006 17:19:26 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14519>

"stg clone" is currently broken:

$ stg clone http://homepage.ntlworld.com/cmarinas/stgit.git    
stg clone: git-rev-parse --git-dir failed

This happens with current git.  "git-rev-parse --git-dir" doesn't work
in an empty directory.  The patch avoids running "git-rev-parse
--git-dir" when the requested command doesn't assume existence of git
repository.

Signed-off-by: Pavel Roskin <proski@gnu.org>

---
Warning: this is my first non-trivial patch to StGIT and the first patch
to a Python program.

diff --git a/stgit/git.py b/stgit/git.py
index a7b1c3f..0e63f69 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -82,13 +82,16 @@ __commits = dict()
 # Functions
 #
 
-def get_base_dir():
+def get_base_dir(assume_top = False):
     """Different start-up variables read from the environment
     """
     if 'GIT_DIR' in os.environ:
         return os.environ['GIT_DIR']
     else:
-        return _output_one_line('git-rev-parse --git-dir')
+        if assume_top:
+            return '.git'
+        else:
+            return _output_one_line('git-rev-parse --git-dir')
 
 def get_commit(id_hash):
     """Commit objects factory. Save/look-up them in the __commits
diff --git a/stgit/stack.py b/stgit/stack.py
index 8b7c296..1c080b3 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -263,7 +263,7 @@ class Series:
             self.__name = git.get_head_file()
 
         if self.__name:
-            base_dir = git.get_base_dir()
+            base_dir = git.get_base_dir(assume_top = (name == 'master'))
             self.__patch_dir = os.path.join(base_dir, 'patches',
                                             self.__name)
             self.__base_file = os.path.join(base_dir, 'refs', 'bases',


-- 
Regards,
Pavel Roskin
