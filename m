From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] git: add --no-replace option to disable replacing
Date: Sun, 11 Oct 2009 17:32:26 +0200
Message-ID: <20091011153227.8487.81803.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3Tg-0007eK-F0
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbZJKSpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 14:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbZJKSpk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:45:40 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48426 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbZJKSpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 14:45:39 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A624F8180C2;
	Sun, 11 Oct 2009 20:44:55 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 19A14818173;
	Sun, 11 Oct 2009 20:44:52 +0200 (CEST)
X-git-sha1: 31b537b7e093b6a319a8c9918608cc5af7ed6d5c 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129942>

Commit dae556b (environment: add global variable to disable replacement)
adds a variable to enable/disable replacement, and it is enabled by
default for most commands.

So there is no way to disable it for some commands, which is annoying
when we want to get information about a commit that has been replaced.

For example:

$ git cat-file -p N

would output information about the replacement commit if commit N is
replaced.

With the "--no-replace" option that this patch adds it is possible to
get information about the original commit using:

$ git --no-replace cat-file -p N

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

	Jakub Narebski wrote:

	> Wouldn't it be better for this option to be option for git
	> wrapper, i.e.
	>
	>  $ git --no-replace cat-file -p N
	>
	> and not
	>
	>  $ git cat-file --no-replace -p N

	You mean something like this patch?

	This is untested yet. I will add some tests and documentation
	later if it's ok to add this option.


diff --git a/git.c b/git.c
index 9883009..cfef7ac 100644
--- a/git.c
+++ b/git.c
@@ -6,7 +6,7 @@
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [--html-path]\n"
-	"           [-p|--paginate|--no-pager]\n"
+	"           [-p|--paginate|--no-pager] [--no-replace]\n"
 	"           [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE]\n"
 	"           [--help] COMMAND [ARGS]";
 
@@ -87,6 +87,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			use_pager = 0;
 			if (envchanged)
 				*envchanged = 1;
+		} else if (!strcmp(cmd, "--no-replace")) {
+			read_replace_refs = 0;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
 				fprintf(stderr, "No directory given for --git-dir.\n" );
-- 
1.6.5.1.g31b53
