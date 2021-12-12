Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C2C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhLLUyO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 12 Dec 2021 15:54:14 -0500
Received: from elephants.elehost.com ([216.66.27.132]:56596 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLLUyN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:54:13 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BCKs0Ar071720
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 12 Dec 2021 15:54:02 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Philip Oakley'" <philipoakley@iee.email>,
        "'Glen Choo'" <chooglen@google.com>,
        "'Git List'" <git@vger.kernel.org>
References: <e30ae0dd-739b-7ecd-735e-992395b31ccc@iee.email> <kl6ltufg843d.fsf@chooglen-macbookpro.roam.corp.google.com> <7ffa36ab-da93-0fe7-8d21-f489b16a3340@iee.email>
In-Reply-To: <7ffa36ab-da93-0fe7-8d21-f489b16a3340@iee.email>
Subject: RE: New (better?) hash map technique in limit case.
Date:   Sun, 12 Dec 2021 15:53:54 -0500
Organization: Nexbridge Inc.
Message-ID: <000001d7ef9a$6493d150$2dbb73f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLA95Z8aQbjx9S5ytaZs4PeYyqWrgIV2jqmAd3MLtWqPZ9VcA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 12, 2021 12:44 PM, Philip Oakley:
> To: Glen Choo <chooglen@google.com>; Git List <git@vger.kernel.org>
> Subject: Re: New (better?) hash map technique in limit case.
> 
> Hi Glen,
> On 10/12/2021 22:52, Glen Choo wrote:
> > Philip Oakley <philipoakley@iee.email> writes:
> >
> >> Recently I saw a report [1] on a new theoretical result about how to
> >> manage hash maps which get nearly 'full', which beats Knuth's limit
> >> formula. The full paper is at [2]
> >>
> >> As I understand it, the method adds the gravestone entries early
> >> during has collisions to avoid clumping of such collision insertions,
> >> rather than always having to enter the collision list at the end.
> >> This keeps the available slots relatively randomly spaced.
> >>
> >> It feels like the old random bus arrival problem where the average
> >> wait for next bus is identical to the average time since the last
> >> bust, which is the same as the average bus interval (thus 1 + 1 = 1),
> >> and the technique maintains that advantageous perception.
> >>
> >> Given Git's use of hashes, it sounds like it could have uses,
> >> assuming the theory pans out. I've not yet gone through the paper
> >> itself [2] but hope springs eternal.
> >>
> >> Philip
> >>
> >> [1]
> >> S. Nadis and M. I. of Technology, “Theoretical breakthrough could
> >> boost data storage.”
> >> https://techxplore.com/news/2021-11-theoretical-breakthrough-boost-
> st
> >> orage.html
> >> (accessed Nov. 18, 2021).
> >>
> >> [2]
> >> M. A. Bender, B. C. Kuszmaul, and W. Kuszmaul, “Linear Probing
> >> Revisited: Tombstones Mark the Death of Primary Clustering,”
> >> arXiv:2107.01250 [cs, math], Jul. 2021, Accessed: Nov. 18, 2021.
> >> [Online]. Available: http://arxiv.org/abs/2107.01250
> > Very interesting, thanks for sharing. I haven't read the full paper
> > either, but this is an interesting result.
> >
> > It seems that this result is limited to hashmaps with a approximately
> > equal number of insertions and deletions..
> >
> > From [1]
> >
> >   They found that for applications where the number of insertions and
> >   deletions stays about the same—and the amount of data added is roughly
> >   equal to that removed—linear-probing hash tables can operate at high
> >   storage capacities without sacrificing speed.apacities without
> >   sacrificing speed.
> >
> > and [2]
> >
> >   ...We then turn our attention to sequences of operations that contain
> >   deletions, and show that the tombstones left behind by those deletions
> >   have a primary-anti-clustering effect, that is, they have a tendency
> >   to speed up future insertions
> >
> > Do we have any such use cases?
> I know that we use hash maps, but haven't followed there actual usage in
> various optimisations.
> 
> Obviously we use hash naming of objects but that's generally a red-herring, I
> think, unless we are over-abbreviating the hash so that it's no longer unique
> (which could be happening somewhere).
> 
> I suspect that some of the hosting providers may be more interested from a
> File system perspective, as I think we just pass the object store problems to
> the FS. Then again, all the mono-repo and partial checkout corporate users
> are likely to be interested, especially if this unblocks some historical
> misunderstanding about the limits and how to handle them.

If we are going to change data structures for object hashes, it might be better to use a compressed trie data structure (trie is not a typo for tree). This can be mapped easily to the current FS structure in .git/objects - in fact, .git/objects is mappable to a two-level compressed trie with a top level of 2 characters. Extending the data structure model both in memory and on the file system to become multi-level instead of just 2 levels should not be particularly onerous and has a O(1) search speed that, at worst, is the same as a perfect closed hash and the same as an open hash with single entries in buckets. Once open hashes degenerate to have long chains, the compressed trie is substantially more time efficient. A trie is an O(1) lookup and insert in all cases and does not degenerate like hashes or trees do. Uncompressed tries are generally extremely less space efficient than hashes (making them quite bad for our purposes) but compressed tries substantially reduce wasted space with a trade-off of some time to do node-splits on insert and single-level mid-key lookups.

Note: In a FS look up, the search is not O(1) unless the FS is also implemented as a trie, so the benefit on disk will not be as fully realized, although if you can get the compression to fit into a directory inode block, the search speeds up significantly because of reduced I/Os. A FS existence search is O(n,m) where n is the maximum number of partitions in the trie's key, and m is the maximum number of files within a directory IF the key partitioning compression is not known - if it IS known, then the FS existence search is O(m). This n is different (much smaller) than the total number of entries in the hash. As an example, a sample repo has 2607 entries under object, and the key partitioned length (n) is always 2, representing, as an example, 00/16212c76018d27bd1a39630c32d1027fbfbebd. Keeping the key partitioning unknown allows the searcher to adapt to any repository trie compression, including existing ones, so there's that advantage.

-Randall

