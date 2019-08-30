Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F801F4B9
	for <e@80x24.org>; Fri, 30 Aug 2019 19:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH3Tgh (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:36:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54936 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfH3Tgh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:36:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D8E8E1F4B7;
        Fri, 30 Aug 2019 19:36:36 +0000 (UTC)
Date:   Fri, 30 Aug 2019 19:36:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 11/11] hashmap_get_next returns "struct hashmap_entry *"
Message-ID: <20190830193636.xg6pcd5hjcgk3nob@dcvr>
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-12-e@80x24.org>
 <2f22841c-779e-6d6e-19b7-0a119088e343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f22841c-779e-6d6e-19b7-0a119088e343@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> wrote:
> On 8/25/2019 10:43 PM, Eric Wong wrote:
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -1035,8 +1035,10 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
> >  {
> >  	int i;
> >  	char *got_match = xcalloc(1, pmb_nr);
> > +	struct hashmap_entry *ent = &match->ent;
> >  
> > -	for (; match; match = hashmap_get_next(hm, &match->ent)) {
> > +	for (; ent; ent = hashmap_get_next(hm, ent)) {
> > +		match = container_of(ent, struct moved_entry, ent);
> 
> Lines like this are very difficult to parse. In this
> container_of() macro, 'ent' is taking both the 'ptr' and
> 'member' values.

Agreed, naming is hard :<

In the Linux kernel list.h implementation, there's actually
list_for_each_entry, list_next_entry and a bunch of other
macros which allow the caller to avoid using container_of.
We only have list_first_entry, so far.

We can draw inspiration from those macros by creating
hashmap_get_next_entry and hashmap_for_each_entry macros
which allow callers specify the type once; and there'd
be no need for callers to specify the hashmap_entry
pointer name at all :)

Unlike the kernel, it looks like we can't rely on __typeof__ in
git, but I think we can let the caller specify the type once...


