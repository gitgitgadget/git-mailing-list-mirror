From: Johannes Sixt <j.sixt@viscovery.net>
Subject: t5505-remote fails on Windows
Date: Wed, 18 Mar 2009 12:42:27 +0100
Message-ID: <49C0DE23.8020809@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjuBr-00069f-Qo
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 12:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbZCRLmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 07:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750AbZCRLmb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 07:42:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49776 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528AbZCRLmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 07:42:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjuAF-0002QQ-Ug; Wed, 18 Mar 2009 12:42:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B2FA269F; Wed, 18 Mar 2009 12:42:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113612>

I see this failure related to 'git remote show':

* expecting success:
        (cd test &&
         git config --add remote.origin.fetch
refs/heads/master:refs/heads/upstream &&
         git fetch &&
         git checkout -b ahead origin/master &&
         echo 1 >> file &&
         test_tick &&
         git commit -m update file &&
         git checkout master &&
         git branch --track octopus origin/master &&
         git branch --track rebase origin/master &&
         git branch -d -r origin/master &&
         git config --add remote.two.url ../two &&
         git config branch.rebase.rebase true &&
         git config branch.octopus.merge "topic-a topic-b topic-c" &&
         (cd ../one &&
          echo 1 > file &&
          test_tick &&
          git commit -m update file) &&
         git config --add remote.origin.push : &&
         git config --add remote.origin.push
refs/heads/master:refs/heads/upstream &&
         git config --add remote.origin.push +refs/tags/lastbackup &&
         git config --add remote.two.push
+refs/heads/ahead:refs/heads/master &&

         git config --add remote.two.push
refs/heads/master:refs/heads/another &&
         git remote show origin two > output &&
         git branch -d rebase octopus &&
         test_cmp expect output)

>From d:/Src/mingw-git/t/trash directory.t5505-remote/one
 * [new branch]      master     -> upstream
Branch ahead set up to track remote branch refs/remotes/origin/master.
Switched to a new branch "ahead"
[ahead 847549e] update
 1 files changed, 1 insertions(+), 0 deletions(-)
Switched to branch "master"
Branch octopus set up to track remote branch refs/remotes/origin/master.
Branch rebase set up to track remote branch refs/remotes/origin/master.
Deleted remote branch origin/master (9d34b14).
[master 6329a3c] update
 1 files changed, 1 insertions(+), 0 deletions(-)
error: src refspec refs/tags/lastbackup does not match any.
Deleted branch rebase (9d34b14).
Deleted branch octopus (9d34b14).
--- expect      Wed Mar 18 11:22:53 2009
+++ output      Wed Mar 18 11:22:54 2009
@@ -12,8 +12,8 @@
                 and with remote topic-c
     rebase  rebases onto remote master
   Local refs configured for 'git push':
-    master pushes to master   (local out of date)
     master pushes to upstream (create)
+    master pushes to master   (local out of date)
 * remote two
   URL: ../two
   HEAD branch (remote HEAD is ambiguous, may be one of the following):
* FAIL 8: show


As you can see, the entries for "master pushes to..." are reversed. It
seems that this output is not stable. Before I delve into this, do you
know whether there is some data structure involved that does not guarantee
the order? Such as a hash table, a opendir/readdir sequence, or perhaps
while reading the config file?

It looks like we have to explicitly sort the list somewhere.

-- Hannes
