From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Sun, 8 May 2005 21:59:59 -0600
Message-ID: <200505082159.59595.elenstev@mesatop.com>
References: <200505081911.10371.elenstev@mesatop.com> <200505082125.28521.elenstev@mesatop.com> <2970.10.10.10.24.1115610025.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Marcel Holtmann" <marcel@holtmann.org>,
	"Petr Baudis" <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 05:58:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUzPB-0002lr-Qy
	for gcvg-git@gmane.org; Mon, 09 May 2005 05:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVEIEFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 00:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbVEIEFI
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 00:05:08 -0400
Received: from taco.zianet.com ([216.234.192.159]:46861 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S263038AbVEIEEv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 00:04:51 -0400
Received: (qmail 4998 invoked from network); 9 May 2005 04:04:48 -0000
Received: from 216-31-65-49.zianet.com (216.31.65.49)
  by 0 with SMTP; 9 May 2005 04:04:48 -0000
To: "Sean" <seanlkml@sympatico.ca>
User-Agent: KMail/1.6.1
In-Reply-To: <2970.10.10.10.24.1115610025.squirrel@linux1>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 08 May 2005 09:40 pm, Sean wrote:
> On Sun, May 8, 2005 11:25 pm, Steven Cole said:
> 
> > I had intended it only as a quick check by an end-user before doing
> > a commit that the values had been set as desired.
> 
> Hey Steven,
> 
> Rather than creating a separate command, perhaps the values could
> automatically be added to the initial commit message in a few "CG:" lines?
> 
> Sean

A secondary reason for adding the cg-printenv capability was that a user would
see this command in the cg-help list, and cg-help printenv would give:

Print exported git environment variables
Copyright (c) Steven Cole 2005  <--- Petr, my early version of cg-help stripped (c) lines.

These git environment variables are used in case
values other than that returned by getpwuid(getuid())
are desired when performing a commit.

AUTHOR_NAME		Author's name
AUTHOR_EMAIL		Author's e-mail address
AUTHOR_DATE		Date, perhaps from a patch e-mail
COMMIT_AUTHOR_NAME	Committer's name
COMMIT_AUTHOR_EMAIL	Committer's e-mail address

Takes no parameters.
-------------
Yes, I know that the environment variables are documented in Documentation/core-git.txt,
but having this usage right up front like this may help those who only RTFM as a last resort.

If others feel that the more obscure environment variables should be exposed here, feel
free to submit patches.

Here is a patch with Junio's improved version:

--------------------------------------------------------------------------------------
The cg-printenv command will print exported git environment variables.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

Index: Makefile
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/Makefile  (mode:100644)
+++ uncommitted/Makefile  (mode:100644)
@@ -48,7 +48,8 @@
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch cg-patch \
-	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update
+	cg-printenv cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls \
+	cg-update
 
 LIB_SCRIPT=cg-Xlib cg-Xdiffdo cg-Xmergefile
 
Index: cg-help
===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/cg-help  (mode:100755)
+++ uncommitted/cg-help  (mode:100755)
@@ -35,6 +35,7 @@
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
 	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]
 	cg-patch			< patch on stdin
+	cg-printenv
 	cg-pull		[BNAME]
 	cg-restore	[FILE]...
 	cg-rm		FILE...
Index: cg-printenv
===================================================================
--- /dev/null  (tree:3974261da777f55a7a11aff6e02f584bbfe2b475)
+++ uncommitted/cg-printenv  (mode:100755)
@@ -0,0 +1,21 @@
+#!/usr/bin/env bash
+#
+# Print exported git environment variables
+# Copyright (c) Steven Cole 2005
+#
+#These git environment variables are used in case
+#values other than that returned by getpwuid(getuid())
+#are desired when performing a commit.
+#
+#AUTHOR_NAME		Author's name
+#AUTHOR_EMAIL		Author's e-mail address
+#AUTHOR_DATE		Date, perhaps from a patch e-mail
+#COMMIT_AUTHOR_NAME	Committer's name
+#COMMIT_AUTHOR_EMAIL	Committer's e-mail address
+#
+# Takes no parameters.
+echo AUTHOR_NAME="$AUTHOR_NAME"
+echo AUTHOR_EMAIL="$AUTHOR_EMAIL"
+echo AUTHOR_DATE="$AUTHOR_DATE"
+echo COMMIT_AUTHOR_NAME="$COMMIT_AUTHOR_NAME"
+echo COMMIT_AUTHOR_EMAIL="$COMMIT_AUTHOR_EMAIL"

