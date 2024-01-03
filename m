Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B5A18623
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14417 invoked by uid 109); 3 Jan 2024 09:01:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Jan 2024 09:01:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13271 invoked by uid 111); 3 Jan 2024 09:01:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Jan 2024 04:01:55 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Jan 2024 04:01:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #01; Tue, 2)
Message-ID: <20240103090152.GB1866508@coredump.intra.peff.net>
References: <xmqq5y0bcjpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5y0bcjpw.fsf@gitster.g>

On Tue, Jan 02, 2024 at 05:02:35PM -0800, Junio C Hamano wrote:

> * jk/t1006-cat-file-objectsize-disk (2023-12-21) 1 commit
>   (merged to 'next' on 2023-12-28 at d82812e636)
>  + t1006: add tests for %(objectsize:disk)
> 
>  Test update.
> 
>  Will merge to 'master'.
>  source: <20231221094722.GA570888@coredump.intra.peff.net>

It looks like this is the original version. I posted a v2 that took
René's suggestion to swap out the awk for shell, but it got overlooked.
I'm happy enough either way, but if we want to salvage that effort,
here's a patch which could go on top:

-- >8 --
From: René Scharfe <l.s.r@web.de>
Subject: [PATCH] t1006: prefer shell loop to awk for packed object sizes

To compute the expected on-disk size of packed objects, we sort the
output of show-index by pack offset and then compute the difference
between adjacent entries using awk. This works but has a few readability
problems:

  1. Reading the index in pack order means don't find out the size of an
     oid's entry until we see the _next_ entry. So we have to save it to
     print later.

     We can instead iterate in reverse order, so we compute each oid's
     size as we see it.

  2. Since the awk invocation is inside a text_expect block, we can't
     easily use single-quotes to hold the script. So we use
     double-quotes, but then have to escape the dollar signs in the awk
     script.

     We can swap this out for a shell loop instead (which is made much
     easier by the first change).

Signed-off-by: Jeff King <peff@peff.net>
---
I gave René authorship since this was his cleverness, but obviously I
wrote the commit message. Giving an explicit signoff would be nice,
though.

 t/t1006-cat-file.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0c2eafae65..5ea3326128 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1117,14 +1117,16 @@ test_expect_success 'cat-file %(objectsize:disk) with --batch-all-objects' '
 		while read idx
 		do
 			git show-index <"$idx" >idx.raw &&
-			sort -n <idx.raw >idx.sorted &&
+			sort -nr <idx.raw >idx.sorted &&
 			packsz=$(test_file_size "${idx%.idx}.pack") &&
 			end=$((packsz - rawsz)) &&
-			awk -v end="$end" "
-			  NR > 1 { print oid, \$1 - start }
-			  { start = \$1; oid = \$2 }
-			  END { print oid, end - start }
-			" idx.sorted ||
+			while read start oid rest
+			do
+				size=$((end - start)) &&
+				end=$start &&
+				echo "$oid $size" ||
+				return 1
+			done <idx.sorted ||
 			return 1
 		done
 	} >expect.raw &&
-- 
2.43.0.514.g7147b80757

