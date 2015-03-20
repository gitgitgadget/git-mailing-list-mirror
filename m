From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 19:20:30 +0100
Message-ID: <1426875630-17481-1-git-send-email-t.gummerer@gmail.com>
References: <xmqqtwxfee6a.fsf@gitster.dls.corp.google.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 19:21:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1Y6-0007wg-I5
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbbCTSVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:21:30 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36708 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbCTSV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:21:29 -0400
Received: by wibg7 with SMTP id g7so151333661wib.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvhR43aEpWJqyEHpXD9Vpf9UNRu8unhTrIm6io19kp0=;
        b=bCBtRnAHHq8LKowi2KLJkCmQVh8L0prYCMJTL+Zw41WKu6M5WV9LdjeZHEu7LS+MZV
         v9LWKuoyajHg9Vp6u2OYos2nfq3BSndieFx6EJeQDpynXBcpDkuVgsjhnyKWB9v04ium
         XvgjT1Hy9B0r0I4EY3U6DT9111XgK3RwiByxwUuWCiTARKJdoVTmGH345u+q/wPF5Or4
         a7BNHZFeYZe4y9d05erJzHMwU0q0HFmXnECdlphJFL9ZO6K3141FYiKU6vkhLjZQLE+U
         7Oy2WjXBF2knFYw3BQYw9pKNjfHMimhlQSkFaU0HrsruuZjWNLujfBeaqole5GsMJmEf
         fNNw==
X-Received: by 10.180.75.140 with SMTP id c12mr26932432wiw.14.1426875688839;
        Fri, 20 Mar 2015 11:21:28 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id wo10sm7385982wjb.35.2015.03.20.11.21.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 11:21:28 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.377.gdac1145
In-Reply-To: <xmqqtwxfee6a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265930>

The different index versions have different sha-1 checksums.  Those
checksums are checked in t1700, which makes it fail when the test suite
is run with TEST_GIT_INDEX_VERSION=4.  Fix it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
> An updated patch to mention "when run with TEST_GIT_INDEX_VERSION=4"
> in the log message was what I was asking for ;-)

Sorry I didn't catch that.  Here it is.
					      

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
