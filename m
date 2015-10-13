From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: How to rebase when some commit hashes are in some commit
 messages
Date: Tue, 13 Oct 2015 16:00:04 +0300
Message-ID: <20151013160004.11a103942062ee09c53bd235@domain007.com>
References: <561C1132.3090606@orange.fr>
	<vpqsi5fx2gr.fsf@grenoble-inp.fr>
	<561CC5E0.7060206@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Tue Oct 13 15:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlzBp-0001xL-5p
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 15:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbbJMNAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 09:00:15 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:42178 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932234AbbJMNAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 09:00:13 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t9DD05ww009022;
	Tue, 13 Oct 2015 16:00:08 +0300
In-Reply-To: <561CC5E0.7060206@orange.fr>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279499>

On Tue, 13 Oct 2015 10:50:40 +0200
Francois-Xavier Le Bail <devel.fx.lebail@orange.fr> wrote:

> >> For example, if I rebase the following commits, I would want that
> >> if the commit hash 2222222... become 7777777...,
> >> the message
> >> "Update test output for 2222222222222222222222222222222222222222"
> >> become
> >> "Update test output for 7777777..."
> >>
> >> Is it possible currently? And if yes how?
> > 
> > AFAIK, it's not possible other than by editing the message by hand.
> 
> It seems to me useful to be able to do it. Can we hope a new option?

How do you think this could be practically implemented?

A couple of things which immediately spring to my mind:

To begin with, you are free to specify just a few first characters of
the commit name you're referring to.  So the alogrythm which finds the
relevant commits them has to be smart to somehow avoid misfires.  Or
have knobs to tune it (like -M of `git log`).

OK, suppose that this is solved through the usage of some agreed-upon
keywords in the commit message.  Say, you adopt a policy to put
something like

  X-Refers-To: 2dd8a9d9bb33ebffccb2ff516497adc8535bcab4

in your commit message to make the finder tool happy.

Now think how exactly it should work.  First, any commit at all might
mention the name of the target commit in its commit message.  Okay,
let's suppose there will be some way to somehow prune the possible DAG
down.  Then what happens if the commit to change is a part of the chain
of commits reachable from some branch other than that you're rebasing?
Automatically rebasing it would rewrite that commits and all commits
"after" it -- possibly resulting in what the "Recovering from upstream
rebase" part of the git-rebase(1) manual page deals with.

Having said that, the feature you're after appears to me to be a
sensible thing to have but the possibility of its generic implementation
appears to be moot.

Note that to deal with narrow simple cases (all possibly affected
commits leave on the same branch you're rebasing, and come later than
the rebase's anchor) you could write a script which uses `git log` to
find those commits which need special care.
