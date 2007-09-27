From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push (mis ?)behavior
Date: Thu, 27 Sep 2007 12:22:24 -0700
Message-ID: <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
References: <20070927130447.GH10289@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaywZ-0006Js-3k
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237AbXI0TWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbXI0TWc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:22:32 -0400
Received: from rune.pobox.com ([208.210.124.79]:54042 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157AbXI0TWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:22:31 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 559D913B079;
	Thu, 27 Sep 2007 15:22:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C72D13AD32;
	Thu, 27 Sep 2007 15:22:48 -0400 (EDT)
In-Reply-To: <20070927130447.GH10289@artemis.corp> (Pierre Habouzit's message
	of "Thu, 27 Sep 2007 15:04:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59317>

Pierre Habouzit <madcoder@debian.org> writes:

> The real question is "what does users intend when they `git push`". In
> a git/kernel/... like model, you don't think the same than in a
> svn/cvs-like model. I mean, Junio or Linus likely don't push a lot to
> their public repository. It happens probably a couple of time per day.
> While I'm at work, it happens up way more frequentely, and I then want
> to lazily type `git push` and not `git push origin <somebranch>`. it's
> too long.
>
>   I'm not sure what we can do about it, but I'm pretty sure it bites a
> lot of people out there. For now I use this alias in my .gitconfig:
>
>   p=!git-push origin `git-symbolic-ref HEAD`
>
> but still, it feels really wrong to me. Not to mention that git-push(1)
> says that it has a --all option that in fact is the current default
> behavior, hence sounds pretty useless.

The default is not --all but "matching branches", iow, what you
have never published yet never goes out.

Having said that, I would agree that in some workflows "I am on
this branch and I would want to push only this branch" would be
the norm, and the norm even be "and this branch 'foo' is called
identically as 'foo' at the remote site as well".

Don't worry about me when discussing to change the default.
Myself, I also often push only one or two branches.  A typical
workflow for me while working on git.git is to prepare 'maint'
(if there are any changes) and 'master', push them (without
pushing 'next' and 'pu') to a private "build it to make sure"
repository I have at a k.org machine which runs RH, make sure
they are Ok, and then continue working on integrating 'next' and
'pu'.  At the end of the day, I push out all four integration
branches to a separate "publish" area, but even this one, I rely
on the explicit configuration (remote.<name>.push) to push out
only the integration branches and not other branches.

We would also want to have --mirror option that acts like --all
but removes the refs from the remote that do not exist anymore,
so we will be talking about updating "git push" in the near
future anyway.

So what's the desired semantics?

The current semantics is:

   "git push" says "you do not say to which repository?" and
   consults "branch.<current>.remote" but defaults to 'origin'
   if unconfigured.  

   "git push <name>" (or using the <name> determined as above)
   says "you do not say which branches?" and consults
   "remote.<name>.push" to find branches to push out, but
   defaults to 'matching branches' if unconfigured.

What you would want to change is the fallback behaviour for
unconfigured "remote.<name>.push".  I think it is sensible to
have an option to make it push only the current branch.  I am
not sure if it is sensible to make that the default (and
introduce --matching option to get the current behaviour) at
this point in 1.5.X series, but from the general usability point
of view, I would not object to demote 'matching' to optional and
make 'current only' the default in 1.6.X or later.

Thoughts?
