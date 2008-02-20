From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor annoyance with git push
Date: Wed, 20 Feb 2008 00:23:06 -0800
Message-ID: <7vzltwavf9.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
 <20080209030046.GA10470@coredump.intra.peff.net>
 <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
 <alpine.LSU.1.00.0802091307160.11591@racer.site>
 <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802100213330.11591@racer.site>
 <20080210101756.GB26568@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101219280.11591@racer.site>
 <20080210122321.GA31009@coredump.intra.peff.net>
 <alpine.LSU.1.00.0802101303140.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 09:24:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRkFR-0003JI-RF
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 09:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbYBTIXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 03:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbYBTIXi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 03:23:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbYBTIXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 03:23:36 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3695DBD26;
	Wed, 20 Feb 2008 03:23:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 6DC9FBD1C; Wed, 20 Feb 2008 03:23:24 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802101303140.11591@racer.site> (Johannes
 Schindelin's message of "Sun, 10 Feb 2008 13:04:03 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74505>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hmm.  So that means that if an old-timer comes to help to a new-comer, 
> the old-timer will be surprised?

Actually, after carefully examining what I have been doing, I
think this "somebody cries 'git push ;# nothing else' does not
work, and old timer needs to remember to check one extra thing
to help" has been a bit overblown.

To diagnose "git push ;# nothing else", you would already need
to ask the following _anyway_:

 - On what branch are you?

 - Do you have "branch.$current_branch.remote"?

 - What is "branch.$current_branch.remote" set to?

 - Do you have remote.$that_remote.url?

   - If it is http://, do you have very new version of curl
     library, often not even in distro?

   - If it is http://, does it end with '/'?

   - If it is http://, do you have DAV enabled over there?

   - If it is host:path, does your non-interactive ssh get
     appropriate PATH at the other end?

   - Is your username there the same as local?  Otherwise do you
     have "User your_name_over_there" set up in your
     $HOME/.ssh/config?

   - 47 other questions about transfers.

 - Do you have remote.$that_remote.push?

 - What local branches do you have?

 - What local branches does $that_remote have?

So it is not _so_ unreasonable if we add an extra configuration
or two to this mix.

What configuration semantics is reasonable is a different
matter.  Let's back up a bit.

The "matching" semantics has been advertised as a convenient way
to keep track of which branches you would want publish and which
ones to keep private without having to have extra configuration.
This is very true for people whose workflow is based on _owned_
public distribution points.  The destination is controlled by
you and you alone, and after pushing the branches you want to
show out explicitly, the destination repository _remembers_
which branches you are interested in publishing for later
"matching" pushes.  When you are no longer interested in showing
that work, you remove it from the remote and matching and that
(1) stops publishing and at the same time (2) remembers you are
no longer interested in publishing.

However, when you allow others to push into the destination, the
set of branches there obviously cannot serve as your private
configuration anymore.  So "matching" can never be a convenient
way if your push is to a shared repository.

Which would mean that "matching" is not a personal taste nor
even per-repository matter.  I think it is reasonable to set
this per-remote.

    You may have a repository you use during daytime on your
    desktop, and the repository may have more than one remotes
    defined.  "origin" may point to a shared repository you push to
    and fetch from in order to work together with others, "backup"
    may point to another repository on your server you push your
    work into, and "satellite" may point to yet another repository
    on your notebook when you are done for the day and take your WIP
    along with you.

    You may not want "matching" when interacting with the shared
    repository (if you always want "current only" is a different
    matter, but let's pretend you do), but you would want
    "matching" when pushing back to "satellite", and you would
    want "mirror" when pushing to "backup".

So perhaps we can have "remote.*.push" that says "current" in
some way.  Tentatively let's say the syntax is like this:

	[remote "origin"]
        	url = server.oss.example.org:/pub/project.git/
                push = HEAD
                fetch = +refs/heads/*:refs/remotes/origin/*
	[remote "backup"]
        	url = server.example.com:/home/me/mine.git/
                push = +refs/*:refs/*
	[remote "satellite"]
        	url = notebook.example.com:/home/me/mine.git/

	[branch "master"]
        	remote = "origin"
                merge = refs/heads/master
	[branch "ticket-47"]
               	remote = "origin"
                merge = refs/heads/ticket-47

While on "master", "git push" will say...

	Ah, you are too lazy to say where to push to.
	branch.master.remote says "origin", so that is it.

	And you are too lazy to say what to push either.
	remote.origin.push says HEAD which is a special token
	that means the current branch.

	Let's pretend you told me "git push origin master"

I was hoping we can do without the "remote.*.push = HEAD" if we
can detect the remote is a shared repository while talking to
it, but I think it is a bit too much magic, because we cannot
visualize what the pushing side and the receiving side  are
negotiating.

Putting this "push = HEAD" by default when "git clone" and "git
remote add" creates the [remote "$remote"] section is probably
possible, and at that stage we may even be able to do the "if
the other end is shared, then set this up automagically", as the
result of the magic can be inspected in the resulting config
file.
