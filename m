From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v8 7/8] add a test for semantic errors in config files
Date: Wed,  6 Aug 2014 07:53:11 -0700
Message-ID: <1407336792-16962-8-git-send-email-tanayabh@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 17:01:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2iM-0000Os-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbaHFPBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 11:01:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56238 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbaHFPBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:01:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3451282pde.37
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6J84A8d7SA4s+ioXYwDFc2Ho0m6XtdpdzFEBl94j3r8=;
        b=NkKU59G/Z56VYd1GKowzLMVnhB89EECsE0CUMT2RnPcBcPdyjdPP4rlvqwwPf5K7Nl
         6wyPyVA7H2x2UzkFOvx/Vx8dTkJ5JpkBxTraq1iIerPxxUhLwRs/FFR1CBm6xlnNhIq0
         UDCzswFanfRYxtbj0LIiqcswJDkp43qpAi50FdXFvhhe2elusYIvK/OevdIgoFAP0z7d
         8VxAxK82w6Ardoz4qvLTCQ4BcUF9LeRzSh7SnKnV+YOylU0TBiMhWKRHt0QeubUT4tPU
         yUcA4R+J7o4HIRRb8kdpyjkTrBb4AdJhzJUeQcvKhxCdOOPW1sZdwoCXAKa8VxEwfC6M
         pF4Q==
X-Received: by 10.67.14.193 with SMTP id fi1mr11850268pad.17.1407337269466;
        Wed, 06 Aug 2014 08:01:09 -0700 (PDT)
Received: from localhost.localdomain ([223.176.214.188])
        by mx.google.com with ESMTPSA id u2sm1547305pbs.42.2014.08.06.08.01.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:01:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254862>

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
index 7fdf840..5ea0aa4 100755
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
+	grep "line 2.*.git/config\|.git/config.*line 2" result
+'
+
 test_done
-- 
1.9.0.GIT
