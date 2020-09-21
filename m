Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE6C4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B409323A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIUWUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:20:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:36164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:20:23 -0400
Received: (qmail 10910 invoked by uid 109); 21 Sep 2020 22:20:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Sep 2020 22:20:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26437 invoked by uid 111); 21 Sep 2020 22:20:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Sep 2020 18:20:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Sep 2020 18:20:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        dermoth@aei.ca
Subject: Re: [PATCH v2] diff: Fix modified lines stats with --stat and
 --numstat
Message-ID: <20200921222021.GA3533110@coredump.intra.peff.net>
References: <20200918113256.8699-2-tguyot@gmail.com>
 <20200920130945.26399-1-tguyot@gmail.com>
 <20200920153915.GB2726066@nand.local>
 <xmqqlfh4gt5z.fsf@gitster.c.googlers.com>
 <20200921192630.GA2399334@coredump.intra.peff.net>
 <xmqqft7aer3a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft7aer3a.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 02:51:21PM -0700, Junio C Hamano wrote:

> > This is the direction I was getting at in my earlier emails, except that
> > I imagined that first conditional could be checking:
> >
> >   if (!one->oid_valid || !two->oid_valid)
> >
> > but I was surprised to see that diff_fill_oid_info() does not set
> > oid_valid. Is that a bug?
> 
> I do not think so.  oid_valid refers to the state during the
> collection phase (those who called diff_addremove() etc.) and
> updating it in diff_fill_oid_info() would lose information.  Maybe
> nobody looks at the bit at this late in the processing chain these
> days, in which case we can start flipping the bit there, but I
> offhand do not know what consequences such a change would trigger.

We use the flag to determine whether we need to compute the oid from
scratch. So I would think the current code causes us to compute the oid
multiple times in many cases. For example, with this patch:

diff --git a/diff.c b/diff.c
index ee8e8189e9..8363abab5b 100644
--- a/diff.c
+++ b/diff.c
@@ -4424,6 +4424,8 @@ static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *is
 				die_errno("stat '%s'", one->path);
 			if (index_path(istate, &one->oid, one->path, &st, 0))
 				die("cannot hash %s", one->path);
+			warning("computed oid of %s as %s",
+				one->path, oid_to_hex(&one->oid));
 		}
 	}
 	else

I get (because diff.c is dirty in my working tree due to the patch):

  $ ./git diff --stat -p
  warning: computed oid of diff.c as 8363abab5b51479ac8cc9fb1c96b39fb90041f88
   diff.c | 2 ++
   1 file changed, 2 insertions(+)
  
  warning: computed oid of diff.c as 8363abab5b51479ac8cc9fb1c96b39fb90041f88
  diff --git a/diff.c b/diff.c
  index ee8e8189e9..8363abab5b 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -4424,6 +4424,8 @@ static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *is
   				die_errno("stat '%s'", one->path);
   			if (index_path(istate, &one->oid, one->path, &st, 0))
   				die("cannot hash %s", one->path);
  +			warning("computed oid of %s as %s",
  +				one->path, oid_to_hex(&one->oid));
   		}
   	}
   	else

even though we already know the oid in the second call, so it's wasted
work. I agree that other code could be depending on oid_valid in a weird
way, but IMHO that code is probably wrong to do so. But it may not be
worth digging into, if nobody has complained about the waste.

> > I also imagined that we'd have to determine right then whether the
> > contents are actually different or not with a memcmp(), to avoid
> > emitting a "0 changes" line, but we do handle that case within the
> > "!same_contents" conditional. See the comment starting with "Omit
> > diffstats..." added recently by 1cf3d5db9b (diff: teach --stat to ignore
> > uninteresting modifications, 2020-08-20).
> 
> Yes, we are essentially on the same page---same_contents bit is
> merely an optimization to decide cheaply when we do not have to do
> xdl, but the codepath that does the xdl must be prepared to deal
> with the "we thought they are different, but after all they turn out
> to be equivalent" case.  Therefore false positive to declare two
> different things as same cannot be tolerated, but false negative to
> declare two things that are the same as !same_contents is fine.

I thought it may matter on "maint", where we do not have 1cf3d5db9b.
I.e., I expected:

  echo foo >a
  echo foo >b
  git diff --no-index --stat a b

might switch from no output to having a line like:

  a => b | 0

But we don't even get to builtin_diffstat() there. We throw out the pair
in diffcore_skip_stat_unmatch(). Likewise, if you get past that with
something like a mode change:

  chmod +x b
  git diff --no-index --stat a b

then that does generate the "0" stat line. But it does so both before
and after the proposed change. The same thing happens in no-index mode:

  git init
  echo foo >file
  git add .
  git commit -am no-bit
  chmod +x file
  git commit -am exec-bit
  git show --stat

will give you:

   file | 0

I'm not sure if that's the desired behavior or not, but at any rate
fixing this builtin_diffstat() conditional won't change it either way. :)

-Peff
