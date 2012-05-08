From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2] checkout: do not corrupt HEAD on empty repo
Date: Tue,  8 May 2012 19:22:33 +0200
Message-ID: <1336497753-4208-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j.sixt@viscovery.net, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 19:22:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRo7d-0006ev-2l
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab2EHRWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 13:22:44 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58271 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab2EHRWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:22:43 -0400
Received: by lbbgm6 with SMTP id gm6so4389483lbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=22dkCNmQAvjk7ByH5bnV0Mqwg1QTeYpT+rWIc4qiQDY=;
        b=s8wYkGMNzaKr5iKo1Ym24MSOLsX6jby7Xh27NbT9PAv/0DPS6goNgipDq9HitEl6oh
         3NJ+G4PBLxhPPMIwcnKKB5d6YHx8rFaKwfbJDci33SOUuLIk63PrHIcH4pX1O8e0/7Sw
         CSq+RJnMtpNAQSntY60XM6K1b4Ihdzs7tHWLO96buEg1/Cm/pn6XNoWWTA9KVZqN8x4Y
         GkEhC1JnppGYA69zbg5hxHtXaPog47P21h6zbEWGdXbsxtPkArenu5sTIfLeydecWv+f
         kBY682y6Gyl8vYj2ajPmonML+NhPSBWJ8UMU88Gv4QQ6iYu9VWiNfZHkC0EZ4bnfUY6l
         4XeA==
Received: by 10.152.148.34 with SMTP id tp2mr5588797lab.47.1336497762106;
        Tue, 08 May 2012 10:22:42 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id uc6sm28292196lbb.3.2012.05.08.10.22.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:22:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197397>

In abe1998 ("git checkout -b: allow switching out of an unborn
branch"), a code-path overly-optimisticly assumed that a
branch-name was specified. This is not always the case, and as
a result a NULL-pointer was attempted printed to .git/HEAD.

This could lead to at least two different failure modes:
 1) vsnprintf formated the NULL-string as something useful (e.g
    "(null)")
 2) vsnprintf crashed

Neither were very convenient for formatting a new HEAD-reference.

To fix this, reintroduce some strictness so we only take this
new codepath if a banch-name was specified.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/checkout.c         |    2 +-
 t/t2015-checkout-unborn.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 23fc56d..35924d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1091,7 +1091,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.writeout_stage)
 		die(_("--ours/--theirs is incompatible with switching branches."));
 
-	if (!new.commit) {
+	if (!new.commit && opts.new_branch) {
 		unsigned char rev[20];
 		int flag;
 
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index 6352b74..37bdced 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -46,4 +46,15 @@ test_expect_success 'checking out another branch from unborn state' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checking out in a newly created repo' '
+	test_create_repo empty &&
+	(
+		cd empty &&
+		git symbolic-ref HEAD >expect &&
+		test_must_fail git checkout &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.7.10.msysgit.1
