From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/5] range-set: satisfy non-empty ranges invariant
Date: Tue, 23 Jul 2013 10:28:06 -0400
Message-ID: <1374589688-27751-4-git-send-email-sunshine@sunshineco.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 16:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1da9-00053l-B3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560Ab3GWO2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:28:43 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:51598 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3GWO2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:28:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so10359608obb.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=03wtUJdTEWbUUPELK8yHyq4T0EsNzktOtzri4LU6Nf4=;
        b=g/pk1CpdCyxcSXgsYCLyOj1yoKmb3y6BU5hT5NCzd7XXdMhj2IplvOy22mfM5QuqO9
         GbaUc/NiQPX3q2R0wowjlPsb5efPUPXXls1S/21fe3V77Dxkt787W0Bk9uz1+KJPprlW
         NxHfkhfKJKHke1AhnjkPFvU+ML6MVH1QCeqfAjP22121Ka7Pg4SwIIcmOjMfjDC2x/y8
         TuYuhZaeA7vkb2RtjbWYxoHWamwV+u/iMuMYfCwEDKKfPmtJjiWlMDWD1QAbUVr4JQMM
         B6niOyEXZcksGywGXwcCsN6p6y/ItOuh/NkYyS/9TR8KMpD5vamezf5N8exEW2e5o+5f
         OCFA==
X-Received: by 10.60.92.165 with SMTP id cn5mr31069141oeb.53.1374589721480;
        Tue, 23 Jul 2013 07:28:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id rs4sm40422546obc.10.2013.07.23.07.28.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 07:28:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231039>

range-set invariants are: ranges must be (1) non-empty, (2) disjoint,
(3) sorted in ascending order.

During processing, various range-set utility functions break the
invariants (for instance, by adding empty ranges), with the
expectation that a finalizing sort_and_merge_range_set() will restore
sanity.

sort_and_merge_range_set(), however, neglects to fold out empty
ranges, thus it fails to satisfy the non-empty constraint. Subsequent
range-set functions crash or throw an assertion failure upon
encountering such an anomaly. Rectify the situation by having
sort_and_merge_range_set() fold out empty ranges.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-log.c          | 2 ++
 t/t4211-line-log.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 5234879..6f94d56 100644
--- a/line-log.c
+++ b/line-log.c
@@ -115,6 +115,8 @@ static void sort_and_merge_range_set(struct range_set *rs)
 	qsort(rs->ranges, rs->nr, sizeof(struct range), range_cmp);
 
 	for (i = 0; i < rs->nr; i++) {
+		if (rs->ranges[i].start == rs->ranges[i].end)
+			continue;
 		if (o > 0 && rs->ranges[i].start <= rs->ranges[o-1].end) {
 			if (rs->ranges[o-1].end < rs->ranges[i].end)
 				rs->ranges[o-1].end = rs->ranges[i].end;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1db1edd..12814c0 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -67,7 +67,7 @@ test_bad_opts "-L :foo:b.c" "no match"
 # There is a separate bug when an empty -L range is the first -L encountered,
 # thus to demonstrate this particular bug, the empty -L range must follow a
 # non-empty -L range.
-test_expect_failure '-L {empty-range} (any -L)' '
+test_expect_success '-L {empty-range} (any -L)' '
 	n=$(expr $(cat b.c | wc -l) + 1) &&
 	git log -L1,1:b.c -L$n:b.c
 '
-- 
1.8.3.4.1120.gc240c48
