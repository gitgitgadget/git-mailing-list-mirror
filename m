From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v6 5/7] add a test for semantic errors in config files
Date: Thu, 31 Jul 2014 08:47:40 -0700
Message-ID: <1406821662-1570-6-git-send-email-tanayabh@gmail.com>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 17:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCsbC-0008KP-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 17:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbaGaPsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 11:48:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:54737 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaGaPsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 11:48:50 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so3698840pdj.22
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwKxe/PJgLVd6XQAA/TQUZ5UVtNX5M6Pim9n7e92Noo=;
        b=IlIDzXiKT45Fp3g/HipBPbUgQmMquMqcDECPCT/+tvoXqoJ3X2SyzGta4Tn8fmMWuA
         fyzK47HRayAMA0+lFbH9jD8ZJiNo0pLawqo/P4XYDTkKEnL5kz2ppdPLJMjP45ExEeIw
         272izRZ74NemWaGeEpMAVLwSerBW6qTubH/qlDTVmmu/3YJSPJp7TU9sjS2ISMnXluTW
         jJfoycjMf6vatGpBTzZ9QHI7vv8zaowbFPHhS7r5PWZp81/8b0myHAc29REqGbsdEMmO
         /1WUb7UaS2YOJFOH66Db9cO1z9jFpHraUXLh7Uf9IgNZCMS3JcV9H6/F18Q73Vzk97Wh
         CNOQ==
X-Received: by 10.68.130.97 with SMTP id od1mr4830680pbb.148.1406821730123;
        Thu, 31 Jul 2014 08:48:50 -0700 (PDT)
Received: from localhost.localdomain ([223.229.21.143])
        by mx.google.com with ESMTPSA id n16sm8837555pdj.41.2014.07.31.08.48.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 08:48:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254582>

Semantic errors (for example, for alias.* variables NULL values are
not allowed) in configuration files cause a die printing the line
number and file name of the offending value.

Add a test documenting that such errors cause a die printing the
accurate line number and file name.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7fdf840..e2f9d0b 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -197,4 +197,15 @@ test_expect_success 'proper error on error in custom config files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check line errors for malformed values' '
+	mv .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	cat >.git/config <<-\EOF &&
+	[alias]
+		br
+	EOF
+	test_expect_code 128 git br 2>result &&
+	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result
+'
+
 test_done
-- 
1.9.0.GIT
