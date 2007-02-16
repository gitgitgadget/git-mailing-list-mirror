From: Mark Levedahl <mdl123@verizon.net>
Subject: Respun - Scripts to use bundles to move data between repos
Date: Thu, 15 Feb 2007 19:19:51 -0500
Message-ID: <11715851974102-git-send-email-mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqpn-0000rW-4w
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422839AbXBPAUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbXBPAUN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:13 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:55137 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422839AbXBPAUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:12 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00MGZ4X8EGZ0@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:19:57 -0600 (CST)
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39870>

Respun patch for git-bundle / git-unbundle.

I am working a project using git where we have many repositories on
machines that can never be directly connected, but which need to have
the same objects and development history.  Existing git protocols offer
limited support: we can either a) publish and apply patch files branch
by branch, or b) copy an entire repository from one machine to another
and then do local push or fetch.  While both are workable, neither is a
completely satisfactory solution, so I wrote the attached scripts that
support a "bundle" transfer mechanism.  A bundle is a tar archive having
two files: a list of references as given by git-show-ref and a pack file
of objects from git-pack-objects.  git-bundle creates the bundle,
git-unbundle unpacks and applies at the receiving end.  The means of
transporting the bundle file between the machines is arbitrary (sneaker
net, email, etc all can work).

This transfer protocol leaves it to the user to assure that the objects
in the bundle are sufficient: git-fetch and git-push determine what is
needed by comparison, but no such conversation is possible here.  The
approach is to specificy a range of commits to include in the bundle:
e.g.  git-bundle master~10..master to get the last 10 commits.  Having
too many is fine: git at the receiving end happily ignores duplicates.
Having too few objects raises an error and references are updated only
if their full set of dependencies are found in the target repository.


---

Thanks to all for comments on my previous set of patches on this topic,
I have respun them, taking the following actions on the various
suggestions.

1) Reformat help and .txt to fit 80 column screen: Done.

2) Use tar for the bundle, not zip. Done.

3) Link into main makefile: Done (including rename of git* to git*.sh

4) Link into Documentation/cmd-list.perl: Done.

5) Source git-sh-setup: Done (including removal of --bare and git dir
   checks).

6) Use git-index-pack rather than git-unpack-objects -Done.

7) Pipe ref list directly into git-pack-objects. - doesn't handle
   rev-list-args such as --since=5.days.ago, piping through git-rev-list
   first does so I left it that way.

8) Shallow option was broken - removed as non-essential and too hard to
   fix. (can re-add properly later if someone really wants it).

9) Dont use git-fsck, instead tell receiver what commits are needed
   directly. Done, but with regrets. git-rev-list --objects-edge needs
   to be taught to work when given --max-age, git-bundle calculates the
   required result using a shell pipeline for the moment. Will revisit
   after re-educating git-rev-list. (git-bundle does use git-rev-list
   when --max-age is not present).

10) Allow --output file, rather than --output=file. Rejected as this
   required git-bundle to check arguments for git-rev-list rather than
   letting git-rev-parse do that, or requires a specific ordering of
   inputs. The first violates separation of functions (let git-rev-parse
   handle errors on arguments it takes), or simply trades one annoyance
   for another. No available solution is better than what is there now.

11) Don't use temporary files in git-bundle. Left as is. Shell scrambles
   binary data, so cannot be used to split out a binary pack file. This
   is the service tar provides, and tar will only build from existing
   files, so temporary files are needed unless this whole thing is
   re-written in C.


Mark Levedahl
