From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v9 7/8] add a test for semantic errors in config files
Date: Thu,  7 Aug 2014 04:59:18 -0700
Message-ID: <1407412759-13833-8-git-send-email-tanayabh@gmail.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 14:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFMN8-0005AQ-Be
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 14:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbaHGMAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 08:00:33 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62434 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbaHGMAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 08:00:30 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so5086899pdb.5
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sg10QLJnnYH9A33L2wn72CoD6/2QK4YmgNaal412AuQ=;
        b=ffPym6dOnRLM1bpVp88oXWTr2L4z6ddR5Bw/9SwR9gWD5F2y0l42WyT5LI+9UZMsnu
         9n0KTanEEjxE58t6l2tksw3oykeyaZjIGlH4fuIGrXqlg/U5/H/uq3vqsZPz6HT2hqZA
         xKSbVJi8k0iWKz2AnbZHvAQIl3O9E3Pboh8NV/rXAaGlbvKbL+L+wri8FCHnOdcyZxAf
         26mIl/aBaCH96VEjPzUXOctzEY+ylg8ef0+Az5EWQIph3ZRmkmYJuFLR4kYLs0BMVGE/
         dInqMYvoRJRYwElybsEut1HLpjMI981iZnoLng9Yv4Aa57QBiVJL1dlSp2RQPh/8LSco
         LKmw==
X-Received: by 10.68.132.225 with SMTP id ox1mr6563542pbb.99.1407412829460;
        Thu, 07 Aug 2014 05:00:29 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id cb8sm13997212pad.8.2014.08.07.05.00.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 05:00:28 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254957>

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
index 7fdf840..9cc678d 100755
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
+	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
+'
+
 test_done
-- 
1.9.0.GIT
