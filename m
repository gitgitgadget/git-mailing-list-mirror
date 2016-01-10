From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] t7810: correct --no-index test
Date: Sun, 10 Jan 2016 15:19:55 +0100
Message-ID: <1452435597-12099-2-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 15:26:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIGwx-00019D-0d
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 15:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620AbcAJOTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 09:19:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32996 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609AbcAJOTp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2016 09:19:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so22603537wmu.0
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 06:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sPuaWWMg0ITmyLUFxy4nAfg9VTiOZeAqNz3Xf9KTxQc=;
        b=YvUWeqIpkUx5rgkolXkhgzqNRSZs0dlY6dj4PKykh82p3DSaX8a7sSyO4cJXSva/Gi
         cyINtXyV2D4FgAtcSbHNXxhvj8HUcolg9dihcEXoBXl/s7j4ioJ56Em2NXkVreTB02ar
         vD05b8Rg+uu5AvYqQToD2E6GtGlSMOGMnL1QwydSMlrV1E2zVGpXnpt8Ht+JpvdLfOHM
         eXpFL4k2JD3qib2fRxMCDwXeTDajjMqUxZQrir3m8+m69u/AgXWwR78keAI10wPCAh/D
         FMdVtTTvcc/ZFyauW13pUI2PzzhCabrhUmNMK50crCjsJwfw4TTw9liO4DAKTQIMxGS5
         S5Hg==
X-Received: by 10.28.87.135 with SMTP id l129mr9069577wmb.9.1452435584084;
        Sun, 10 Jan 2016 06:19:44 -0800 (PST)
Received: from localhost (host251-54-dynamic.20-79-r.retail.telecomitalia.it. [79.20.54.251])
        by smtp.gmail.com with ESMTPSA id u4sm114758111wjz.4.2016.01.10.06.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 06:19:42 -0800 (PST)
X-Mailer: git-send-email 2.6.3.387.g749a69c.dirty
In-Reply-To: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283622>

GIT_CEILING_DIRECTORIES doesn't prevent chdir up into another directory
while looking for a repository directory if it is equal to the current
directory.  Because of this, the test which claims to test the git grep
--no-index command outside of a repository actually tests it inside of a
repository.  The test_must_fail assertions still pass because the git
grep only looks at untracked files and therefore no file matches, but
not because it's run outside of a repository as it was originally
intended.

Set the GIT_CEILING_DIRECTORIES environment variable to the parent
directory of the directory in which the git grep command is executed, to
make sure it is actually run outside of a git repository.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

 t/t7810-grep.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 028ffe4..ab94716 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -791,7 +791,7 @@ test_expect_success 'outside of git repository' '
 	} >non/expect.full &&
 	echo file2:world >non/expect.sub &&
 	(
-		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git grep o &&
@@ -805,7 +805,7 @@ test_expect_success 'outside of git repository' '
 
 	echo ".*o*" >non/git/.gitignore &&
 	(
-		GIT_CEILING_DIRECTORIES="$(pwd)/non/git" &&
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git grep o &&
-- 
2.6.3.387.g749a69c.dirty
