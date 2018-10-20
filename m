Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07791F453
	for <e@80x24.org>; Sat, 20 Oct 2018 18:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJUDKR (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 23:10:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727413AbeJUDKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 23:10:17 -0400
Received: (qmail 1994 invoked by uid 109); 20 Oct 2018 18:58:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 20 Oct 2018 18:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24014 invoked by uid 111); 20 Oct 2018 18:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 20 Oct 2018 14:58:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Oct 2018 14:58:53 -0400
Date:   Sat, 20 Oct 2018 14:58:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
Message-ID: <20181020185852.GA6234@sigill.intra.peff.net>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
 <20181018225739.28857-1-avarab@gmail.com>
 <20181019220755.GA31563@sigill.intra.peff.net>
 <87ftx0dg4r.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftx0dg4r.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 01:14:28PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I'd guess this sort of thing is pretty rare. But I wonder if we're
> > crossing the line of trying to assume too much about what the user's
> > arbitrary code does.
> >
> > A simple depth counter can limit the fork bomb, and with a high enough
> > depth would be unlikely to trigger a false positive. It could also
> > protect non-aliases more reasonably, too (e.g., if you have a 1000-deep
> > git process hierarchy, there's a good chance you've found an infinite
> > loop in git itself).
> 
> I don't think this edge case you're describing is very plausible, and I
> doubt it exists in the wild.
> 
> But going by my personal incredulity and a git release breaking code in
> the wild would suck, so agree that I need to re-roll this to anticipate
> that.

I agree it's probably quite rare, if it exists at all. But I also wonder
how important looping alias protection is. It's also rare, and the
outcome is usually "gee, I wonder why this is taking so long? ^C".

At least that's my instinct. I don't remember having run into this at
all myself (though certainly I have written my fair share of infinite
loops in other systems, like bash aliases, and that is what happened).

> I don't have time to write it now, but what do you think about a version
> of this where we introduce a core.recursionLimit setting, and by default
> set it to "1" (for one recursion), so by default die just as we do now,
> but with some advice() saying that we've bailed out early because this
> looks crazy, but you can set it to e.g. "1000" if you think you know
> what you're doing, or "0" for no limit.
> 
> The reason I'd like to do that is because I think it's *way* more common
> to do this accidentally than intentionally, and by having a default
> limit of 1000 we'd print a really long error message, or alternatively
> would have to get into the mess of de-duplicating the callstack as we
> print the error.

Would we print a long error message? I'd assume that we'd just recurse
for longer and print one error message that says:

  fatal: woah, you're 1000-levels deep in Git commands!

That doesn't help the user find the recursion, but re-running with
GIT_TRACE=1 would make it pretty clear, I'd think.

> It also has the advantage that if people in the wild really use this
> they'll chime in about this new annoying core.recursionLimit=1 setting,
> at the cost of me having annoyed them all by breaking their working
> code.

Right, I'm not too happy about that annoyance. But it seems clear that I
think the loop protection is way less important than you do, so I'm
willing to sacrifice (or more accurately, risk the possibility of
sacrificing) a lot less for it. :)

I dunno. I doubt it is likely to help or hinder that many people either
way.

> >> +	cmd_history = strbuf_split_buf(old, strlen(old), ' ', 0);
> >> +	for (ptr = cmd_history; *ptr; ptr++) {
> >> +		strbuf_rtrim(*ptr);
> >> +		string_list_append(cmd_list, (*ptr)->buf);
> >> +	}
> >> +	strbuf_list_free(cmd_history);
> >
> > Maybe string_list_split() would be a little simpler?
> 
> Yeah looks like it. I cargo-culted this from elsewhere without looking
> at that API. I'll look into it.

I cheated before writing that and confirmed that it does seem to work. ;)

Here's the patch in case it is useful. IMHO we should be trying to get
rid of strbuf_split, because it's a pretty crappy interface.

diff --git a/git.c b/git.c
index cba242836c..9d1b66a1fa 100644
--- a/git.c
+++ b/git.c
@@ -675,7 +675,6 @@ static void execv_dashed_external(const char **argv)
 static void init_cmd_history(struct strbuf *env, struct string_list *cmd_list)
 {
 	const char *old = getenv(COMMAND_HISTORY_ENVIRONMENT);
-	struct strbuf **cmd_history, **ptr;
 
 	if (!old || !*old)
 		return;
@@ -683,12 +682,7 @@ static void init_cmd_history(struct strbuf *env, struct string_list *cmd_list)
 	strbuf_addstr(env, old);
 	strbuf_rtrim(env);
 
-	cmd_history = strbuf_split_buf(old, strlen(old), ' ', 0);
-	for (ptr = cmd_history; *ptr; ptr++) {
-		strbuf_rtrim(*ptr);
-		string_list_append(cmd_list, (*ptr)->buf);
-	}
-	strbuf_list_free(cmd_history);
+	string_list_split(cmd_list, env->buf, ' ', -1);
 }
 
 static void add_cmd_history(struct strbuf *env, struct string_list *cmd_list,

-Peff
