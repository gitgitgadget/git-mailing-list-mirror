From: Junio C Hamano <junkio@cox.net>
Subject: Re: impure renames / history tracking
Date: Wed, 01 Mar 2006 11:56:52 -0800
Message-ID: <7v3bi2ey63.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
	<4405C012.6080407@op5.se>
	<Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
	<46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com>
	<Pine.LNX.4.64.0603011851430.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 20:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEXRS-0006up-HY
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 20:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWCAT4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 14:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWCAT4z
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 14:56:55 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20712 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751880AbWCAT4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 14:56:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301195521.UAPL20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 14:55:21 -0500
To: paul@hibernia.jakma.org
In-Reply-To: <Pine.LNX.4.64.0603011851430.13612@sheen.jakma.org> (Paul Jakma's
	message of "Wed, 1 Mar 2006 19:13:36 +0000 (GMT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17007>

Paul Jakma <paul@clubi.ie> writes:

> For sake of argument assume the workflow corresponds to:
>
>     o-o-o-o---o--o
>    /              \
> --o----------------m->
>
> And collapsing just the 'oops, made a typo' commits so it looks like:
>
>     o-----o------o
>    /              \
> --o----------------m->
>
>
> The /real/ point, other than workflow, is:
>
> - can we track 'rename and rewrite'?

Yes.  Especially the collapsing is 'oops, made a typo' kind.

Interestingly enough, there are two levels of "rename tracking"
the current git does.  Whey you run "git whatchanged -M", you
are looking at renames between each commit in the commit chain,
one step at a time.  There as long as the rename+rewrite does
not amount to too much rewrite, you would see what should be
detected as rename to be detected as renames.  I found the
current default threshold parameters to be about right, maybe a
bit too tight sometimes, though.  If you want to loosen the
default, you can specify similiarity index after -M.

The way recursive merge strategy uses the rename detection,
unlike what whatchanged shows you, does not use chains of
commits down to the common merge base in order to detect renames
(my recollection may be wrong here -- it's a while since I
looked at the recursive merge the last time).  It just looks at
the two heads being merged, and detects similarility between
them.  So it does not make _any_ difference with the current
implementation of recursive merge if you kept a history full of
"honest but disgusting" commits or collapsed them into a history
with small number of "cleaned up" commits.

One thing it _could_ do (and you _could_ implement as another
merge strategy and call it "pauls-rename" merge) is to follow
the commit chain one by one down to the common merge base from
both heads being merged, and analyze rename history on the both
commit chains.  Then, you would get better rename+rewrite
detection than what it currently does.

HOWEVER.

If you have that kind of rename-following merge, a workflow that
collapses a useful history into a single huge commit "Ok, this
commit is a roll-up patch between version 2.6.14 and 2.6.15"
becomes far less attractive than it currently already is.  At
that point, you _are_ throwing away useful history.
