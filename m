Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD9E1FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 01:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeCWB2Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 21:28:16 -0400
Received: from avasout01.plus.net ([84.93.230.227]:57592 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWB2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 21:28:16 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id zBV6eckFEMLyGzBV7e2f7R; Fri, 23 Mar 2018 01:28:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=HInt6Llv c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=9b8fkM-ioTngJvvghTUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7a49135b-faad-9856-b757-e3ed4886720d@ramsayjones.plus.com>
Date:   Fri, 23 Mar 2018 01:28:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322093212.GB28907@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMPEVjr2w/2mRlh9Vnzz6ZLihYhdy6kyl29fMa/As8qcaSz3ETpRxLAgQpp8v9ef0O5ycs/js54z5G/+gIln3xP+WwX8a3610BN4j1bSO+6DP91oKQxd
 4SPmZ8XpmZ85JCJvGc+ToBiUj1Qw8aBNAXwtFXRGTSO+ojt8TGdGDL3WIpqZPuHiiC5966ihNMMEzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/03/18 09:32, Jeff King wrote:
> On Wed, Mar 21, 2018 at 04:59:19PM +0100, Duy Nguyen wrote:
> 
>>> I hate to be a wet blanket, but am I the only one who is wondering
>>> whether the tradeoffs is worth it? 8% memory reduction doesn't seem
>>> mind-bogglingly good,
>>
>> AEvar measured RSS. If we count objects[] array alone, the saving is
>> 40% (136 bytes per entry down to 80). Some is probably eaten up by
>> mmap in rss.
> 
> Measuring actual heap usage with massif, I get before/after peak heaps
> of 1728 and 1346MB respectively when repacking linux.git. So that's ~22%
> savings overall.
> 
> Of the used heap after your patches:
> 
>  - ~40% of that is from packlist_alloc()
>  - ~17% goes to "struct object"
>  - ~10% for the object.c hash table to store all the "struct object"
>  - ~7% goes to the delta cache
>  - ~7% goes to the pack revindex (actually, there's a duplicate 7%
>        there, too; I think our peak is when we're sorting the revindex
>        and have to keep two copies in memory at once)

which begs the question, how much slower would it be if we
replaced the radix-sort with an in-place sort (e.g. heapsort).

I hacked up the patch below, just for fun. I don't have any
large repos (or enough disk space) to do any meaningful perf
tests, but I did at least compile it and it passes the test-suite.
(That is no guarantee that I haven't introduced bugs, of course!)

;-)

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] pack-revindex: replace radix-sort with in-place heapsort

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 pack-revindex.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index ff5f62c03..16f17eac1 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -15,6 +15,7 @@
  * get the object sha1 from the main index.
  */
 
+#ifdef DUMMY
 /*
  * This is a least-significant-digit radix sort.
  *
@@ -112,6 +113,65 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 #undef BUCKETS
 #undef DIGIT_SIZE
 }
+#endif
+
+static inline void swap(struct revindex_entry *a, int i, int j)
+{
+	struct revindex_entry t;
+
+	t = a[i];
+	a[i] = a[j];
+	a[j] = t;
+}
+
+/*
+ * assume that elements first .. last (array index first-1 .. last-1) obey
+ * the partially ordered tree property, except possibly for the children of
+ * the first element. push down the first element until the partially
+ * ordered tree property is restored.
+ */
+static void push_down(struct revindex_entry *a, int first, int last)
+{
+	int parent = first;
+	int last_node = last / 2;
+
+	while (parent <= last_node) {
+
+		int left = 2 * parent;
+		int right = left + 1;
+		int biggest;
+
+		if (right > last) /* parent only has one child */
+			biggest = left;
+		else {
+			if (a[left-1].offset >= a[right-1].offset)
+				biggest = left;
+			else
+				biggest = right;
+
+		}
+
+		if (a[parent-1].offset >= a[biggest-1].offset)
+			break; /* partially ordered tree property, we're done */
+
+		/* push parent down */
+		swap(a, parent-1, biggest-1);
+		parent = biggest;
+	}
+}
+
+static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
+{
+	int i;
+
+	for (i = n/2; i > 0; i--)
+		push_down(entries, i, n);
+
+	for (i = n; i > 1; i--) {
+		swap(entries, 0, i-1);
+		push_down(entries, 1, i-1);
+	}
+}
 
 /*
  * Ordered list of offsets of objects in the pack.
-- 
2.16.0

