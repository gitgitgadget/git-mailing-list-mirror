From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Fri, 06 Jul 2012 09:18:23 +0200
Message-ID: <1341559103.10752.59.camel@flaca.cmartin.tk>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
	 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
	 <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 09:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn2oI-0004d1-8f
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 09:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab2GFHS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 03:18:29 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:37324 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab2GFHS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 03:18:28 -0400
Received: from [192.168.42.201] (unknown [176.5.191.32])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 4E4CB46149;
	Fri,  6 Jul 2012 09:18:25 +0200 (CEST)
In-Reply-To: <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201087>

On Thu, 2012-07-05 at 10:44 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think it was a mistake that nobody noticed that it is likely that
> > the operation most often will be done for the current branch and the
> > usual "give me one branch name to operate on, or I'll operate on the
> > current branch" command line convention of "git branch" commannd is
> > not a good fit for it, when "set upstream" feature was added, and
> > suggested an alternative syntax that avoids the mistake you quoted
> > above, perhaps something like:
> >
> > 	git branch --set-upstream-to=origin/master [HEAD]
> >
> > which would have been very clear whose upstream is set to what (with
> > or without the name of the other branch).  In other words, make the
> > name "origin/master" *NOT* the first branch name on the command line
> > in the usual sense, but a parameter to the --set-upstream option, so
> > that "give me one branch name to operate on, or I'll operate on the
> > current branch" convention is still kept.
> > 
> > You also broke people who corrected another kind of mistake in this
> > workflow:
> > ...
> > Coming from the above observation, while I am sympathetic to your
> > cause and agree that we would want to do something about it, I am
> > having a hard time to convince myself that your patch is the best
> > way to go.
> >
> > I am not entirely happy with the hypothetical "set-upstream-to"
> > myself, either.
>
> Thinking about it a bit more, I am starting to think that something
> based on the "set upstream to" could be a sane way forward:
> 
>  * add "git branch [--set-upstream-to=<name>]" that does what your
>    patch does.  The synopsis must make it clear that <name> is not
>    the usual first <name> like other "branch" command line arguments
>    that specify the branch being operated on, but is an argument to
>    the --set-upstream option [*1*].

Let's do this then. Disregard my earlier patch making -u a synonym of
--set-upstream so we can make it a synonym of --set-upstream-to instead.
This way we can use -u and then it's not so bad if the long name is a
bit ugly.

> 
>  * when "git branch --set-upstream <name>" without <start point>
>    is given, you first see if <name> exists and find out the
>    upstream of <name>, do what the user told you to do (i.e. reset
>    the upstream of the <name>d branch to the current branch), and
>    give hints to recover.  Two possibilities:
> 
>      $ git checkout frotz
>      $ git branch --set-upstream xyzzy
>      Branch xyzzy set up to track local branch frotz.
>      If you wanted to make frotz track xyzzy, do this:
>        $ git branch --set-upstream xyzzy <original>
>        $ git branch --set-upstream-to xyzzy
> 
>      $ git checkout frotz
>      $ git branch --set-upstream origin/xyzzy
>      Branch origin/xyzzy set up to track local branch frotz.
>      If you wanted to make frotz track xyzzy, do this:
>        $ git branch -d origin/xyzzy
>        $ git branch --set-upstream-to origin/xyzzy

Yep, this seems good. Now that you mention the <name> existing, I wonder
if letting --set-upstream create the branch as well wasn't another bad
decision, as the name suggests it's for setting that information after
the branch has already been created.

> 
>  * possibly, deprecate --set-upstream as a historical wart that had
>    misdesigned UI, and when it is used, give deprecation warning and
>    nudge the user to use --set-upstream-to instead.

I'd definitely like to deprecate the current behaviour. It's a common
source of irritation (not just for me personally, it shows up in #git
every once in a while).

I'll probably have some patches to send at the end of the weekend.

   cmn
