From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: diagnose empty HEAD more clearly
Date: Thu, 4 Jun 2015 04:34:30 -0400
Message-ID: <20150604083430.GB5771@peff.net>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
 <20150603062005.GA20580@peff.net>
 <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
 <20150603081432.GA32000@peff.net>
 <xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 10:34:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Qby-0003bz-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbFDIeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 04:34:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:41004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752856AbbFDIed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:34:33 -0400
Received: (qmail 16887 invoked by uid 102); 4 Jun 2015 08:34:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 03:34:33 -0500
Received: (qmail 29964 invoked by uid 107); 4 Jun 2015 08:34:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Jun 2015 04:34:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jun 2015 04:34:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp5cyabx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270760>

On Wed, Jun 03, 2015 at 10:24:02AM -0700, Junio C Hamano wrote:

> Which is what led me to say "Why are we defaulting to HEAD before
> checking if it even exists?  Isn't that the root cause of this
> confusion?  What happens if we stopped doing it?"
> 
> And I think the "diagnose after finding that pending is empty and we
> were given 'def'" approach almost gives us the equivalent, which is
> why I said "Okay" above.
> 
> If we can make it possible to tell if that "def" was given by the
> user (i.e. --default parameter) or by the machinery (e.g. "git log"
> and friends), then we can remove "almost" from the above sentence.

My thought was that we would not stop dying (for compatibility), and
that if we keep dying, it is effectively the same as what I proposed
(perhaps slightly worse, in the sense that we do not diagnose "--default
foo" as thoroughly, but effectively the same in that basically nobody
uses "--default" in the first place).

But if you are OK to eventually stop dying, I think this line of
reasoning is OK.

> diff --git a/builtin/log.c b/builtin/log.c
> index 4c4e6be..3b568a1 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -148,6 +148,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
>  	argc = setup_revisions(argc, argv, rev, opt);
>  
> +	if (!rev->pending.nr && !opt->def)
> +		die("you do not have a commit yet on your branch");

Do we want to mention the name of the branch here? I guess it does not
really matter. Perhaps "the current branch" would be better than "your
branch", though. Maybe:

  fatal: you do not have any commits yet on the current branch

This message hopefully goes away in the long run, but we'll have it for
a while.

> +static void default_to_head_if_exists(struct setup_revision_opt *opt)
> +{
> +	unsigned char unused[20];
> +
> +	if (resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, unused, NULL))
> +		opt->def = "HEAD";
> +}

This approach looks sane to me. Want to wrap it up with a commit
message and a test?

-Peff
