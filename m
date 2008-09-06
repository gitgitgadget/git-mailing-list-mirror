From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates and push
Date: Sat, 06 Sep 2008 11:06:49 -0700
Message-ID: <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
 <20080906162030.GT9129@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2DG-00031H-9z
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbYIFSG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYIFSG5
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:06:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbYIFSG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:06:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B15C5FCA2;
	Sat,  6 Sep 2008 14:06:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 711565FCA1; Sat,  6 Sep 2008 14:06:51 -0400 (EDT)
In-Reply-To: <20080906162030.GT9129@mit.edu> (Theodore Tso's message of "Sat,
 6 Sep 2008 12:20:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 970B7440-7C3E-11DD-9915-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95084>

Theodore Tso <tytso@MIT.EDU> writes:

> Long-standing mis-feature in git's logic in deciding what to push.
> It's been reported a few times, but apparently it's hard to fix, or at
> least it never hsa been fixed as far as I know.

This comes from an early (mis)design of git.

Background.

 * A git repository and the object store it uses can be separate.  From
   the beginning, you can have a"objects/" directory (aka "object store")
   that is shared by more than one repositories.  There is no Porcelain
   level support to set up two repositories that physically share the same
   object store, but the result of "git init; rm -rf .git/objects; ln -s
   $other/.git/objects .git/objects" was supposed to work (and it still
   largely works, until you gc) in the original design.

   The alternate object store does not even have to be a git repository,
   which makes things worse.  You can have everybody pointing at
   /var/cache/objects, and /var/cache does not have to be a git repository
   (i.e. no var/cache/refs).

 * The existing alternates mechanism is not about alternate repositories.
   It is about alternate object stores.  That is why each line of this
   file points at "objects" directory elsewhere, not the ".git" directory
   that is typically at one level above that "objects" directory.

   The fact your repository's object store points at the object store that
   happens to be inside Linus's repository does not imply that Linus's
   object store is associated with refs in Linus's repository in any way
   (that's the early _mis_design part).

 * An existing ref in a git repository is meant to be a guarantee that all
   objects the object referenced by the ref is found somewhere in the
   object store(s) the repository uses.  Object transfers in git
   (i.e. fetch and push) use this guarantee to tell what a repository has
   to the other side.

   What happens in your case is that github end knows that the repository
   you are pushing into have up to the refs you have there.  Alternate may
   point at object store that holds objects from Linus's repository, but
   there is no information as to what the latest commits you do not see in
   your refs namespace (namely, "what's Linus's latest" is not something
   you can learn from your repository that has alternates).

A possible fix would involve:

 - Deprecate objects/info/alternates file, and GIT_OBJECT_DIRECTORY and
   GIT_ALTERNATE_OBJECT_DIRECTORIES environment variables;

 - Introduce info/alternates that points at alternate _repositories_ (as
   opposed to objects/info/alternates that points at alternate object
   stores);

 - Teach fetch and push to include refs from alternate _repositories_ into
   what local side considers complete.

The above won't break existing setups, but it won't help them either.  All
the borrowing repositoies need to be converted if we go that route.

We could instead redefine the semantics of the existing alternates
mechanism.  This technically *breaks* backward compatibility, but I
suspect it won't hurt many existing installations:

 - Declare that a freestanding object store is illegal.  In other words,
   if a directory "$D/objects" is (1) used as $GIT_OBJECT_DIRECTORY's
   value, (2) pointed by some repository's "alternates" file, or (3)
   listed in $GIT_ALTERNATE_OBJECT_DIRECTORIES's value, this change makes
   it illegal for "$D" not being a proper git repository.

   This will not break your example of your repository's object store
   borrowing from the object store inside Linus's repository.

 - When you have "$D/objects" in alternates, start relying on "$D/refs"
   being correct (i.e. repository $D is not corrupt).  This technically
   makes the system slightly less robust, as we are depending on _other
   people's_ good behaviour even more when you use alternates, but you are
   already depending on them having good objects in $D/objects anyway, so
   it is not a big deal.

 - Now that we declared that everything reachable from "$D/refs" do not
   have to be transferred from elsewhere when a push sends things into us
   (or a fetch gets things from elsewhere into us) when you have
   "$D/objects" in your alternates.  In your "borrowing from Linus"
   example, Linus's latest will be reachable from somewhere in "$D/refs",
   when you are borrowing from him by having "$D/objects" in your
   alternates. 
