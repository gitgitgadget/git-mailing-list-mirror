From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/16] t/t5505-remote: test multiple push/pull in remotes-file
Date: Fri, 21 Jun 2013 16:42:37 +0530
Message-ID: <1371813160-4200-14-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKX-0003kx-IH
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405Ab3FULQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:29 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33788 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030379Ab3FULQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:26 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so29118pde.32
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+7u69qGxYag+xROKXJKKNCRhWrxC1KN5BWflu4awQb0=;
        b=Pst0e7SoGVeeBM5or3/g9iA9U18Sfyl/ky1oPlCDQl+LxjdzO6hcPDW2I/1qYID847
         cVD731E1K8hvGtZSkaCeiW2TxhuwhvsgJguRerRKbDyBF90wSbbIBZz0FjCIm6eY9lLb
         Ltg0+qdFMU8b08C5NLv/l2e2mHeQgpO/5Quqw+I1ORDSvc/ila/SGycIfsy3sBIQKQ1X
         M/xYEnWF6IIBPg1Ns4cjq6LX9RzUBBgWDrRv8IJoggrPtPYMX24zrSbscioriFfVenvN
         3PJXm1gxW1HcLzBozehUdgIdpw7k+UGpKkvRlHm54ncBARojmUfIM4Jx5y0lafMfyIoD
         +6sA==
X-Received: by 10.66.253.195 with SMTP id ac3mr15749826pad.107.1371813385661;
        Fri, 21 Jun 2013 04:16:25 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228604>

Extend the test "migrate a remote from named file in $GIT_DIR/remotes"
to test that multiple "Push:" and "Pull:" lines in the remotes-file
works as expected.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 06ed381..5497a23 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -671,7 +671,9 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 cat > remotes_origin << EOF
 URL: quux
 Push: refs/heads/master:refs/heads/upstream
+Push: refs/heads/master:refs/heads/upstream2
 Pull: refs/heads/master:refs/heads/origin
+Pull: refs/heads/master:refs/heads/origin2
 EOF
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
@@ -684,8 +686,18 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 		git remote rename origin origin &&
 		test_path_is_missing .git/remotes/origin &&
 		test "$(git config remote.origin.url)" = "quux" &&
-		test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
-		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+		cat >push_expected <<-\EOF
+		refs/heads/master:refs/heads/upstream
+		refs/heads/master:refs/heads/upstream2
+		EOF
+		cat >fetch_expected <<-\EOF
+		refs/heads/master:refs/heads/origin
+		refs/heads/master:refs/heads/origin2
+		EOF
+		git config --get-all remote.origin.fetch >push_actual &&
+		git config --get-all remote.origin.fetch >fetch_actual &&
+		test_cmp push_expected push_actual &&
+		test_cmp fetch_expected fetch_actual &&
 	)
 '
 
-- 
1.8.3.1.499.g7ad3486.dirty
