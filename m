From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] test-lib.sh: fix color support when tput needs
 ~/.terminfo
Date: Wed, 17 Jun 2015 15:43:15 -0400
Message-ID: <20150617194315.GE25304@peff.net>
References: <1434567986-23552-1-git-send-email-rhansen@bbn.com>
 <1434567986-23552-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:43:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JF5-0004FP-S4
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbbFQTnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:43:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:47622 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756819AbbFQTnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:43:18 -0400
Received: (qmail 32744 invoked by uid 102); 17 Jun 2015 19:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:43:18 -0500
Received: (qmail 28590 invoked by uid 107); 17 Jun 2015 19:43:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 15:43:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 15:43:15 -0400
Content-Disposition: inline
In-Reply-To: <1434567986-23552-3-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271896>

On Wed, Jun 17, 2015 at 03:06:26PM -0400, Richard Hansen wrote:

> If tput needs ~/.terminfo for the current $TERM, then tput will
> succeed before HOME is changed to $TRASH_DIRECTORY (causing color to
> be set to 't') but fail afterward.
> 
> One possible way to fix this is to treat HOME like TERM: back up the
> original value and temporarily restore it before say_color() runs
> tput.
> 
> Instead, pre-compute and save the color control sequences before
> changing either TERM or HOME.  Use the saved control sequences in
> say_color() rather than call tput each time.  This avoids the need to
> back up and restore the TERM and HOME variables, and it avoids the
> overhead of a subshell and two invocations of tput per call to
> say_color().
> 
> Signed-off-by: Richard Hansen <rhansen@bbn.com>

Nice, I like it.

> +	# Save the color control sequences now rather than run tput
> +	# each time say_color() is called.  This is done for two
> +	# reasons:
> +	#   * TERM will be changed to dumb
> +	#   * HOME will be changed to a temporary directory and tput
> +	#     might need to read ~/.terminfo from the original HOME
> +	#     directory to get the control sequences
> +	# Note:  This approach assumes the control sequences don't end
> +	# in a newline for any terminal of interest (command
> +	# substitutions strip trailing newlines).  Given that most
> +	# (all?) terminals in common use are related to ECMA-48, this
> +	# shouldn't be a problem.

Yeah, that was my first thought, but I agree it probably isn't going to
be a big deal in practice.

> +	say_color_error=$(tput bold; tput setaf 1) # bold red
> +	say_color_skip=$(tput setaf 4) # blue
> +	say_color_warn=$(tput setaf 3) # brown/yellow
> +	say_color_pass=$(tput setaf 2) # green
> +	say_color_info=$(tput setaf 6) # cyan
> +	say_color_sgr0=$(tput sgr0)
> [...]
> +		error|skip|warn|pass|info)
> +			eval "say_color_color=\$say_color_$1";;
>  		*)
>  			test -n "$quiet" && return;;

I think you could dispense with this case statement entirely and do:

  eval "say_color_color=\$say_color_$1"
  if test -z "$say_color_color"; then
          test -n "$quiet" && return
  fi

I guess that is making the assumption that all colors have non-zero
sizes, but that seems reasonable. I do not mind it so much as you have
it, but it does mean adding a new field needs to update two spots.

-Peff
