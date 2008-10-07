From: Abdelrazak Younes <younes@lyx.org>
Subject: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 07 Oct 2008 15:10:07 +0200
Message-ID: <48EB5FAF.4080303@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org> <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 15:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnCLy-0003H5-M6
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 15:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbYJGNKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 09:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYJGNKo
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 09:10:44 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:40344 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474AbYJGNKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 09:10:43 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 3D68417278;
	Tue,  7 Oct 2008 15:10:42 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 2937119752;
	Tue,  7 Oct 2008 15:10:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97704>

On 07/10/2008 13:57, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 1:36 PM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>>> Sound like a problem of startup directory: on the command line you
>>> start from the right directory...when you double click on which repo
>>> qgit is open ?
>>>
>>>        
>> None of course. But when I open a repository manually I would expect that
>> this is properly filled in.
>>
>>      
>
> In git.cpp, Git::userInfo() function get info about user by means of
> 'git config' calls, my guess (I cannot it test now) is that 'git
> config' does not work if we are not in a git directory.
>    

OK, with this patch, I see that the local config request is apparently 
successful even though the 'user' and 'email' strings stay empty.
OTOH, the two global config requests fail.

---
  src/git.cpp |   19 ++++++++++++-------
  1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index 4ffc4ea..e77f4a1 100755
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -6,6 +6,8 @@
      Copyright: See COPYING file that comes with this distribution

  */
+#include <string>
+
  #include <QApplication>
  #include <QDateTime>
  #include <QDir>
@@ -347,13 +349,16 @@ void Git::userInfo(SList info) {

      errorReportingEnabled = false; // 'git config' could fail, see docs

-    run("git config user.name", &user);
-    run("git config user.email", &email);
-    info << "Local config" << user << email;
-
-    run("git config --global user.name", &user);
-    run("git config --global user.email", &email);
-    info << "Global config" << user << email;
+    if (bool success = run("git config user.name", &user)) {
+        success = run("git config user.email", &email);
+        if (success)
+            info << "Local config" << user << email;
+    }
+    if (bool success = run("git config --global user.name", &user)) {
+        success = run("git config --global user.email", &email);
+        if (success)
+            info << "Global config" << user << email;
+    }

      errorReportingEnabled = true;
  }
-- 
1.6.0.2.1172.ga5ed0
