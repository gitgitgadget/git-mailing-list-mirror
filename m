From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/5] range-set: fix sort_and_merge_range_set() corner case bug
Date: Tue, 23 Jul 2013 10:28:04 -0400
Message-ID: <1374589688-27751-2-git-send-email-sunshine@sunshineco.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 16:28:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1da7-00053l-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 16:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab3GWO2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 10:28:39 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57458 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab3GWO2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 10:28:38 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so10217022obq.21
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hFJnKo4YyVwc3fKqSf58ztHvSatEH33SpsXmPBTT53g=;
        b=MbYulMwBllIC0O5h8ePZwH5mYRfn89T5vmkmryOH3HNLNoL+Dalel2RGqSO9khb7GN
         xkRKpnxEm3H+g/vjqyoof6EAisDG+g7UX8WMNJWe7/IXyKfPUC62OkkqJ1rAlvnr8bB4
         hYFnr0YSbT6IGc45EM0JHh3eQ5ItepOQL59Ck+/EEVCVtMvSQYT3riLRDtabHsSu9vvh
         vRMyWF5ZHJIcTB8Ln9kOyNE/w4W4TTOXDPkGH3r48xjLSRp1TNu2c88aYJoXYTLgltnR
         gEqPFzVhCf1UUBHNsTjdeESRKm22jTAASg/GDoh2CPm41PeJ/wYIpRe2ilcgYeTpG3eE
         1Cdw==
X-Received: by 10.182.66.137 with SMTP id f9mr24698056obt.24.1374589717538;
        Tue, 23 Jul 2013 07:28:37 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id rs4sm40422546obc.10.2013.07.23.07.28.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 07:28:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1120.gc240c48
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231036>

When handed an empty range_set (range_set.nr == 0),
sort_and_merge_range_set() incorrectly sets range_set.nr to 1 at exit.
Subsequent range_set functions then access the bogus range at element
zero and crash or throw an assertion failure. Fix this bug.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This bug could have been fixed with a simple conditional rather than
changing the for() loop to start at 0. I did it this way, however,
because the next fix (range-set: satisfy non-empty ranges invariant)
also needs the for() loop starting at 0. Thus, by changing the for()
loop here, the subsequent fix becomes much more obvious and easy to
read.

 line-log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index 8cc29a0..5234879 100644
--- a/line-log.c
+++ b/line-log.c
@@ -110,12 +110,12 @@ static void range_set_check_invariants(struct range_set *rs)
 static void sort_and_merge_range_set(struct range_set *rs)
 {
 	int i;
-	int o = 1; /* output cursor */
+	int o = 0; /* output cursor */
 
 	qsort(rs->ranges, rs->nr, sizeof(struct range), range_cmp);
 
-	for (i = 1; i < rs->nr; i++) {
-		if (rs->ranges[i].start <= rs->ranges[o-1].end) {
+	for (i = 0; i < rs->nr; i++) {
+		if (o > 0 && rs->ranges[i].start <= rs->ranges[o-1].end) {
 			if (rs->ranges[o-1].end < rs->ranges[i].end)
 				rs->ranges[o-1].end = rs->ranges[i].end;
 		} else {
-- 
1.8.3.4.1120.gc240c48
