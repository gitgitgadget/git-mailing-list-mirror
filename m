From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 1/4] t5541-http-push: add test for chunked
Date: Wed,  4 May 2011 18:11:33 +0800
Message-ID: <1304503896-5988-2-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
 <1304503896-5988-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 12:12:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHZ3m-0002px-31
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 12:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab1EDKLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 06:11:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61505 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDKLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 06:11:45 -0400
Received: by pzk9 with SMTP id 9so430713pzk.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 03:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gI6nfdVpTFmHlB/+a+YNJvyp96Ijtq3EADvZ1bJ+0sA=;
        b=FVan4K7ZQ+h3cZnMjkBG2nsEw+uH9el6tO1EiekXm+93A5JIHP07/yc0uYovQKKpsM
         3oPpWAHmcyHoF0XN3KLEnEA7H4jYBhNR7X8I3LCwIIQY1VKMsa1ZQGyQqZ6NdKBHqEaJ
         jsRFsOOo5Vcbd69GCL9lqyYyrM1ym/EDv2zfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xpbfT7Q5Jxxy2luWtce802DV3ok+EfedW32hw9C5j87qxFDkn1yeFzuONTdYwHXfjV
         /+4a6tA+8AKJHoXCUICdOJECNvhXC1837+AiblbITo6+i07CaBTZjHVpdwKGyKGNvbW/
         ZWZRiMWPW94mbjzde/zXFkYSHtlAYBSFOS1VQ=
Received: by 10.68.40.164 with SMTP id y4mr1359249pbk.291.1304503904941;
        Wed, 04 May 2011 03:11:44 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id y5sm643190pbq.57.2011.05.04.03.11.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 03:11:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304503896-5988-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172736>

Trigger the chunked type of pushing for smart HTTP. This can serve as a
regression test for the issue fixed in 1e41827 (http: clear POSTFIELDS
when initializing a slot).

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed in v4: simplified the way chunked pushing is triggered. The test
now runs in a tarball extract.

 t/t5541-http-push.sh |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 0492877..0c0917a 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -65,14 +65,16 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone
 '
 
-test_expect_success 'push to remote repository' '
+test_expect_success 'push to remote repository (standard)' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -m path2 &&
 	HEAD=$(git rev-parse --verify HEAD) &&
-	git push &&
+	GIT_CURL_VERBOSE=1 git push -v -v 2>err &&
+	! grep "Expect: 100-continue" err &&
+	grep "POST git-receive-pack (376 bytes)" err &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
@@ -140,5 +142,17 @@ test_expect_success C_LOCALE_OUTPUT 'push fails for non-fast-forward refs unmatc
 		output
 '
 
+test_expect_success 'push (chunked)' '
+	git checkout master &&
+	test_commit commit path3 &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	git config http.postbuffer 4 &&
+	git push -v -v origin $BRANCH 2>err &&
+	grep "POST git-receive-pack (chunked)" err &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD = $(git rev-parse --verify HEAD)) &&
+	git config --unset http.postbuffer
+'
+
 stop_httpd
 test_done
-- 
1.7.3.3.585.g74f6e
