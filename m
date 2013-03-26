From: Jeff King <peff@peff.net>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 16:08:51 -0400
Message-ID: <20130326200851.GA22080@sigill.intra.peff.net>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <51519DA0.4090201@nod.at>
 <20130326145637.GA3822@sigill.intra.peff.net>
 <5151D589.2000002@nod.at>
 <20130326174059.GA10383@sigill.intra.peff.net>
 <7vfvzit439.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:09:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaBR-0004k9-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab3CZUI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:08:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40616 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab3CZUI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:08:56 -0400
Received: (qmail 7084 invoked by uid 107); 26 Mar 2013 20:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 16:10:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:08:51 -0400
Content-Disposition: inline
In-Reply-To: <7vfvzit439.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219195>

On Tue, Mar 26, 2013 at 11:20:58AM -0700, Junio C Hamano wrote:

> When you are in ~/mail/subdir, because GIT_DIR alone does not give
> you to specify where the root-level of the working tree is, you had
> to "cd .." before running "GIT_DIR=~/git/mail.git git ...".  By
> setting GIT_WORK_TREE to point at ~/mail once, you can freely chdir
> around inside subdirectories of ~/mail without losing sight of where
> the root-level is, and if your ~/git/mail.git is tied to a single
> working tree (and that is true in this example, it is always ~/mail),
> you can even set core.worktree in ~/git/mail.git/config.

Yeah, I did not talk about moving around to multiple working trees with
the same GIT_DIR. I have done that, but I do not know of a workflow
where it is a good practice, and not just a one-off hack.

> > We could do so now, as long as we provide an escape hatch (and I think
> > spelling that hatch as GIT_WORK_TREE=. is probably sane, but I am open
> > to other suggestions).
> 
> If we were to do so, GIT_WORK_TREE=. would be the most sensible, but
> I do not think it is worth breaking.  Why do these people set GIT_DIR
> without setting GIT_WORK_TREE in the first place?

I don't think there is a good reason. The argument, as I see it, is
mainly that doing so can be confusing and destructive, and there is not
a big benefit to allowing it.

I am not sure I am convinced it is worth the breakage, either. Curious
as to what the code would look like, I made a straw-man series, which
will follow. Note that I am not suggesting we do this, but still merely
thinking about the idea.

Notably, at the end of the series a number of tests fail. A few of them
are testing the GIT_DIR behavior explicitly (I fixed up t1510, but did
not hunt down all of the spots), but a few of them are legitimate
breakages in scripts. For example, difftool is broken because it sets
GIT_DIR. That gives us an indication of what kinds of breakages we would
see in real-world third-party scripts.

> > The problem is not with "clean", which just happens to be a destructive
> > command, but rather with the notion of what the git tree is when you
> > provide GIT_DIR.
> 
> Yes, "git add ." would happily add random cruft to your index, which
> is equally bad.

Eh, I would say it is bad, but not equally bad to removing your entire
home directory. ;)

-Peff
