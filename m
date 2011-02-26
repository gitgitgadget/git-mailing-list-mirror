From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/2] t6022: New test checking for unnecessary updates of renamed+modified files
Date: Sat, 26 Feb 2011 11:34:56 -0700
Message-ID: <1298745297-25713-2-git-send-email-newren@gmail.com>
References: <20110224115233.GA31356@sigill.intra.peff.net>
 <1298745297-25713-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 19:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtOzB-0001Ny-TL
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 19:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab1BZSfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 13:35:16 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49022 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1BZSfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 13:35:13 -0500
Received: by gxk8 with SMTP id 8so1097822gxk.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 10:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=k6aYDoXG5AAL7M1jX+28OELRReiWqT+82ZbZgzT1k7A=;
        b=nWhmklBp3mEV0kdj/iiqi8A72MnzmBzZsIbvDnYTS6LZ7UMTKPQNKQJYYaYGuD14LM
         DiiI9QOlssBg71i8Lt8+1pHqkd5GGL9umaQ70OufNNaB42t4wA2y/SVbzdfvW1fCLFbV
         lhbNVHDK0RsWR5yA3LK06hvU81MXMpe7Ulpd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rXdAbpgp6OqpnutZhVwY0XzDGbGVRpHUUB1utQZXwJrOcfjb8D3kCdnbmQ3LuLLy/3
         KgBDQ21FQielEYlDGJ+c/mapgCOXTWu3Tm6T2bRLWxbcfLsn/9yQy4NutDMVdJuLn3lg
         qUIs4uTYoUv2SZe7cnasYCtp0vBz4qPade2sc=
Received: by 10.91.197.31 with SMTP id z31mr5291353agp.178.1298745312789;
        Sat, 26 Feb 2011 10:35:12 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b11sm2491718ana.18.2011.02.26.10.35.10
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 10:35:12 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.23.g4865dd
In-Reply-To: <1298745297-25713-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167987>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 1ed259d..71bfd22 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -609,4 +609,36 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	! test -f original
 '
 
+test_expect_success 'setup avoid unnecessary update' '
+	git reset --hard &&
+	git checkout --orphan avoid-unnecessary-update &&
+	git rm -rf . &&
+	git clean -fdqx &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >original &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	git mv original rename &&
+	echo 11 >>rename &&
+	git add -u &&
+	git commit -m "Renamed and modified" &&
+
+	git checkout -b other-branch HEAD~1 &&
+	echo "random content" >random-file &&
+	git add -A &&
+	git commit -m "Random, unrelated changes"
+'
+
+test_expect_failure 'avoid unnecessary update' '
+	git checkout -q avoid-unnecessary-update^0 &&
+	orig=$(stat --format="%Y" rename) &&
+	sleep 1 &&
+	git merge other-branch &&
+	new=$(stat --format="%Y" rename) &&
+	echo "Checking whether stat times are same: $orig vs $new" &&
+	test "$orig" == "$new" &&
+	git diff-files --exit-code # Is "rename" clean, or only racily clean?
+'
+
 test_done
-- 
1.7.4.1.23.g4865dd
