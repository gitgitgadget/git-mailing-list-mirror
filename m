From: "Robert Blum" <rob.blum@gmail.com>
Subject: [PATCH] git-p4: chdir now properly sets PWD environment variable in msysGit
Date: Fri, 1 Aug 2008 12:50:03 -0700
Message-ID: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: simon@lst.de, shausman@trolltech.com, marius@trolltech.com,
	hanwen@google.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 01 21:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0ea-0004L3-NM
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 21:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYHATuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYHATuG
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 15:50:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:56446 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYHATuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 15:50:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so719410ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qS6WgE8Vp67uGkZGPi/zFvGdnZl1VPvU8xXFxZUhk2g=;
        b=shbZkZsAP/cvpdoQzRWdtbOpEzeBTBUVtxHCDH9rJ2oMIyJGM+TRkS6MT/FHicXC1U
         IE/o9BATKiligmgsZMnFTOOXK5zp+J0iEbVII2TnWKkC0TypYPNRWsgI77OOHIofg4q0
         pJ3hOqBxXl6xpIUotLZ7WbLcXhTPTuLTIoeJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=IPN0eXvWDpRdFyfkxGvaGIW9RlmOnbhMnNmzefNnEYHbEDNZkEzIeGmce15w/+2zh7
         HZie+oWkacWaMiKPCU8+v5gM01vFtLih/MQFu6hOIwQpMqX4nFHP6+iHR4j2wMAWrVnI
         Xwm0o9q4E4MnqnJ4Lgdpnw+xy5mfgrHSyv78Q=
Received: by 10.150.191.10 with SMTP id o10mr3807616ybf.31.1217620203756;
        Fri, 01 Aug 2008 12:50:03 -0700 (PDT)
Received: by 10.151.99.1 with HTTP; Fri, 1 Aug 2008 12:50:03 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91081>

P4 on Windows expects the PWD environment variable to be set to the
current working dir, but os.chdir in python doesn't do that by default

Signed-off-by: Robert Blum <rob.blum@gmail.com>
---

Pushing it out to the list since I'm not entirely sure who the git-p4 owner
even is. CC'ed likely suspects for ownership ;)

 contrib/fast-import/git-p4 |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6ae0429..b4d0c65 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -16,6 +16,13 @@ from sets import Set;

 verbose = False

+if os.name == 'nt':
+    def os_chdir(dir):
+        os.environ['PWD']=dir
+        os.chdir(dir)
+else:
+    os_chdir = os.chdir
+
 def die(msg):
     if verbose:
         raise Exception(msg)
@@ -712,7 +719,7 @@ class P4Submit(Command):
         print "Perforce checkout for depot path %s located at %s" % (self.depot
Path, self.clientPath)
         self.oldWorkingDirectory = os.getcwd()

-        os.chdir(self.clientPath)
+        os_chdir(self.clientPath)
         print "Syncronizing p4 checkout..."
         system("p4 sync ...")

@@ -732,7 +739,7 @@ class P4Submit(Command):

         if len(commits) == 0:
             print "All changes applied!"
-            os.chdir(self.oldWorkingDirectory)
+            os_chdir(self.oldWorkingDirectory)

             sync = P4Sync()
             sync.run([])
@@ -1670,7 +1677,7 @@ class P4Clone(P4Sync):
         print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneD
estination)
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
-        os.chdir(self.cloneDestination)
+        os_chdir(self.cloneDestination)
         system("git init")
         self.gitdir = os.getcwd() + "/.git"
         if not P4Sync.run(self, depotPaths):
@@ -1782,7 +1789,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe("git rev-parse --show-cdup").strip()
                     if len(cdup) > 0:
-                        os.chdir(cdup);
+                        os_chdir(cdup);

         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):
--
1.5.5.1015.g9d258
