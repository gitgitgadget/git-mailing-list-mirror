From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/5] line-log: fix "log -LN" crash when N is last line of file
Date: Tue, 23 Jul 2013 10:28:08 -0400
Message-ID: <1374589688-27751-6-git-send-email-sunshine@sunshineco.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 16:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1daA-00053l-DV
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694Ab3GWO2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:28:49 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:65503 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3GWO2r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:28:47 -0400
Received: by mail-oa0-f49.google.com with SMTP id n12so6632998oag.8
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Xd3+6/6mOkKyEVAUsHuccj4LDJp6C4rBZ+jnfmJg73Q=;
        b=pLX3+hCZJqL7EIqcl6rzDJ533j4+tR2nQNs3Hb3KIeWmWkWsy/fsLw4FBdLrO0F7Wl
         /8vRGnC6ue26O0kjRu0hQB9Y2r2rCMuZJoQ09LmpLCiNU+xwgQmnXSqLGjOwrJblP4OY
         VwRi9d8bubgwfP2NXJbvGme6Yx3T9BnN8+GTuVA/K3lmXDymS7dwRyaEkiQomoJukyxF
         NH+XQRgPoyoNOGVJVg/rpSMqkn83yWJMW19bHCegNcQh3Y4Us+KS8uftEEXAqUx5fDVz
         RXkWxrmEgEE8Z3VFHoEQBowkfgtgJ/jrETefomR6p++Ycxsleqd/JOXEGHiJjakab5am
         AuBQ==
X-Received: by 10.182.171.7 with SMTP id aq7mr24593229obc.103.1374589725485;
        Tue, 23 Jul 2013 07:28:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id rs4sm40422546obc.10.2013.07.23.07.28.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 07:28:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231040>

range-set invariants are: ranges must be (1) non-empty, (2) disjoint,
(3) sorted in ascending order.

line_log_data_insert() breaks the non-empty invariant under the
following conditions: the incoming range is empty and the pathname
attached to the range has not yet been encountered. In this case,
line_log_data_insert() assigns the empty range to a new line_log_data
record without taking any action to ensure that the empty range is
eventually folded out.  Subsequent range-set functions crash or throw an
assertion failure upon encountering such an anomaly.  Fix this bug.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-log.c          | 1 +
 t/t4211-line-log.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 6f94d56..c2d01dc 100644
--- a/line-log.c
+++ b/line-log.c
@@ -299,6 +299,7 @@ static void line_log_data_insert(struct line_log_data **list,
 	p = xcalloc(1, sizeof(struct line_log_data));
 	p->path = path;
 	range_set_append(&p->ranges, begin, end);
+	sort_and_merge_range_set(&p->ranges);
 	if (ip) {
 		p->next = ip->next;
 		ip->next = p;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 7616365..94267d7 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -72,7 +72,7 @@ test_expect_success '-L {empty-range} (any -L)' '
 	git log -L1,1:b.c -L$n:b.c
 '
 
-test_expect_failure '-L {empty-range} (first -L)' '
+test_expect_success '-L {empty-range} (first -L)' '
 	n=$(expr $(cat b.c | wc -l) + 1) &&
 	git log -L$n:b.c
 '
-- 
1.8.3.4.1120.gc240c48
