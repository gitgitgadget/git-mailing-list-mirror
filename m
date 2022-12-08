Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94C4C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 07:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiLHH1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 02:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLHH1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 02:27:06 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E44667A
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 23:27:04 -0800 (PST)
Received: (qmail 23623 invoked by uid 109); 8 Dec 2022 07:27:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 07:27:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10011 invoked by uid 111); 8 Dec 2022 07:27:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 02:27:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 02:27:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, David Caro <dcaro@wikimedia.org>,
        git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Message-ID: <Y5GRx86i3ZIiVxb3@coredump.intra.peff.net>
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
 <xmqqlenj7t0b.fsf@gitster.g>
 <20221207084027.7dhyaatkzaawrg4g@vulcanus>
 <Y5EQCD4XCsN10HO+@nand.local>
 <xmqqtu266cj5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu266cj5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 08:04:46AM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> > >     $ git commit --signoff[=[no-]dedup]
> > ...
> > Thanks, I look forward to seeing your work. It would be nice to
> > standardize on this `--signoff[=[no-]dedup]` thing throughout all of the
> > different commands that support it.
> 
> Also, if I am not mistaken, each of trailers can be configured to
> have its own semantics (e.g. .where and .ifExists).
> 
>  * Should we have similar override to these trailer tokens, not just
>    sign-off?

This made me curious about the opposite: is there config you can set to
get this behavior for --signoff? I think the answer is "no". You can do:

  git -c trailer.ifExists=addIfDifferent \
      commit --amend --trailer="Signed-off-by: Jeff King <peff@peff.net>"

to get the desired behavior, but using "--signoff" does not respect
trailer settings.

I feel like config is probably a better match for the use cases here,
because the decision about de-duping is not something you'd usually set
for one particular operation, but is more likely to be a project policy
about what the trailer means (and that includes Signed-off-by). So you'd
want to set it per-repo, not per-operation.

>  * Should we offer not just [no-]dedup (which is equivalent to
>    switching from addIfDifferentNeighbor to addIfDifferent) but
>    other customization?  This affects what --signoff should be
>    allowed to take for consistency across trailers.

Yeah, writing the above made me wonder if --signoff should behave
exactly like:

  --trailer="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"

For the most part that would not change any behavior unless you set
trailer.signed-off-by.*, and setting those presumably signals intent
that you expect them to take effect. The one exception is that the
generic trailer.ifExists, etc, would start affecting --signoff, which
_might_ be a surprise. If we wanted to retain the behavior there, we
could say "--signoff is special, and doesn't respect generic trailer
config".

Alternatively, it would be nice if there was an easy way to put your
ident into a trailer (what I wrote above doesn't really work unless you
have those variables in your environment, and of course it's a lot of
typing). I think you can hack it up like:

  git config trailer.sign.key Signed-off-by
  git config trailer.sign.cmd \
    'git var GIT_COMMITTER_IDENT | sed "s/>.*/>/";:'
  git commit --trailer=sign

which is only a little more typing than --signoff, but it's not very
ergonomic.

-Peff
