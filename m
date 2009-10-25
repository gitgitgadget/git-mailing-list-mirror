From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 5/7] t5540-http-push: check existence of fetched files
Date: Sun, 25 Oct 2009 23:22:27 +0800
Message-ID: <20091025232227.96769e50.rctay89@gmail.com>
References: <20091025232142.6558d9e4.rctay89@gmail.com>
 <20091025232044.06d7ce5c.rctay89@gmail.com>
 <20091025231932.be9a6dfa.rctay89@gmail.com>
 <20091025231809.15b470fa.rctay89@gmail.com>
 <20091025231651.18c75559.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:22:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24vX-000244-MW
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbZJYPW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752835AbZJYPW1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:22:27 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:63679 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbZJYPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:22:27 -0400
Received: by ywh40 with SMTP id 40so7628001ywh.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=oPIJ/j1h6A83K13oHE1u0iu78a4gjsCXbdCnb545dr4=;
        b=Rpd0CT203nq35ORGYhE+33Z0+w0aOGjo71i672pqZCWGh+Xk1bUELVqojQtWTEOvNj
         bT9oIEy2UL38izfxMrmfbJvqSamz++yjFjhmq7ixWqLaCWB502DjeF0KTB8DqcYgMymK
         wk+xvG5yOfIX28/tC26X0I6LSJKgo5lpg2GsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=sXfiCIGjWMTJrhgXlcTacghgXkdzGS0Xx6JkVJFwNVGbAXNEko3Nfc6DIRgaoKClcm
         MiHhsKYZFnIf2pDxeLFyowlbSJu8corAV/J/jobt15S2fOOkfIB4oPrXnv3hILi7RgXd
         NwpouzlRxgdEI+LC3rucoxafTNVKM+99C5tHs=
Received: by 10.101.88.1 with SMTP id q1mr1692425anl.177.1256484151854;
        Sun, 25 Oct 2009 08:22:31 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 35sm894358yxh.51.2009.10.25.08.22.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:22:31 -0700 (PDT)
In-Reply-To: <20091025232142.6558d9e4.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131212>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index c7b8a40..ee7f84a 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -64,13 +64,18 @@ test_expect_success 'http-push fetches unpacked objects' '
 	git clone $HTTPD_URL/test_repo_unpacked.git \
 		"$ROOT_PATH"/fetch_unpacked &&

+	COMMIT_PATH=$(git rev-parse --verify HEAD |
+		sed -e "s/^\([0-9a-f]\{2\}\)\([0-9a-f]\{38\}\)/\1\/\2/") &&
+
 	# By reset, we force git to retrieve the object
 	(cd "$ROOT_PATH"/fetch_unpacked &&
 	 git reset --hard HEAD^ &&
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+	 test ! -e ".git/objects/$COMMIT_PATH" &&
+	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master &&
+	 test -e ".git/objects/$COMMIT_PATH")
 '

 test_expect_success 'http-push fetches packed objects' '
@@ -80,9 +85,14 @@ test_expect_success 'http-push fetches packed objects' '
 	git clone $HTTPD_URL/test_repo_packed.git \
 		"$ROOT_PATH"/test_repo_clone_packed &&

-	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
-	 git --bare repack &&
-	 git --bare prune-packed) &&
+	cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
+	git --bare repack &&
+	git --bare prune-packed &&
+
+	PACK_PATH=$(cat "objects/info/packs" |
+		sed -e "s/^P \(pack-[0-9a-f]\{40\}\.pack\)/\1/") &&
+	COMMIT_PATH=$(git rev-parse --verify HEAD |
+		sed -e "s/^\([0-9a-f]\{2\}\)\([0-9a-f]\{38\}\)/\1\/\2/") &&

 	# By reset, we force git to retrieve the packed object
 	(cd "$ROOT_PATH"/test_repo_clone_packed &&
@@ -90,7 +100,10 @@ test_expect_success 'http-push fetches packed objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_packed.git master)
+	 test ! -e ".git/objects/$COMMIT_PATH" &&
+	 test ! -e ".git/objects/pack/$PACK_PATH" &&
+	 git push -f -v $HTTPD_URL/test_repo_packed.git master &&
+	 test -e ".git/objects/pack/$PACK_PATH")
 '

 test_expect_success 'create and delete remote branch' '
--
1.6.4.4
