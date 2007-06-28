From: Yann Dirson <ydirson@altern.org>
Subject: Problem with "stgit show"
Date: Thu, 28 Jun 2007 22:51:54 +0200
Message-ID: <20070628205154.GI7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 22:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I40yN-0000PC-6S
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 22:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761249AbXF1UwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 16:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760123AbXF1UwM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 16:52:12 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55452 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760196AbXF1UwL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 16:52:11 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 124365A2A2;
	Thu, 28 Jun 2007 22:52:09 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id E1E531F150; Thu, 28 Jun 2007 22:51:54 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51128>

While investigating bug #8453 (https://gna.org/bugs/?8453) I looked
for the 1st time at how "stg show" is implemented, and it looks like
this and a couple of related parts of the code need some refactoring.

The problem is, "stg show a@b" and "stg show a@b z@b" trigger
different code paths.  The problem with the latter is that, having
more than one arg, it gets feed through parse_patches(), which is only
designed to deal with patches in a single stack, and rejects "a@b"
as not a member of the current stack.

The single-arg form, at the opposite, falls into the branch designed
to emulate "git show" by allowing git refs not otherwise meaningful to
stgit.  That is, "stg show a@b" seems to only work as a side-effect.

The same difference in handling single-arg from multiple-arg will
similarly cause non-stgit refs to be invalid when not given alone
(ie. "stg show origin/master" works, but "stg show origin/master
patch1" fails with "Unknown patch name: origin/master".


Since the different handling of len(args)==1 results in
inconsistencies, IMHO we should get rid of it.  Now adding support for
out-of-this-stack refs to parse_patches() would require a total
rewrite thereof, so I suggest we leave this for another round.

Non-stgit refs should IMHO be dropped.  Catalin, you mentionned
consistency with "stg pick" IIRC, but "pick" only ever takes a single
arg, so the commands are clearly too different.  We always have
git-show anyway if we want to look at them.

For patches on other branches, we could simply add the common --branch
flag to "stg show".  That would not allow to get patches from
different stacks in a single run, and it's a bit more verbose than the
@ syntax for a single patch, but well, that could make sense for 0.13.

I'll send out a couple of patchlets for this.
-- 
Yann
