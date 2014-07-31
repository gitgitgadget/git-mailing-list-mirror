From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 5/7] add a test for semantic errors in config files
Date: Thu, 31 Jul 2014 02:44:15 -0700
Message-ID: <1406799857-28048-6-git-send-email-tanayabh@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 11:46:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCmvw-0004va-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 11:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbaGaJpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 05:45:53 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57971 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265AbaGaJpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 05:45:52 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so3298899pac.18
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwKxe/PJgLVd6XQAA/TQUZ5UVtNX5M6Pim9n7e92Noo=;
        b=JDZP8Bh2XHnjAoWlp6+uP4CEVliaWu3QlWmxE0VYLbHJ8mUXKP8ElE2AKzR2nKd/bg
         uixs8dt0DsOej/7EM7BN4E/E6WQXYtD8AUBE3NUcxxiAdE+jsDr3aOD+SxtriQMtmEDv
         GasZMrkKbrz9e9FfiLfb+JLBka/9/rcb4CRZsmW9aG61PANwnSm/1VtsNM6d2AFJdRzn
         x2D48wNP0ubpncLI7OncIKR7rJiNR4gFENVMDOl585jAcW0M7QI+0EwgfRKBNvjOL1j9
         8eij8Mg/vSgXl5ewqSkLBnP03Vjs8ypjAUWKr4Eg6Z7w9V9L8i2khtNrLZD+5x70kDhu
         vIpg==
X-Received: by 10.66.158.130 with SMTP id wu2mr2924216pab.59.1406799951877;
        Thu, 31 Jul 2014 02:45:51 -0700 (PDT)
Received: from localhost.localdomain ([106.201.156.106])
        by mx.google.com with ESMTPSA id zq5sm4933551pbb.37.2014.07.31.02.45.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 02:45:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254545>

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
