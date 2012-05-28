From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git push" silently fails, says 'Everything up-to-date" when it's not.
Date: Mon, 28 May 2012 14:11:19 +0200
Message-ID: <vpqipfgec9k.fsf@bauges.imag.fr>
References: <1338206011.11518.115.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Mon May 28 14:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYynm-0008G1-0O
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 14:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab2E1MLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 08:11:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39934 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab2E1MLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 08:11:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4SC33L7015569
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2012 14:03:03 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SYyn9-0002KI-W8; Mon, 28 May 2012 14:11:20 +0200
In-Reply-To: <1338206011.11518.115.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Mon, 28 May 2012 12:53:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 May 2012 14:03:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4SC33L7015569
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338811385.47194@OJ71r+4EvljuBVwBQ/Jnug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198705>

David Woodhouse <dwmw2@infradead.org> writes:

> [dwmw2@shinybook mtd-2.6]$ git push
> Everything up-to-date
>
> But it lies. Only when I try to *pull* does it give me a hint:
>
> [dwmw2@shinybook mtd-2.6]$ git pull
> You are not currently on a branch, so I cannot use any

What does

  git config push.default 

say?

You probably have push.default=matching, which is the default. In this
mode, Git will push all your local branches to remote branches having
the same name (regardless of which branch you currently have
checked-out). The commits you just did were not on any branch, so
they're not pushed.

> Why would it do this evil thing and start lying to me? When it told me
> 'Everything up-to-date', precisely *what* was it telling me was up to
> date? Did it ever push *anything*, *anywhere*, or was it just a complete
> fabrication?

It probably pushed your branches, but not commits done in detached HEAD.

> I don't quite know how I ended up "not currently on a branch" either.

Either you did "git checkout <some-commit-identifier>" (in which case
you had a big fat warning), or you used one command that runs in
detached HEAD like "git rebase" or "git bisect" without concluding the
operation ("git bisect reset", "git rebase --continue" or so).

With a recent enough version of Git, each commit you did in detached
head had this little reminder:

$ git commit -m foo
[detached HEAD acb1d5b] foo
 ^^^^^^^^^^^^^

As for the future, there's a patch serie in progress that will make "git
status" warn a bit more loudly in these cases, and give you a clue about
what to do next.

In Git 2.0, the push.default value will change to "simple", which errors
out like this in your case:

$ git push
fatal: You are not currently on a branch.
To push the history leading to the current (detached HEAD)
state now, use

    git push origin HEAD:<name-of-remote-branch>

If you can't wait to have this "simple" mode, you may want to set
push.default=upstream (or current), which will push the current branch
to its upstream (or to the one with the same name remotely).

I don't know what can be done to improve the case of detached HEAD with
push.default=matching. Perhaps Git should warn when HEAD is not pushed
(detached HEAD, or HEAD points to a branch that doesn't exist remotely)?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
