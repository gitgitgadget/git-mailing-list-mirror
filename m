From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Wed, 25 May 2011 20:37:12 -0700
Message-ID: <1306381034-44190-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Heitzmann?= 
	<frederic.heitzmann@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 05:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPRO5-0003ma-Cw
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 05:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab1EZDhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 23:37:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49124 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab1EZDhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 23:37:21 -0400
Received: by pwi15 with SMTP id 15so159611pwi.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=jCbaN+4FWj+qB5iKWczppDe/YOnO2yH1ecONvNLsU6I=;
        b=n39CVIur3L7O5+19GPa1rKnsFcQlLwKONO1QYLUJwST1WRMJnUPf9vi5TtuK4XuZYL
         lvd9n6gDKiBnK5/50xR/P1P8V30noGWF1CIussPSGlX1v53bmA2BlM8xJ5rTHCxkBJbC
         4Ai1CTPHzziaREcZJhxcAw1rPeaYyve6+haEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BtMIjF2beJCP+U7mnOMj95rtLxq2Yv1n7tFRKnQSiaUpCCfERBjRW9OvkZ3xAq/fo/
         eNqv1UV9+8u00bWfrhxOCVMcRRIl9kPtiHoAO+riIxUNEdjWjkwn3LBXVYVqLxRlZBLm
         sNS9k5KJ72CQQeBO2YQVbrRI2R1/fyVEhXKv8=
Received: by 10.68.18.105 with SMTP id v9mr111302pbd.265.1306381041086;
        Wed, 25 May 2011 20:37:21 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id y3sm577909pbg.16.2011.05.25.20.37.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 20:37:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.2.660.g9f46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174489>

GIT_PREFIX was added in 7cf16a14f5c070f7b14cf28023769450133172ae so that
aliases can know the directory from which a !alias was called.

Knowing the prefix relative to the root is helpful in other programs
so export it to built-ins as well.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

The original version of this patch did not set GIT_PREFIX
to an empty string when prefix returns NULL.
Now we do.

 setup.c                 |    5 +++++
 t/t1020-subdirectory.sh |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 013ad11..4569974 100644
--- a/setup.c
+++ b/setup.c
@@ -710,6 +710,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *prefix;
 
 	prefix = setup_git_directory_gently_1(nongit_ok);
+	if (prefix)
+		setenv("GIT_PREFIX", prefix, 1);
+	else
+		setenv("GIT_PREFIX", "", 1);
+
 	if (startup_info) {
 		startup_info->have_repository = !nongit_ok || !*nongit_ok;
 		startup_info->prefix = prefix;
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index ddc3921..3c74480 100755
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
+	printf "printf \"\$GIT_PREFIX\"" >>diff &&
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
1.7.5.2.660.g9f46
