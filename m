From: Scott Collins <scc@ScottCollins.net>
Subject: [PATCH] Clarify documentation of git-cvsserver, particularly in relation to git-shell
Date: Tue, 15 Apr 2008 17:44:43 -0400
Message-ID: <1208295883-19599-1-git-send-email-scc@ScottCollins.net>
References: <39292ba40804151233k2dd9300as5611e65ab6fcd81d@mail.gmail.com>
Cc: Scott Collins <scc@ScottCollins.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 15 23:46:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlsyf-0000Aw-Vw
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 23:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYDOVpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756059AbYDOVpY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 17:45:24 -0400
Received: from mx-2.vasoftware.com ([208.48.95.24]:46877 "EHLO
	mx-2.vasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbYDOVpX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 17:45:23 -0400
Received: from ip199-194.digitalrealm.net ([216.144.199.194] helo=localhost.localdomain)
	by mx-2.vasoftware.com with esmtpa 
	(Exim 4.64)
	id 1Jlsxt-00080n-MY by VAAuthID scollins with plain; Tue, 15 Apr 2008 14:45:22 -0700
X-Mailer: git-send-email 1.5.5.49.gf43e2
In-Reply-To: <39292ba40804151233k2dd9300as5611e65ab6fcd81d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79634>

Currently, for SSH clients restricted to git-shell, CVS_SERVER should
not be changed: git-shell understands the default value of 'cvs' to mean
git-cvsserver and actually _doesn't_ understand the command
'git-cvsserver'. This makes it totally transparent to CVS users, but the
original wording here perhaps less so to the person setting-up CVS
access.  Previous wording mentioning GIT_AUTHOR, GIT_COMMITTER variables
may not have made clear we really meant GIT_AUTHOR_(NAME|EMAIL), etc.
Note that .ssh/environment is a good place to set these, and that
.bashrc is shell-specific. Add a bit of text to differentiate cvs -d
(setting CVSROOT) from cvs co -d (setting the name of the newly checked
out directory).  Removed an extra 'Example:' string.

Signed-off-by: Scott Collins <scc@ScottCollins.net>
---
...because of course I forget to mention .ssh/environment (required for
git-shell clients).  Sorry for the patch noise.


 Documentation/git-cvsserver.txt |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 9cec802..bd98fc1 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -106,11 +106,13 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
 
 ------
-cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
+cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name> -d <dir_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
-variable.
+variable.  SSH users restricted to git-shell don't need to override the default
+with CVS_SERVER (and probably shouldn't) as git-shell understands 'cvs' to mean
+git-cvsserver.
 --
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
@@ -141,25 +143,28 @@ allowing access over SSH.
         enabled=1
 ------
 --
-3. On the client machine you need to set the following variables.
-   CVSROOT should be set as per normal, but the directory should point at the
-   appropriate git repo. For example:
+3. If you didn't specify the CVSROOT/CVS_SERVER directly in the checkout command,
+   automatically saving it in your 'CVS/Root' files, then you need to set them
+   explicitly in your environment.  CVSROOT should be set as per normal, but the
+   directory should point at the appropriate git repo.  As above, for SSH clients
+   _not_ restricted to git-shell, CVS_SERVER should be set to git-cvsserver.
 +
 --
-For SSH access, CVS_SERVER should be set to git-cvsserver
-
-Example:
-
 ------
      export CVSROOT=:ext:user@server:/var/git/project.git
      export CVS_SERVER=git-cvsserver
 ------
 --
-4. For SSH clients that will make commits, make sure their .bashrc file
-   sets the GIT_AUTHOR and GIT_COMMITTER variables.
+4. For SSH clients that will make commits, make sure their server-side
+   .ssh/environment files (or .bashrc, etc., according to their specific shell)
+   export appropriate values for GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL,
+   GIT_COMMITTER_NAME, and GIT_COMMITTER_EMAIL.  For SSH clients connecting to a
+   bash shell, .bashrc is a reasonable alternative.
 
 5. Clients should now be able to check out the project. Use the CVS 'module'
-   name to indicate what GIT 'head' you want to check out. Example:
+   name to indicate what GIT 'head' you want to check out.  This also sets the
+   name of your newly checked-out directory, unless you tell it otherwise with
+   `-d <dir_name>`.  Example:
 +
 ------
      cvs co -d project-master master
-- 
1.5.5.49.gf43e2
