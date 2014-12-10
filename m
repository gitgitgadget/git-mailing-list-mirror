From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] introduce git root
Date: Wed, 10 Dec 2014 15:10:57 -0500
Message-ID: <20141210201057.GC23273@peff.net>
References: <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
 <20141202070415.GC1948@peff.net>
 <xmqqd282m09j.fsf@gitster.dls.corp.google.com>
 <20141204092251.GC27455@peff.net>
 <xmqqlhmntf02.fsf@gitster.dls.corp.google.com>
 <20141204211232.GC19953@peff.net>
 <CAP8UFD2P9P9zL=irZ-7uPD6+bEhxaiABowh0O3RT01Ov3VqT6w@mail.gmail.com>
 <20141205092752.GC32112@peff.net>
 <xmqqoarcn0wm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:11:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XynbN-00063R-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 21:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945AbaLJULE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 15:11:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:51241 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755965AbaLJULA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 15:11:00 -0500
Received: (qmail 25085 invoked by uid 102); 10 Dec 2014 20:11:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 14:11:00 -0600
Received: (qmail 12489 invoked by uid 107); 10 Dec 2014 20:11:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 15:11:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 15:10:57 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoarcn0wm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261244>

On Tue, Dec 09, 2014 at 10:17:13AM -0800, Junio C Hamano wrote:

> It is a tangent, the current definition of "git_editor" helper reads
> like this:
> 
>         git_editor() {
>                 if test -z "${GIT_EDITOR:+set}"
>                 then
>                         GIT_EDITOR="$(git var GIT_EDITOR)" || return $?
>                 fi
> 
>                 eval "$GIT_EDITOR" '"$@"'
>         }
> 
> If "git var editor" were to compute a reasonable value from the
> various user settings, and because GIT_EDITOR is among the sources
> of user settings, I wonder if the surrounding "if test -z then...fi"
> should be there.

I think it should not be. The point of "git var" is to say "compute for
me what the internal C code would compute". I think it happens to be a
noop in this case, because the C code will give GIT_EDITOR preference
over anything else. But it seems like a layering violation; the shell
scripts should not have to know or care about the existence $GIT_EDITOR.

> The pager side seems to do (halfway) "the right thing":
> 
>         git_pager() {
>                 if test -t 1
>                 then
>                         GIT_PAGER=$(git var GIT_PAGER)
>                 else
>                         GIT_PAGER=cat
>                 fi
>                 : ${LESS=-FRX}
>                 : ${LV=-c}
>                 export LESS LV
> 
>                 eval "$GIT_PAGER" '"$@"'
>         }
> 
> The initial "test -t 1" is "we do not page to non-terminal", but we
> ask "git var" to take care of PAGER/GIT_PAGER fallback/precedence.
> 
> It is tempting to argue that "we do not page to non-terminal" should
> also be part of "various user settings" for "git var" to take into
> account and fold this "if test -t 1...then...else...fi" also into
> "git var", but because a typical command line "git var" will be used
> on would look like this:
> 
> 	GIT_PAGER=$(git var pager)
>         eval "$GIT_PAGER" ...
> 
> with the standard output stream of "git var" not connected to
> terminal, that would not fly very well, and I am not sure what
> should be done about it.

Right, I think in an ideal world the "is it a terminal" context is
handled by "git var", but the reality of shell scripts makes it hard. We
face the same problem with "git config --get-colorbool". There we cheat
a little and use the exit code to signal the result. That works for a
bool, but not for a string. :)

I think you'd have to do something a little gross like:

  pager=$(git var GIT_PAGER >&3) 3>&1

Except that doesn't work; the shell does not take redirections for a
straight variable assignment. Something like:

  # git var uses fd 3 by convention for stdout-tty tests
  exec 3>&1

at the top of git-sh-setup, and then:

  pager=$(git var GIT_PAGER >&3)

in the scripts themselves. That works, but is a bit ugly.

> This is another tangent that comes back to the original "how to name
> them?" question, but I wonder if a convention like this would work.
> 
>  * When asking for a feature (e.g. "what editor to use"), if there
>    is a git-specific environment variable that can be set to
>    override all other settings (e.g. "$GIT_EDITOR" trumps "$EDITOR"
>    environment or "core.editor" configuration), "git var" can be
>    queried with the name of that "strong" environment variable.

I'd prefer to create a new namespace. When you set $GIT_EDITOR as a
"trump" variable, then that is leaking information about the computation
from "git var" out to the caller. What happens if the computation
changes so that $GIT_EDITOR is no longer the last word?

>  * All other features without such a strong environment variables
>    should not be spelled as if there is such an environment variable
>    the user can set in order to avoid confusion.

So now you have two classes of variables. Some that look like
environment variables, and some that do not. What does it buy you for
the ones that do look like environment variables? I feel like either way
you will still use them as:

  editor=$(git var editor)
  eval "$editor" "$@"

Does it matter whether you call it $editor or $GIT_EDITOR?

-Peff
