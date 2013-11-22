From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 22:54:54 +0100
Message-ID: <20131122215454.GA4952@sandbox-ub>
References: <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net>
 <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 22 23:00:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjylw-0001GD-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 23:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab3KVWAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 17:00:16 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:40665 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab3KVWAP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 17:00:15 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vjygk-0002Ty-KB; Fri, 22 Nov 2013 22:54:58 +0100
Content-Disposition: inline
In-Reply-To: <528FC638.5060403@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238216>

Hi,

On Fri, Nov 22, 2013 at 10:01:44PM +0100, Jens Lehmann wrote:
> Hmm, looks like git show also needs to be fixed to honor the
> ignore setting from .gitmodules. It already does that for
> diff.ignoreSubmodules from either .git/config or git -c and
> also supports the --ignore-submodules command line option.
> The following fixes this inconsistency for me:
> 
> ---------------------->8-------------------
> diff --git a/builtin/log.c b/builtin/log.c
> index b708517..ca97cfb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -25,6 +25,7 @@
>  #include "version.h"
>  #include "mailmap.h"
>  #include "gpg-interface.h"
> +#include "submodule.h"
> 
>  /* Set a default date-time format for git log ("log.date" config variable) */
>  static const char *default_date_mode = NULL;
> @@ -521,6 +522,7 @@ int cmd_show(int argc, const char **argv, const char *prefix
>         int i, count, ret = 0;
> 
>         init_grep_defaults();
> +       gitmodules_config();
>         git_config(git_log_config, NULL);
> 
>         memset(&match_all, 0, sizeof(match_all));
> ---------------------->8-------------------
> 
> But the question is if that is the right thing to do: should
> diff.ignoreSubmodules and submodule.<name>.ignore only affect
> the diff family or also git log & friends? That would make
> users blind for submodule history (which they already are
> when using diff & friends, so that might be ok here too).
> 
> > For some reason, the
> > `git add .` is adding the ignored submodule to the index.
> 
> The ignore setting is documented to only affect diff output
> (including what checkout, commit and status show as modified).
> While I agree that this behavior is confusing for Sergey and
> not optimal for the floating branch model he uses, git is
> currently doing exactly what it should. And for people using
> the ignore setting to not having to stat submodules with huge
> and/or many files that behavior is what they want: don't bother
> me with what changed, but commit what I did change on purpose.
> We may have to rethink what should happen for users of the
> floating branch model though.

This gets more nasty. When using 'git add .' you secretly add the
submodule to the index. But it is neither shown in status nor diff
--cached. commit actually complains there is nothing to add. But then
once you add a local file to the index you can commit and secretly take
the submodule change with you.

What I think needs fixing here first is that the ignore setting should not
apply to any diffs between HEAD and index. IMO, it should only apply
to the diff between worktree and index.

When we have that the user does not see the submodule changed when
normally working. But after doing git add . the change to the submodule
should be shown in status and diff regardless of the configuration.

I will have a look at that.

After that we can discuss whether add should add submodules that are
tracked but not shown. How about commit -a ? Should it also ignore the
change? I am undecided here. There does not seem to be any good
decision. From the users point of view we should probably not add it
since its not visible in status. What do others think?

Cheers Heiko
