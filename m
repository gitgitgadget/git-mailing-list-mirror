From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 30 Jan 2009 14:24:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301423120.3586@pacific.mpi-cbg.de>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de> <7v4ozhd1wp.fsf@gitster.siamese.dyndns.org> <7vwscdbkpd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:26:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStNg-0001Ic-Dz
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZA3NYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZA3NYf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:24:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:34816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752362AbZA3NYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:24:34 -0500
Received: (qmail invoked by alias); 30 Jan 2009 13:24:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 30 Jan 2009 14:24:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gzUUAr5ignXsWiYteMdZ6GOqIEyp9GkxH1hC3Lr
	beqtFNzz1I4Mdp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vwscdbkpd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107814>

Hi,

On Thu, 29 Jan 2009, Junio C Hamano wrote:

> @@ -239,9 +239,12 @@ static const char *update(struct command *cmd)
>  			" that are now in HEAD.");
>  		break;
>  	case DENY_REFUSE:
> -		if (!is_ref_checked_out(name))
> +		if (is_bare_repository() || !is_ref_checked_out(name))
>  			break;
> -		error("refusing to update checked out branch: %s", name);
> +		error("refusing to update checked out branch: %s\n"
> +			"if you know what you are doing, you can allow it by "
> +			"setting\n\n"
> +			"\tgit config receive.denyCurrentBranch true\n", name);
>  		return "branch is currently checked out";
>  	}
>  
> As the message I am currently getting from such a push is:
> 
> $ git push ../victim-010 next:master
> Total 0 (delta 0), reused 0 (delta 0)
> warning: updating the currently checked out branch; this may cause confusion,
> as the index and working tree do not reflect changes that are now in HEAD.
> To ../victim-010
>    a34a9db..d79e69c  next -> master
> 
> which is much better than what you did.  It at least tries to explain why
> it is warning, even though I think it has a huge room for improvement.

I do not really care about the output.  You are probably right, it should 
be different from what I proposed.

> You alluded that we wanted to make grace period much longer, but you 
> want to cut it short.  I think it is a huge mistake.  The warning has 
> only been there for the last two months, and only can be seen from 
> v1.6.1-rc1 or newer software.  These new people even haven't a chance to 
> learn from the existing warning.

In reality, people will not learn from the warning.  Those that are 
old-timers (and who should be warned in the first place, instead of 
refuses) will just happily ignore that there was a warning: the command 
they used so often and the worked all the time just happened to work -- 
again -- no matter what the output is.

But we are really hurting new users, and let's face it, the balance of 
time cost currently is in a huge favor of the old-timers there.

Not only are there many more newbies these days than old timers.

No, the _time_ spent by an old-timer to read an appropriate message and 
fix the setup would be _substantially_ shorter than the _hours_ of 
frustration a newbie spends on the issue.

And we claim to make decentralized repositories easy.

> I think what would work much better would be a patch that keeps the
> warn-but-allow as the default, but clarifies the warning message.

As I said, I am _convinced_ that a warning will do nothing at all.  Just 
like the warning about the dashed commands, nobody who should be concerned 
will notice it.

>  (1) what symptoms, that are easily observable by the most novice users,
>      are caused by "index and work tree going out of sync" the warning
>      talks about, and why that would not be what they want;
> 
>  (2) if the user did not mean to do it (and the user can tell by observing
>      the symptom described in the previous point), describe what needs to
>      be done to recover from the fallout this push has caused (we do not
>      need a recipe; pointing at a URL or manpage is fine), and what switch
>      to flip to prevent herself from doing it again in the future;
> 
>  (3) if the user did mean it, and finds the above two big warning
>      annoying, what switch to flip to squelch the warning for future
>      pushes.
> 
> The goal of the warning should be to *force* people *choose*, either to
> silently-allow (aka DENY_IGNORE) or refuse (DENY_REFUSE), and give enough
> information for them to make an informed decision.  We can afford to be
> annoyingly long, loud and verbose there.
> 
> On the other hand, you cannot make the message for DENY_REFUSE annoyingly
> long, as people may have already chosen to say "please refuse my push into
> a live branch".
> 
> If you are making "refuse" the default, an annoyingly long message is even
> worse.  "Yeah, thanks for stopping me, but you do not have to remind me
> every time that I made a mistake in large red letters.  I perfectly well
> know what I am doing, I perfectly well know that I did not want to push
> into that branch, I just made a mistake---you do not have to be so loud".
> 
> I suspect that you cannot even be long enough to be informative, not to
> annoy people.

Let's reap all the opinions about this issue, and then I'll do the wrap-up 
patch.

But this is a serious issue that seriously needs to be coped with.  We are 
getting another generation of "Git is difficult" users that way.

Ciao,
Dscho
