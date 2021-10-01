Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A851FC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0461A58
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352971AbhJAJY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:24:29 -0400
Received: from mout.web.de ([217.72.192.78]:59429 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353029AbhJAJY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633080160;
        bh=n6w4CQLItzfHt8jF9AaXDRlMbTIUhOmaWfuK+45V/ZY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Gl166SaDW/8teCBMJolsQBg61BBMZXxyIz77WguyE4UB/JLzIeCXhATFHia++y5Ti
         9S/lcR4ZFwTkryCEj1gMUBXVvkwhmh9KSgPMB30ODvzQwnDPHPhLzJYxRXmqO7O3br
         bM7fLZ9q1hSCjxcoDIaPq1QDyG+4xI4PkHxgf088=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lzb94-1mrUjN3nYA-014n1g; Fri, 01 Oct 2021 11:22:39 +0200
Subject: [PATCH 9/9] mergesort: use ranks stack
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <636647b1-f666-f1e2-4127-ee0869b61036@web.de>
Date:   Fri, 1 Oct 2021 11:22:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lG3kJnx3Irmf/74D4oFxLWoTbugUMEJcVZzJ+md1uNpeEeoz/mB
 Jw2Fg1Sp+9As9ktKHQc9NtccVt1uxKM6Q7neIIPFju0uXu0R2zG3yM3J6Yr8AU4FbUJgYqc
 Ds7kXzjVIc6NwO3q2lJdbjkf11ywtnybCpNAiX82mL9no1xI3zRPYadR/65pjlWTZjgpPSq
 Cpu8mQshaIunIT3wXHnQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:claqsnqsrNs=:RQNoA9gwDSRRhS/MuZSpiD
 4QIIqdP6fMmnEHmKLm4e4Gp1VWEZVFbFcTw0o/Kj2WdUlcgExxwoYDq+8uiZX1iA8NPrRxXI5
 nJZgIJU0ZF+JTrJ0ZUS6bUktjE+Q+oN/Yl4KQEAqvxUxG/q3kJUeO5zqCvzc2uMCaWAz/cXt6
 3Mxbghmo3ZWPHtKHKGhNTc4lRXGg9pFIoK7CyPCxmqLoXYTicpVKDL8AZ7iVZQ3LntBq4cT0Y
 GAmwrMOlAzMuhMinzLl1HBOe7ov2/XeuGCba/OOHARhyzs3ScZEGxwtLkYLYoSKDf6Md1iSnH
 VIqfF+7LSqsKxTs6zF5adzWPMUW+3Pa992ap45pzUkds+lcE/Jt7zrBQSNYAmgTTHOCQioQ79
 uFXJPrkUGc3YSmtnYRFlJTxkaKqzVvHGwoSzIp0bR3irc9P4lZJ5FuD/YaBwPEHlcI3c3jt8U
 ROnyyqGCN7OfkZP6vTsvASFNRg5gNOnwBnBJBj2vcr1LwQSo2e4V/BFMF1hjepbm2ioTa+Yx0
 fy6iQB+d4gZtSXtwfaFvfytQDblf2AlYqLehbHzvgJH4fKf23BY0QEr5tK5AsLDfL0MdaDddf
 5ZlQbv1rXI+CTzzvEzdGUq6m8zJxql/fsIzWIOXtbYoz2lrne/4PEnCiaV4bVUQ4XPGkmQhES
 XH48R5Gd4z1PJPP3PfnkpS9BCo1NSFV6MBmQ8BOTyVRge/UpqJHFlQrU4O+9ZeHTKqtsR++Iy
 kPYZyQvqvTGCZjWoVR7B5vECztbILUeIXtOvk96kCZZhXHRY7JaYlfkdhMAnq+1nkNRim4ye/
 HrHGM7UmMiZtjCEcvUGlyr/D5/loeIWlHWwam5ExagllSSKNodH7usE1XD8qlSGdo48XeaQnP
 NTbm4fsxY566wfUdqEujGeUDJQtVEYQb5RAt4YIgryKr0EqQ+MAkyFuhYSsfo+M6yDCJNCRcq
 U8iNSbO8fKwRC764QSfSCOQTpzrPrJc1z3Cz/NiKTOzxFKprvttzqwwUk2eeBiKQstHZ1vMjo
 yydFks+q1BMuan3NmJHbC6omYCU3c8ZIIbf3G88sE/cV7HC2QJPBV67yGymm2ITCGST5MJBE0
 dxIOeDnnXEin5A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bottom-up mergesort implementation needs to skip through sublists a
lot.  A recursive version could avoid that, but would require log2(n)
stack frames.  Explicitly manage a stack of sorted sublists of various
lengths instead to avoid fast-forwarding while also keeping a lid on
memory usage.

While this patch was developed independently, a ranks stack is also used
in https://github.com/mono/mono/blob/master/mono/eglib/sort.frag.h by
the Mono project.

The idea is to keep slots for log2(n_max) sorted sublists, one for each
power of 2.  Such a construct can accommodate lists of any length up to
n_max.  Since there is a known maximum number of items (effectively
SIZE_MAX), we can preallocate the whole rank stack.

We add items one by one, which is akin to incrementing a binary number.
Make use of that by keeping track of the number of items and check bits
in it instead of checking for NULL in the rank stack when checking if a
sublist of a certain rank exists, in order to avoid memory accesses.

The first item can go into the empty first slot as a sublist of length
2^0.  The second one needs to be merged with the previous sublist and
the result goes into the empty second slot as a sublist of length 2^1.
The third one goes into vacated first slot and so on.  At the end we
merge all the sublists to get the result.

The new version still performs a stable sort by making sure to put items
seen earlier first when the compare function indicates equality.  That's
done by preferring items from sublists with a higher rank.

The new merge function also tries to minimize the number of operations.
Like blame.c::blame_merge(), the function doesn't set the next pointer
if it already points to the right item, and it exits when it reaches the
end of one of the two sublists that it's given.  The old code couldn't
do the latter because it kept all items in a single list.

The number of comparisons stays the same, though.  Here's example output
of "test-tool mergesort test" for the rand distributions with the most
number of comparisons with the ranks stack:

   $ t/helper/test-tool mergesort test | awk '
       NR > 1 && $1 !=3D "rand" {next}
       $7 > max[$3] {max[$3] =3D $7; line[$3] =3D $0}
       END {for (n in line) print line[n]}
   '

distribut mode                    n        m get_next set_next  compare ve=
rdict
rand      copy                  100       32      669      420      569 OK
rand      dither               1023       64     9997     5396     8974 OK
rand      dither               1024      512    10007     6159     8983 OK
rand      dither               1025      256    10993     5988     9968 OK

Here are the differences to the results without this patch:

distribut mode                    n        m get_next set_next  compare
rand      copy                  100       32     -515     -280        0
rand      dither               1023       64    -6376    -4834        0
rand      dither               1024      512    -6377    -4081        0
rand      dither               1025      256    -7461    -5287        0

The numbers of get_next and set_next calls are reduced significantly.

NB: These winners are different than the ones shown in the patch that
introduced the unriffle mode because the addition of the unriffle_skewed
mode in between changed the consumption of rand() values.

Here are the distributions with the most comparisons overall with the
ranks stack:

   $ t/helper/test-tool mergesort test | awk '
       $7 > max[$3] {max[$3] =3D $7; line[$3] =3D $0}
       END {for (n in line) print line[n]}
   '

distribut mode                    n        m get_next set_next  compare ve=
rdict
sawtooth  unriffle_skewed       100      128      689      632      589 OK
sawtooth  unriffle_skewed      1023     1024    10230    10220     9207 OK
sawtooth  unriffle             1024     1024    10241    10240     9217 OK
sawtooth  unriffle_skewed      1025     2048    11266    10242    10241 OK

And here the differences to before:

distribut mode                    n        m get_next set_next  compare
sawtooth  unriffle_skewed       100      128     -495      -68        0
sawtooth  unriffle_skewed      1023     1024    -6143      -10        0
sawtooth  unriffle             1024     1024    -6143        0        0
sawtooth  unriffle_skewed      1025     2048    -7188    -1033        0

We get a similar reduction of get_next calls here, but only a slight
reduction of set_next calls, if at all.

And here are the results of p0071-sort.sh before:

0071.12: llist_mergesort() unsorted    0.36(0.33+0.01)
0071.14: llist_mergesort() sorted      0.15(0.13+0.01)
0071.16: llist_mergesort() reversed    0.16(0.14+0.01)

... and here the ones with this patch:

0071.12: llist_mergesort() unsorted    0.24(0.22+0.01)
0071.14: llist_mergesort() sorted      0.12(0.10+0.01)
0071.16: llist_mergesort() reversed    0.12(0.10+0.01)

NB: We can't use t/perf/run to compare revisions in one run because it
uses the test-tool from the worktree, not from the revisions being
tested.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 mergesort.c | 121 ++++++++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 55 deletions(-)

diff --git a/mergesort.c b/mergesort.c
index e5fdf2ee4a..6216835566 100644
=2D-- a/mergesort.c
+++ b/mergesort.c
@@ -1,73 +1,84 @@
 #include "cache.h"
 #include "mergesort.h"

-struct mergesort_sublist {
-	void *ptr;
-	unsigned long len;
-};
-
-static void *get_nth_next(void *list, unsigned long n,
-			  void *(*get_next_fn)(const void *))
+/* Combine two sorted lists.  Take from `list` on equality. */
+static void *llist_merge(void *list, void *other,
+			 void *(*get_next_fn)(const void *),
+			 void (*set_next_fn)(void *, void *),
+			 int (*compare_fn)(const void *, const void *))
 {
-	while (n-- && list)
-		list =3D get_next_fn(list);
-	return list;
-}
+	void *result =3D list, *tail;

-static void *pop_item(struct mergesort_sublist *l,
-		      void *(*get_next_fn)(const void *))
-{
-	void *p =3D l->ptr;
-	l->ptr =3D get_next_fn(l->ptr);
-	l->len =3D l->ptr ? (l->len - 1) : 0;
-	return p;
+	if (compare_fn(list, other) > 0) {
+		result =3D other;
+		goto other;
+	}
+	for (;;) {
+		do {
+			tail =3D list;
+			list =3D get_next_fn(list);
+			if (!list) {
+				set_next_fn(tail, other);
+				return result;
+			}
+		} while (compare_fn(list, other) <=3D 0);
+		set_next_fn(tail, other);
+	other:
+		do {
+			tail =3D other;
+			other =3D get_next_fn(other);
+			if (!other) {
+				set_next_fn(tail, list);
+				return result;
+			}
+		} while (compare_fn(list, other) > 0);
+		set_next_fn(tail, list);
+	}
 }

+/*
+ * Perform an iterative mergesort using an array of sublists.
+ *
+ * n is the number of items.
+ * ranks[i] is undefined if n & 2^i =3D=3D 0, and assumed empty.
+ * ranks[i] contains a sublist of length 2^i otherwise.
+ *
+ * The number of bits in a void pointer limits the number of objects
+ * that can be created, and thus the number of array elements necessary
+ * to be able to sort any valid list.
+ *
+ * Adding an item to this array is like incrementing a binary number;
+ * positional values for set bits correspond to sublist lengths.
+ */
 void *llist_mergesort(void *list,
 		      void *(*get_next_fn)(const void *),
 		      void (*set_next_fn)(void *, void *),
 		      int (*compare_fn)(const void *, const void *))
 {
-	unsigned long l;
-
-	if (!list)
-		return NULL;
-	for (l =3D 1; ; l *=3D 2) {
-		void *curr;
-		struct mergesort_sublist p, q;
+	void *ranks[bitsizeof(void *)];
+	size_t n =3D 0;
+	int i;

-		p.ptr =3D list;
-		q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
-		if (!q.ptr)
-			break;
-		p.len =3D q.len =3D l;
+	while (list) {
+		void *next =3D get_next_fn(list);
+		if (next)
+			set_next_fn(list, NULL);
+		for (i =3D 0; n & (1 << i); i++)
+			list =3D llist_merge(ranks[i], list, get_next_fn,
+					   set_next_fn, compare_fn);
+		n++;
+		ranks[i] =3D list;
+		list =3D next;
+	}

-		if (compare_fn(p.ptr, q.ptr) > 0)
-			list =3D curr =3D pop_item(&q, get_next_fn);
+	for (i =3D 0; n; i++, n >>=3D 1) {
+		if (!(n & 1))
+			continue;
+		if (list)
+			list =3D llist_merge(ranks[i], list, get_next_fn,
+					   set_next_fn, compare_fn);
 		else
-			list =3D curr =3D pop_item(&p, get_next_fn);
-
-		while (p.ptr) {
-			while (p.len || q.len) {
-				void *prev =3D curr;
-
-				if (!p.len)
-					curr =3D pop_item(&q, get_next_fn);
-				else if (!q.len)
-					curr =3D pop_item(&p, get_next_fn);
-				else if (compare_fn(p.ptr, q.ptr) > 0)
-					curr =3D pop_item(&q, get_next_fn);
-				else
-					curr =3D pop_item(&p, get_next_fn);
-				set_next_fn(prev, curr);
-			}
-			p.ptr =3D q.ptr;
-			p.len =3D l;
-			q.ptr =3D get_nth_next(p.ptr, l, get_next_fn);
-			q.len =3D q.ptr ? l : 0;
-
-		}
-		set_next_fn(curr, NULL);
+			list =3D ranks[i];
 	}
 	return list;
 }
=2D-
2.33.0
