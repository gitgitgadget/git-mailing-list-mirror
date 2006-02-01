From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 22:42:05 -0800
Message-ID: <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 07:42:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Bgx-0003uE-Ne
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 07:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWBAGmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 01:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWBAGmI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 01:42:08 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25821 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030550AbWBAGmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 01:42:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201064107.LJBV3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 01:41:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 31 Jan 2006 16:38:50 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15388>

Linus Torvalds <torvalds@osdl.org> writes:

> Oh, one final suggestion: if you give a filename to "git commit", and you 
> do the new semantics which means something _different_ than "do a 
> git-update-index on that file and commit", then I'd really suggest that 
> the _old_ index for that filename should match the parent exactly. 
> Otherwise, you may have done a
>
> 	git diff filename
>
> and you _thought_ you were committing just a two-line thing (because you 
> didn't understand about the index), but another, earlier, action caused 
> the index to be different from the file you had in HEAD, and in reality 
> you're actually committing a much bigger diff.

This "I thought I was only checking in the two-liner I did as
the last step but you committed the whole thing, stupid git!"
confusion feels to be a parallel of "I thought I was only
checking in the files I specified on the command line but you
also committed the files I earlier git-add'ed, stupid git!"
confusion.

Taken together with your "during a partially conflicted merge"
example, it feels to me that the simplest safety valve would be
to refuse "git commit paths..." if the index does not exactly
match HEAD.  Not just mentioned paths but anywhere.

People who do not like this can set in their config file some
flag, say, 'core.index = understood', to get the current
behaviour.

The reason I am bringing this up is because of this command
sequence:

	# start from a clean tree, after 'git reset --hard'
        $ create a-new-file
        $ git add a-new-file
        $ edit existing-file
        $ edit another-file
        $ git commit existing-file

There is no question we do not commit "another-file" and we do
commit changes to the "existing-file" as a whole.  What should
we do to "a-new-file", and how do we explain why we do so to
novices?

We can argue it either way.  We could say we shouldn't because
"commit" argument does not mention it.  We could say we should
because the user already told that he wants to add that file to
git.  Either makes sort-of sense from what the end user did.

I think a file "cvs add"ed is committed if whole subdirectory
commit (similar to our "commit -a") is done or the file is
explicitly specified on the "cvs commit" command line, and that
may match people's expectations.  That's an argument for not
committing "a-new-file".  But to be consistent with that, this
should not commit anything:

        # the same clean tree.
	$ create a-new-file
        $ git add a-new-file
        $ git commit

Which is counterintuitive to me by now (because I played too
long with git).

We could make "git commit" without paths to mean the current
"-a" behaviour, which would match CVS behaviour more closely.
However, it would make commit after a merge conflict resolution
in a dirty working tree _very_ dangerous -- it may give more
familiar feel to CVS people, but it is not an improvement for
git people at all.  I would rather not.

Right now, "git add" means "stage this for the next commit in
the index".  If we change the semantics of "git add" to mean "I
am not adding it for the next commit yet; I am just letting you
know there is a file in the working tree so that you can keep an
eye on it for me", using the intent-to-add index entry I've
mentioned a couple of times, I think the above problem might
naturally be solved.  For people who do not use update-index,
"commit -a" and "commit paths..." are the only two ways to
actually check-in anything to the index file for the next
commit ("git add" alone does not count).  "commit -a" would do
the equivalent of current "update all the not-up-to-date file to
the index and then commit", which would include the intent-to-add
paths.
