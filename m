Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91601F453
	for <e@80x24.org>; Fri, 19 Oct 2018 22:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeJTGPw (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 02:15:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:47104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726282AbeJTGPw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 02:15:52 -0400
Received: (qmail 6623 invoked by uid 109); 19 Oct 2018 22:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 22:07:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16519 invoked by uid 111); 19 Oct 2018 22:07:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 18:07:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 18:07:55 -0400
Date:   Fri, 19 Oct 2018 18:07:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
Message-ID: <20181019220755.GA31563@sigill.intra.peff.net>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
 <20181018225739.28857-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018225739.28857-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 10:57:39PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Add detection for aliasing loops in cases where one of the aliases
> re-invokes git as a shell command. This catches cases like:
> 
>     [alias]
>     foo = !git bar
>     bar = !git foo
> 
> Before this change running "git {foo,bar}" would create a
> forkbomb. Now using the aliasing loop detection and call history
> reporting added in 82f71d9a5a ("alias: show the call history when an
> alias is looping", 2018-09-16) and c6d75bc17a ("alias: add support for
> aliases of an alias", 2018-09-16) we'll instead report:
> 
>     fatal: alias loop detected: expansion of 'foo' does not terminate:
>       foo <==
>       bar ==>

The regular alias expansion can generally assume that there's no
conditional recursion going on, because it's expanding everything
itself. But when we involve multiple processes, things get trickier.

For instance, I could do this:

  [alias]
  countdown = "!f() { echo \"$@\"; test \"$1\" -gt 0 && git countdown $(($1-1)); }; f"

which works now, but not with your patch.

Now obviously that's a silly toy example, but are there real cases which
might trigger this? Some plausible ones I can think of:

  - an alias which handles some special cases, then chains to itself for
    the simpler one (or to another alias or script, which ends up
    chaining back to the original)

  - an alias that runs a git command, which then spawns a hook or other
    user-controlled script, which incidentally uses that same alias

I'd guess this sort of thing is pretty rare. But I wonder if we're
crossing the line of trying to assume too much about what the user's
arbitrary code does.

A simple depth counter can limit the fork bomb, and with a high enough
depth would be unlikely to trigger a false positive. It could also
protect non-aliases more reasonably, too (e.g., if you have a 1000-deep
git process hierarchy, there's a good chance you've found an infinite
loop in git itself).

> +static void init_cmd_history(struct strbuf *env, struct string_list *cmd_list)
> +{
> +	const char *old = getenv(COMMAND_HISTORY_ENVIRONMENT);
> +	struct strbuf **cmd_history, **ptr;
> +
> +	if (!old || !*old)
> +		return;
> +
> +	strbuf_addstr(env, old);
> +	strbuf_rtrim(env);
> +
> +	cmd_history = strbuf_split_buf(old, strlen(old), ' ', 0);
> +	for (ptr = cmd_history; *ptr; ptr++) {
> +		strbuf_rtrim(*ptr);
> +		string_list_append(cmd_list, (*ptr)->buf);
> +	}
> +	strbuf_list_free(cmd_history);

Maybe string_list_split() would be a little simpler?

-Peff
