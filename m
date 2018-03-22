Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5401F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 08:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeCVIHp (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 04:07:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:38500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752494AbeCVIHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 04:07:42 -0400
Received: (qmail 1900 invoked by uid 109); 22 Mar 2018 08:07:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 08:07:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17859 invoked by uid 111); 22 Mar 2018 08:08:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 04:08:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 04:07:40 -0400
Date:   Thu, 22 Mar 2018 04:07:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        e@80x24.org, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180322080740.GA28907@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <87tvt9xuel.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvt9xuel.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 05:31:14PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > [...]Yes, having that many packs is insane, but that's going to be
> > small consolation to somebody whose automated maintenance program now
> > craps out at 16k packs, when it previously would have just worked to
> > fix the situation[...]
> 
> That's going to be super rare (and probably nonexisting) edge case, but
> (untested) I wonder if something like this on top would alleviate your
> concerns, i.e. instead of dying we just take the first N packs up to our
> limit:

I wish you were right about the rarity, but it's unfortunately something
I have seen multiple times in the wild (and why I spent time optimizing
the many-packs case for pack-objects). Unfortunately I don't know how
often it actually comes up, because in theory running "git repack"
cleans it up without further ado. But after these patches, not so much.

I'll admit that my experiences aren't necessarily typical of most git
users. But I wouldn't be surprised if other people hosting their own
repositories run into this, too (e.g., somebody pushing in a loop,
auto-gc disabled or clogged by something silly like the "too many loose
objects" warning).

>     diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>     index 4406af640f..49d467ab2a 100644
>     --- a/builtin/pack-objects.c
>     +++ b/builtin/pack-objects.c
>     @@ -1065,8 +1065,9 @@ static int want_object_in_pack(const struct object_id *oid,
> 
>             want = 1;
>      done:
>     -       if (want && *found_pack && !(*found_pack)->index)
>     -               oe_add_pack(&to_pack, *found_pack);
>     +       if (want && *found_pack && !(*found_pack)->index) {
>     +               if (oe_add_pack(&to_pack, *found_pack) == -1)
>     +                       return 0;

Something like this does seem like a much better fallback, as we'd make
forward progress instead of aborting (and exacerbating whatever caused
the packs to stack up in the first place).

I think the patch as-is does not work, though. You say "oops, too many
packs" and so the "yes we want this object" return becomes "no, we do
not want it". And it is not included in the resulting packfile.

But what happens after that? After pack-objects finishes, we return to
"git repack", which assumes that pack-objects packed everything it was
told to. And with "-d", it then _deletes_ the old packs, knowing that
anything of value was copied to the new pack. So with this patch, we'd
corrupt the repository if this code is ever hit.

You'd need some way to report back to "git repack" that the pack was
omitted. Or probably more sensibly, you'd need "git repack" to count up
the packs and make sure that it marks anybody beyond the limit manually
as .keep (presumably using Duy's new command-line option rather than
actually writing a file).

-Peff
