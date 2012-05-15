From: Avishay Lavie <avishay.lavie@gmail.com>
Subject: PATCH: git-svn: support rebase --preserve-merges
Date: Tue, 15 May 2012 12:09:06 +0300
Message-ID: <CAHkK2boHtwbpbfQiqWFWn3BaGfJkojVPLisaghY256m+irE3ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 11:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUDl8-00073M-5F
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 11:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155Ab2EOJJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 05:09:29 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41291 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2EOJJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 05:09:28 -0400
Received: by wibhj8 with SMTP id hj8so2568592wib.1
        for <git@vger.kernel.org>; Tue, 15 May 2012 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=6arqBBjRWPHQCFivnLzHDKJTCYcQhzHA6sbeAHfrm14=;
        b=oKEKh+kHowfAWlRue/+PyuGGUPOBOeBmp2sLlS3pwbz60jQ8mbPcPccmyxUs1Ntvgq
         Cl/f2MyuOgnhonebpeU0syO8nZ4EI2NXe8p8mruTGhDL2yXPjE1YiBw6uM2K9ZN3f6lK
         C/9y2Dl4vcNeh4DVqbgLdCav+Nxc2kf6tnB2s4GIBBvR0hKxtumcjpIQOQ7ekhKz6ODv
         ofRdxRUTBePtDGOLNXFSnfWN8VRDe+c4reMD4oBgEPfTs8Es4E/zt6y2k0wkzllnEAYb
         BTYQfEFdIEMVWuKqfgq5UUI6eBtOIOr9rzhz3537ztl4Ra7JYsW71KwTWrONPIXkIQ9j
         L0HA==
Received: by 10.180.8.69 with SMTP id p5mr28119590wia.17.1337072966879; Tue,
 15 May 2012 02:09:26 -0700 (PDT)
Received: by 10.216.187.204 with HTTP; Tue, 15 May 2012 02:09:06 -0700 (PDT)
X-Google-Sender-Auth: TFZG71Voxi2ide45hLWqZE50KRM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197824>

From: Avishay Lavie <avishay.lavie@gmail.com>
Date: Tue, 15 May 2012 11:45:50 +0300
Subject: [PATCH] git-svn: support rebase --preserve-merges

When git svn rebase is performed after an unpushed merge, the
rebase operation follows both parents and replays both the user's
local commits and those from the merged branch. This is usually
not the intended behavior.
This patch adds support for the --preserve-merges/-p flag which
allows for a better workflow by re-applying merge commits as merges.

Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
---
 Documentation/git-svn.txt |    2 ++
 git-svn.perl              |    4 +++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee785..0d52997 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -572,6 +572,8 @@ config key: svn.repackflags
 --merge::
 -s<strategy>::
 --strategy=<strategy>::
+-p::
+--preserve-merges::
 	These are only used with the 'dcommit' and 'rebase' commands.
 +
 Passed directly to 'git rebase' when using 'dcommit' if a
diff --git a/git-svn.perl b/git-svn.perl
index ca038ec..e86d60b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -84,7 +84,7 @@ my ($_stdin, $_help, $_edit,
 	$_message, $_file, $_branch_dest,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
-	$_merge, $_strategy, $_dry_run, $_local,
+	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag, $_merge_info, $_interactive);
 $Git::SVN::_follow_parent = 1;
@@ -233,6 +233,7 @@ my %cmd = (
 			  'local|l' => \$_local,
 			  'fetch-all|all' => \$_fetch_all,
 			  'dry-run|n' => \$_dry_run,
+			  'preserve-merges|p' => \$_preserve_merges
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
@@ -1570,6 +1571,7 @@ sub rebase_cmd {
 	push @cmd, '-v' if $_verbose;
 	push @cmd, qw/--merge/ if $_merge;
 	push @cmd, "--strategy=$_strategy" if $_strategy;
+	push @cmd, "--preserve-merges" if $_preserve_merges;
 	@cmd;
 }

-- 
1.7.9.msysgit.0
