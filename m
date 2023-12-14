Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB006DCF7
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8721 invoked by uid 109); 14 Dec 2023 20:59:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 20:59:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11277 invoked by uid 111); 14 Dec 2023 20:59:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 15:59:36 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 15:59:36 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Ondrej Pohorelsky <opohorel@redhat.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1] test-lib-functions: add object size functions
Message-ID: <20231214205936.GA2272813@coredump.intra.peff.net>
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
 <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
 <20231212200153.GB1127366@coredump.intra.peff.net>
 <ff735aac-b60b-4d52-a6dc-180ab504fc8d@web.de>
 <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65557f2d-9de0-49ae-a858-80476aa52b68@web.de>

On Wed, Dec 13, 2023 at 01:28:56PM +0100, René Scharfe wrote:

> Add test_object_size and its helpers test_loose_object_size and
> test_packed_object_size, which allow determining the size of a Git
> object using only the low-level Git commands rev-parse and show-index.
> 
> Use it in t6300 to replace the bare-bones function test_object_file_size
> as a motivating example.  There it provides the expected output of the
> high-level Git command for-each-ref.

This adds a packed-object function, but I doubt anybody actually calls
it. If we're going to do that, it's probably worth adding some tests for
"cat-file --batch-check" or similar.

At which point I wonder if rather than having a function for a single
object, we are better off just testing the result of:

  git cat-file --batch-all-objects --unordered --batch-check='%(objectsize:disk)'

against a single post-processed "show-index" invocation.

> So how about this?  I'm a bit nervous about all the rules about output
> descriptors and error propagation and whatnot in the test library, but
> this implementation seems simple enough and might be useful in more than
> one test.  No idea how to add support for alternate object directories,
> but I doubt we'll ever need it.

I'm not sure that we need to do anything special with output
redirection. Shouldn't these functions just send errors to stderr as
usual? If they are run inside a test_expect block, that goes to
descriptor 4 (which is either /dev/null or the original stderr,
depending on whether "-v" was used).

> +test_loose_object_size () {
> +	test "$#" -ne 1 && BUG "1 param"
> +	local path=$(test_oid_to_path "$1")
> +	test_file_size "$(git rev-parse --git-path "objects/$path")" 2>&4
> +}

OK. We lose the exit code from "rev-parse" but that is probably OK for
our purposes.

> +test_packed_object_size () {
> +	test "$#" -ne 2 && BUG "2 params"
> +	local oid=$1 idx=$2 packsize rawsz end
> +
> +	packsize=$(test_file_size "${idx%.idx}.pack")
> +	rawsz=$(test_oid rawsz)
> +	end=$(($packsize - $rawsz))

OK, this $end is the magic required for the final entry. Makes sense.

> +	git show-index <"$idx" |
> +	awk -v oid="$oid" -v end="$end" '
> +		$2 == oid {start = $1}
> +		{offsets[$1] = 1}
> +		END {
> +			if (!start || start >= end)
> +				exit 1
> +			for (o in offsets)
> +				if (start < o && o < end)
> +					end = o
> +			print end - start
> +		}
> +	' && return 0

I was confused at first, because I didn't see any sorting happening. But
if I understand correctly, you're just looking for the smallest "end"
that comes after the start of the object we're looking for. Which I
think works.

-Peff
