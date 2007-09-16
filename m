From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 01:06:45 -0700
Message-ID: <7vwsur590q.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Sep 16 10:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWp9n-0000J5-GP
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 10:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbXIPIHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 04:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXIPIHA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 04:07:00 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXIPIG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 04:06:58 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A7DE135E40;
	Sun, 16 Sep 2007 04:07:09 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	(david@lang.hm's message of "Sat, 15 Sep 2007 18:30:53 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58302>

david@lang.hm writes:

> git has pre-commit hooks that could be used to gather the permission
> information and store it into a file.
>
> git now has the ability to define cusom merge strategies for specific
> file types, which could be used to handle merges for the permission
> files.
> ...
> There are some significant advantages of having the permission store
> be just a text file.
>
> 1. it doesn't require a special API to a new datastore in git
>
> 2. when working in an environment that doesn't allow for implementing the
>    permissions (either a filesystem that can't store the permissions or
>    when not working as root so that you can't set the ownership) the file
>    can just be written and then edited with normal tools.
>
> 3. normal merge tools do a reasonable job of merging them.
>
> however to do this git would need to gain the ability to say 'this
> filename is special, it must be checked out before any other file is
> checked out' (either on a per-directory or per-repository level)

I'd rather not implement it at such a low level where a true
"checkout" happens.  For one thing, I am afraid that the special
casing will affect the normal codepath too much and would make
it into a maintenance nightmare.  But more importantly, if you
are switching between commits (this includes switching branches,
checking out a different commit to a detached HEAD, or
pulling/merging updates your HEAD and updates your work tree),
and the contents of a path does not change between the original
commit and the switched-to commit, you may still have to
"checkout" the external information for that path if your
"permission information file" are different between these two
commits.  To the underlying checkout aka "two tree merge"
operation, that kind of change is invisible and it should stay
so for performance reasons, not to harm the normal operation.
IOW, I do not want the core level to even know about the
existence of "permission information file", even the code that
implements it is well isolated, ifdefed out or made conditional
based on some config variable.

I however think your idea to have extra "permission information
file" is very interesting.  What would be more palatable, than
mucking with the core level git, would be to have an external
command that takes two tree object names that tells it what the
old and new trees our work tree is switching between, and have
that command to:

 - inspect the diff-tree output to find out what were checked
   out and might need their permission information tweaked;

 - inspect the differences between the "permission information
   file" in these trees to find out what were _not_ checked out,
   but still need their permission information tweaked.

 - tweak whatever external information you are interested in
   expressing in your "permission information file" in the work
   tree for the paths it discovered in the above two steps.
   This step may involve actions specific to projects and call
   hook scripts with <path, info from "permission information
   file" for that path> tuples to carry out the actual tweaking.

If we go that route, I am not deeply opposed to add code to
Porcelains to call that new command after they "checkout" a new
commit at the very end of their processing (namely, git-commit,
git-merge, git-am, and git-rebase).

Yes, I am very well aware that somebody already mentioned "there
is a window between the true checkout and permission tweaking".
If you need to touch the core level in order to close that
window, I am not interested.

> The ability to handle /etc comes up every few months. it's got to be
> the most common unimplemented request git has seen.

Asking a pony for many times does not necessary make it the
right for you to have the pony.  The sane way to implement this
is in your Makefile, as Randal and other people with more
experience have already pointed out, and I happen to agree with
them.

My gut feeling is that the approach to use an external hook that
reads your "permission information file" could be done with
negligible impact to the normal operation of git.  I suspect
that the "new command" I suggested above that would run after
"checkout" actions would perform what people need to do in their
Makefiles' "install" rules (if they have the work tree vs target
tree distinction), or "post-checkout" rules (if they want to use
the work tree in-place), and not having to write/reinvent a
Makefile target for this in every project would hopefully make
it easier to use.  That is the only reason I am writing this
message on this topic.

> so would changes like this be acceptable?

That is a different question.  Is having an extention to help
people who want to manage perm bits a worthy goal?  Perhaps, but
it depends.  Is it worthy enough goal to complicate the really
core parts of the code and add huge maintenance burden?
Absolutely not.  Can it be made in such a way that it does not
have much impact to the core parts?  We need to see how it is
done.
