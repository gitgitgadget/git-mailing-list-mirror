From: Junio C Hamano <junkio@cox.net>
Subject: Dropping Git.pm (at least Git.xs)?
Date: Sun, 03 Sep 2006 04:34:31 -0700
Message-ID: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 13:34:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJqFA-0002lS-Ur
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 13:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWICLeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 07:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWICLeV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 07:34:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60350 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751293AbWICLeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 07:34:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060903113419.FKFO27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 3 Sep 2006 07:34:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HnaE1V0031kojtg0000000
	Sun, 03 Sep 2006 07:34:14 -0400
To: pasky@suse.cz
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26371>

I was reviewing the "next" tonight and ended up reverting a few
patches that came from Git.pm topic that touched fairly core
part of the system.

Parts of environment.c and sha1_file.c are fairly old code that
has "we start in one repository, do our work and exit" mentality
pretty much ingrained.  The reverted one was meant to minimally
work it around to allow switching between repositories.

The intention is good, but I felt keeping such hack without
thinking about what the semantics of switching repositories
should mean would harm eventual libification.

In the ideal world in admittably not so immediate future, I
would rather have a honestly libified git that encapsulates
git_dir, git_object_dir, git_index_file, etc. into a structure
("struct git_repository" perhaps) and passes a pointer to it to
functions like has_sha1_file(), get_sha1() and friends.
Probably to keep the changes manageable, we would start from one
instance of "struct git" that is the default, and existing
interfaces would become thin wrappers that pass the pointer to
that default one to the updated functions that are repo aware.

One great promise Git.pm topic showed, at least from my point of
view, was consolidation of core-wrapper functions various script
had.  In the hindsight, I should have pushed for that
consolidation a lot stronger while rejecting Git.xs (I
underestimated that Git.xs would introduce such portability
issues).  After all, existing Perl scripts did things without
having to use any .xs.

Since there is no serious user of Git.pm exists, especially
git-mv and git-fmt-merge-msg are now not in Perl anymore, I do
not think we are in great hurry to have Git.xs yet.  I would
expect that the most major customer of Git.xs to be gitweb
eventually, but to support it in persistent environment (read:
mod_perl) we would need to have multi-repo infrastructure in
place.  And I do not think we want a hacky one.

What bothered me most was that has_sha1_file() issue; I think it
is Ok for read_sha1_file() to return object contents from a
repository that is not the current repository even after the
eventual libification that each invocation of a function is told
in which repository to operate.  After all, we depend on object
name being a reliable handle to its contents, and if the caller
has a name of the object that is not in the current repository
and wants to get its contents, and if the system happens to know
the answer (even when it shouldn't have known -- the reason it
knows is only because the process happens to have switched to
that other repository in the past), not failing the request and
give the contents is acceptable.  It could even be considered a
feature and would be handy when writing cross repository (albeit
limited to local repositories) diff/merge tools, for example.

But has_sha1_file() is different.  It is used to check if it
exists in the current repository when the caller knows the
object name (and presumably its contents), so that the caller
can base its decision on what to do next based on the result.
It really should care what repository it is operating in.

The approach taken by the patch I reverted were minimal patch to
allow switching, which was OK for get_object() purposes, and did
not even attempt to define what the semantics of has_sha1_file()
and read_sha1_file() should be.

I think being able to switch repositories in a single process is
important needs to be designed, not hacked in.  I am sure there
certainly are other things that needs more thought (e.g. how
should grafts work across repositories), but I think nobody
knows what they are because we haven't thought about the issues
yet.

A few sentences to conclude this message.

 - I think the clean-up promise of Git.pm is great (e.g.
   safe_qx should be part of it not in git-svn alone).

 - I think Git.xs was a bit premature and raised the hurdle of
   cleaning up and consolidating various core-wrappers from
   existing Perl scripts into Git.pm and have them use Git.pm.
   It would be nice if we can drop this part for now, and do a
   bit more Perl-level clean-up first.

 - I think "repository" abstraction, if we are going to have
   one, should be designed from the core level if we are going
   to have it accessible from Git.xs.  Unfortunately I am not
   ready to invest great time and effort for core level
   libification at this moment.



-- 
VGER BF report: U 0.516772
