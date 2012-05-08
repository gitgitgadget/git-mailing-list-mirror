From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] checkout: do not corrupt HEAD on empty repo
Date: Tue,  8 May 2012 18:05:14 +0200
Message-ID: <1336493114-4984-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j.sixt@viscovery.net, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 18:05:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmup-0003W3-TM
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755613Ab2EHQF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 12:05:27 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45159 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2EHQF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 12:05:26 -0400
Received: by lbbgm6 with SMTP id gm6so4330224lbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=TsCqu319GuGIMGLtGzpol/HksFKFL77FHzSlf4o3PD8=;
        b=OMf9faa65O5tMDs3WUoho8wYE/ztdDEClJ1d+ldVsjEoi0n7eUbjF1GMxAPlv5SxPS
         z0OG8IWV3JQ27bFWey5/OXfe6DeSTyMs6WEVb+C74mG2jEk38x+4mC3DtQGPYxMLQCLC
         iyf3ze5PJGpImCsTcefb82c5gv+DHCfByqVqEpq+lCN62fAqHZ1w6UgUvpTK0XYOvOP5
         ZGwp0t9uMZ+sYqIzAbFO2A8vYD5Wkyv42JbPJVoqK1xp/EPiyFKUJvkrggt+x12XCUI3
         IYuF6yyAJex34JZ/iqxxykAhxuaagMbpKUpRQWPqOazD2D5tjKGKPVL/uJkn2uBwbGJK
         ELLw==
Received: by 10.152.147.100 with SMTP id tj4mr18348625lab.39.1336493125279;
        Tue, 08 May 2012 09:05:25 -0700 (PDT)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id h8sm28041273lbx.8.2012.05.08.09.05.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 09:05:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.msysgit.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197379>

In abe1998 ("git checkout -b: allow switching out of an unborn
branch"), a code-path overly-optimisticly assumed that a
branch-name was specified. This is not always the case, and as
a result a NULL-pointer was attempted printed to .git/HEAD.

This could lead to at least two different failure modes:
 1) The CRT formated the NULL-string as something useful (e.g
    "(null)")
 2) The CRT crasheed.

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
index 6352b74..2fa9458 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -46,4 +46,15 @@ test_expect_success 'checking out another branch from unborn state' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checking out in a newly created repo' '
+	test_create_repo empty &&
+	(
+		cd empty &&
+		cat .git/HEAD >expect &&
+		test_must_fail git checkout &&
+		cat .git/HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
1.7.10.msysgit.1
