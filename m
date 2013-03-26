From: Jeff King <peff@peff.net>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 13:41:00 -0400
Message-ID: <20130326174059.GA10383@sigill.intra.peff.net>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <51519DA0.4090201@nod.at>
 <20130326145637.GA3822@sigill.intra.peff.net>
 <5151D589.2000002@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Tue Mar 26 18:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKXsR-0005R8-OO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 18:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab3CZRlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 13:41:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40433 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab3CZRlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 13:41:04 -0400
Received: (qmail 5312 invoked by uid 107); 26 Mar 2013 17:42:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 13:42:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 13:41:00 -0400
Content-Disposition: inline
In-Reply-To: <5151D589.2000002@nod.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219173>

On Tue, Mar 26, 2013 at 06:06:17PM +0100, Richard Weinberger wrote:

> >We could, but that would break the existing behavior for other people
> >(and I assume you mean "when GIT_WORK_TREE is not set at all", as I
> >would think GIT_WORK_TREE=. is explicit enough).
> 
> Is there a valid use case to call git-clean with GIT_DIR set but GIT_WORK_TREE
> not (or to ."")?
> It will delete "." ;)

Yes, setting GIT_DIR but not GIT_WORK_TREE has always been a valid way
to work on a repository where you do not want the working tree polluted
with your .git file. It's not a common setup, but people do use it.
E.g., you might keep ~/mail as a git repo, but do not want the presence
of ~/mail/.git to confuse your mail tools. You can keep ~/git/mail.git
as just a repository, and do "cd ~/mail && GIT_DIR=~/git/mail.git git
foo" (or "git --git-dir=~git/mail.git foo").

Later, we introduced GIT_WORK_TREE (and core.worktree), which provided
another way of doing the same thing (instead of the "cd", you could set
GIT_WORK_TREE). For the most part, I'd expect setting core.worktree to
be the simplest for such setups, as once it is set, you can just do "cd
~/git/mail.git git foo", and everything should just work.

We never deprecated the original "GIT_DIR without GIT_WORK_TREE means
'.' is the implicit worktree" behavior, as nobody ever complained, and
it would break existing users of the feature.

We could do so now, as long as we provide an escape hatch (and I think
spelling that hatch as GIT_WORK_TREE=. is probably sane, but I am open
to other suggestions). And in general we try to avoid such breakage
without a deprecation period to give people time to fix their scripts
and workflows.

> But was kinda shocked that git-clean deletes files outside my git tree.
> I'm aware of -d. But in my case it happened within a fully automated script.
> I simply thought GIT_DIR=.. git-clean -f -d does the right thing...

It did do the right thing; just not the one you expected. :)

The problem is not with "clean", which just happens to be a destructive
command, but rather with the notion of what the git tree is when you
provide GIT_DIR. Though clean is an obvious problematic command,
something like "git reset --hard" could also be destructive. I don't
think it makes sense to do any fix that is specific to clean. If there
is a fix to be done, it should be about making the working tree lookup
algorithm more obvious.

-Peff
