From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Tue, 03 Jul 2007 22:10:35 -0700
Message-ID: <7vy7hwlpo4.fsf@assigned-by-dhcp.cox.net>
References: <20070610150839.GG4084@efreet.light.src>
	<e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	<20070611044258.GJ4084@efreet.light.src>
	<e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	<20070701122625.GC26243@efreet.light.src>
	<e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
	<20070702180309.GA4400@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:11:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x90-0001Ir-Be
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbXGDFKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXGDFKr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:10:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:52868 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbXGDFKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 01:10:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704051037.TVKK1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 01:10:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHAb1X00F1kojtg0000000; Wed, 04 Jul 2007 01:10:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51566>

Jan Hudec <bulb@ucw.cz> writes:

>> P.S: Why 'git-commit --amend -F' it's explicitely forbidden?

The reasoning goes like this (here, I am not particularly trying
to justify it, but am merely explaining the original reasoning
and intended use case as a historical background):

    To amend means to remove the tip commit, replace with a new
    one, possibly but not necessarily with a different tree from
    the removed one.

    Since you are "amending", the spirit of the commit you are
    going to create, in order to replace the old one, ought to
    be the same as the one being replaced.

    - You may be only adding a change that you forgot to add
      before making the previous commit (in which case your tree
      is slightly different, but what you are going to say in
      the commit log message is exactly the same), or

    - you may found a typo in the commit log message and trying
      to fix it (in which case your tree is identical but the
      commit log message would be slightly different).

    In either case, the resulting commit log message would be
    very similar to the existing one, so the tool helps you by
    letting re-use and re-edit the commit log message instead of
    forcing you to re-type it.

There is no room for -F, -c, nor -m to make sense for these use
cases, and giving them to "commit --amend" is most likely a user
error, and diagnozed as such, because "commit --amend" is an
end-user level Porcelain program.

If you are popping one commit and replacing with a totally
**unrelated** commit, that is not what --amend is about.  What
you are doing is "reset --soft HEAD^" followed by "add <something>"
followed by "commit".

At the mechanical level, you could argue that --amend is doing
the same thing.  After all, that reset/add/commit sequence is
exactly what is done by --amend internally.

But if a Porcelain like StGIT or Qgit would want to do that kind
of operation for different use case than "amending", it can and
should use plumbing commands, just like the implementation of
"commit --amend" does, with different constraints and error
checks.
