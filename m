Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAAB82070F
	for <e@80x24.org>; Mon, 19 Sep 2016 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbcISXek (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 19:34:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:45306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753136AbcISXei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 19:34:38 -0400
Received: (qmail 5172 invoked by uid 109); 19 Sep 2016 23:34:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Sep 2016 23:34:37 +0000
Received: (qmail 15344 invoked by uid 111); 19 Sep 2016 23:34:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Sep 2016 19:34:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 16:34:35 -0700
Date:   Mon, 19 Sep 2016 16:34:35 -0700
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC
 PATCH]
Message-ID: <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com>
 <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160919204408.GA28962@cloud>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 01:44:08PM -0700, Josh Triplett wrote:

> On Mon, Sep 19, 2016 at 10:49:17AM -0700, Junio C Hamano wrote:
> > Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> > 
> > > Sounds good to me. Agreed that "RFC" is essentially the only prefix
> > > other than "PATCH" that I see, at least in the kernel.
> > 
> > Around here I think we saw WIP too, and that makes me lean towards
> > Peff's earlier suggestion to allow an end-user supplied string in
> > front of PATCH, i.e. "-P RFC" => "--subject-prefix='RFC PATCH'",
> > even though I understand that those who _ONLY_ care about RFC would
> > prefer --rfc (5 keystrokes) over "-P RFC" (6 keystrokes).
> 
> I do share the concern raised elsewhere in the thread that adding new
> format-patch short options potentially conflicts with diff/rev-list
> short options.  If you're not worried about that, I'd be happy to add
> (and document and test) -P.  However, I'd still advocate adding --rfc as
> well; it's a common case, and "-P RFC" is actually rather more
> keystrokes when you count shifting. :)
> 
> There might also be some value in steering people towards "RFC" (since a
> WIP is in a way an RFC).

Good point. This may be an opportunity to be just slightly opinionated
and nudge people towards a micro-standard.

I was curious what we have used over the years on the git list. So here
are the top hits for:

  # start with a maildir archive
  find git/cur -type f |

  # grab first subject line from each mail
  xargs grep -i -m1 -h ^subject: |

  # pull out only bracketed text, ignore "re: [PATCH]"
  perl -lne '/subject:\s*(\[.*?\])/i and print $1' |

  # normalize numbers; note that a long patch series will be
  # over-represented, since it gets one hit per message
  perl -pe 's/[0-9]+/X/g' |

  # and then sort by count
  sort | uniq -c | sort -rn

The top 5 hits are:

  26252 [PATCH X/X]
  18255 [PATCH]
  17262 [PATCH vX X/X]
   2330 [PATCH vX]
   2297 [PATCHvX X/X]

which is not surprising (our "-v" uses "PATCH vX", which is why that's
so much more common). After that it starts to get interesting, but let's
do two further transformations before the sort to coalesce similar
cases:

  # drop versioning entirely
  perl -pe 's/\s*vX//' |

  # drop multipart subjects
  perl -pe 's{\s*X/X}{}' |

That gives us:

  67081 [PATCH]
   1286 [PATCH/RFC]
   1169 [RFC/PATCH]
    863 [JGIT PATCH]
    832 [ANNOUNCE]
    797 [RFC]
    675 [RFC PATCH]
    537 [StGit PATCH]
    524 [EGIT PATCH]
    367 [BUG]
    169 [StGIT PATCH]
    158 [GUILT]
    142 [PATCH RFC]
    131 [WIP PATCH]
    129 [PATCH/WIP]
    115 [TopGit PATCH]
    115 [PATCH VX]
    ...

Some of those are obviously uninteresting (like "ANNOUNCE" or "BUG").
But I see a few interesting patterns:

  - the "slash" form of RFC/PATCH or PATCH/RFC seems more common than a
    straight prefix (2400 versus about 800)

  - both RFC/PATCH and PATCH/RFC seems similarly popular (but "RFC
    PATCH" is much more popular than "PATCH RFC")

  - WIP is a lot less popular; it seems reasonable that it's a synonym
    for RFC and I don't mind pushing people in that direction

  - there are a non-trivial number of patches for other projects (JGIT,
    EGIT, StGit, etc). This is somewhat unique to git, where we discuss
    a lot of related projects on the list. But I wonder if other
    projects would use subsystems in a similar way (though I guess for
    the kernel, there are separate subsystems lists, so the "to" or "cc"
    header becomes the more interesting tag).

So I dunno what all this means. I do think "--rfc" to standardize on
_some_ form of "RFC PATCH" or "PATCH/RFC" would serve the most people,
and would make things more consistent. But at least in Git, people would
be served by having arbitrary prefixes, too.

I don't have a big opinion on ordering or slashes. The slashes make
sense to me as "this is a patch, and it has these attribute tags" (so
we could even start saying "PATCH/maint" or something, I guess). And
"RFC" functions as such a tag. But for subsystems, putting the tag first
is probably best; I don't care about EGIT patches, so I can immediately
ignore them when it's at the beginning.

As far as your patch goes, I'd be OK with defining:

  --rfc::
	Pretend as if `--subject-prefix='RFC PATCH'` was given.

for now. If we later add:

  -P <tag>::
	Pretend as if `--subject-prefix='<tag> PATCH'` was given.

then `--rfc` naturally becomes:

  --rfc::
	Pretend as if `-P RFC` was given.

in a backwards-compatible way. It doesn't have to all come at once, and
it sounds like `-P` may not be as useful for the kernel (though I'd be
interested if somebody wanted to do a similar count; I don't have a copy
of the kernel archive handy).

-Peff

PS There are some amusing ones as you get far down the list, like "DRY
   HUMOR PATCH". Clearly we need "-P" to encourage such things. :)
