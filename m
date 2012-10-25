From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] git-status: show short sequencer state
Date: Thu, 25 Oct 2012 05:29:19 -0400
Message-ID: <20121025092919.GG8390@sigill.intra.peff.net>
References: <1351022574-27869-1-git-send-email-hordp@cisco.com>
 <1351022574-27869-2-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:29:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJkx-00032j-2T
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934971Ab2JYJ30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:29:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56005 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758028Ab2JYJ3X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:29:23 -0400
Received: (qmail 6793 invoked by uid 107); 25 Oct 2012 09:30:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:30:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:29:19 -0400
Content-Disposition: inline
In-Reply-To: <1351022574-27869-2-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208374>

On Tue, Oct 23, 2012 at 04:02:54PM -0400, Phil Hord wrote:

> Teach git-status to report the sequencer state in short form
> using a new --sequencer (-S) switch.  Output zero or more
> simple state token strings indicating the deduced state of the
> git sequencer.
> 
> Introduce a common function to determine the current sequencer
> state so the regular status function and this short version can
> share common code.
> 
> Add a substate to wt_status_state to track more detailed
> information about a state, such as "conflicted" or "resolved".
> Move the am_empty_patch flage out of wt_status_state and into

This patch ended up quite long. It might be a little easier to review
if it were broken into refactoring steps (I have not looked at it too
closely yet, but it seems like the three paragraphs above could each be
their own commit).

> State token strings which may be emitted and their meanings:
>     merge              a git-merge is in progress
>     am                 a git-am is in progress
>     rebase             a git-rebase is in progress
>     rebase-interactive a git-rebase--interactive is in progress

A minor nit, but you might want to update this list from the one in the
documentation.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index a17a5df..9706ed9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -114,7 +114,8 @@ static struct strbuf message = STRBUF_INIT;
>  static enum {
>  	STATUS_FORMAT_LONG,
>  	STATUS_FORMAT_SHORT,
> -	STATUS_FORMAT_PORCELAIN
> +	STATUS_FORMAT_PORCELAIN,
> +	STATUS_FORMAT_SEQUENCER
>  } status_format = STATUS_FORMAT_LONG;

Hmm. So the new format is its own distinct output format. I could not
say "I would like to see short status, and by the way, show me the
sequencer state", as you can with "-b". Is it possible to do this (or
even desirable; getting the sequencer state should be way cheaper, so
conflating the two may not be what some callers want).

Not complaining, just wondering about the intended use cases.

Also, does there need to be a --porcelain version of this output? It
seems like we can have multiple words (e.g., in a merge, with conflicted
entries). If there is no arbitrary data, we do not have to worry about
delimiters and quoting.  But I wonder if we would ever want to expand
the information to include arbitrary strings, at which point we would
want NUL delimiters; should we start with that now?

> +	// Determine main sequencer activity

Please avoid C99 comments (there are others in the patch, too).

> +void wt_sequencer_print(struct wt_status *s)
> +{
> +	struct wt_status_state state;
> +
> +	wt_status_get_state(s, &state);
> +
> +	if (state.merge_in_progress)
> +		wt_print_token(s, "merge");
> +	if (state.am_in_progress)
> +		wt_print_token(s, "am");
> +	if (state.rebase_in_progress)
> +		wt_print_token(s, "rebase");
> +	if (state.rebase_interactive_in_progress)
> +		wt_print_token(s, "rebase-interactive");
> +	if (state.cherry_pick_in_progress)
> +		wt_print_token(s, "cherry-pick");
> +	if (state.bisect_in_progress)
> +		wt_print_token(s, "bisect");
> +
> +	switch (state.substate) {
> +	case WT_SUBSTATE_NOMINAL:
> +		break;
> +	case WT_SUBSTATE_CONFLICTED:
> +		wt_print_token(s, "conflicted");
> +		break;
> +	case WT_SUBSTATE_RESOLVED:
> +		wt_print_token(s, "resolved");
> +		break;
> +	case WT_SUBSTATE_EDITED:
> +		wt_print_token(s, "edited");
> +		break;
> +	case WT_SUBSTATE_EDITING:
> +		wt_print_token(s, "editing");
> +		break;
> +	case WT_SUBSTATE_SPLITTING:
> +		wt_print_token(s, "splitting");
> +		break;
> +	case WT_SUBSTATE_AM_EMPTY:
> +		wt_print_token(s, "am-empty");
> +		break;
> +	}
> +}

It is clear from this code that some tokens can happen together, and
some are mutually exclusive. Should the documentation talk about that,
or do we want to literally keep it as a list of tags?

-Peff
