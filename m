Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18319C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 16:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCMQnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 12:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCMQnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 12:43:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FCD902D
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 09:43:06 -0700 (PDT)
Received: (qmail 21672 invoked by uid 109); 13 Mar 2023 16:43:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Mar 2023 16:43:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8662 invoked by uid 111); 13 Mar 2023 16:43:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Mar 2023 12:43:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Mar 2023 12:43:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
Message-ID: <ZA9SmZaUyrgbH2fb@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
 <xmqq5yb9q42e.fsf@gitster.g>
 <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net>
 <xmqqcz5g7d2i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz5g7d2i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 09:04:21AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > While it is not _quite_ the same thing to say "use prefixes a/ and b/"
> > versus "countermand any config and use the default", it is close enough
> > that I am tempted to say this patch should be scrapped. I mostly just
> > wanted to have a way to counter format.noprefix, if we are going to
> > endorse it as a concept (whether by adding it, or saying "no, respecting
> > diff.noprefix is not a bug").
> >
> > (If we do scrap it, I'd probably fold the extra tests into the previous
> > commit, but using --src-prefix, etc).
> 
> I would very much like to keep this one; if we can find a shorter
> name that would be even sweeter.

OK. I don't mind keeping it, if you think it's useful (and certainly it
doesn't hurt). I couldn't come up with a better name, but suggestions
are welcome.

By the way, we might also want something like this:

diff --git a/builtin/rebase.c b/builtin/rebase.c
index dd31d5ab91e..5b7b908b66b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -661,7 +661,7 @@ static int run_am(struct rebase_options *opts)
 	format_patch.git_cmd = 1;
 	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 		     "--full-index", "--cherry-pick", "--right-only",
-		     "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
+		     "--default-prefix", "--no-renames",
 		     "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
 		     "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)

which uses --src-prefix to (you may have guessed it!) counteract
diff.noprefix in the user's config. (It would still be necessary even
with my series because the user might have set format.patch).

> I am wondering if we can keep the current behaviour instead and send
> a message: "if you do not want your everyday diff not to have
> prefixes, fine, go set diff.noprefix, but if you do not like that
> format-patch also gives a no-prefix patches with that configuration,
> or at times you may want your 'git show' to show the standard
> prefix, you can countermand your diff.noprefix configuration".

Sure, but how do we send that message? I guess if we leave diff.noprefix
as it is and add a new format.patch (which preempts diff.noprefix only
for format-patch), then people will still accidentally send patches
without prefixes, but at least there is an "out" for the maintainer
receiving them to say "don't do that; please set format.patch".

I was hoping to avoid having the accident happen in the first place, but
if we're not willing to change how diff.noprefix works now, then I think
that's our runner-up.

It would be pretty easy to rework the series (drop patch 4, and tweak
patch 5 to be a yes/no/unset tri-state, plus a new test to check the
fallback behavior).

-Peff
