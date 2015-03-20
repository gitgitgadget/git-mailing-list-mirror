From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 16:09:24 +0100
Message-ID: <1426864165-7334-1-git-send-email-t.gummerer@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 16:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYyYW-0007po-0S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 16:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbbCTPJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 11:09:44 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38299 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbCTPJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 11:09:43 -0400
Received: by wibgn9 with SMTP id gn9so17228900wib.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mM7y+FyhDX9ZzLF/yrdjl+YLRqn0nsIuK2YtkTv2mFg=;
        b=zH3pn13uICPRTPxHBGo2QKfFwjEz4NTLgIBrS9MnqLPMSuCk39JYn+IwdFl1tTIPNu
         lCQk+R+VoF3sEpavhjQrwkZD+wLSyQXh03TTLeIUzGX745jcTxl2Hzo11hsXAERUdjtj
         Pq6hCO6xlAFHkTJG+Det5HZ0wstz0lQznsoefLEhdSDlII5S5/hmuXsGyWALexhaV20T
         7JmpJhQ5vV54U6csUAaML9rp/ZNC695Kb68I6N1FsTOdNacY+QzfhKy6mPPZkUIgtSDj
         A7ppqz3Q11edCu6GVwBzJ4+AEVZsKvsER+4ZAI99eUwbLk3BGmMRg23CcU4d0o0KrjLr
         oPcA==
X-Received: by 10.194.177.195 with SMTP id cs3mr158586121wjc.141.1426864182018;
        Fri, 20 Mar 2015 08:09:42 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id n3sm6730269wja.36.2015.03.20.08.09.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 08:09:41 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.377.gdac1145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265908>

The different index versions have different sha-1 checksums.  Those
checksums are checked in t1700, which makes it fail when run with index
v4.  Fix it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t1700-split-index.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 94fb473..92f7298 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -10,9 +10,18 @@ sane_unset GIT_TEST_SPLIT_INDEX
 test_expect_success 'enable split index' '
 	git update-index --split-index &&
 	test-dump-split-index .git/index >actual &&
+	indexversion=$(test-index-version <.git/index) &&
+	if test "$indexversion" = "4"
+	then
+		own=432ef4b63f32193984f339431fd50ca796493569
+		base=508851a7f0dfa8691e9f69c7f055865389012491
+	else
+		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
+		base=39d890139ee5356c7ef572216cebcd27aa41f9df
+	fi &&
 	cat >expect <<EOF &&
-own 8299b0bcd1ac364e5f1d7768efb62fa2da79a339
-base 39d890139ee5356c7ef572216cebcd27aa41f9df
+own $own
+base $base
 replacements:
 deletions:
 EOF
@@ -30,7 +39,7 @@ EOF
 
 	test-dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<EOF &&
-base 39d890139ee5356c7ef572216cebcd27aa41f9df
+base $base
 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
 replacements:
 deletions:
-- 
2.3.3.377.gdac1145
