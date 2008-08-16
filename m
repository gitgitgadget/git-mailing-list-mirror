From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH] git-p4: chdir now properly sets PWD environment
 variable in msysGit
Date: Fri, 15 Aug 2008 22:56:26 -0700
Message-ID: <7vabfdjyet.fsf@gitster.siamese.dyndns.org>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
 <7v7iaxu7i1.fsf@gitster.siamese.dyndns.org>
 <bad7471c0808040601y10cceb44idcde5a4a8f415769@mail.gmail.com>
 <bad7471c0808040604p6de570f1k35aa4e76757ca6fd@mail.gmail.com>
 <7vskt5jyzh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>
To: "Robert Blum" <rob.blum@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 07:57:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUEnE-0004WO-Jc
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 07:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYHPF4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 01:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYHPF4h
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 01:56:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbYHPF4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 01:56:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C960162150;
	Sat, 16 Aug 2008 01:56:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7F0746214F; Sat, 16 Aug 2008 01:56:28 -0400 (EDT)
In-Reply-To: <7vskt5jyzh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 15 Aug 2008 22:44:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 149D06D2-6B58-11DD-AE23-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92534>

Junio C Hamano <gitster@pobox.com> writes:

> "Robert Blum" <rob.blum@gmail.com> writes:
>
>> Forgot reply-all - forwarding to list....
> ...
> I have been wondering what happened to this thread afterwards.

In the meantime, here is what I am inclined to apply.  The same approach
as the original, taking stylistic suggestion from Han-Wen.

-- >8 --
From: Robert Blum <rob.blum@gmail.com>
Date: Fri, 1 Aug 2008 12:50:03 -0700
Subject: [PATCH] git-p4: chdir now properly sets PWD environment variable in msysGit

P4 on Windows expects the PWD environment variable to be set to the
current working dir, but os.chdir in python doesn't do so.

Signed-off-by: Robert Blum <rob.blum@gmail.com>
Acked-by: Simon Hausmann <simon@lst.de>
Acked-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/fast-import/git-p4 |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6ae0429..3f2303d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -16,6 +16,11 @@ from sets import Set;
 
 verbose = False
 
+def chdir(dir):
+    if os.name == 'nt':
+        os.environ['PWD']=dir
+    os.chdir(dir)
+
 def die(msg):
     if verbose:
         raise Exception(msg)
@@ -712,7 +717,7 @@ class P4Submit(Command):
         print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
         self.oldWorkingDirectory = os.getcwd()
 
-        os.chdir(self.clientPath)
+        chdir(self.clientPath)
         print "Syncronizing p4 checkout..."
         system("p4 sync ...")
 
@@ -732,7 +737,7 @@ class P4Submit(Command):
 
         if len(commits) == 0:
             print "All changes applied!"
-            os.chdir(self.oldWorkingDirectory)
+            chdir(self.oldWorkingDirectory)
 
             sync = P4Sync()
             sync.run([])
@@ -1670,7 +1675,7 @@ class P4Clone(P4Sync):
         print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
-        os.chdir(self.cloneDestination)
+        chdir(self.cloneDestination)
         system("git init")
         self.gitdir = os.getcwd() + "/.git"
         if not P4Sync.run(self, depotPaths):
@@ -1782,7 +1787,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe("git rev-parse --show-cdup").strip()
                     if len(cdup) > 0:
-                        os.chdir(cdup);
+                        chdir(cdup);
 
         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):
-- 
1.6.0.rc3.11.g8134a
