From: Sundararajan R <dyoucme@gmail.com>
Subject: [PATCH 2/2] Added tests for git reset -
Date: Tue, 10 Mar 2015 02:16:50 +0530
Message-ID: <1425934010-8780-2-git-send-email-dyoucme@gmail.com>
References: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
Cc: Sundararajan R <dyoucme@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 21:47:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV4aE-0004LW-LP
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 21:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbbCIUrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 16:47:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37159 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbbCIUrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 16:47:21 -0400
Received: by paceu11 with SMTP id eu11so61438505pac.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjPFC5dKC5aPH/Z4D6rAe1QSbCCFQSONZIEnaVhNcYo=;
        b=Ny20BEd8tNXBv8I0HmebVUGnUrZmrtpK+VqdizMLasPJPhTJUCaOKPSm4XVy3GDZz2
         qIUHMAd1cWRncMGr9j/k3ew5qidVKkZOIXte6ypMD7E5w+tL4JlTLXG8N0MtaY8rZlAw
         icN/GNTLo8n8V6CX1Ip/mrHdJbcnNYGq+2RbCO6e5oJNhj4qS0OdrFjUVJUjuSa1lmqs
         G7BY8UBs3dEHnK+UA4i5VlMTU8ojRyP9mTde232PmGC6GRQO26V1Os2kC2y6yKMjSt8+
         Vxrut8RVsiSyHTYIOtSSJM81kx4UGD/LZ3a1ikcFyYFuSM43BIzLdYlcTAJe8RWIFM/v
         UtAA==
X-Received: by 10.66.65.195 with SMTP id z3mr57858589pas.10.1425934041445;
        Mon, 09 Mar 2015 13:47:21 -0700 (PDT)
Received: from work.localdomain ([210.212.66.19])
        by mx.google.com with ESMTPSA id fi8sm11495520pdb.43.2015.03.09.13.47.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 13:47:20 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265195>

As you had suggested @Junio, I have added the required tests.
Please let me know if there is something is I should add.

Signed-off-by: Sundararajan R <dyoucme@gmail.com>
Thanks-to: Junio C Hamano
---
I have added 6 tests to check for the following cases:
git reset - with no @{-1}
git reset - with no @{-1} and file named -
git reset - with @{-1} and file named @{-1}
git reset - with @{-1} and file named - 
git reset - with @{-1} and file named @{-1} and - 
git reset - with @{-1} and no file named - or @{-1} 
The 1st test with no previous branch results in the error
The 2nd,3rd,4th and 5th result in the ambiguous argument error 
The 6th test has - working like @{-1}

 t/t7102-reset.sh | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 98bcfe2..a670938 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -568,4 +568,111 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reset - with no @{-1}' '
+	git init new --quiet &&
+	cd new &&
+	test_must_fail git reset - >actual &&
+	touch expect &&
+	test_cmp expect actual
+'
+
+rm -rf new
+
+cat >expect <<EOF
+fatal: ambiguous argument '-': both revision and filename
+Use ./- for file named -
+Use '--' to separate paths from revisions, like this:
+'git <command> [<revision>...] -- [<file>...]'
+EOF
+
+test_expect_success 'reset - with no @{-1} and file named -' '
+	git init new --quiet &&
+	cd new &&
+	echo "Hello" > - &&
+	git add -
+	test_must_fail git reset - 2>actual &&
+	test_cmp ../expect actual
+'
+
+cd ..
+rm -rf new
+
+cat >expect <<EOF
+fatal: ambiguous argument '@{-1}': both revision and filename
+Use '--' to separate paths from revisions, like this:
+'git <command> [<revision>...] -- [<file>...]'
+EOF
+
+test_expect_success 'reset - with @{-1} and file named @{-1}' '
+	git init new --quiet &&
+	cd new && 
+	echo "Hello" >@{-1} &&
+	git add @{-1} &&
+	git commit -m "first_commit" &&
+	git checkout -b new_branch &&
+	touch @{-1} &&
+	git add @{-1} &&
+	test_must_fail git reset - 2>actual &&
+	test_cmp ../expect actual
+'
+
+cd ..
+rm -rf new
+
+cat >expect <<EOF
+fatal: ambiguous argument '-': both revision and filename
+Use ./- for file named -
+Use '--' to separate paths from revisions, like this:
+'git <command> [<revision>...] -- [<file>...]'
+EOF
+
+test_expect_success 'reset - with @{-1} and file named - ' '
+	git init new --quiet &&
+	cd new && 
+	echo "Hello" > - &&
+	git add - &&
+	git commit -m "first_commit" &&
+	git checkout -b new_branch &&
+	touch - &&
+	git add - &&
+	test_must_fail git reset - 2>actual &&
+	test_cmp ../expect actual
+'
+
+cd ..
+rm -rf new
+
+test_expect_success 'reset - with @{-1} and file named @{-1} and - ' '
+	git init new --quiet &&
+	cd new &&
+	echo "Hello" > - &&
+	git add - &&
+	git commit -m "first_commit" &&
+	git checkout -b new_branch
+	echo "Hello" >@{-1} &&
+	git add @{-1} &&
+	test_must_fail git reset - 2>actual &&
+	test_cmp ../expect actual
+'
+
+cd ..
+rm -rf new
+
+test_expect_success 'reset - with @{-1} and no file named - or @{-1} ' '
+	git init new --quiet &&
+	cd new &&
+	echo "Hello" >new_file &&
+	git add new_file &&
+	git commit -m "first_commit" &&
+	git checkout -b new_branch &&
+	echo "Hey" >new_file &&
+	git add new_file &&
+	git reset - &&
+	git status -uno >file1 &&
+	git add new_file &&
+	git reset @{-1} &&
+	git status -uno >file2 &&
+	test_cmp file1 file2
+'
+
 test_done
-- 
2.1.0
