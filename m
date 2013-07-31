From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/11] t8001/t8002: blame: decompose overly-large test
Date: Wed, 31 Jul 2013 04:15:35 -0400
Message-ID: <1375258545-42240-2-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4RaH-0005ts-U3
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785Ab3GaIQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:33 -0400
Received: from mail-gh0-f171.google.com ([209.85.160.171]:42563 "EHLO
	mail-gh0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab3GaIQb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:31 -0400
Received: by mail-gh0-f171.google.com with SMTP id f15so176032ghb.30
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0F6L16hQWgJfGcL0ipI0BV2kCiGaztRH8tdWmgaQ3T0=;
        b=03ilnYrlf9/BAQlXnpGNi2z8BLzfwRF17HIOMVwTvPuJfQh/CyoFanT1mighveUIdx
         ikipAkMVkzWYbrQq/cpJ/GmDYPYyy3Hvkxv5jr9a1eXbvht7layel5MgZWc3eObZNTx8
         NK/I4NxSgiOexOcxDXHzk02+elqwHgSAp76gsExshZrQGc3il/r7NfUdqMJTVIVH7sao
         aB52qU+8FHsYiVcRyL69Z4lgz7t+Xpq44cGVA/C7DDseCDSyNxUufbMvaaMtkxtyLfi0
         99mrrdO0wk2i0bfPX6AgjSmAvar0JjRvbl8srPwEjEe1zsodDNFq1i96vdyTiLgfEHwT
         4B4g==
X-Received: by 10.236.118.144 with SMTP id l16mr15359183yhh.84.1375258590692;
        Wed, 31 Jul 2013 01:16:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231401>

Checking all bogus -L syntax forms in a single test makes it difficult
to identify the offender when one case fails. Decompose this
conglomerate test in order to check each bad syntax case separately.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 0bfee00..3524eaf 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -275,12 +275,30 @@ test_expect_success 'blame -L :nomatch' '
 	test_must_fail $PROG -L:nomatch hello.c
 '
 
-test_expect_success 'blame -L bogus' '
-	test_must_fail $PROG -L file &&
-	test_must_fail $PROG -L1,+ file &&
-	test_must_fail $PROG -L1,- file &&
-	test_must_fail $PROG -LX file &&
-	test_must_fail $PROG -L1,X file &&
-	test_must_fail $PROG -L1,+N file &&
+test_expect_success 'blame -L' '
+	test_must_fail $PROG -L file
+'
+
+test_expect_success 'blame -L X,+' '
+	test_must_fail $PROG -L1,+ file
+'
+
+test_expect_success 'blame -L X,-' '
+	test_must_fail $PROG -L1,- file
+'
+
+test_expect_success 'blame -L X (non-numeric X)' '
+	test_must_fail $PROG -LX file
+'
+
+test_expect_success 'blame -L X,Y (non-numeric Y)' '
+	test_must_fail $PROG -L1,Y file
+'
+
+test_expect_success 'blame -L X,+N (non-numeric N)' '
+	test_must_fail $PROG -L1,+N file
+'
+
+test_expect_success 'blame -L X,-N (non-numeric N)' '
 	test_must_fail $PROG -L1,-N file
 '
-- 
1.8.3.4.1120.gc240c48
