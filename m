From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 7/8] add a test for semantic errors in config files
Date: Fri,  1 Aug 2014 10:05:55 -0700
Message-ID: <1406912756-15517-8-git-send-email-tanayabh@gmail.com>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:07:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGIZ-0002Go-KR
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbaHARHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:07:11 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45095 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbaHARHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:07:09 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so6149576pab.29
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwKxe/PJgLVd6XQAA/TQUZ5UVtNX5M6Pim9n7e92Noo=;
        b=yBHpUn9ceF2MVWAlk/hNulBogQLC6ChkvuqjgGJg9+gVXMwtUxzy6ATZnBi+5UXcnR
         wIEqVYd9DEZi+skyjnnss1oru4llYGdeoR/5LPxYUtwS5J29j4LrB1G/0KlbAc1qNQRv
         ICXx+XiE9p+OcKEhFen7lSLyG9HxyY/ebCHIITxdUwEbl3lPoS2cePvmDhYRVX0un7wq
         KByGgm6NC15vpCFR8NHAd1HXqzCobUawCM5ZrcStmtJgI29mrGvBElGWbDJEgu23spfk
         xVOqcnhQ/j7eq9WWAwsfKKa6vm5fWlUsggViTW0RH1y7O0x8Tm1tal7X11LobSVqCMac
         Ufyw==
X-Received: by 10.68.203.67 with SMTP id ko3mr7838617pbc.160.1406912828551;
        Fri, 01 Aug 2014 10:07:08 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.07.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:07:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254640>

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
