Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E5C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 11:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjDZLhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDZLhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 07:37:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067373598
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:36:59 -0700 (PDT)
Received: (qmail 6909 invoked by uid 109); 26 Apr 2023 11:36:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Apr 2023 11:36:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13883 invoked by uid 111); 26 Apr 2023 11:36:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Apr 2023 07:36:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Apr 2023 07:36:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Message-ID: <20230426113658.GC130148@coredump.intra.peff.net>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
 <20230425055458.GC4015649@coredump.intra.peff.net>
 <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
 <xmqqttx43q08.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttx43q08.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 09:06:47AM -0700, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > This probably doesn't matter in practice but we define our own
> > isspace() that does not treat '\v' and '\f' as whitespace. However
> > parse_timestamp() (which is just strtoumax()) uses the standard
> > library's isspace() which does treat those characters as whitespace
> > and is locale dependent. This means we can potentially stop at a
> > character that parse_timestamp() treats as whitespace and if there are
> > no digits after it we'll still walk past the end of the line. Using
> > Rene's suggestion of testing the character with isdigit() would fix
> > that. It would also avoid parsing negative timestamps as positive
> > numbers and reject any timestamps that begin with a locale dependent
> > digit.
> 
> A very interesting observation.  I wonder if a curious person can
> craft a malformed timestamp with "hash-object --literally" to do
> more than DoS themselves?

I think the answer is no, because the worst case is that they read to
the trailing NUL that we stick after any object content we read into
memory. So we'd mis-parse:

  committer name <email> \v\n

  123456 in the subject line

to read "123456" as the commit timestamp (so basically the same bug my
patch was trying to fix). But we'd never read out-of-bounds memory.
Still, it does not give me warm fuzzies, and I think is worth fixing.

> We are not going to put anything other than [ 0-9+-] after the '>'
> we scan for, and making sure '>' is followed by SP and then [0-9]
> would be sufficient to ensure strtoumax() to stop before the '\n'
> but does not ensure that the "signal a bad timestamp with 0"
> happens.  Perhaps that would be sufficient.  I dunno.

Any single non-whitespace character at all would be sufficient to avoid
the problem. And that's what the current iteration of the patch is
trying to do. It's just that our definition of "whitespace" has to agree
with strtoumax()'s for it to work. And as Phillip notes, that may even
include locale dependent characters. So I don't think we want to get
into trying to match them all (i.e., a "allow known" strategy).

Instead, we should go back to what the original iteration of the series
was doing, and make sure there is at least one digit (i.e., a "forbid
unknown" strategy). Assuming that there is no locale where ascii "1" is
considered whitespace. ;)

Note that will exclude a few cases that we do allow now, like:

  committer name <email> \v123456 +0000\n

Right now that parses as "123456", but we'd reject it as "0" after such
a patch.

The alternative is to check _all_ of the characters between ">" and the
newline and make sure there is some digit somewhere, which would be
sufficient to prevent strtoumax() from walking past the newline.

I guess it's not even any more expensive in the normal case (since the
very first non-whitespace entry should be a digit!). I'm not sure it's
worth caring about too much either way. Garbage making it into
name/email is an easy mistake to make (for users and implementations).
Putting whitespace control codes into your timestamp is not, and marking
them as "0" is an OK outcome.

-Peff
