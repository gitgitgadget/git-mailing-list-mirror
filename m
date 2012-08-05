From: Junio C Hamano <gitster@pobox.com>
Subject: Bringing a bit more sanity to $GIT_DIR/objects/info/alternates?
Date: Sat, 04 Aug 2012 21:56:56 -0700
Message-ID: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxsuZ-0001mx-4z
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 06:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab2HEE5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 00:57:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61969 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab2HEE5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 00:57:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A58E29B9C;
	Sun,  5 Aug 2012 00:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=x
	Y8Lw79PpbZL68iiwIXsH74fek0=; b=MIJw9Br7uFGxseCDvhRThVHdZxigyIj/4
	p2Siqp4EscyOVcl6aPcPxoBan9lbbM0NZjXiFdCNzhxBq99AAqnTdusQxmObrfC+
	d82B9wGxwNtr0UtMP2dELwVcIE6JMa8JrUWTnKHv4Rhc6x5VYilvtWcTOCb856n7
	W7SZuAQKPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=joS
	7g/RkKPZw9QCYtnrKmeE0PUdweA0ib3Vy9fsnr7cAuOsrrkwx+Mk5hQXJ3pKZuZ2
	PaLdW7jYfWRACyWWbqaSaoKhnyjUNDzkKozNnTaMTEFkZY5YnAp8K66AWRHaBx9P
	KlaQx16EzsxVvWP7UlYMBtbs7q0EMeBMpcy3JEgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 943DB9B9B;
	Sun,  5 Aug 2012 00:56:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4B0B9B97; Sun,  5 Aug 2012
 00:56:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC0C6E9E-DEB9-11E1-856A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202902>

The "alternates" mechanism lets you keep a single object store (not
necessarily a git repository on its own, but just the objects/ part
of it) on a machine, have multiple repositories on the same machine
share objects from it, to save the network transfer bandwidth when
cloning from remote repositories and the disk space used by the
local repositories.  A repository created by "clone --reference" or
"clone -s" uses this mechanism to borrow objects from the object
store of another repository.  A user also can manually add new
entries to $GIT_DIR/objects/info/alternates to borrow from other
object stores.

The UI for this mechanism however has some room for improvement, and
we may want to start improving it for the next release after the
upcoming Git 1.7.12 (or even Git 2.0 if the change is a large one
that may be backward incompatible but gives us a vast improvement).

Here are some random thoughts as a discussion starter.

 - By design, the borrowed object store MUST not ever lose any
   object from it, as such an object loss can corrupt the borrowing
   repositories.  In theory, it is OK for the object store whose
   objects are borrowed by repositories to acquire new objects, but
   losing existing objects is an absolute no-no.

   But the UI of "clone -s" encourages users to borrow from the
   object store of a repository that the user may actively develop
   in.  It is perfectly normal for users to perform operations that
   make objects that used to be reachable from tips of its branches
   unreachable (e.g. rebase, reset, "branch -d") in a repository
   that is used for active development, but a "gc" after such an
   operation will lose objects that were originally available in the
   repository.  If objects lost that way were still needed by the
   repositories that borrow from it, the borrowing repository gets
   corrupt immediately.

   In practice, this means that users who use "clone -s" to make a
   new repository can *never* prune the original repository without
   risking to corrupt its borrowing repository [*1*].

   Some ideas:

   - Make "clone --reference" without "-s" not to borrow from the
     reference repository.  E.g. if you have a clone of Linus
     repository at /git/linux.git/, cloning a related repository
     using it as --reference:

     $ git clone --reference /git/linux.git git://k.org/linux-next.git

     should still take advantage of /git/linux.git/{refs,objects} to
     reduce the transfer cost of fetching from k.org, but the
     resulting repository should not point /git/linux.git with its
     objects/info/alternates file.

   - Make the distinction between a regular repository and an object
     store that is meant to be used for object sharing stronger.

     Perhaps a configuration item "core.objectstore = readonly" can
     be introduced, and we forbid "clone -s" from pointing at a
     repository without such a configuration.  We also forbid object
     pruning operations such as "gc" and "repack" from being run in
     a repository marked as such.

     It may be necessary to allow some special kind of repacking of
     such a "readonly" object store, in order to reduce the number
     of packfiles (and get rid of loose object files); it needs to
     be implemented carefully not to lose any object, regardless of
     local reachability.

 - When you have a repository and one or more repositories that
   borrow from it, you may want to dissociate the borrowing
   repositories from the borrowed one (e.g. so that you can repack
   or prune the original repository safely, or you may even want to
   remove it).

   I think "git repack -a -d -f" in the borrowing repository happens
   to be the way to do this, but it is not clear to the users why.

   Some ideas:

   - It might not be a bad idea to have a dedicated new command to
     help users manage alternates ("git alternates"?); obviously
     this will be one of its subcommand "git alternates detach" if
     we go that route.

   - Or just an entry in the documentation is sufficient?

 - When you have two or more repositories that do not share objects,
   you may want to rearrange things so that they share their objects
   from a single common object store.

   There is no direct UI to do this, as far as I know.  You can
   obviously create a new bare repository, push there from all
   of these repositories, and then borrow from there, e.g.

	git --bare init shared.git &&
	for r in a.git b.git c.git ...
        do
	    (
		cd "$r" &&
	        git push ../shared.git "refs/*:refs/remotes/$r/*" &&
		echo ../../../shared.git/objects >.git/objects/info/alternates
   	    )
	done

   And then repack shared.git once.

   Some ideas:

   - (obvious: give a canned command to do the above, perhaps then
     set the core.objectstore=readonly in the resuting shared.git)

 - When you have one object store and a repository that does not yet
   borrow from it, you may want to make the repository borrow from
   the object store.  Obviously you can run "echo" like the sample
   script in the previous item above, but it is not obvious how to
   perform the logical next step of shrinking $GIT_DIR/objects of
   the repository that now borrows the objects.

   I think "git repack -a -d" is the way to do this, but if you
   compare this command to "git repack -a -d -f" we saw previously
   in this message, it is not surprising that the users would be
   confused---it is not obvious at all.

   Some ideas:

   - (obvious: give a canned subcommand to do this)


[Footnote]

*1* Making the borrowed object store aware of all the repositories
that borrow from it, so that operations like "gc" and "repack" in
the repository with the borrowed object store can keep objects that
are needed by borrowing repositories, is theoretically possible, but
is not a workable approach in practice, as (1) borrowers may not
have a write access to the shared object store to add such a back
pointer to begin with, (2) "gc"/"repack" in the borrowed object
store and normal operations in the borrowing repositories can easily
race with each other, without any coordination between the users,
and (3) a casual "borrowing" can simply be done with a simple "echo"
as shown in the main text of this message, and there is no way to
ensure a backpointer from the borrowed object store to such a
borrowing repository.
