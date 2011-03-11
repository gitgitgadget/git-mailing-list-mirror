From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git stash: status from current dir not top dir?
Date: Fri, 11 Mar 2011 21:49:13 +0100
Message-ID: <4D7A8AC9.1030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 21:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py9H8-0004XP-4P
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 21:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692Ab1CKUtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 15:49:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51441 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357Ab1CKUtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 15:49:24 -0500
Received: by bwz15 with SMTP id 15so2999237bwz.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=0xDo4S5/oosr67eQKT6CKf6FwrLqs4KuHlOetC0Pn+U=;
        b=ew7X2K/DgyCbtWGld3gKL5D7RwwCyUdkQj0JD4Ic/1YoMj+jSLNOxQTEpnDMBYd6mD
         5DGflSuMXcZi5ye1A1Y5OrBx12OPT2FMjP6tlsMR0JElJShqbp5xkGdt94xETIdmJdYF
         9MGzh00f3zh3tzzD4spiEIFsMdVVuNcw8kqYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=jInSIGnjoA07D46rWYWbVauu2m1jYM8eSbuMMjvsEuX+Wpf3KG++cgdFiNc+ruMXhl
         o+Khkwgz+KBDzZENvCZN5lbxMc0JUGkpJEUVzA6WuHAM7nAgf+gAwGr49zRaZGtGjCkB
         SdOIkwqV+3V/jSw6aTLo/4OxgmeXYZrSzBEAs=
Received: by 10.204.53.17 with SMTP id k17mr6465311bkg.17.1299876562099;
        Fri, 11 Mar 2011 12:49:22 -0800 (PST)
Received: from [192.168.1.101] (bxd250.neoplus.adsl.tpnet.pl [83.29.253.250])
        by mx.google.com with ESMTPS id k5sm1565197bku.16.2011.03.11.12.49.19
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Mar 2011 12:49:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168925>

Hi,

git status shows paths relative to current directory, so it's
possible to copy&paste them directly, even if you're in a subdirectory. 

But "git stash apply" shows status from root of git repository.
This is misleading because you can't copy and paste the paths.

I wonder if it's possible/better to change it so "git stash apply" shows
status relative to directory from which it was executed?

OTOH "git commit" also shows paths relative to root. So maybe git status
should be changed (hopefully no, because the relative paths are quite
useful IMO).

This patch tries to fix git-stash.sh to show status relative to 
current directory. I can resend the patch with better commit message.

Example:

$ mkdir d && cd d && echo a > ../topfile && echo b > subfile && git add ..
$ git commit -m 1
[master (root-commit) 6935958] 1
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 d/subfile
 create mode 100644 topfile
$ echo x > ../topfile ; echo y > subfile 
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   subfile
#	modified:   ../topfile
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git stash
Saved working directory and index state WIP on master: 6935958 1
HEAD is now at 6935958 1
$ git stash pop
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   d/subfile
#	modified:   topfile
#
no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (3c7c82dba01feed37c725a795116354f6e229d76)
$ git checkout -- topfile
error: pathspec 'd/topfile' did not match any file(s) known to git.


With the patch:

$ git stash pop
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   subfile
#	modified:   ../topfile
#
no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (4a0f7bb0a3e2902ba9046686d457b1b8f1ade04c)

---8<---
From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date: Fri, 11 Mar 2011 20:50:49 +0100
Subject: [PATCH] git stash: show status relative to currect directory


Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..586c12f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -12,6 +12,7 @@ USAGE="list [<options>]
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
+START_DIR=`pwd`
 . git-sh-setup
 require_work_tree
 cd_to_toplevel
@@ -394,7 +395,7 @@ apply_stash () {
 		then
 			squelch='>/dev/null 2>&1'
 		fi
-		eval "git status $squelch" || :
+		(cd "$START_DIR" && eval "git status $squelch") || :
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
-- 
1.7.1
