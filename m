Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54A771F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932859AbeAXWTk (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:19:40 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58436 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXWTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:19:39 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.90)
        (envelope-from <mh@glandium.org>)
        id 1eeTOI-0004BQ-5l; Thu, 25 Jan 2018 07:19:34 +0900
Date:   Thu, 25 Jan 2018 07:19:34 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?iso-8859-15?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180124221932.v6up7j67llwhjox4@glandium.org>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmhiykvw.fsf@evledraar.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 11:03:47PM +0100, Ævar Arnfjörð Bjarmason wrote:
> If you have a bunch of git repositories cloned of the same project on
> the same filesystem, it would be nice of the packs that are produced
> would be friendly to block-level deduplication.
> 
> This would save space, and the blocks would be more likely to be in
> cache when you access them, likely speeding up git operations even if
> the packing itself is less efficient.
> 
> Here's a hacky one-liner that clones git/git and peff/git (almost the
> same content) and md5sums each 4k packed block, and sort | uniq -c's
> them to see how many are the same:
> 
>     (
>        cd /tmp &&
>        rm -rf git*;
>        git clone --reference ~/g/git --dissociate git@github.com:git/git.git git1 &&
>        git clone --reference ~/g/git --dissociate git@github.com:peff/git.git git2 &&
>        for repo in git1 git2
>        do
>            (
>                cd $repo &&
>                git repack -A -d --max-pack-size=10m
>            )
>        done &&
>        parallel "perl -MDigest::MD5=md5_hex -wE 'open my \$fh, q[<], shift; my \$s; while (read \$fh, \$s, 2**12) { say md5_hex(\$s) }' {}" ::: \
>            $(find /tmp/git*/.git/objects/pack -type f)|sort|uniq -c|sort -nr|awk '{print $1}'|sort|uniq -c|sort -nr
>     )
> 
> This produces a total of 0 blocks that are the same. If after the repack
> we throw this in there after the repack:
> 
>     echo 5be1f00a9a | git pack-objects --no-reuse-delta --no-reuse-object --revs .git/objects/pack/manual
> 
> Just over 8% of the blocks are the same, and of course this pack
> entirely duplicates the existing packs, and I don't know how to coerce
> repack/pack-objects into keeping this manual-* pack and re-packing the
> rest, removing any objects that exist in the manual-* pack.
> 
> Documentation/technical/pack-heuristics.txt goes over some of the ideas
> behind the algorithm, and Junio's 1b4bb16b9e ("pack-objects: optimize
> "recency order"", 2011-06-30) seems to be the last major tweak to it.
> 
> I couldn't find any references to someone trying to get this particular
> use-case working on-list. I.e. to pack different repositories with a
> shared history in such a way as to optimize for getting the most amount
> of identical blocks within packs.
> 
> It should be possible to produce such a pack, e.g. by having a repack
> mode that would say:
> 
>  1. Find what the main branch is
>  2. Get its commits in reverse order, produce packs of some chunk-size
>     of commit batches.
>  3. Pack all the remaining content
> 
> This would delta much less efficiently, but as noted above the
> block-level deduplication might make up for it, and in any case some
> might want to use less disk space.
> 
> Has anyone here barked up this tree before? Suggestions? Tips on where
> to start hacking the repack code to accomplish this would be most
> welcome.

FWIW, I sidestep the problem entirely by using alternatives.

Mike
