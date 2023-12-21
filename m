Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32776909
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28270 invoked by uid 109); 21 Dec 2023 21:30:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 21:30:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28117 invoked by uid 111); 21 Dec 2023 21:30:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 16:30:34 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 16:30:34 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1006: add tests for %(objectsize:disk)
Message-ID: <20231221213034.GB1446091@coredump.intra.peff.net>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
 <20231214205936.GA2272813@coredump.intra.peff.net>
 <6750c93c-78d0-46b5-bfc2-0774156ed2ed@web.de>
 <20231221094722.GA570888@coredump.intra.peff.net>
 <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d44cb8e7-ffce-4184-b9b5-6bb56705dcd1@web.de>

On Thu, Dec 21, 2023 at 01:19:53PM +0100, René Scharfe wrote:

> I think we can do it even in shell, especially if...
> [...]

Yeah, your conversion looks accurate. I do wonder if it is worth golfing
further, though. If it were a process invocation per object, I'd
definitely say the efficiency gain is worth it. But dropping one process
from the whole test isn't that exciting either way.

> (sort -r), then we don't need to carry the oid forward:
> 
> 			sort -nr <idx.raw >idx.sorted &&
> 			packsz=$(test_file_size "${idx%.idx}.pack") &&
> 			end=$((packsz - rawsz)) &&
> 			awk -v end="$end" "
> 			  { print \$2, end - \$1; end = \$1 }
> 			" idx.sorted ||
> 
> And at that point it should be easy to use a shell loop instead of awk:
> 
> 			while read start oid rest
> 			do
> 				size=$((end - start)) &&
> 				end=$start &&
> 				echo "$oid $size" ||
> 				return 1
> 			done <idx.sorted

The one thing I do like is that we don't have to escape anything inside
an awk program that is forced to use double-quotes. ;)

> Should we deduplicate here, like cat-file does (i.e. use "sort -u")?
> Having the same object in multiple places for whatever reason would not
> be a cause for reporting an error in this test, I would think.

No, for the reasons I said in the commit message: if an object exists in
multiple places the test is already potentially invalid, as Git does not
promise which version it will use. So it might work racily, or it might
work for now but be fragile. By not de-duplicating, we make sure the
test's assumption holds.

> One more thing: We can do the work of the first awk invocation in the
> already existing loop as well:
> [...]
> ... but the substitutions are a bit awkward:
> 
> 		find .git/objects/?? -type f |
> 		while read path
> 		do
> 			basename=${path##*/} &&
> 			dirname=${path%/$basename} &&
> 			oid="${dirname#.git/objects/}${basename}" &&
> 			size=$(test_file_size "$path") &&
> 			echo "$oid $size" ||
> 			return 1
> 		done &&
> 
> The avoided awk invocation might be worth the trouble, though.

Yeah, I briefly considered whether it would be possible in pure shell,
but didn't get very far before assuming it was going to be ugly. Thank
you for confirming. ;)

Again, if we were doing one awk per object, I'd try to avoid it. But
since we can cover all objects in a single pass, I think it's OK.

-Peff
