From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.2-rc3
Date: Thu, 10 May 2007 21:28:05 -0700
Message-ID: <7vtzukf0h6.fsf@assigned-by-dhcp.cox.net>
References: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
	<200705111023.37676.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 06:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmMjl-0008Qj-R7
	for gcvg-git@gmane.org; Fri, 11 May 2007 06:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbXEKE2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 00:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbXEKE2I
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 00:28:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57443 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbXEKE2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 00:28:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511042806.FEIJ26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 00:28:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xgU61W0091kojtg0000000; Fri, 11 May 2007 00:28:06 -0400
In-Reply-To: <200705111023.37676.litvinov2004@gmail.com> (Alexander Litvinov's
	message of "Fri, 11 May 2007 10:23:37 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46934>

Alexander Litvinov <litvinov2004@gmail.com> writes:

>> * Plumbing level subproject support.
> ...
> Is there any help onhow to use subprojects ? I did not found anything at 
> Documentation/ directiory.

Sorry, you are expecting too much.

At this point, plumbing level support is just enough to
futureproof and not yet ready for mere mortals who need recipe
to be spoon-fed.  Documentation needs to be written as well as
Porcelains need to be put on top of it.

It is enough to futureproof in the sense that if you fetch from
a remote repository of a project that _uses_ subprojects in its
objects, your end will not barf by saying "oops, I do not know
about a tree that can contain commit objects".

You can already play with it, though.  Try:

	git init ;# in an empty directory

	mkdir sub
        cd sub
        git init
        echo I am sublevel project >READ.ME
        git add READ.ME
        git commit -a -m 'sublevel initial commit'
        cd .. ;# back to toplevel

        echo I am toplevel project >READ.ME
        mkdir dir
        echo hello >dir/world
        git add .
        git commit -a -m 'toplevel initial commit'

A subproject in git is nothing but a directory that is a regular
git repository by its own right, but "tied to" the containing
repository.  In this example, 'sub' is such a subproject.

At this point, if you run "git ls-tree -r -t HEAD", you would get
something like this:

        $ git ls-tree -r -t HEAD
        100644 blob 20a51da49ae274e8e6449b11ffad38bcddfee9f9	READ.ME
        040000 tree dbd05ee6f475f80f28fb3bd4f4be3cec91547add	dir
        100644 blob ce013625030ba8dba906f756967f9e9ca394464a	dir/world
        160000 commit e502e6978a792adbec7e5e7a76a29a6597bda314	sub

The object name for 'sub' is the commit object name at HEAD of
the subproject.  Verify it with:

	$ (cd sub && git-rev-parse HEAD)"
	e502e6978a792adbec7e5e7a76a29a6597bda314

The mode bit 160000 is something new -- git versions prior to
1.5.2 would not understand it, and fetching from this repository
would fail with older tools.  That is what futureproofing is
mostly about.

Now, let's have a bit of fun by going down to subproject and
advance its history.

	cd sub
        echo touch it >>READ.ME
        git commit -a -m 'subproject second commit'
        cd .. ;# back to toplevel

What does that change look like to the toplevel project?

	$ git diff
        diff --git a/sub b/sub
        index e502e69..300e71f 160000
        --- a/sub
        +++ b/sub
        @@ -1 +1 @@
        -Subproject commit e502e6978a792adbec7e5e7a76a29a6597bda314
        +Subproject commit 300e71f68d458cdc8ce571b1b720ad16be992be2

That's right.  The current state of the toplevel project records
that subproject was at its initial commit, but now you advanced
its history and notices the difference.  You could even make a
commit to record that the updated subproject state should go
with the toplevel.

	echo updated subproject >>READ.ME
        git commit -a -m 'updated'

I was going to list what still do not work, but this is pretty
much it.  For example, you would expect this to check out
subproject in the right state:

	mv sub sss ;# stash away somewhere
        git checkout -f

This "git checkout" *recreates* sub/ directory, but it does not
(yet) run git-init in it, nor check out the named commit (you
can find it out with "git ls-files -s sub") there.  However, you
could at this point do:

	cd sub
        git init
        git pull ../sss
        cd .. ;# back to toplevel

and running "git diff" at the toplevel realizes that nothing has
changed.
        
If you are interested, go back to the list archive and start
reading around April 13th - 15th.  We had quite an active
weekend; two neat features (subproject and attributes)
materialized almost at the same time.
