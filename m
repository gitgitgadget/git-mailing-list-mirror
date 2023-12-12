Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643DC8E
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 12:01:55 -0800 (PST)
Received: (qmail 16541 invoked by uid 109); 12 Dec 2023 20:01:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 20:01:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18690 invoked by uid 111); 12 Dec 2023 20:01:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 15:01:54 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 15:01:53 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Test breakage with zlib-ng
Message-ID: <20231212200153.GB1127366@coredump.intra.peff.net>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>

On Tue, Dec 12, 2023 at 06:04:55PM +0100, René Scharfe wrote:

> Subject: [PATCH] t6300: avoid hard-coding object sizes
> 
> f4ee22b526 (ref-filter: add tests for objectsize:disk, 2018-12-24)
> hard-coded the expected object sizes.  Coincidentally the size of commit
> and tag is the same with zlib at the default compression level.
> 
> 1f5f8f3e85 (t6300: abstract away SHA-1-specific constants, 2020-02-22)
> encoded the sizes as a single value, which coincidentally also works
> with sha256.
> 
> Different compression libraries like zlib-ng may arrive at different
> values.  Get them from the file system instead of hard-coding them to
> make switching the compression library (or changing the compression
> level) easier.

Yeah, this is definitely the right solution here. I'm surprised the
hard-coded values didn't cause problems before now. ;)

The patch looks good to me, but a few small comments:

> +test_object_file_size () {
> +	oid=$(git rev-parse "$1")
> +	path=".git/objects/$(test_oid_to_path $oid)"
> +	test_file_size "$path"
> +}

Here we're assuming the objects are loose. I think that's probably OK
(and certainly the test will notice if that changes).

We're covering the formatting code paths along with the underlying
implementation that fills in object_info->disk_sizep for loose objects.
Which I think is plenty for this particular script, which is about
for-each-ref.

It would be nice to have coverage of the packed_object_info() code path,
though. Back when it was added in a4ac106178 (cat-file: add
%(objectsize:disk) format atom, 2013-07-10), I cowardly punted on this,
writing:

  This patch does not include any tests, as the exact numbers
  returned are volatile and subject to zlib and packing
  decisions. We cannot even reliably guarantee that the
  on-disk size is smaller than the object content (though in
  general this should be the case for non-trivial objects).

I don't think it's that big a deal, but I guess we could do something
like:

  prev=
  git show-index <$pack_idx |
  sort -n |
  grep -A1 $oid |
  while read ofs oid csum
  do
    test -n "$prev" && echo "$((ofs - prev))"
    prev=$ofs
  done

It feels a little redundant with what Git is doing under the hood, but
at least is exercising the code (and we're using the idx directly, so
we're confirming that the revindex is right).

Anyway, that is all way beyond the scope of your patch, but I wonder if
it's worth doing on top.

> @@ -129,7 +129,7 @@ test_atom head push:strip=1 remotes/myfork/main
>  test_atom head push:strip=-1 main
>  test_atom head objecttype commit
>  test_atom head objectsize $((131 + hexlen))
> -test_atom head objectsize:disk $disklen
> +test_atom head objectsize:disk $(test_object_file_size refs/heads/main)

These test_object_file_size calls are happening outside of any
test_expect_* block, so we'd miss failing exit codes (and also the
helper is not &&-chained), and any stderr would leak to the output.
That's probably OK in practice, though (if something goes wrong then the
expected value output will be bogus and the test itself will fail).

-Peff
