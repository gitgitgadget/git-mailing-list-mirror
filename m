From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/16] range-set: publish API for re-use by git-blame -L
Date: Tue,  6 Aug 2013 09:59:36 -0400
Message-ID: <1375797589-65308-4-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hob-0003Su-58
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400Ab3HFOAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:34 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36100 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab3HFOAb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:31 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so892365obb.23
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R7p6Uv9GrMOUMas5ASzr7EcMGBgAS4niXBwarxb6Pn8=;
        b=cLtFtTfEfPRGJ8J4aF6JF561hdbjoJO21+hMLJAke65p0+2Cbmbz5HgCGOVItt+VqO
         wMTcxCmR64G6+2LBPkKoCRpd+aGtHeHhq6xjjGYWwm6RNYEMrPv9IiHOP2UecYcR6H3W
         ADQvQEO+CFmu3FXnQS3lMZV3RgcvcY2ccXLMUpTsU6WTce7OrqNSn/9ehjg7lBJH5TYb
         asSKFhZ1iwcOg/0TxuDZD5w7eyk2xqaYJOc+x1fAigBwrVJMkJa9xS/+bwF5oo6O3Iv1
         XAuE+3m3d1FXnL12WA5botEmbeNjGhcb+3bo8qYOSwRtH3GqvTRHzSPlnV9o+CKSziVn
         BNNw==
X-Received: by 10.60.161.136 with SMTP id xs8mr1085313oeb.77.1375797630539;
        Tue, 06 Aug 2013 07:00:30 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231741>

git-blame is slated to accept multiple -L ranges.  git-log already
accepts multiple -L's but its implementation of range-set, which
organizes and normalizes -L ranges, is private.  Publish the small
subset of range-set API which is needed for git-blame multiple -L
support.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Since range-set is generic -- not at all specific to -L line ranges -- a
future patch series may want to publish the entire API, move the
implementation to its own file, and add documentation and full unit-test
coverage, however, such a topic is orthogonal to the present series
which adds multiple -L support to git-blame.

 line-log.c | 10 +++++-----
 line-log.h | 12 ++++++++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/line-log.c b/line-log.c
index 1c3ac8d..bdadf35 100644
--- a/line-log.c
+++ b/line-log.c
@@ -23,7 +23,7 @@ static void range_set_grow(struct range_set *rs, size_t extra)
 /* Either initialization would be fine */
 #define RANGE_SET_INIT {0}
 
-static void range_set_init(struct range_set *rs, size_t prealloc)
+void range_set_init(struct range_set *rs, size_t prealloc)
 {
 	rs->alloc = rs->nr = 0;
 	rs->ranges = NULL;
@@ -31,7 +31,7 @@ static void range_set_init(struct range_set *rs, size_t prealloc)
 		range_set_grow(rs, prealloc);
 }
 
-static void range_set_release(struct range_set *rs)
+void range_set_release(struct range_set *rs)
 {
 	free(rs->ranges);
 	rs->alloc = rs->nr = 0;
@@ -56,7 +56,7 @@ static void range_set_move(struct range_set *dst, struct range_set *src)
 }
 
 /* tack on a _new_ range _at the end_ */
-static void range_set_append_unsafe(struct range_set *rs, long a, long b)
+void range_set_append_unsafe(struct range_set *rs, long a, long b)
 {
 	assert(a <= b);
 	range_set_grow(rs, 1);
@@ -65,7 +65,7 @@ static void range_set_append_unsafe(struct range_set *rs, long a, long b)
 	rs->nr++;
 }
 
-static void range_set_append(struct range_set *rs, long a, long b)
+void range_set_append(struct range_set *rs, long a, long b)
 {
 	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
 	range_set_append_unsafe(rs, a, b);
@@ -107,7 +107,7 @@ static void range_set_check_invariants(struct range_set *rs)
  * In-place pass of sorting and merging the ranges in the range set,
  * to establish the invariants when we get the ranges from the user
  */
-static void sort_and_merge_range_set(struct range_set *rs)
+void sort_and_merge_range_set(struct range_set *rs)
 {
 	int i;
 	int o = 0; /* output cursor */
diff --git a/line-log.h b/line-log.h
index 8bea45f..a9212d8 100644
--- a/line-log.h
+++ b/line-log.h
@@ -25,6 +25,18 @@ struct diff_ranges {
 	struct range_set target;
 };
 
+extern void range_set_init(struct range_set *, size_t prealloc);
+extern void range_set_release(struct range_set *);
+/* Range includes start; excludes end */
+extern void range_set_append_unsafe(struct range_set *, long start, long end);
+/* New range must begin at or after end of last added range */
+extern void range_set_append(struct range_set *, long start, long end);
+/*
+ * In-place pass of sorting and merging the ranges in the range set,
+ * to sort and make the ranges disjoint.
+ */
+extern void sort_and_merge_range_set(struct range_set *);
+
 /* Linked list of interesting files and their associated ranges.  The
  * list must be kept sorted by path.
  *
-- 
1.8.4.rc1.409.gbd48715
