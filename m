From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 1/3] t5541-http-push: add test for URLs with trailing slash
Date: Thu,  8 Apr 2010 10:15:16 +0800
Message-ID: <1270692918-4300-1-git-send-email-rctay89@gmail.com>
References: <1270656067-688-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 04:15:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzhHX-0003Hm-FT
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 04:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0DHCPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 22:15:42 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:40409 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0DHCPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 22:15:33 -0400
Received: by qyk9 with SMTP id 9so1957941qyk.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Vi0mW2IWCkcj2BNGvhHXzB10wGGG/xEHCh1Wr8bCXAg=;
        b=nLAQuTvoMme1noZIAbO8ZiicWT0rHJXg61FwRS0Ce5a4UJwAXUBdUCV75Vvl3QX/8c
         Aab4qekUMG/CgnTLh2TYoHKV5Jw/gZhexhv/HNRLvB5wQdMHKRbwweVZVbuHSk7Q4yjD
         Fl343mHCbkbgz9VxhGC/xYLCrAB8/CA3Nqpn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i9B/p7Ieat+oZGMk5Ygbb1lLdRQa2foaLBEx4uuPCWRlziIZeQobTWn8N/++NEvdXC
         W1C9SeNXkGemNUzhxNa2bu1guKcaSTupBX9g6wWYX/sYa8WK1ksfkbUlmoX7BlLpm+mz
         5P9tgb9CwVTZjmOUvl5IGYCea4SmuhZnJ4JGM=
Received: by 10.229.225.73 with SMTP id ir9mr3610587qcb.22.1270692931350;
        Wed, 07 Apr 2010 19:15:31 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id v26sm8664223qce.13.2010.04.07.19.15.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 19:15:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1270656067-688-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144305>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 795dc2b..e94ac78 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -34,8 +34,34 @@ test_expect_success 'setup remote repository' '
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
 
-test_expect_success 'clone remote repository' '
+cat >exp <<EOF
+GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
+EOF
+test_expect_failure 'no empty path components' '
+	# In the URL, add a trailing slash, and see if git appends yet another
+	# slash.
 	cd "$ROOT_PATH" &&
+	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
+
+	sed -e "
+		s/^.* \"//
+		s/\"//
+		s/ [1-9][0-9]*\$//
+		s/^GET /GET  /
+	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+
+	# Clear the log, so that it does not affect the "used receive-pack
+	# service" test which reads the log too.
+	#
+	# We do this before the actual comparison to ensure the log is cleared.
+	echo > "$HTTPD_ROOT_PATH"/access.log &&
+
+	test_cmp exp act
+'
+
+test_expect_success 'clone remote repository' '
+	rm -rf test_repo_clone &&
 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
 '
 
@@ -68,6 +94,7 @@ test_expect_success 'create and delete remote branch' '
 '
 
 cat >exp <<EOF
+
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-- 
1.6.6.1368.g82eeb
