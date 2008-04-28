From: Liu Yubao <yubao.liu@gmail.com>
Subject: [DOC] more explanation about --git-dir and --work-tree options
Date: Tue, 29 Apr 2008 04:09:20 +0800
Message-ID: <48162EF0.6050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 22:10:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZft-0007iZ-9M
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 22:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765789AbYD1UJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbYD1UJV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 16:09:21 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:16917 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765789AbYD1UJU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 16:09:20 -0400
Received: by el-out-1112.google.com with SMTP id n30so1668074elf.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=925kqsaKYjiCdK/euzF5jsuqDUew3TRl+pJuXXeI98Q=;
        b=rZexG3xxZg2TLdJM21a33MfMUPu1pBBRwyGxuTdQffvVVjZYzXOp66hwL2ZhHhlosdGJ48n38U9xWT7yKJAgloX4om+eQ/W4BFe54r4ASJ4BPSPeWglgDCHbgp7V41rjfBAK6I18a77jFGUk1j0zJwbLU8tkqFdQIt3tsl0+sUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=J62FLmj13lig49rUKi2CJ9cTFXcVfhKhnGaMY1mcbgAxjXWb8mM5PzekPrmLp3065Ef7aq+JAUUR6Ee5ET9fEciW7rLLknasXJ4h/Slb7Iv3QG+RjNMCxMP7F6vl1j2Ood5UrKDufZKXhKA04kSmKXHBLSwWmdez4eKue4K9tF4=
Received: by 10.142.201.3 with SMTP id y3mr2408043wff.1.1209413358398;
        Mon, 28 Apr 2008 13:09:18 -0700 (PDT)
Received: from ?192.168.88.2? ( [61.49.223.152])
        by mx.google.com with ESMTPS id 30sm13244133wff.11.2008.04.28.13.09.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 13:09:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80603>

Hi,

I find these two options bring me surprise:

   git init $HOME
   git add ~/.vimrc ~/.gvimrc ~/.vim
   cd $HOME/work/xxx
   ....do some work, then change ~/.vimrc without changing
       working directory
   git --git-dir $HOME/.git status

I use --git-dir because I have another .git in $HOME/work/xxx, the
last command surprises me much, it tells me .vim* are all deleted!

After checking the code, I realize git thinks the current working
directory as top directory of the working tree if --git-dir is specified
without --work-tree option.

I try to modify this behaviour so that git thinks the parent directory
of .git/ as the top directory of my working tree, but later I find many
tests are broken and I realize many scripts and many(??) git users would
like probably to work in the top directory of their working trees providing
only one extra --git-dir option with separated git repositories without
touching .git/config and environment variables, so I decide to give up
my patch and accustom myself to the new lovely core.worktree configuration
variable.

And here is my supplement to the documentation.

---
 Documentation/config.txt |    9 ++++++++-
 Documentation/git.txt    |   10 ++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7a24f6e..307e089 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -234,7 +234,14 @@ core.worktree::
 	used in combination with repositories found automatically in
 	a .git directory (i.e. $GIT_DIR is not set).
 	This can be overridden by the GIT_WORK_TREE environment
-	variable and the '--work-tree' command line option.
+	variable and the '--work-tree' command line option. It can be
+	a absolute path or relative path to the directory specified by
+	--git-dir or GIT_DIR.
+	Note: If --git-dir or GIT_DIR are specified but none of
+	--work-tree, GIT_WORK_TREE and core.worktree is specified,
+	the current working directory is regarded as the top directory
+	of your working tree.
+
 
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
diff --git a/Documentation/git.txt b/Documentation/git.txt
index a070e07..5b41e16 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -143,7 +143,8 @@ help ...'.
 
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by
-	setting the GIT_DIR environment variable.
+	setting the GIT_DIR environment variable. It can be an absolute
+	path or relative path to current working directory.
 
 --work-tree=<path>::
 	Set the path to the working tree.  The value will not be
@@ -151,7 +152,12 @@ help ...'.
 	a .git directory (i.e. $GIT_DIR is not set).
 	This can also be controlled by setting the GIT_WORK_TREE
 	environment variable and the core.worktree configuration
-	variable.
+	variable. It can be an absolute path or relative path to
+	the directory specified by --git-dir or GIT_DIR.
+	Note: If --git-dir or GIT_DIR are specified but none of
+	--work-tree, GIT_WORK_TREE and core.worktree is specified,
+	the current working directory is regarded as the top directory
+	of your working tree.
 
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
-- 
1.5.5
