Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC0A1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 10:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfHYKCY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 06:02:24 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:41186 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfHYKCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 06:02:24 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i1pLh-0002Zy-9e; Sun, 25 Aug 2019 19:02:13 +0900
Date:   Sun, 25 Aug 2019 19:02:13 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 2/2] fast-import: duplicate into history rather than
 passing ownership
Message-ID: <20190825100213.fssjydohathfhhe5@glandium.org>
References: <20190825080640.GA31453@sigill.intra.peff.net>
 <20190825081055.GB31824@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825081055.GB31824@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 04:10:55AM -0400, Jeff King wrote:
> Fast-import's read_next_command() has somewhat odd memory ownership
> semantics for the command_buf strbuf. After reading a command, we copy
> the strbuf's pointer (without duplicating the string) into our cmd_hist
> array of recent commands. And then when we're about to read a new
> command, we clear the strbuf by calling strbuf_detach(), dropping
> ownership from the strbuf (leaving the cmd_hist reference as the
> remaining owner).
> 
> This has a few surprising implications:
> 
>   - if the strbuf hasn't been copied into cmd_hist (e.g., because we
>     haven't ready any commands yet), then the strbuf_detach() will leak
>     the resulting string
> 
>   - any modification to command_buf risks invalidating the pointer held
>     by cmd_hist. There doesn't seem to be any way to trigger this
>     currently (since we tend to modify it only by detaching and reading
>     in a new value), but it's subtly dangerous.
> 
>   - any pointers into an input string will remain valid as long as
>     cmd_hist points to them. So in general, you can point into
>     command_buf.buf and call read_next_command() up to 100 times before
>     your string is cycled out and freed, leaving you with a dangling
>     pointer. This makes it easy to miss bugs during testing, as they
>     might trigger only for a sufficiently large commit (e.g., the bug
>     fixed in the previous commit).
> 
> Instead, let's make a new string to copy the command into the history
> array, rather than having dual ownership with the old. Then we can drop
> the strbuf_detach() calls entirely, and just reuse the same buffer
> within command_buf over and over. We'd normally have to strbuf_reset()
> it before using it again, but in both cases here we're using
> strbuf_getline(), which does it automatically for us.
> 
> This fixes the leak, and it means that even a single call to
> read_next_command() will invalidate any held pointers, making it easier
> to find bugs. In fact, we can drop the extra input lines added to the
> test case by the previous commit, as the unfixed bug would now trigger
> just from reading the commit message, even without any modified files in
> the commit.
> 
> Reported-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fast-import.c          | 4 +---
>  t/t9300-fast-import.sh | 5 -----
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index ee7258037a..1f9160b645 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1763,7 +1763,6 @@ static int read_next_command(void)
>  		} else {
>  			struct recent_command *rc;
>  
> -			strbuf_detach(&command_buf, NULL);
>  			stdin_eof = strbuf_getline_lf(&command_buf, stdin);
>  			if (stdin_eof)
>  				return EOF;
> @@ -1784,7 +1783,7 @@ static int read_next_command(void)
>  				free(rc->buf);
>  			}
>  
> -			rc->buf = command_buf.buf;
> +			rc->buf = xstrdup(command_buf.buf);

You could xstrndup(command_buf.buf, command_buf.len), which would avoid
a hidden strlen.

Mike
