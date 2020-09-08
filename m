Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFFFC2D0A7
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09292074D
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbgIHQkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:40:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731857AbgIHQjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:39:48 -0400
Received: (qmail 27294 invoked by uid 109); 8 Sep 2020 13:53:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Sep 2020 13:53:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24296 invoked by uid 111); 8 Sep 2020 13:53:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Sep 2020 09:53:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Sep 2020 09:53:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] pretty: allow to override the built-in formats
Message-ID: <20200908135303.GA2448968@coredump.intra.peff.net>
References: <20200905192406.74411-1-dev+git@drbeat.li>
 <20200905195218.GA892287@generichostname>
 <xmqqeene36t7.fsf@gitster.c.googlers.com>
 <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
 <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 06, 2020 at 11:54:42PM -0700, Junio C Hamano wrote:

> > I gave a reason for the reference format, at least.
> >
> > Would you be fine with a patch that just allows to override the
> > reference format (for the stated reasons)?
> 
> Your "reason" read pretty much the same as "I want reference to do
> something else", but that leads to "depending on the configuration,
> even built-in names that are well known to all Git users behave
> differently---the users lose common reference (no pun intended)".

I think there is some value in having names and rough semantics that are
well-known to all Git users (and scripts), but whose exact output is not
set in stone.  So a name like "reference" becomes a rendezvous point
between a script like gitk and the user. It is a shorthand for
"reference a commit in a human-readable way according to the user or
project preferences". The script wants to read that value, and the user
wants to specify it.

You could accomplish something similar by having gitk look up
pretty.userReference, and defaulting to something sensible if it's not
defined. For a big script like gitk that's not too much of an
imposition. But it's awfully convenient to be able to just say
--format=reference in any script and get the user's preferred format.

That's where I think your pretty.kernel example falls down; both the
repo and the script have to agree that the name "kernel" exists.

> Also I am not sure how your reason applies specifically to the
> reference format.  It would be widely applicable to other formats
> like 'short' and 'oneline' in that depending on projects' and
> personal preference, people may want "something like X but not
> exactly X" for all the built-in formats.

The things that may make "reference" different are:

 - it's new-ish, so there's less chance of historical dependencies on it
   (this is a bit hand-wavy, of course; it has been in released
   versions. On the other hand, people may well have been using
   pretty.reference for this already, and we made it stop working when
   we added "reference").

 - from the start, the point was for it to be a human-readable format
   (it's not even unambiguously parseable anyway).

So of any of the formats, it seems like the most likely candidate for
such a feature (setting "pretty.raw" would be a pretty big foot-gun, for
instance). I don't like the inconsistency it introduces between formats,
though.

Here's a slightly different proposal. I'm not sure if I like it or not,
but just thinking out loud for a moment. The issue is that we're worried
the consumer of the output may be surprised by a user-configured pretty
format. Can we give them a way to say "I don't care about the exact
output; pick what the user configured for this name, or some sane
default". I.e., something like:

  git log --format=loose:reference

? That would let pretty.reference override the built-in name, but the
behavior of plain "--format=reference" would continue to ignore it. It's
a little more annoying for a script to specify, but not nearly as
annoying as:

  format=$(git config pretty.customReference || echo "%h (%s, %d)")
  git log --format="%format"

-Peff
