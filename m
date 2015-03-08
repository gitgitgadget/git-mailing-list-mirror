From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] t7510: do not fail when gpg warns about insecure memory
Date: Sun,  8 Mar 2015 08:40:50 -0700
Message-ID: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 08 16:41:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUdK8-00057i-Ht
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 16:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbbCHPk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 11:40:56 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:42322 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbbCHPkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 11:40:55 -0400
Received: by pdbfl12 with SMTP id fl12so57548656pdb.9
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5NJiKMY/pMjIsn65p/Voasc9ntWdkJ02sPkeSLl+Y9c=;
        b=neJTlYXCJhQP3aaJP+2CqA4wGL7Q7mQOTOcx6m16AKIAPh/VSSeCNDUmhqm5Cguqc3
         398J1bNypPVxlWN8LoNKouPOF5gp3iQQzh+O5AB1Lq8kJd5igzpBcNLB/uXD4QRIrQE/
         nhmGCTN5PWh9QR+cwQlYNtThOiadzkirXWsBbmYkACxxg8IGQX0mG4qaRPO2W01YoYO0
         tqMP14DUhWqsy5VAqanyHyE2JJ6dToOAj2kJtrvevTjGu3d9rEQ7WXmxYlBx9JyzHl5B
         RaNC4bwo0K+eBrHDBrvyVFQcfTXzodqhGf82514gkEmVIKhI5r25IMLhjR+thi0sNadd
         8Ohg==
X-Received: by 10.66.119.37 with SMTP id kr5mr43664626pab.136.1425829255303;
        Sun, 08 Mar 2015 08:40:55 -0700 (PDT)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id ie5sm15049170pbb.14.2015.03.08.08.40.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 08 Mar 2015 08:40:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265095>

Depending on how gpg was built, it may issue the following
message to stderr when run:

  Warning: using insecure memory!

Unfortunately when running the test, that message gets
collected in the stdout result of git show -s --show-signature
but is collected in the stderr result of git verify-commit -v
causing both the stdout and stderr result comparisions to fail.

Since checking for secure memory use by gpg is not the point of
this test, filter out such messages to allow the test to pass
even when gpg is "using insecure memory".

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 t/t7510-signed-commit.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 474dab38..e86923bc 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -84,9 +84,10 @@ test_expect_success GPG 'verify and show signatures' '
 test_expect_success GPG 'show signed commit with signature' '
 	git show -s initial >commit &&
 	git show -s --show-signature initial >show &&
-	git verify-commit -v initial >verify.1 2>verify.2 &&
+	git verify-commit -v initial >verify.1 2>verify.2.out &&
 	git cat-file commit initial >cat &&
-	grep -v "gpg: " show >show.commit &&
+	grep -v -e "gpg: " -e "insecure memory" show >show.commit &&
+	grep -v "insecure memory" verify.2.out >verify.2 &&
 	grep "gpg: " show >show.gpg &&
 	grep -v "^ " cat | grep -v "^gpgsig " >cat.commit &&
 	test_cmp show.commit commit &&
---
