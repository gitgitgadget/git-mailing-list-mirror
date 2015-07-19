From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 06/12] t4150: am --resolved fails if index has unmerged entries
Date: Sun, 19 Jul 2015 23:49:12 +0800
Message-ID: <1437320958-11192-7-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqg-0005iY-IF
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbbGSPtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:47 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33560 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbbGSPtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:46 -0400
Received: by pdbnt7 with SMTP id nt7so18594459pdb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Wo3fuKixpASQZSOoSXbFEJcFvgA5ssha7vMjuBoezU=;
        b=Wc4gXQKF7HnwDkJJQIj6Sg6sunPQeY+qJNWhSNG0ezPGVSvVXShtAMhfEb0ZgYMi4i
         GrKhVd1MARDBr9hXKhdjHD2T8koB3Rtz34oZ7MdqTd9U/nlbP7HIdxbDvlU1tgvGUVpq
         cMRpMj02UDDSn7P2O2/Viv04gzd3R+AVZkCvqnrTQYrYTD0El3sZaiHieJGDnRmyhfrL
         wMOCtRn98K8ybMEY4g3bcAB/HM08WC/dYpZjZkUDRtB127mZ0lHFjSeeUF2hRdUuLmY+
         ujWADT/kAsYv65R+0QOFNEMp+dy+FJddRn0wQe8p9LEpw9rztEFwoDE0VmnQfHHQF6LZ
         Qhdg==
X-Received: by 10.66.132.16 with SMTP id oq16mr26449775pab.13.1437320985474;
        Sun, 19 Jul 2015 08:49:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274218>

Since c1d1128 (git-am --resolved: more usable error message.,
2006-04-28), git-am --resolved will check to see if there are any
unmerged entries, and will error out with a user-friendly error message
if there are.

Add a test for this.

Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t4150-am.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 430ae71..c1ec4d5 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -437,6 +437,19 @@ test_expect_success 'am --resolved fails if index has no changes' '
 	test_cmp_rev lorem2^^ HEAD
 '
 
+test_expect_success 'am --resolved fails if index has unmerged entries' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	test_must_fail git am -3 lorem-move.patch &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	test_must_fail git am --resolved >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	test_i18ngrep "still have unmerged paths" err
+'
+
 test_expect_success 'am takes patches from a Pine mailbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.5.0.rc2.110.gf2a5fc6
