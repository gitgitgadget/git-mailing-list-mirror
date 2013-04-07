From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 18:52:10 +0100
Message-ID: <20130407175210.GI2222@serenity.lan>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
 <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
 <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan>
 <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
 <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:52:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtlh-0001xj-OF
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934234Ab3DGRwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:52:22 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41393 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934154Ab3DGRwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:52:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A8683CDA56C;
	Sun,  7 Apr 2013 18:52:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAV4ZTecQW6L; Sun,  7 Apr 2013 18:52:19 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E61E6CDA580;
	Sun,  7 Apr 2013 18:52:12 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220349>

On Sun, Apr 07, 2013 at 10:52:50PM +0530, Ramkumar Ramachandra wrote:
> Sure, I'll write it out for you from an end-user perspective:

To play Devil's Advocate for a bit...

> 0. Great UI/UX.  No more cd-to-toplevel, and a beautiful set of native
> commands that are consistent with the overall design of git-core.
> Which means: clone (to put something in an unstaged place), add (to
> stage), and commit (to commit the change).  There's now exactly one
> place in your worktree (which is represented as one file in git; think
> of it a sort of symlink)  to look in for all the information.  git
> cat-link <link> to figure out its parameters, git edit-link to edit
> its parameters: no more "find the matching pwd in .gitmodules in
> toplevel".  To remove a submodule, just git rm.  And git mv works!

Presumably now without .git/config support, so I can't override the
checked-in settings without my own custom branch.  Even carrying a dirty
working tree seems problematic here since a checked-out link object is a
directory, which can't have information like the remote URL in it.

> 1. True floating submodules.  You can have a submodule checked out at
> `master` or `v3.1`: no more detached HEADs in submodules unless you
> want fixed submodules.  No additional cruft required to do the
> floating: the information is native, in a link object.

Can't I do that now with "submodule.<name>.branch" and "git submodule
update --remote --rebase" and friends?

> 2. Initializing a nested submodule without having to initialize the
> outer one: no more repo XML nonsense.  And it's composable: you don't
> need to put the information about all submodules in one central place.

How does this interact when there is the following structure:

    super
    `-- sub
        `-- subsub   (specified by sub)

and subsub is specified as a submodule in *both* super and sub but with
different settings.  Do I get different behaviour depending on $PWD?

> 3. Ability to have very many large submodule repositories without the
> performance hit.  It makes sense to block stat() from going through
> when you have floating submodules.  This means that many levels of
> nesting are very easily possible.

Can't I already control this to some degree?  Certainly the following
commands take different amounts of time to run:

    git status
    git -c status.submodulesummary=true status

> 4. It's suddenly much easier to add new features to this
> implementation.  You don't need to do the kind of gymnastics you'd
> have to do if you were hacking on submodule.c/ git-submodule.sh.
> 
> This is basically how "great design" plays out.
