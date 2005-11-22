From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 1/2] Use remote information in .git/config
Date: Mon, 21 Nov 2005 16:06:58 -0800
Message-ID: <7vhda5lf4t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511211452470.13775@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4q65sst3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511212109440.4213@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 01:08:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeLgl-0000nP-U7
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 01:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVKVAHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 19:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVKVAHB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 19:07:01 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:28885 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932409AbVKVAHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 19:07:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122000630.GUYM15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 19:06:30 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12503>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I am unsure if putting everything in .git/config file is the
>> right approach, though.  What will we put there next?  ls-files
>> ignore patterns?  grafts?  alternates?  We should be able to
>> even get rid of .git/refs directory hierarchy and replace that
>> with something like this:
>> ...
>> Where will we stop, and why?
>
> Ahh! I have a clear picture of what *I* would put into it: all interesting 
> static data about that particular repository which I would not like to 
> version.

There are certain things that _might_ benefit from the third
kind we currently do not support: developer opt-in.

Currently, .gitignore and friends (what you call versioned) are
project-wide.  Anybody who follows git.git uses _the_ .gitignore
that is from the respository, although they can override with
their own .git/info/exclude, which might be a good candidate for
"core.gitignore = ...".  But certain people might want to share
their forked .gitignore without going through hassles to
integrate that to project-wide copy.  ".gitignore" might be a
bad example, and grafts may be better.  People interested in
Linux archaeology might want to share grafts to let them go back
from tip of 2.6 all the way down to 2.4.0 (or before) while
majority of users do not share that interest.

Obviously, user.name is private to you, but you would still want
to use the same across your repositories.

Once we start thinking about allowing the template mechansim to
give default "config" information to newly created repositories,
having everything in one file may make things a bit awkward to
handle.  When you managed to make your colleage interested in
git development, you can let her copy your remotes/junio.  Once
you moved remotes/ to .git/config file, while you would not want
her to use copy of your .git/config verbatim without updating at
least user.name, you would want to have her use other pieces in
the .git/config, including [remote.jnio] bits.

The following comments are not about your patch but I am having
a feeling that we ended up having too much flexibility.  It may
not necessarily be a bad thing when we view git as pure
plumbing, but it makes things confusing to have too many "you
could do it this way if you want to gain XXX, as long as you are
careful about YYY".

For example, we do not define how checked-out tree, repository
and object database _should_ work together.  The officially
recommended way is to have one object database at .git/objects/,
possibly borrowing from somebody via objects/info/alternates,
which hangs under one repository (.git), and the repository can
have one checked-out tree associated with it.

However, it is possible to symlink .git/objects to somewhere
else, to share an object database between two repositories, as
long as you are careful when pruning (you can lose objects the
refs in other repository points at but you do not).

Even worse (or better), you could symlink everything except the
HEAD and index file to somewhere else to have one repository
with multiple checked-out trees (I believe Daniel does this), as
long as you are careful when pulling/fetching (fetching into a
branch that another working tree has checked out will move the
head commit there without updating the index).

Another example is the assumption we place on completeness of
the refs.  We pretty much declares that if there are some
objects you cannot reach starting from your refs, your
repository is corrupt (incomplete). But such an incomplete
repository can be useful in certain situations, and some things
work properly but not others.  I think using commit-walkers
without -a option can easily create such an incomplete
repository.

The recent "should commit be always utf-8" thread probably falls
into this category.  We all know things should be in utf-8, but
other things are possible as long as people understand
boundaries.

Most of the time, what we recommend are the BCP, but
knowledgeable users can deviate from that, to gain some
advantage (e.g. reduced disk space using an incomplete
repository, convenience of having more than one checked-out
trees at the same time, not having to migrate to all UTF-8
system) over the BCP if they are willing to sacrifice something
else or their use pattern is not affected negatively by what
they are losing (e.g. can live without an access to ancient
history, be very careful when pruning and fetching, do not have
people whose names cannot be spelled in KOI-8).
