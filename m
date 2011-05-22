From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Sun, 22 May 2011 02:57:07 -0700
Message-ID: <1306058229-93800-1-git-send-email-davvid@gmail.com>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 11:57:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO5PW-0000iL-2b
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 11:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab1EVJ5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 05:57:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35699 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab1EVJ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 05:57:16 -0400
Received: by pzk9 with SMTP id 9so2242016pzk.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=S2WZYDMLfnyWBNFEyME1pGkgCI+kHDaT6sfV5FwbYsc=;
        b=s5FSiK1e4pF+PB6wTxHgtTYsDStiBQUcubZW5S3LgqJSyL8K//BIrDxOxBebJBJQe5
         b7mZeX/vZmCLFyK5SmHoceHDW46XSuKj6cT+TXpgf1iX/cIZoLdbGcoF+Xfe2ojEWYxB
         cYh/LZeS6Ec2WVHP1klENaBkwDy16ZkYZVJ8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J7TgJLysHKgzZOLWUWmSsWRzXhVi//xSvWSzI04pRPrqPb8fZEqZRG8gQ37lAsY03d
         h4dNFkRVyTmEmgnNfgPRbai8ycQ4mQGXtht0xeO6oGrZqDY3hVJDo0jKhGmgtBelnz0p
         hXqhyNXtAKNck/qYfrNNjfWfopSzKSr1R86VU=
Received: by 10.143.61.20 with SMTP id o20mr606028wfk.367.1306058235516;
        Sun, 22 May 2011 02:57:15 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 25sm4866325wfb.22.2011.05.22.02.57.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 02:57:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.317.g391b14
In-Reply-To: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174186>

GIT_PREFIX was added in 7cf16a14f5c070f7b14cf28023769450133172ae so that
aliases can know the directory from which a !alias was called.

Knowing the prefix relative to the root is helpful in other programs
so export it to built-ins as well.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 setup.c                 |    6 ++++++
 t/t1020-subdirectory.sh |   16 ++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index b6e6b5a..fc169a4 100644
--- a/setup.c
+++ b/setup.c
@@ -603,6 +603,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *prefix;
 
 	prefix = setup_git_directory_gently_1(nongit_ok);
+	/* Provide the prefix to all external processes and programs */
+	if (prefix)
+		setenv("GIT_PREFIX", prefix, 1);
+	else
+		unsetenv("GIT_PREFIX");
+
 	if (startup_info) {
 		startup_info->have_repository = !nongit_ok || !*nongit_ok;
 		startup_info->prefix = prefix;
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index ddc3921..a85b594 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -139,6 +139,22 @@ test_expect_success 'GIT_PREFIX for !alias' '
 	test_cmp expect actual
 '
 
+test_expect_success 'GIT_PREFIX for built-ins' '
+	# Use GIT_EXTERNAL_DIFF to test that the "diff" built-in
+	# receives the GIT_PREFIX variable.
+	printf "dir/" >expect &&
+	printf "#!/bin/sh\n" >diff &&
+	printf "printf \"\$GIT_PREFIX\"\n" >>diff &&
+	chmod +x diff &&
+	(
+		cd dir &&
+		printf "change" >two &&
+		env GIT_EXTERNAL_DIFF=./diff git diff >../actual
+		git checkout -- two
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no file/rev ambiguity check inside .git' '
 	git commit -a -m 1 &&
 	(
-- 
1.7.5.2.317.g391b14
