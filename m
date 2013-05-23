From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 01:57:12 +0200
Message-ID: <20130523235711.GJ12252@machine.or.cz>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 24 02:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UffWD-0001lX-FG
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 02:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661Ab3EXAF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 20:05:57 -0400
Received: from pasky.or.cz ([84.242.80.195]:39590 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890Ab3EXAF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 20:05:56 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2013 20:05:56 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id 318CF1700058; Fri, 24 May 2013 01:57:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225323>

  Hi!

On Fri, May 24, 2013 at 12:56:50AM +0200, Thomas Rast wrote:
> > It is not --ignore-changes bit, and has never been.

  Indeed, it has been my lack of imagination regarding what can go
wrong. I am fine with the changes not being shown in `git diff` and even
not so worried about them being overwritten by a merge/checkout
(touching that file for other purposes), but `git stash` dropping the
changes is rather vicious. ;-)

  An emergency fix would be to add a warning to the documentation that
under various circumstances, your changes may get overwritten and keep a
backup copy. It's a bit silly, I'm not sure how long it may take to
flesh out a proper solution; if we just stop recommending anything (or
recommend something unhelpful like "you don't want that"), people will
just refer to the old advice and I think it's better to warn them.

> > What are the workflows that are helped if we had such a bit?  If we
> > need to support them, I think you need a real --ignore-changes bit,
> > not an abuse of --assume-unchanged.
> 
> I gather -- from #git -- that it's mostly used for config files, which
> have an annoying habit of being different from the repository.
> 
> Which is wrong, really.  But we still claim that --assume-unchanged is
> a solution to it in git-update-index(1).

  The main workflow for me is when you don't get to pick the workflow.
Most recently, I found myself tackling this scenario:

  (i) https://github.com/huceke/omxplayer carries file Makefile.include

  (ii) I'm paid to make some modifications to the omxplayer software
on short notice.

  (iii) Makefile.include hardcodes some crosscompiling tool paths and
other things (like CFLAGS) that are different in my setup.

  For the first few commits, I have avoided using -a, then I went ahead
and marked Makefile.include with --assume-unchanged. It felt like
something dangerous, so I also made a backup of the file for good
measure; that turned out to be a good idea after the first `git stash`
issued. (Unfortunately, I forgot about the problem before I would have
time to think about fixing that.)

  Yeah, omxplayer's setup is not ideal. But in this scenario, I'm not
really in the position to easily start poking into other people's
toolchain setup, I'd like git just to help me get my work done and move
on and ideally keep my pull requests clean of unrelated commits.


  Just to clear up on what the best practice is, I'd imagine the setup
to be something like:

	(a) Makefile contains inclusion of Makefile.include.

	(b) There is a file like Makefile.include.template containing
	a template to be copied over and filled by the user.

	(c) Makefile contains code that makes sure all variables that
	are supposed to be set are set and obsolete variables are not,
	since there is no mechanism to cause e.g. a merge conflict
	on change of Makefile.include.template.

Is there a better way to solve this?

  There are a couple of things to notice here:

  (i) The solution is highly specific for the particular file format
and usage, universal recommendations are difficult especially if we
are to cover (c).

  (ii) The solution is certainly not the simplest one to occur to
the original author, who will probably initially just commit
Makefile.include with the values suitable for them.

  (iii) A corrolary to (ii), the person who will find tackling this
problem first will probably be a newcoming developer to the project
who is likely not to be familiar with it and its toolchain / config
mechanisms, and this will be a huge hassle.

  Therefore the demand for Git to just solve their problem on its level.
Of course Git would be simpler and more elegant if it didn't have to do
this and cover all the annoying corner cases. But is this simplification
worth the extra workflow hassle for its users?

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
