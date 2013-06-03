From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Mon, 3 Jun 2013 17:15:56 -0400
Message-ID: <20130603211556.GB23224@sigill.intra.peff.net>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-2-git-send-email-artagnon@gmail.com>
 <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
 <CALkWK0=LzUe0k7rWcrbiiTZNOOGg+=SsQB3u2F2ysjb5AJ=qZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujc6l-0000Gv-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab3FCVQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:16:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:34680 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab3FCVP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:15:58 -0400
Received: (qmail 5100 invoked by uid 102); 3 Jun 2013 21:16:43 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Jun 2013 16:16:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2013 17:15:56 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=LzUe0k7rWcrbiiTZNOOGg+=SsQB3u2F2ysjb5AJ=qZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226293>

On Mon, Jun 03, 2013 at 03:17:27PM +0530, Ramkumar Ramachandra wrote:

> Thomas Rast wrote:
> > Do you have other ways of distinguishing the branch and the state?
> > Colors?  I'm a bit too lazy to check.  Perhaps it could be made to only
> > use caps if not in colored mode?
> 
> Currently, no.   See git-prompt.sh:401, 403, 409; we don't have a
> separate color for $r.  I didn't introduce a color in this series
> because it would conflict with rr/zsh-color-prompt which is in pu: we
> can introduce it after that graduates.  I was thinking yellow, since
> that's not taken?
> 
> You really should use colors.  I don't think it's worth the extra
> ugliness to scream in the no-color case.
> 
> As such, the prompt is a fine bikeshedding target.  I even introduced
> GIT_PS1_SEPARATOR, because some people were unhappy with me stripping
> one whitespace (yes, one).  If we go down the configurability road,
> we'll either end up with a ton of environment variables, or be made to
> write a generalized custom formatter which splices together tons of
> arguments using color (super painful).  While I do agree that it is a
> matter of taste, we have to make a few compromises for the sake of
> sanity.

It seems silly to argue about output formats when we are writing a
prompt in a convenient Turing-complete scripting language already.
What about something like:

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index eaf5c36..1da3833 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -404,6 +404,8 @@ __git_ps1 ()
 			fi
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 			PS1="$ps1pc_start$gitstring$ps1pc_end"
+		elif test "$(type -t __git_ps1_printer)" = "function"; then
+			__git_ps1_printer
 		else
 			# NO color option unless in PROMPT_COMMAND mode
 			printf -- "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p"

and then you can define your own custom function if you like, which will
inherit all of the variables from __git_ps1. E.g.:

  __git_ps1_printer() {
          echo "${r,,}"
  }

yields a lower-case "rebase-i". Of course there are many other variables
you want to put in your prompt, too. The only problem I see is that the
current set of variables is not suitable as a user-visible interface.
The names are not good (the branch should be "$branch" rather than "$b",
the operation-in-progress should be "$operation" or similar rather than
"$r", etc), and the formats are not as convenient ("$r" contains the
full "|REBASE-i 6/10", whereas it should be broken down so the printing
function can easily use a case statement).

And of course the variables would need documentation.

-Peff
