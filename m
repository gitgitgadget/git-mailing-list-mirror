Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,TRACKER_ID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046261F597
	for <e@80x24.org>; Fri,  3 Aug 2018 06:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeHCIrb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:47:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:59407 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbeHCIrb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Aug 2018 04:47:31 -0400
X-IronPort-AV: E=Sophos;i="5.51,437,1526335200"; 
   d="scan'208";a="341267304"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 08:52:38 +0200
Date:   Fri, 3 Aug 2018 08:52:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        nicolas.palix@univ-grenoble-alpes.fr,
        yamada.masahiro@socionext.com, cocci@systeme.lip6.fr,
        nicolas.palix@imag.fr
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
In-Reply-To: <20180803064419.GC237521@aiede.svl.corp.google.com>
Message-ID: <alpine.DEB.2.20.1808030848160.2446@hadrien>
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180802115522.16107-1-szeder.dev@gmail.com> <20180802180155.GD15984@sigill.intra.peff.net> <87bmaktpbt.fsf@evledraar.gmail.com> <alpine.DEB.2.20.1808030755350.2446@hadrien>
 <20180803064419.GC237521@aiede.svl.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Aug 2018, Jonathan Nieder wrote:

> Hi,
>
> Julia Lawall wrote:
>
> > This was already possible.  Make coccicheck is not supposed to be used
> > with -j, but rather with J=n.  That tells Coccinelle to parallelize the
> > treatment of the files internally.  In this case, the semantic patch is
> > only parsed once, and then n worker processes are forked to treat the
> > different files.
>
> Thanks for this hint.
>
> I wonder if we can make this happen automatically under suitable
> conditions.  We can parse -j<num> out of MAKEFLAGS and convert it into a
> J=<num> argument,

It does happen automatically, in the sense that the default with no -j or
J=option is to use all the cores on the machine.

With -j, it seems to have to default to one core internally:

d7059ca0147adcd495f3c5b41f260e1ac55bb679

Also, if it didn't do that, it would end up with the product of the -j
option and the number of cores on the machine, which would give very bad
performance.

> but that only solves half the problem: the "make"
> parent process would think that the coccinelle run only deserves to
> occupy one job slot.

Yes, it seems to be intended to be run by itself.

> Technically we could do all this using a wrapper that pretends to be a
> submake <https://www.gnu.org/software/make/manual/html_node/Job-Slots.html>
> (prefixing the command with '+', parsing jobserver options from the
> MAKEFLAGS envvar) but it gets ugly.
>
> It's likely that the best we can do is just to advertise J more
> prominently.
>
> [...]
> >> On Thu, Aug 02 2018, Jeff King wrote:
>
> >>>   cat contrib/coccinelle/*.cocci >mega.cocci
> >>>   make -j40 coccicheck COCCI_SEM_PATCHES=mega.cocci
> >
> > There was already a COCCI=foo.cocci argument to focus on a single semantic
> > patch.
> >
> > I'm surprised that the above cat command would work.  Semantic patch rules
> > have names, and Coccinelle will not be happy isf two rules have the same
> > name.
>
> Yes, Git's semantic patches (in contrib/coccinelle) tend to be
> relatively undemanding.
>
> >       Some may also have variables declared in initializers, although
> > perhaps the ones in the kernel don't do this.  Causing these variables to
> > be shared would not have a good effect.
>
> ... oh!  You're thinking of the Linux kernel.
>
> It looks like Linux's scripts/coccicheck has a lot we can crib from.
> That's where the J envvar and automatic parallelism you mentioned are
> implemented, too.
>
> So it sounds to me like at a minimum we should use all of that. ;-)

Yes.

julia
