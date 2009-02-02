From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Mon, 2 Feb 2009 07:41:48 -0500
Message-ID: <20090202124148.GB8325@sigio.peff.net>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com> <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de> <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com> <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de> <20090131095622.6117@nanako3.lavabit.com> <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 13:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTy8m-0000dp-LD
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 13:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbZBBMlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 07:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbZBBMlh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 07:41:37 -0500
Received: from peff.net ([208.65.91.99]:42323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230AbZBBMlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 07:41:36 -0500
Received: (qmail 8362 invoked by uid 1000); 2 Feb 2009 12:41:48 -0000
Content-Disposition: inline
In-Reply-To: <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108080>

On Sat, Jan 31, 2009 at 05:27:45PM -0800, Junio C Hamano wrote:

> I haven't manged to convince myself about the "git init" change (I have
> the code and also I've looked at the extent of damage the change causes to

I think the "git init" change doesn't make sense. In fact, I don't think
such a proposal ever really makes sense (and I have even proposed it in
the past, but others arguments have changed my way of thinking).

The reason is that you are just moving the breakage to a different point
in their workflow. The claim is that it's not OK for this to break:

  cd foo && git init
  git push ;# ok
  ... time passes, git upgrade ...
  git push ;# broken

but it somehow _is_ OK for this to break:

  cd foo && git init
  git push ;# ok
  ... time passes, git upgrade ...
  cd bar && git init
  git push ;# broken

In both cases, you have a sequence of commands that does one thing with
one git version, and something else with another git version. The only
difference is whether your sequence includes git init. So while you
don't break people with existing repositories, you are still breaking
anybody who creates a new one and gets confused when there is new
behavior (or even has scripts which involve repository creation).

So in my opinion either the breakage is serious enough not to allow the
change, or minor enough (compared to the benefit) to allow it. But
changing default config in git init is:

  - a half-way solution that leaves some workflows broken and some not

  - possibly even _worse_, since now we have sacrificed consistency. So
    now users wonder why some of their repos show breakage and some
    don't. Or why a particular behavior goes away when they try to write
    a test case that involves creating a new test repo.

And note that it doesn't matter whether you think the right path is to
make the change or not: I am only arguing here against this sort of
half-way technique.

> -- >8 --
> Subject: [PATCH] receive-pack: explain what to do when push updates the current branch
> 
> This makes "git push" issue a more detailed instruction when a user pushes
> into the current branch of a non-bare repository without having an
> explicit configuration set to receive.denycurrentbranch.  In such a case,
> it will also tell the user that the default will change to refusal in a
> future version of git.

I think this is a definite improvement over the current behavior. As I
said before, I am not sure what is the right path (though I think I am
leaning towards leaving the warning longer based on the recent
discussion), but if we are to leave the default to warn and not refuse,
I think this should definitely be applied.

A few comments on the specific message:

>  }
>  
> +static char *warn_unconfigured_deny_msg[] = {
> +	"Updating the currently checked out branch may cause confusion,",
> +	"as the index and work tree do not reflect changes that are in HEAD."
> +	"As a result, you may see the changes you just pushed into it",

Missing comma between lines 2 and 3, which results in an overly long
line in the output.

> +	"You can set 'receive.denyCurrentBranch' configuration variable to",
> +	"'refuse' in the repository to forbid pushing into the current branch",
> +	"of it."

Maybe this should specifically say "remote repository". If you
understand how the feature works, it is obvious that you must do it that
way, but for less advanced users it is not even clear that this text is
being generated by the remote end.

> +	"To allow pushing into the current branch, you can set it to 'ignore';",
> +	"but this is not recommended unless you really know what you are doing."

I thought somebody (you?) argued against the phrase "unless you really
know what you are doing". And it is better here in context explaining
the general issue. But as a user, now I have to ask: do I know what I am
doing, and if not, how do I find out?

The two obvious solutions for people who "know what they are doing" are
running "git reset --hard", and installing a hook that does something
sensible. I don't know if it is worth mentioning them here (the former
is mentioned earlier in the message, but that doesn't necessarily mean
the user understands all the implications). Since there are so many
subtleties to explain, maybe it make sense to simply put in a pointer to
an expanded discussion in the "git push" manpage?

-Peff
