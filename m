Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD585C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 05:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjDYFyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjDYFyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 01:54:44 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D904C15
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 22:54:43 -0700 (PDT)
Received: (qmail 21767 invoked by uid 109); 25 Apr 2023 05:54:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 05:54:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 878 invoked by uid 111); 25 Apr 2023 05:54:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 01:54:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 01:54:42 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fixing some parse_commit() timestamp corner cases
Message-ID: <20230425055442.GA4015600@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g>
 <20230418041253.GD60552@coredump.intra.peff.net>
 <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
 <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
 <20230422134150.GA3516940@coredump.intra.peff.net>
 <20230425055244.GA4014505@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425055244.GA4014505@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 01:52:45AM -0400, Jeff King wrote:

> Here's a v2 of my series. The behavior should be identical, but I've
> incorporated some comment and small code tweaks based on feedback from
> the first round.
> 
> I also added a fourth patch which adds a new comment explaining some of
> the cases that were alluded to in the earlier round's patch 3.
> 
>   [1/4]: t4212: avoid putting git on left-hand side of pipe
>   [2/4]: parse_commit(): parse timestamp from end of line
>   [3/4]: parse_commit(): handle broken whitespace-only timestamp
>   [4/4]: parse_commit(): describe more date-parsing failure modes
> 
>  commit.c               | 47 +++++++++++++++++++++++++++++++++++-------
>  t/t4212-log-corrupt.sh | 39 +++++++++++++++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 10 deletions(-)

Whoops, forgot my range-diff (though nothing should be too surprising
based on the round 1 discussion):

1:  07932cf666 = 1:  ac38ce133d t4212: avoid putting git on left-hand side of pipe
2:  7ee34c7d5f ! 2:  f59e61262d parse_commit(): parse timestamp from end of line
    @@ Commit message
         parse back to the final ">". In theory we could use split_ident_line()
         here, but it's actually a bit more strict. In particular, it requires a
         valid time-zone token, too. That should be present, of course, but we
    -    wouldn't want to break --until for malformed cases that are working
    -    currently.
    +    wouldn't want to break --until for cases that are working currently.
     
         We might want to teach split_ident_line() to become more lenient there,
         but it would require checking its many callers (since right now they can
    @@ commit.c: static timestamp_t parse_commit_date(const char *buf, const char *tail
     -	if (buf >= tail)
     +
     +	/*
    -+	 * parse to end-of-line and then walk backwards, which
    -+	 * handles some malformed cases.
    ++	 * Jump to end-of-line so that we can walk backwards to find the
    ++	 * end-of-email ">". This is more forgiving of malformed cases
    ++	 * because unexpected characters tend to be in the name and email
    ++	 * fields.
     +	 */
     +	eol = memchr(buf, '\n', tail - buf);
     +	if (!eol)
      		return 0;
     -	dateptr = buf;
     -	while (buf < tail && *buf++ != '\n')
    -+	for (dateptr = eol; dateptr > buf && dateptr[-1] != '>'; dateptr--)
    - 		/* nada */;
    +-		/* nada */;
     -	if (buf >= tail)
    ++	dateptr = eol;
    ++	while (dateptr > buf && dateptr[-1] != '>')
    ++		dateptr--;
     +	if (dateptr == buf || dateptr == eol)
      		return 0;
     -	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
3:  e8e94083f5 ! 3:  c62fc59bf1 parse_commit(): handle broken whitespace-only timestamp
    @@ Commit message
         It's not subject to the same bug, because it insists that there be one
         or more digits in the timestamp.
     
    -    We can use the same logic here. If there's a non-whitespace but
    -    non-digit value (say "committer name <email> foo"), then
    -    parse_timestamp() would already have returned 0 anyway. So the only
    -    change should be for this "whitespace only" case.
    -
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## commit.c ##
     @@ commit.c: static timestamp_t parse_commit_date(const char *buf, const char *tail)
    - 	if (dateptr == buf || dateptr == eol)
    + 	dateptr = eol;
    + 	while (dateptr > buf && dateptr[-1] != '>')
    + 		dateptr--;
    +-	if (dateptr == buf || dateptr == eol)
    ++	if (dateptr == buf)
      		return 0;
      
    +-	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
     +	/*
    -+	 * trim leading whitespace; parse_timestamp() will do this itself, but
    -+	 * it will walk past the newline at eol while doing so. So we insist
    -+	 * that there is at least one digit here.
    ++	 * Trim leading whitespace; parse_timestamp() will do this itself, but
    ++	 * if we have _only_ whitespace, it will walk right past the newline
    ++	 * while doing so.
     +	 */
     +	while (dateptr < eol && isspace(*dateptr))
     +		dateptr++;
    -+	if (!strchr("0123456789", *dateptr))
    ++	if (dateptr == eol)
     +		return 0;
     +
    - 	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
    ++	/*
    ++	 * We know there is at least one non-whitespace character, so we'll
    ++	 * begin parsing there and stop at worst case at eol.
    ++	 */
      	return parse_timestamp(dateptr, NULL, 10);
      }
    + 
     
      ## t/t4212-log-corrupt.sh ##
     @@ t/t4212-log-corrupt.sh: test_expect_success 'absurdly far-in-future date' '
-:  ---------- > 4:  28ed51a2ca parse_commit(): describe more date-parsing failure modes
