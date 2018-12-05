Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE3B211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 06:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeLEGKh (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 01:10:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:59434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726092AbeLEGKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 01:10:37 -0500
Received: (qmail 1582 invoked by uid 109); 5 Dec 2018 06:10:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 06:10:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28397 invoked by uid 111); 5 Dec 2018 06:10:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 01:10:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 01:10:35 -0500
Date:   Wed, 5 Dec 2018 01:10:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/3] sha1-file: emit error if an alternate looks like a
 repository
Message-ID: <20181205061035.GB12980@sigill.intra.peff.net>
References: <87tvjtvah0.fsf@evledraar.gmail.com>
 <20181204132716.19208-3-avarab@gmail.com>
 <xmqqzhtkd4sz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhtkd4sz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 12:35:08PM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Since 26125f6b9b ("detect broken alternates.", 2006-02-22) we've
> > emitted an error if the alternates directory doesn't exist, but not
> > for the common misstep of adding a path to another git repository as
> > an alternate, as opposed to its "objects" directory.
> >
> > Let's check for this, i.e. whether X/objects or X/.git/objects exists
> > if the user supplies X and print an error (which as a commit leading
> > up to this one shows doesn't change the exit code, just "warns").
> 
> I agree that "Let's check for this" is a good idea, but do not
> necessarily agree with "i.e.".  Don't we have a helper that takes
> the path to an existing directory and answers "Yup, it does look
> like a Git repository"?  Using that is a lot more in line with what
> you claimed to do in the title for this patch.

Hmm. Yeah, one case this does not handle is when ".git" is a git-file
pointing elsewhere, which should trigger the condition, too.

I think we can afford to be a bit loose with this check if it's just
generating a warning for a case that would otherwise not work (and the
worst is that we might fail to correctly diagnose a broken setup). But
that I think points to another issue: this kicks in even if the path is
otherwise usable.

So if had, say, a git repository whose worktree was full of objects and
packfiles, it currently works for me to point to that as an alternate.
But after this patch, we'd complain "wait, this looks like a git repo!".

So I'd much rather see the logic check first for something usable, and
only when we fail to find it, start doing a loose diagnosis. Something
like:

  if !is_directory($path)
	complain that it does not exist, as now
  else if !is_directory($path/pack)
	/*
	 * it doesn't look like an object directory; technically it
	 * _could_ just have loose objects, and maybe we ought to check
	 * for directories matching [0-9a-f]{2}, though it seems
	 * somewhat unlikely these days.
	 */
	if is_directory($path/objects) || exists($path/.git)
		complain that it looks like a git dir
	else
		complain that it doesn't look like an object dir
  fi

Hmm. I managed to write a gross mix of C and shell for my pseudocode,
but hopefully you can read it. ;)

> I haven't read 3/3 yet, but as I said, I suspect it is reasonable to
> DWIM and use the object store associated with the directory we found
> to be a repository.

Yeah, I'm tempted by that, too, though I worry about corner cases. How
much effort should we put into discovery? I guess the rules from
enter_repo() would make sense, though the logic in that function would
need some refactoring to be reused elsewhere.

-Peff
