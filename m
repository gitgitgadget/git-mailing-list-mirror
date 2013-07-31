From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/11] t8001/t8002: blame: add empty file & partial-line tests
Date: Wed, 31 Jul 2013 04:15:37 -0400
Message-ID: <1375258545-42240-4-git-send-email-sunshine@sunshineco.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 10:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4RaQ-0005zM-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 10:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758951Ab3GaIQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 04:16:37 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:43475 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab3GaIQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 04:16:35 -0400
Received: by mail-yh0-f51.google.com with SMTP id 29so226003yhl.10
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7tm2dBXD6cKb3yeHpz2C8ZulLKqoMNuLJ50kP/KIw1c=;
        b=WeYGUvEzp8Y/0sEk4vLBHL4kkkSJXBVc85lbZWCIMkEhOPI4MPjHbbBsHoQUlOvBws
         4SLjOSQDFc8yNqBoBwxEgC7Ksjvq+KL0LPIiBek+2I43BcO66eNL4S7ZoV9mGLxDhCGu
         zgBMLJpATf1CcJhugqVTQmSR8VXBXdiC/uAuI9mbSZbhFo6Hv7IyQuQOjD0iVMnZoL2+
         6/7uTyjzQfAC9edQnOOKYgh11Uqv76FFEVCX4Wzz9atE70A5OPCxI5XKc8QawnijtOPD
         0RGo/MdJJPLq+cqBNu3Y9GpkUvYGbJIXO8HycpW1FdAIjaTuBbVY8lSGOl2Wqe8y/2rr
         a3PA==
X-Received: by 10.236.192.225 with SMTP id i61mr32170770yhn.13.1375258594694;
        Wed, 31 Jul 2013 01:16:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id i4sm636759yhg.16.2013.07.31.01.16.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 01:16:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231404>

Add boundary case tests, with and without -L, for empty file; file with
one partial line; file with one full line.

The empty file test without -L is of particular interest. Historically,
this case has been supported (empty blame output) and this test protects
against regression by a subsequent patch fixing an off-by-one bug which
incorrectly accepts -LX where X is one past end-of-file.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/annotate-tests.sh | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 02fbbf1..f67332c 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -297,6 +297,78 @@ test_expect_success 'blame -L :nomatch' '
 	test_must_fail $PROG -L:nomatch hello.c
 '
 
+test_expect_success 'setup incremental' '
+	(
+	GIT_AUTHOR_NAME=I &&
+	export GIT_AUTHOR_NAME &&
+	GIT_AUTHOR_EMAIL=I@test.git &&
+	export GIT_AUTHOR_EMAIL &&
+	>incremental &&
+	git add incremental &&
+	git commit -m "step 0" &&
+	printf "partial" >>incremental &&
+	git commit -a -m "step 0.5" &&
+	echo >>incremental &&
+	git commit -a -m "step 1"
+	)
+'
+
+test_expect_success 'blame empty' '
+	check_count -h HEAD^^ -f incremental
+'
+
+test_expect_success 'blame -L 0 empty (undocumented)' '
+	check_count -h HEAD^^ -f incremental -L0
+'
+
+test_expect_failure 'blame -L 1 empty' '
+	test_must_fail $PROG -L1 incremental HEAD^^
+'
+
+test_expect_success 'blame -L 2 empty' '
+	test_must_fail $PROG -L2 incremental HEAD^^
+'
+
+test_expect_success 'blame half' '
+	check_count -h HEAD^ -f incremental I 1
+'
+
+test_expect_success 'blame -L 0 half (undocumented)' '
+	check_count -h HEAD^ -f incremental -L0 I 1
+'
+
+test_expect_success 'blame -L 1 half' '
+	check_count -h HEAD^ -f incremental -L1 I 1
+'
+
+test_expect_failure 'blame -L 2 half' '
+	test_must_fail $PROG -L2 incremental HEAD^
+'
+
+test_expect_success 'blame -L 3 half' '
+	test_must_fail $PROG -L3 incremental HEAD^
+'
+
+test_expect_success 'blame full' '
+	check_count -f incremental I 1
+'
+
+test_expect_success 'blame -L 0 full (undocumented)' '
+	check_count -f incremental -L0 I 1
+'
+
+test_expect_success 'blame -L 1 full' '
+	check_count -f incremental -L1 I 1
+'
+
+test_expect_failure 'blame -L 2 full' '
+	test_must_fail $PROG -L2 incremental
+'
+
+test_expect_success 'blame -L 3 full' '
+	test_must_fail $PROG -L3 incremental
+'
+
 test_expect_success 'blame -L' '
 	test_must_fail $PROG -L file
 '
-- 
1.8.3.4.1120.gc240c48
