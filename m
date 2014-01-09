From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: [PATCH v2 2/4] t7505: ensure cleanup after hook blocks merge
Date: Thu,  9 Jan 2014 00:45:42 +0000
Message-ID: <1389228344-38813-3-git-send-email-ryan@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
 <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ryan Biesemeyer <ryan@yaauie.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 01:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W13mX-0007CX-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbaAIAra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:47:30 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45848 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097AbaAIAr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 19:47:29 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so2482003pdj.11
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 16:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ylZkhwBTf0W0UOApzBhETry4a//pVrFKTRoCVbu+hkg=;
        b=cE076Z29yNNO9So5S9JqZQnz4t1S27jEKJ/EbBBJqr+IchfsQAtwdHSV8/JaG3yTpT
         e1Ixl1fqzj4dRkti5lU5emLH9tPh8EY1lNmYdWnsLkANx+blfuVu7tQ/qhYMyzN0tiha
         L8SMyq08kSi+w9RBpALZwrBMBCFTw2O0xGIGvySw8Ub3Hq/vkSMiskwEkN9oTLTfVY2d
         ioQM0/qOjtctr1uUzBPNSqs1BfC+tOJx2Na/5+dvEslPoNCzOlIcjw0LtNb83zW0HxSb
         4TZgIxbQ8NZV1TXyTgmfYV+wTYsmcDvkCLEZRSbUzBcq+hQaM/Ds9Qj1YsVVLSwE2ySb
         J4OA==
X-Gm-Message-State: ALoCoQn45r0qGDJXZHO+gozqEWezMmTYyPsZGQ/xBVwYYO0RuL+g1rb3HfNf7hwJeSLMR9dq2P7M
X-Received: by 10.68.75.9 with SMTP id y9mr141818pbv.61.1389228448640;
        Wed, 08 Jan 2014 16:47:28 -0800 (PST)
Received: from beorn.local.com ([69.164.175.238])
        by mx.google.com with ESMTPSA id xs1sm6854477pac.7.2014.01.08.16.47.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 16:47:27 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240236>

Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 1c95652..697ecc0 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -168,18 +168,19 @@ test_expect_success 'with failing hook (--no-verify)' '
 '
 
 test_expect_success 'with failing hook (merge)' '
-
-	git checkout -B other HEAD@{1} &&
-	echo "more" >> file &&
-	git add file &&
-	rm -f "$HOOK" &&
-	git commit -m other &&
-	write_script "$HOOK" <<-EOF &&
-	exit 1
-	EOF
-	git checkout - &&
-	test_must_fail git merge other
-
+  test_when_finished "git merge --abort" &&
+  (
+		git checkout -B other HEAD@{1} &&
+		echo "more" >> file &&
+		git add file &&
+		rm -f "$HOOK" &&
+		git commit -m other &&
+		write_script "$HOOK" <<-EOF &&
+		exit 1
+		EOF
+		git checkout - &&
+		test_must_fail git merge other
+  )
 '
 
 test_done
-- 
1.8.5
