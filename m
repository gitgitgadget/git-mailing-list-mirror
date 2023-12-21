Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95550224C7
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22300 invoked by uid 109); 21 Dec 2023 09:47:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 09:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22791 invoked by uid 111); 21 Dec 2023 09:47:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 04:47:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 04:47:22 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t1006: add tests for %(objectsize:disk)
Message-ID: <20231221094722.GA570888@coredump.intra.peff.net>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>

On Tue, Dec 19, 2023 at 05:42:39PM +0100, René Scharfe wrote:

> > This adds a packed-object function, but I doubt anybody actually calls
> > it. If we're going to do that, it's probably worth adding some tests for
> > "cat-file --batch-check" or similar.
> 
> Yes, and I was assuming that someone else would be eager to add such
> tests. *ahem*

:P OK, here it is. This can be its own topic, or go on top of the
rs/t6300-compressed-size-fix branch.

> > At which point I wonder if rather than having a function for a single
> > object, we are better off just testing the result of:
> >
> >   git cat-file --batch-all-objects --unordered --batch-check='%(objectsize:disk)'
> >
> > against a single post-processed "show-index" invocation.
> 
> Sure, we might want to optimize for bulk-processing and possibly end up
> only checking the size of single objects in t6300, making new library
> functions unnecessary.

So yeah, I think the approach here makes library functions unnecessary
(and I see you already asked Junio to drop your patch 2).

> When dumping size information of multiple objects, it's probably a good
> idea to include "%(objectname)" as well in the format.

Yep, definitely.

-- >8 --
Subject: [PATCH] t1006: add tests for %(objectsize:disk)

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
I stole a bit of your awk. You can tell because I'd have written it in
perl. ;)

 t/t1006-cat-file.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 271c5e4fd3..21915be308 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1100,6 +1100,40 @@ test_expect_success 'cat-file --batch="batman" with --batch-all-objects will wor
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
+			sort -n <idx.raw >idx.sorted &&
+			packsz=$(test_file_size "${idx%.idx}.pack") &&
+			end=$((packsz - rawsz)) &&
+			awk -v end="$end" "
+			  NR > 1 { print oid, \$1 - start }
+			  { start = \$1; oid = \$2 }
+			  END { print oid, end - start }
+			" idx.sorted ||
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
2.43.0.430.gaf21263e5d

