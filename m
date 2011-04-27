From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] handle_alias: provide GIT_PREFIX to !alias
Date: Wed, 27 Apr 2011 10:36:27 +0200
Message-ID: <5058a9853a75bff71187f553e67632997761de44.1303893279.git.git@drmicha.warpmail.net>
References: <4DB7CF72.3080205@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Matej Batic <matej.batic@ge.infn.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0F0-0006ud-HF
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab1D0Igj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:36:39 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52057 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754821Ab1D0Igb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 04:36:31 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 40547206FF;
	Wed, 27 Apr 2011 04:36:31 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 27 Apr 2011 04:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ssgwVWZajVWVUnhbdJYIXsOyEWM=; b=bcHoCNIcdFjAyyVY8NmHMKKny1AFrtwSg5mChbSqhIFeyIH0Qoh4sAjbrZQCM3KSVBO9l3yjPzFzA8DMvTbk4ahjBBhhiOgDVhwkAjPdMhoecsaTGW7BBKKMe2OmOVtjP5vApb20uXHiC4yEa4CvqFdZjOjTgzGJTdbVbBBsImw=
X-Sasl-enc: Ymhy6dC+KI8shvwK0pi3h+INZe2poh0F65mvxgk/ZUKq 1303893390
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 90DDD445080;
	Wed, 27 Apr 2011 04:36:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.270.gafca7
In-Reply-To: <4DB7CF72.3080205@drmicha.warpmail.net>
In-Reply-To: <3422485b672000ecdc72d82ffce8c89f258831b9.1303893279.git.git@drmicha.warpmail.net>
References: <3422485b672000ecdc72d82ffce8c89f258831b9.1303893279.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172198>

Provide an environment variable GIT_PREFIX which contains the subdirectory
from which a !alias was called (i.e. 'git rev-parse --show-prefix') since
these cd to the to level directory before they are executed.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt |    2 ++
 git.c                    |   10 +++++++++-
 t/t1020-subdirectory.sh  |   10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 750c86d..66281dd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -589,6 +589,8 @@ it will be treated as a shell command.  For example, defining
 "gitk --all --not ORIG_HEAD".  Note that shell commands will be
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
+'GIT_PREFIX' is set as returned by running 'git rev-parse --show-prefix'
+from the original current directory. See linkgit:git-rev-parse[1].
 
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
diff --git a/git.c b/git.c
index ef598c3..ed89951 100644
--- a/git.c
+++ b/git.c
@@ -179,6 +179,8 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (alias_string[0] == '!') {
 			const char **alias_argv;
 			int argc = *argcp, i;
+			struct strbuf sb = STRBUF_INIT;
+			const char *env[2];
 
 			commit_pager_choice();
 
@@ -189,7 +191,13 @@ static int handle_alias(int *argcp, const char ***argv)
 				alias_argv[i] = (*argv)[i];
 			alias_argv[argc] = NULL;
 
-			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			strbuf_addstr(&sb, "GIT_PREFIX=");
+			if (subdir)
+				strbuf_addstr(&sb, subdir);
+			env[0] = sb.buf;
+			env[1] = NULL;
+			ret = run_command_v_opt_cd_env(alias_argv, RUN_USING_SHELL, NULL, env);
+			strbuf_release(&sb);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);
 
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 66e40d3..ddc3921 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -129,6 +129,16 @@ test_expect_success '!alias expansion' '
 	test_cmp expect actual
 '
 
+test_expect_success 'GIT_PREFIX for !alias' '
+	printf "dir/" >expect &&
+	(
+		git config alias.test "!sh -c \"printf \$GIT_PREFIX\"" &&
+		cd dir &&
+		git test >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
-- 
1.7.5.270.gafca7
