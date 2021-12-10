Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2CCC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 11:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhLJLpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 06:45:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:48712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233311AbhLJLpB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 06:45:01 -0500
Received: (qmail 18549 invoked by uid 109); 10 Dec 2021 11:41:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 11:41:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30449 invoked by uid 111); 10 Dec 2021 11:41:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 06:41:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 06:41:25 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Message-ID: <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
 <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 11:22:59AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Dropping the st_mult() does nothing to fix the actual problem (which is
> > that this function should use a more appropriate type), but introduces
> > new failure modes.
> 
> Yes you're entirely right. I had some stupid blinders on while writing
> this. FWIW I think I was experimenting with some local macros and
> conflated a testing of the overflow of n*n in gdb with the caste'd
> version, which you rightly point out here won't have the overflow issue
> at all. Sorry.

I'm not sure if this is helpful or not, but this is the minimal fix I
came up with that runs the testcase I showed earlier. It's basically
just swapping out "int" for "ssize_t" for any variables we use to index
the arrays (though note a few are themselves held in arrays, and we have
to cross some function boundaries).

I won't be surprised if it doesn't hit all cases, or if it even hits a
few it doesn't need to (e.g., should "phase" be dragged along with "i"
and "j" in the first hunk?). I mostly did guess-and-check on the
test-case, fixing whatever segfaulted and then running again until it
worked. I didn't even really read the code very carefully.

I think you _did_ do more of that careful reading, and broke down the
refactorings into separate patches in your series. Which is good. So I
think what we'd want is to pick out those parts of your series that end
up switching the variable type. My goal in sharing this here is just to
show that the end result of the fix can (and IMHO should) be around this
same order of magnitude.

---
diff --git a/linear-assignment.c b/linear-assignment.c
index ecffc09be6..3efa30c50b 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -13,11 +13,11 @@
  * i is `cost[j + column_count * i].
  */
 void compute_assignment(int column_count, int row_count, int *cost,
-			int *column2row, int *row2column)
+			ssize_t *column2row, ssize_t *row2column)
 {
 	int *v, *d;
 	int *free_row, free_count = 0, saved_free_count, *pred, *col;
-	int i, j, phase;
+	ssize_t i, j, phase;
 
 	if (column_count < 2) {
 		memset(column2row, 0, sizeof(int) * column_count);
@@ -31,7 +31,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 
 	/* column reduction */
 	for (j = column_count - 1; j >= 0; j--) {
-		int i1 = 0;
+		ssize_t i1 = 0;
 
 		for (i = 1; i < row_count; i++)
 			if (COST(j, i1) > COST(j, i))
@@ -51,7 +51,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	/* reduction transfer */
 	ALLOC_ARRAY(free_row, row_count);
 	for (i = 0; i < row_count; i++) {
-		int j1 = row2column[i];
+		ssize_t j1 = row2column[i];
 		if (j1 == -1)
 			free_row[free_count++] = i;
 		else if (j1 < -1)
@@ -74,13 +74,13 @@ void compute_assignment(int column_count, int row_count, int *cost,
 
 	/* augmenting row reduction */
 	for (phase = 0; phase < 2; phase++) {
-		int k = 0;
+		ssize_t k = 0;
 
 		saved_free_count = free_count;
 		free_count = 0;
 		while (k < saved_free_count) {
 			int u1, u2;
-			int j1 = 0, j2, i0;
+			ssize_t j1 = 0, j2, i0;
 
 			i = free_row[k++];
 			u1 = COST(j1, i) - v[j1];
@@ -130,7 +130,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	ALLOC_ARRAY(pred, column_count);
 	ALLOC_ARRAY(col, column_count);
 	for (free_count = 0; free_count < saved_free_count; free_count++) {
-		int i1 = free_row[free_count], low = 0, up = 0, last, k;
+		ssize_t i1 = free_row[free_count], low = 0, up = 0, last, k;
 		int min, c, u1;
 
 		for (j = 0; j < column_count; j++) {
@@ -192,7 +192,7 @@ void compute_assignment(int column_count, int row_count, int *cost,
 		/* augmentation */
 		do {
 			if (j < 0)
-				BUG("negative j: %d", j);
+				BUG("negative j: %"PRIdMAX, (intmax_t)j);
 			i = pred[j];
 			column2row[j] = i;
 			SWAP(j, row2column[i]);
diff --git a/linear-assignment.h b/linear-assignment.h
index 1dfea76629..7005521d61 100644
--- a/linear-assignment.h
+++ b/linear-assignment.h
@@ -14,7 +14,7 @@
  * row_count).
  */
 void compute_assignment(int column_count, int row_count, int *cost,
-			int *column2row, int *row2column);
+			ssize_t *column2row, ssize_t *row2column);
 
 /* The maximal cost in the cost matrix (to prevent integer overflows). */
 #define COST_MAX (1<<16)
diff --git a/range-diff.c b/range-diff.c
index cac89a2f4f..f1e1e27bf9 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -308,9 +308,10 @@ static int diffsize(const char *a, const char *b)
 static void get_correspondences(struct string_list *a, struct string_list *b,
 				int creation_factor)
 {
-	int n = a->nr + b->nr;
-	int *cost, c, *a2b, *b2a;
-	int i, j;
+	size_t n = a->nr + b->nr;
+	int *cost, c;
+	ssize_t *a2b, *b2a;
+	size_t i, j;
 
 	ALLOC_ARRAY(cost, st_mult(n, n));
 	ALLOC_ARRAY(a2b, n);
