Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C800AC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E50E610E8
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhJNXiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:38:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35254 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhJNXiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 19:38:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7A1321F670;
        Thu, 14 Oct 2021 23:36:16 +0000 (UTC)
Date:   Thu, 14 Oct 2021 23:36:16 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: To "const char *" and cast on free(), or "char *" and no cast...
Message-ID: <20211014233616.GA3348@dcvr>
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
 <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
 <87mtnbfk0g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtnbfk0g.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Oct 14 2021, Phillip Wood wrote:
> 
> [Changed $subject]

Thanks, I might not've noticed this if you hadn't.

> > On 14/10/2021 01:10, Ævar Arnfjörð Bjarmason wrote:
> >> The "checkout" command is one of the main sources of leaks in the test
> >> suite, let's fix the common ones by not leaking from the "struct
> >> branch_info".
> >> Doing this is rather straightforward, albeit verbose, we need to
> >> xstrdup() constant strings going into the struct, and free() the ones
> >> we clobber as we go along.
> >
> > It's great to see these leaks being fixed. I wonder though if it would
> > be better to change the structure definition so that 'name' and 'path' 
> > are no longer 'const'. That would be a better reflection of the new
> > regime.[...]
> 
> I think this is the right thing to do, but I'm not quite sure. There was
> a thread at it here:
> 
>     https://lore.kernel.org/git/YUZG0D5ayEWd7MLP@carlos-mbp.lan/

I'd much prefer we keep const-ness for safety and documentation
purposes.

> Where I chimed in and suggested exactly what you're saying here, but the
> consensus seemed to go the other way, and if you grep:
> 
>     git grep -F 'free((char *)'
> 
> You can see that we use this pattern pretty widely.

I've been using unions to workaround APIs like free(3)
for many years:

static inline void deconst_free(const void *ptr)
{
	/* this initializer is a C99-ism */
	union { const void *in; void *out; } deconst = { .in = ptr };

	free(deconst.out);
}
