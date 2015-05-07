From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 03/12] t5520: test work tree fast-forward when fetch updates head
Date: Thu,  7 May 2015 16:43:59 +0800
Message-ID: <1430988248-18285-4-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQ4-0005VW-JG
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbbEGIo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:29 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36522 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbEGIo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:26 -0400
Received: by pdea3 with SMTP id a3so35371611pde.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=po922jI4iKTPMtKlnlIL6aBM0aWo+1/gz+Of4SZZ2f0=;
        b=frumWTXhvOZO6VwHGP3UAjgiZjEGOcDaj57IQ+kMTZ9eJdUZuu9aoi5gUc/HfYT7Pu
         F6PPTJpV46U0cDn08Eg1RXtNyEU1ciy/614/VC4rMf+9QuT9g2N+KYRmglltRxKNR045
         T7JKmXW7FuxtZYCj4jqhi7YyVXHwZ0BYVUZui7O3ubrqDDjaGocqiTHqhYqUxLlCmRdq
         w7nDx3X1Exlu2i4eTnbp+OsnnqnlTqKuP8MT8omNrxe4908PaoynJNfniJ2Km948DfHC
         To4/o98mO03eD1Sj+0J6dazj0+OaktZzj5eGE0SfSWzrdRU6nugnAq2pFD6uKxVNGCLu
         j3uw==
X-Received: by 10.68.170.229 with SMTP id ap5mr5128923pbc.132.1430988265626;
        Thu, 07 May 2015 01:44:25 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:24 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268514>

Since commit b10ac50f (Fix pulling into the same branch), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Implement tests to ensure that the fast-forward occurs in such a case,
as well as to ensure that the user-friendly advice is printed upon
failure.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Ensure that on fast-forward failure, if there is a conflict, the work
      tree should not be touched.

 t/t5520-pull.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 37ff45f..99b6f67 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -185,6 +185,28 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_cmp expected file
 '
 
+test_expect_success 'fast-forwards working tree if branch head is updated' '
+	git checkout -b third master^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	echo file >expected &&
+	test_cmp expected file &&
+	git pull . second:third 2>out &&
+	test_i18ngrep "fetch updated the current branch head" out &&
+	echo modified >expected &&
+	test_cmp expected file
+'
+
+test_expect_success 'fast-forward fails with conflicting work tree' '
+	git checkout -b third master^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	echo file >expected &&
+	test_cmp expected file &&
+	echo conflict >file &&
+	test_must_fail git pull . second:third 2>out &&
+	test_i18ngrep "Cannot fast-forward your working tree" out &&
+	test `cat file` = conflict
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
