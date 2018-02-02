Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED271F576
	for <e@80x24.org>; Fri,  2 Feb 2018 07:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeBBHPW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 02:15:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:38008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750781AbeBBHPU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 02:15:20 -0500
Received: (qmail 5308 invoked by uid 109); 2 Feb 2018 07:15:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Feb 2018 07:15:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16545 invoked by uid 111); 2 Feb 2018 07:16:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Feb 2018 02:16:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Feb 2018 02:15:18 -0500
Date:   Fri, 2 Feb 2018 02:15:18 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] reset --hard: make use of the pretty machinery
Message-ID: <20180202071518.GB16533@sigill.intra.peff.net>
References: <20180201205721.30087-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201205721.30087-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 01, 2018 at 08:57:21PM +0000, Thomas Gummerer wrote:

> It is a slight change of the output if the second line of the commit
> message is not a blank line, i.e. if the commit message is
> 
>     foo
>     bar
> 
> previously we would print "HEAD is now at 000000 foo", while after
> this change we print "HEAD is now at 000000 foo bar", same as 'git log
> --oneline' shows "000000 foo bar".
> 
> So this does make the output more consistent with other commands, and
> 'reset' is a porcelain command, so nobody should be parsing the output
> in scripts.

Yeah, I'd say it's definitely fine to change the (already translated!)
stderr output of git-reset. I agree that it's an improvement to be
consistent with other commands here.

> The current behaviour dates back to 0e5a7faa3a ("Make "git reset" a
> builtin.", 2007-09-11), so I assume (without digging into the old
> codebase too much) that the logic was implemented because there was
> no convenience function such as 'pp_commit_easy' that would do this
> already.

Yes, there used to be quite a lot of ad hoc parsing of commit objects,
but these days we have safer and more readable alternatives.  Even
without the visible behavior change, I think it would be worth doing
this patch just as a code cleanup.

> +	struct strbuf buf = STRBUF_INIT;
> +
> +	printf(_("HEAD is now at %s"),
> +		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
> +
> +	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
> +	if (buf.len > 0)
> +		printf(" %s", buf.buf);
> +	putchar('\n');
> +	strbuf_release(&buf);

I was disappointed you still had to call find_unique_abbrev(). It seems
like we ought to be able to do this in a single formatting call. But
CMIT_FMT_ONELINE is just about the subject, and doesn't include the hash
at all. There's no equivalent without turning to the user-format code.

You can do:

  struct pretty_print_context ctx = {0, DEFAULT_ABBREV};
  format_commit_message(commit, _("HEAD is now at %H %s"), &buf, &ctx);
  puts(buf.buf);

but I was annoyed at having to say "DEFAULT_ABBREV". It seems like that
ought to be the default.

Anyway, I'm fine with your patch as-is. I just needed a little
formatting code-golf in my day.

-Peff
