Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E19445
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18806 invoked by uid 109); 23 Dec 2023 10:09:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Dec 2023 10:09:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11454 invoked by uid 111); 23 Dec 2023 10:09:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Dec 2023 05:09:05 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 23 Dec 2023 05:09:05 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t1006: add tests for %(objectsize:disk)
Message-ID: <20231223100905.GB2016274@coredump.intra.peff.net>
References: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
 <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
 <20231221213034.GB1446091@coredump.intra.peff.net>
 <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120b3194-5eee-47ed-b2d8-bc6731b71a6b@web.de>

On Fri, Dec 22, 2023 at 12:13:10AM +0100, René Scharfe wrote:

> >> 			while read start oid rest
> >> 			do
> >> 				size=$((end - start)) &&
> >> 				end=$start &&
> >> 				echo "$oid $size" ||
> >> 				return 1
> >> 			done <idx.sorted
> >
> > The one thing I do like is that we don't have to escape anything inside
> > an awk program that is forced to use double-quotes. ;)
> 
> For me it's processing the data in the "correct" order (descending, i.e.
> starting at the end, which we have to calculate first anyway based on the
> size).

That was one thing that I thought made it more complicated. The obvious
order to me is start-to-end in the pack. But I do agree that going in
reverse order makes things much simpler, as we compute the size of each
entry as we see it (and so there are fewer special cases).

So I'm convinced that it's worth switching. Here's a v2 with your
suggestion.

-- >8 --
Subject: t1006: add tests for %(objectsize:disk)

Back when we added this placeholder in a4ac106178 (cat-file: add
%(objectsize:disk) format atom, 2013-07-10), there were no tests,
claiming "[...]the exact numbers returned are volatile and subject to
zlib and packing decisions".

But we can use a little shell hackery to get the expected numbers
ourselves. To a certain degree this is just re-implementing what Git is
doing under the hood, but it is still worth doing. It makes sure we
exercise the %(objectsize:disk) code at all, and having the two
implementations agree gives us more confidence.

Note that our shell code assumes that no object appears twice (either in
two packs, or as both loose and packed), as then the results really are
undefined. That's OK for our purposes, and the test will notice if that
assumption is violated (the shell version would produce duplicate lines
that Git's output does not have).

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1006-cat-file.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 271c5e4fd3..e0c6482797 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1100,6 +1100,42 @@ test_expect_success 'cat-file --batch="batman" with --batch-all-objects will wor
 	cmp expect actual
 '
 
+test_expect_success 'cat-file %(objectsize:disk) with --batch-all-objects' '
+	# our state has both loose and packed objects,
+	# so find both for our expected output
+	{
+		find .git/objects/?? -type f |
+		awk -F/ "{ print \$0, \$3\$4 }" |
+		while read path oid
+		do
+			size=$(test_file_size "$path") &&
+			echo "$oid $size" ||
+			return 1
+		done &&
+		rawsz=$(test_oid rawsz) &&
+		find .git/objects/pack -name "*.idx" |
+		while read idx
+		do
+			git show-index <"$idx" >idx.raw &&
+			sort -nr <idx.raw >idx.sorted &&
+			packsz=$(test_file_size "${idx%.idx}.pack") &&
+			end=$((packsz - rawsz)) &&
+			while read start oid rest
+			do
+				size=$((end - start)) &&
+				end=$start &&
+				echo "$oid $size" ||
+				return 1
+			done <idx.sorted ||
+			return 1
+		done
+	} >expect.raw &&
+	sort <expect.raw >expect &&
+	git cat-file --batch-all-objects \
+		--batch-check="%(objectname) %(objectsize:disk)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up replacement object' '
 	orig=$(git rev-parse HEAD) &&
 	git cat-file commit $orig >orig &&
-- 
2.43.0.448.g93112243fb

