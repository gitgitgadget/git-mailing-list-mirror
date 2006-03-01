From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 01 Mar 2006 11:11:51 -0800
Message-ID: <7virqyf094.fsf@assigned-by-dhcp.cox.net>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
	<4405C6BE.2000706@op5.se>
	<Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
	<200603011814.43573.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 20:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEWjs-000367-OS
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 20:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCATLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWCATLy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 14:11:54 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60371 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750710AbWCATLx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 14:11:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301190852.ORJS26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 14:08:52 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 1 Mar 2006 09:40:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17005>

Linus Torvalds <torvalds@osdl.org> writes:

> But if somebody does the get_sha1() magic, and Junio agrees, then I think 
> it would be a great thing to do.

I am inclined to agree here.

Some caveats upfront, though.

Since I was bitten at least once by attempting get_sha1() to
deal with ambiguous names (the issue was between heads and tags
but I think there are similar issues here) I am really reluctant
to have the function look at anywhere other than heads/ and
tags/ without explicit prefix.

Currently get_sha1_basic() says:

	* look in $GIT_DIR with these prefixes in turn and take
          the first match: "", "refs", "refs/tags", "refs/heads".

The extended one _would_ in addition say one of these things:

	* if none of the above prefixes work, try other
          directories under refs/ as prefixes and take the first
          match.

	or

	* if none of the above prefixes work, try other
          directories under refs/ as prefixes and if there is a
          unique match take it.  If there are more than one
          match, do not take either.

In the context of get_sha1(), get_sha1_basic() is used like
this:

	* if get_sha1_basic() finds an answer, use it.
          Otherwise see if it is an abbreviated object name.

The behaviour of a naive implementation of the former would
depend on readdir() and traversal order, which makes (from the
end user's point of view) a hard to understand confusion that is
not reproducible.  Another repository cloned from such would
even give you different answers.

The latter at first sounds sane, but it has a subtle issue,
which was what bitten me previously between heads/ and tags/.
In that broken version, if you have a head called "dead" and a
tag with the same name, neither was taken ("they are not unique,
so do not take either!") and we ended up finding an object whose
SHA1 name began with those two bytes 0xDE 0xAD.  I do not think
this has happened in the field, fortunately, but it would have
been quite hard to diagnose.

So if we were to do it, I would say do the latter, but be very
careful to make sure you fail the whole get_sha1() when you bail
out of the "try possible prefixes" codepath because of
ambiguity.  There may be other issues involved, but I wouldn't
know -- I reverted the "do not take either if they are
ambiguous between heads/ and tags/" patch primarily because of
the reason from the above paragraph, but also did not want to
deal with any other potential issues to keep my sanity ;-).
