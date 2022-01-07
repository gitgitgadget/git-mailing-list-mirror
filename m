Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FAC433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 14:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiAGO5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:57:14 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:44347 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239219AbiAGO5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 09:57:14 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n5qg3-000Ahf-EQ; Fri, 07 Jan 2022 14:57:12 +0000
Message-ID: <3b03382e-3fb3-54b2-0917-18ddcade566f@iee.email>
Date:   Fri, 7 Jan 2022 14:57:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
Content-Language: en-GB
To:     Jessica Clarke <jrtc27@jrtc27.com>, git@vger.kernel.org
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220105132324.6651-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/2022 13:23, Jessica Clarke wrote:
> Currently git_qsort_s allocates a buffer on the stack that has no
> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
> alignment for any type.
>
> On CHERI, and thus Arm's Morello prototype, pointers are implemented as
> hardware capabilities which, as well as having a normal integer address,
> have additional bounds, permissions and other metadata in a second word,
> so on a 64-bit architecture they are 128-bit quantities, including their
> alignment requirements. Despite being 128-bit, their integer component
> is still only a 64-bit field, so uintmax_t remains 64-bit, and therefore
> uintmax_t does not sufficiently align an allocation.

I did find that the introduction paragraphs in this and its companion
patch needed a little more background of the uninitiated.

I felt it needed a few words to highlight the innovative, potentially
'breaking', changes that CHERI (&co) provides, such as the hidden bit,
the shift from classic von Neumann architecture, inclusion of typing
for  values, etc. and how that affects the compromises that are within
the C standard (and those that features misreadings and conflicts with it).

Some of the follow up discussions have a great similarity with the
Windows LLP64 (`long long`) issues that also confuse the arithmetic
operation capabilities with the memory pointer capabilities.

The layout needed a bit of SPIN (situation, problem, implication, need
payoff) to see how it hangs together across all the different
implementations. I know, from experience, it's not easy to pick out the
'obvious', but implicit, foundational aspects. While, explaining them
from an implementation perspective is easy for those who know the
implementation, I found it took a few reads to get my head around the
discussion (e.g. I wasn't familiar with `typedef union`s).

Improved memory safety does sound to be worthwhile!

Philip
> Moreover, these capabilities have an additional "129th" tag bit, which
> tracks the validity of the capability and is cleared on any invalid
> operation that doesn't trap (e.g. partially overwriting a capability
> will invalidate it) which, combined with the architecture's strict
> checks on capability manipulation instructions, ensures it is
> architecturally impossible to construct a capability that gives more
> rights than those you were given in the first place. To store these tag
> bits, each capability sized and aligned word in memory gains a single
> tag bit that is stored in unaddressable (to the processor) memory. This
> means that it is impossible to store a capability at an unaligned
> address: a normal load or store of a capability will always take an
> alignment fault even if the (micro)architecture supports unaligned
> loads/stores for other data types, and a memcpy will, if the destination
> is not appropriately aligned, copy the byte representation but lose the
> tag, meaning that if it is eventually copied back and loaded from an
> aligned location any attempt to dereference it will trap with a tag
> fault. Thus, even char buffers that are memcpy'ed to or from must be
> properly aligned on CHERI architectures if they are to hold pointers.
>
> Address both of these by introducing a new git_max_align type put in a
> union with the on-stack buffer to force its alignment, as well as a new
> GIT_MAX_ALIGNMENT macro whose value is the alignment of git_max_align
> that gets used for mem_pool_alloc. As well as making the code work on
> CHERI, the former change likely also improves performance on some
> architectures by making memcpy faster (either because it can use larger
> block sizes or because the microarchitecture has inefficient unaligned
> accesses).
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>  compat/qsort_s.c  | 11 +++++++----
>  git-compat-util.h | 11 +++++++++++
>  mem-pool.c        |  6 +++---
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/compat/qsort_s.c b/compat/qsort_s.c
> index 52d1f0a73d..1ccdb87451 100644
> --- a/compat/qsort_s.c
> +++ b/compat/qsort_s.c
> @@ -49,16 +49,19 @@ int git_qsort_s(void *b, size_t n, size_t s,
>  		int (*cmp)(const void *, const void *, void *), void *ctx)
>  {
>  	const size_t size = st_mult(n, s);
> -	char buf[1024];
> +	union {
> +		char buf[1024];
> +		git_max_align align;
> +	} u;
>  
>  	if (!n)
>  		return 0;
>  	if (!b || !cmp)
>  		return -1;
>  
> -	if (size < sizeof(buf)) {
> -		/* The temporary array fits on the small on-stack buffer. */
> -		msort_with_tmp(b, n, s, cmp, buf, ctx);
> +	if (size < sizeof(u.buf)) {
> +		/* The temporary array fits in the small on-stack buffer. */
> +		msort_with_tmp(b, n, s, cmp, u.buf, ctx);
>  	} else {
>  		/* It's somewhat large, so malloc it.  */
>  		char *tmp = xmalloc(size);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5fa54a7afe..28581a45c5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -274,6 +274,17 @@ typedef unsigned long uintptr_t;
>  #define _ALL_SOURCE 1
>  #endif
>  
> +typedef union {
> +	uintmax_t max_align_uintmax;
> +	void *max_align_pointer;
> +} git_max_align;
> +
> +typedef struct {
> +	char unalign;
> +	git_max_align aligned;
> +} git_max_alignment;
> +#define GIT_MAX_ALIGNMENT offsetof(git_max_alignment, aligned)
> +
>  /* used on Mac OS X */
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
> diff --git a/mem-pool.c b/mem-pool.c
> index ccdcad2e3d..748eff925a 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -69,9 +69,9 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len)
>  	struct mp_block *p = NULL;
>  	void *r;
>  
> -	/* round up to a 'uintmax_t' alignment */
> -	if (len & (sizeof(uintmax_t) - 1))
> -		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
> +	/* round up to a 'GIT_MAX_ALIGNMENT' alignment */
> +	if (len & (GIT_MAX_ALIGNMENT - 1))
> +		len += GIT_MAX_ALIGNMENT - (len & (GIT_MAX_ALIGNMENT - 1));
>  
>  	if (pool->mp_block &&
>  	    pool->mp_block->end - pool->mp_block->next_free >= len)

