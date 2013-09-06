From: mfick@codeaurora.org
Subject: A naive proposal for preventing loose object explosions
Date: Fri, 6 Sep 2013 03:42:50 -0000
Message-ID: <54d0a7f13b53e15ad485e212057b85a3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: nasserg@codeaurora.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 05:42:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHmwi-0007VQ-3q
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 05:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758933Ab3IFDmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 23:42:52 -0400
Received: from smtp.codeaurora.org ([198.145.11.231]:44710 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758778Ab3IFDmv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 23:42:51 -0400
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF50A13EF18;
	Fri,  6 Sep 2013 03:42:50 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
	id E30F913F00D; Fri,  6 Sep 2013 03:42:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	pdx-caf-smtp.dmz.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50 autolearn=ham
	version=3.3.1
Received: from www.codeaurora.org (pdx-caf-fw-vip.codeaurora.org [198.145.11.226])
	by smtp.codeaurora.org (Postfix) with ESMTP id A114D13EF18;
	Fri,  6 Sep 2013 03:42:50 +0000 (UTC)
Received: from 172.30.200.101 (proxying for 65.103.115.193)
        (SquirrelMail authenticated user mfick)
        by www.codeaurora.org with HTTP;
        Fri, 6 Sep 2013 03:42:50 -0000
User-Agent: SquirrelMail/1.4.22-3.el6
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234016>

I am imagining what I consider to be a naive approach to preventing
loose unreachable object explosions.   It may seem a bit heavy handed
at first, but every conversation so far about this issue seems to have
died, so I am looking for a simple incremental improvement to what we
have today. I theorize that this approach will provide the same
protections (good and bad) against races as using git-repack -A -d
and git-prune --expire <time> regularly will today.

1a)  Add --prune-packed option to git-repack to force a call to git
prune-packed, without having to specify the -d option to git-repack.

1b) Add a --keep <marker> option to git-repack which will create a
keep file with "marker" in it for existing pack files which were
repacked (not to the new pack).

1c) Now instead of running:

 git-repack -A -d

run:

 git-repack --prune-packed --keep 'prune-when-expired'


This should effectively keep a duplicate copy of all old packfiles
around, but the new pack file will not have unreferenced objects in
it.  This is similar to having unreachable loose objects left around,
but it also keeps around extra copy(ies) of reachable objects wasting
some disk space.  While this will normally consume more disk space in
pack files, it will not explode loose objects, which will likely save
a lot of space when such explosions would have occured.   Of course,
this should also prevent the severe performance downsides to these
explosions.  Object lookups should likely not get any slower than if
repack were not run, and the extra new pack might actually help
find some objects quicker.   Safety with respect to unreachable object
race conditions should be the same as using git repack -A -d since at
least one copy of every object should be kept around during this run?


Then:

2a) Add support for passing in a list of pack files to git-repack.
This list will then be used as the original "existing" list instead
of finding all packfiles without keeps.

2b) Add an --expire-marked <marker> option to git-prune which will
find any pack files with a .keep with "marker" in it, and evaluate if
it meets the --expire time.  If so, it will also call:

   git-repack -a -d <expired-pack-files>...

This should repack any reachable objects from the <expired-pack-files>
into a single new pack file.  This may again cause some reachable
object duplication (likely with the same performance affects as the
first git-repack phase above), but unreachable objects from <expired-
pack-files> will now have been pruned as they would have been if they
had originally been turned into loose objects.

3) Finally on the next repack cycle the current duplicated reachable
objects should likely get fully reconsolidated into a single copy.

Does this sound like it would work?  I may attempt to construct this
for internal use (since it is a bit hacky).  It feels like it could be
done mostly with some simple shell modding/wrapping (feels less scary than
messing with the core C tools).  I wonder if I a missing some obvious flaw
to this approach?

Thanks for any insights,

-Martin
