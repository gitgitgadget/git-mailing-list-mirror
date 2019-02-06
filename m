Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 724221F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfBFS0R (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:26:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:34780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725784AbfBFS0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:26:17 -0500
Received: (qmail 8500 invoked by uid 109); 6 Feb 2019 18:26:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 18:26:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4029 invoked by uid 111); 6 Feb 2019 18:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 13:26:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 13:26:12 -0500
Date:   Wed, 6 Feb 2019 13:26:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        William Hubbs <williamh@gentoo.org>, chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190206182612.GA10231@sigill.intra.peff.net>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <87h8dhl0zh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8dhl0zh.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 10:28:34AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I did some further digging. One of the confusing things is that we've
> been carrying dead code since 2012 to set this
> author_ident_explicitly_given variable. We can just apply this on top of
> master:
> [...]
>     @@ -434,6 +432,2 @@ const char *git_author_info(int flag)
>      {
>     -	if (getenv("GIT_AUTHOR_NAME"))
>     -		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
>     -	if (getenv("GIT_AUTHOR_EMAIL"))
>     -		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
>      	return fmt_ident(getenv("GIT_AUTHOR_NAME"),

Yeah, that would be OK with me. It's conceivable somebody ask "was the author
ident sufficiently given", but given that 7 years have passed, it seems
unlikely (and it's easy to resurrect it in the worst case).

But...

> A more complete "fix" is to entirely revert Jeff's d6991ceedc ("ident:
> keep separate "explicit" flags for author and committer",
> 2012-11-14). As he noted in 2012
> (https://public-inbox.org/git/20121128182534.GA21020@sigill.intra.peff.net/):
> 
>     I do not know if anybody will ever care about the corner cases it
>     fixes, so it is really just being defensive for future code.

I think that reintroduces some oddness. E.g., if I don't have any ident
information set in config or the environment, and I do:

  GIT_AUTHOR_NAME=me GIT_AUTHOR_EMAIL=me@example.com git commit ...

that shouldn't count as "committer ident sufficiently given", and should
still give a warning. So we wouldn't want to conflate them in a single
flag (which is what d6991ceedc fixed). Curiously, though, I'm not sure
you can trigger the problem through git-commit. It does call
committer_ident_sufficiently_given(), but it never calls
git_author_info(), where we set the flags!

Instead, it does its own parse via determine_author_info(), which does
not bother to set the "explicit" flag at all. I suspect this could be
refactored share more code with git_author_info() (which is what the
plumbing commit-tree uses). But that's all a side note here.

There is one other call to check that the committer ident is
sufficiently given, and that's in sequencer.c, when it prints a picked
commit's info. That _might_ be triggerable (it doesn't call
git_author_info() in that code path, but do_merge() does, so if the two
happen in the same process, you'd not see the "Committer:" info line
when you should).

So the bugs are minor and fairly unlikely. But I do think it's worth
keeping the flags separate (even if we don't bother carrying an "author"
one), just because it's an easy mistake to make.

An alternative view is that anybody who calls git_author_info() to
create a commit _should_ be checking author_ident_sufficiently_given(),
and it's a bug that they're not.

I.e., should we be doing something like this (and probably some other
spots, too):

diff --git a/commit.c b/commit.c
index a5333c7ac6..c99b311a48 100644
--- a/commit.c
+++ b/commit.c
@@ -1419,8 +1419,11 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	}
 
 	/* Person/date information */
-	if (!author)
+	if (!author) {
 		author = git_author_info(IDENT_STRICT);
+		if (!author_ident_sufficiently_given())
+			warning("your author ident was auto-detected, etc...");
+	}
 	strbuf_addf(&buffer, "author %s\n", author);
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_STRICT));
 	if (!encoding_is_utf8)

I dunno. It seems pretty low priority, and nobody has even noticed after
all these years. So I'm not sure if it's worth spending too much time on
it.

-Peff
