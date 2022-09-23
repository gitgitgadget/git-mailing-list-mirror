Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE69C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 21:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiIWV67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWV66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 17:58:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0B0E7434
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:58:57 -0700 (PDT)
Received: (qmail 14694 invoked by uid 109); 23 Sep 2022 21:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Sep 2022 21:58:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17354 invoked by uid 111); 23 Sep 2022 21:58:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Sep 2022 17:58:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Sep 2022 17:58:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqillevzeh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 09:17:10AM -0700, Junio C Hamano wrote:

> Not a suggestion to use a different implementation or add a new
> feature on top of this --group-by-time-range idea, but I wonder if
> it is a more flexible and generalizeable approach to say "formulate
> this value given by the --format=<format> string, apply this regular
> expression match, and group by the subexpression value".  E.g.
> 
>     git shortlog \
> 	--group-by-value="%cI" \
> 	--group-by-regexp="^(\d{4}-\d{2})"

Heh, I was about to make the exact same suggestion. The existing
"--group=author" could really just be "--group='%an <%ae>'" (or variants
depending on the "-e" flag).

I don't think you even really need the regexp. If we respect --date,
then you should be able to ask for --date=format:%Y-%m. Unfortunately
there's no way to specify the format as part of the placeholder. The
for-each-ref formatter understands this, like:

  %(authordate:format:%Y-%m)

I wouldn't be opposed to teaching the git-log formatter something
similar.

> That's a better way to implement "group by month" internally, and
> allow more flexibility.  If a project is well disciplined and its
> commit titles follow the "<area>: <description>" convention, you
> probably could do
> 
>     git shortlog --no-merges \
> 	--group-by-value="%s" \
> 	--group-by-regexp="^([^:]+):"
> 
> and group by <area> each commit touches.  Of course, existing
> --committer and --author can also be internally reimplemented using
> the same mechanism.

This example makes the regex feature more interesting, because it's not
something we'd likely have a unique placeholder for (or maybe we
should?).

But there's something else interesting going on in Jack's patch, which
is that he's not just introducing the date-sorting, but also that it's
used in conjunction with other sorting. So really the intended use is
something like:

  git shortlog --group:author --group:%Y-%m

I think we'd want to allow the general form to be a series of groupings.
In the output from his patch it looks like:

  2022-09 Jeff King
     some commit message
     another commit message

I.e., the groups are collapsed into a single string, and unique strings
become their own groups (and are sorted in the usual way).

If you give up the regex thing, then that naturally falls out as
(imagining we learn about authordate as a placeholder):

  git shortlog --group='%(authordate:format=%Y-%n) %an'

without having to implement multiple groupings as a specific feature
(which is both more code, but also has user-facing confusion about when
--group overrides versus appends). That also skips the question of which
--group-by-regex applies to which --group-by-value.

I do agree the regex thing is more flexible, but if we can't come up
with a case more compelling than subsystem matching, I'd just as soon
add %(subject:subsystem) or similar. :)

-Peff
