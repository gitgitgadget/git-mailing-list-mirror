From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] builtins: do not commit pager choice early
Date: Thu, 25 Mar 2010 20:38:14 +0700
Message-ID: <1269524295-24569-1-git-send-email-pclouds@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 20:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nussv-0004QK-Rl
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 20:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab0CYTiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 15:38:24 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:48006 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab0CYTiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 15:38:22 -0400
Received: by fxm5 with SMTP id 5so1367480fxm.29
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=6SGxlCzZuJlys38FPl9MZSBm0su167SwIAF4tYR+7HQ=;
        b=QiMgDL5fp1KNN1r7azV2MyqN4YUbWaMuGXj1+Aot8dx+T+7VzYPTgvjurbYYboh8zX
         SjnOKoVzDvh9snW7C/1hQMjdRbMRFI969hdXm98tPMszf43+iwDn3i3M1YCCKciUfUnF
         YM1H10nQ3j1Ppb8taRoiza+vp957W7sU9Snjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eVEiwu7IvtH6PGSj+bUE8xIDMIFWqK5/arUGsJ8NPZCtuE9UWmb7pZV2UOfGhg61WI
         5OA64D1HNaXirdZpzr+Q3ZZyEk8iRMMGSTVyTLP1XokmQ7dGb/a0Q7LgCruLLzloMzn9
         7rKNxHTevevw/D/QD9qifMhPSTRLR6qg5vXVI=
Received: by 10.223.15.147 with SMTP id k19mr1223215faa.87.1269545900665;
        Thu, 25 Mar 2010 12:38:20 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 18sm216658fks.5.2010.03.25.12.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 12:38:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu, 25 Mar 2010 20:38:16 +0700
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143194>

From: Duy Nguyen <pclouds@gmail.com>

Committing pager choice may require setting up the pager, which
will need access to repository.

At the time after handle_options() is called, the repository has not
been found yet. As a result, unallowed access to repository may
happen.

There are several possible code path after
handle_options()/commit_pager_choice() is called:

1. list_common_cmds_help()
2. run_argv()
3. help_unknown_cmd()

Case 2. will have commit_pager_choice() called inside run_builtin() if
a command is found. Case 1. and 3. won't need a pager, it's short
printout and should be fitted within a screen. So, removing
commit_pager_choice() call after handle_options() is safe.

Signed-off-by: Duy Nguyen <pclouds@gmail.com>
---
 On top of nd/setup. This may help fix the breakage in t7006. And forget t9100
 breakage I mentioned elsewhere. My system is broken, git-svn dies when it "exit 0;"
 and even git one year ago does not fix it.

 git.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 3798791..bd1d4bb 100644
--- a/git.c
+++ b/git.c
@@ -514,7 +514,6 @@ int main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	commit_pager_choice();
 	if (argc > 0) {
 		if (!prefixcmp(argv[0], "--"))
 			argv[0] += 2;
-- 
1.7.0.rc1.541.g2da82.dirty
