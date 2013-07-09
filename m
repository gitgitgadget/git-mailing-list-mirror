From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] range_set: fix coalescing bug when range is a subset of another
Date: Tue,  9 Jul 2013 01:55:05 -0400
Message-ID: <1373349305-63917-3-git-send-email-sunshine@sunshineco.com>
References: <1373349305-63917-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 07:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQtg-0008KF-EV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab3GIFz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:55:29 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:49494 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab3GIFz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:55:28 -0400
Received: by mail-gh0-f180.google.com with SMTP id f18so1885575ghb.25
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BjcKXF7PPQDewmASMEm1F+99Ap6mb/f9Ejvdl7KpZmw=;
        b=jTwctxhEmTEtqLFVUqaQfGVDwjTua3T43TwF9OPJ8t7MLa2p0xmb7Mgrg8eyFiyfzI
         VfNZ2spzSKYtdjCKsdk8+pinPxSpCvpkLE7Gqnc9rup1cJztTrr+GJOZ4Di5ddGr03AX
         YqVqptHhD31ZuVxhNa0i3gunHzFDqvOMXajsSm0jNA1Rrb9piVpU/cq9IhPMR9siTSWV
         DVr6uxcKxO1jSYsPH+WckGfLZstHMtHsRB3UDbBmEAEOIRVX9asr+ep7rgkHKxbt6AkO
         ZKD9nvfLMuZVQFk1grW0WA4jbHGoS3Sa0XsRZCne5hsj/lwGM0YhJwRoEKluO/AxuOZT
         DP8g==
X-Received: by 10.236.209.65 with SMTP id r41mr14016576yho.252.1373349327545;
        Mon, 08 Jul 2013 22:55:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id e69sm42754928yhl.3.2013.07.08.22.55.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 22:55:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373349305-63917-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229915>

When coalescing ranges, sort_and_merge_range_set() unconditionally
assumes that the end of a range being folded into a preceding range
should become the end of the coalesced range. This assumption, however,
is invalid when one range is a subset of another.  For example, given
ranges 1-5 and 2-3 added via range_set_append_unsafe(),
sort_and_merge_range_set() incorrectly coalesces them to range 1-3
rather than the correct union range 1-5. Fix this bug.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 line-log.c          | 3 ++-
 t/t4211-line-log.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index 4bbb09b..8cc29a0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -116,7 +116,8 @@ static void sort_and_merge_range_set(struct range_set *rs)
 
 	for (i = 1; i < rs->nr; i++) {
 		if (rs->ranges[i].start <= rs->ranges[o-1].end) {
-			rs->ranges[o-1].end = rs->ranges[i].end;
+			if (rs->ranges[o-1].end < rs->ranges[i].end)
+				rs->ranges[o-1].end = rs->ranges[i].end;
 		} else {
 			rs->ranges[o].start = rs->ranges[i].start;
 			rs->ranges[o].end = rs->ranges[i].end;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 549df9e..7776f93 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -50,8 +50,8 @@ canned_test "-M -L ':f:b.c' parallel-change" parallel-change-f-to-main
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
 canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
 canned_test "-L :main:a.c -L 4,18:a.c simple" multiple-overlapping
-canned_test_failure "-L 4:a.c -L 8,12:a.c simple" multiple-superset
-canned_test_failure "-L 8,12:a.c -L 4:a.c simple" multiple-superset
+canned_test "-L 4:a.c -L 8,12:a.c simple" multiple-superset
+canned_test "-L 8,12:a.c -L 4:a.c simple" multiple-superset
 
 test_bad_opts "-L" "switch.*requires a value"
 test_bad_opts "-L b.c" "argument.*not of the form"
-- 
1.8.3.2
