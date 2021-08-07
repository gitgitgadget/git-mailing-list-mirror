Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5600BC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 22:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217C160FE7
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 22:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhHGWuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 18:50:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45680 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHGWuP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 18:50:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 326DD1F8C6;
        Sat,  7 Aug 2021 22:49:57 +0000 (UTC)
Date:   Sat, 7 Aug 2021 22:49:57 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
Message-ID: <20210807224957.GA5068@dcvr>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
 <bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
> Am 06.08.21 um 17:31 schrieb Andrzej Hunt:
> > On 29/06/2021 22:53, Eric Wong wrote:
> >> [...snip...]
> >> diff --git a/oidtree.c b/oidtree.c
> >> new file mode 100644
> >> index 0000000000..c1188d8f48
> >> --- /dev/null
> >> +++ b/oidtree.c

> >> +struct oidtree_node {
> >> +    /* n.k[] is used to store "struct object_id" */
> >> +    struct cb_node n;
> >> +};
> >> +
> >> [... snip ...]
> >> +
> >> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
> >> +{
> >> +    struct oidtree_node *on;
> >> +
> >> +    if (!ot->mempool)
> >> +        ot->mempool = allocate_alloc_state();
> >> +    if (!oid->algo)
> >> +        BUG("oidtree_insert requires oid->algo");
> >> +
> >> +    on = alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid));
> >> +    oidcpy_with_padding((struct object_id *)on->n.k, oid);
> >
> > I think this object_id cast introduced undefined behaviour - here's
> > my layperson's interepretation of what's going on (full UBSAN output
> > is pasted below):
> >
> > cb_node.k is a uint8_t[], and hence can be 1-byte aligned (on my
> > machine: offsetof(struct cb_node, k) == 21). We're casting its
> > pointer to "struct object_id *", and later try to access
> > object_id.hash within oidcpy_with_padding. My compiler assumes that
> > an object_id pointer needs to be 4-byte aligned, and reading from a
> > misaligned pointer means we hit undefined behaviour. (I think the
> > 4-byte alignment requirement comes from the fact that object_id's
> > largest member is an int?)

I seem to recall struct alignment requirements being
architecture-dependent; and x86/x86-64 are the most liberal
w.r.t alignment requirements.

> > I'm not sure what an elegant and idiomatic fix might be - IIUC it's
> > hard to guarantee misaligned access can't happen with a flex array
> > that's being used for arbitrary data (you would presumably have to
> > declare it as an array of whatever the largest supported type is, so
> > that you can guarantee correct alignment even when cbtree is used
> > with that type) - which might imply that k needs to be declared as a
> > void pointer? That in turn would make cbtree.c harder to read.
> 
> C11 has alignas.  We could also make the member before the flex array,
> otherbits, wider, e.g. promote it to uint32_t.

Ugh, no.  cb_node should be as small as possible and (for our
current purposes) ->byte could be uint8_t.

> A more parsimonious solution would be to turn the int member of struct
> object_id, algo, into an unsigned char for now and reconsider the issue
> once we support our 200th algorithm or so.

Yes, making struct object_id smaller would benefit all git users
(at least for the next few centuries :P).

> This breaks notes, though.
> Its GET_PTR_TYPE seems to require struct leaf_node to have 4-byte
> alignment for some reason.  That can be ensured by adding an int member.

Adding a 4-byte int to leaf_node after shaving 6-bytes off two
object_id structs would mean a net savings of 2 bytes;
sounds good to me.

I don't know much about notes nor the associated code,
but I also wonder if crit-bit tree can be used there, too.

> Anyway, with either of these fixes UBSan is still unhappy about a
> different issue.  Here's a patch for that:

Thanks <snip>
