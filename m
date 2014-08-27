From: worley@alum.mit.edu (Dale R. Worley)
Subject: What happens when the repository is bigger than gc.autopacklimit * pack.packSizeLimit?
Date: Wed, 27 Aug 2014 15:36:53 -0400
Message-ID: <201408271936.s7RJarOh011358@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 21:43:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMj7c-0003QX-47
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbaH0TnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:43:03 -0400
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:52515
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935467AbaH0TnB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 15:43:01 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2014 15:43:01 EDT
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id juQ71o0081c6gX85DvcvXU; Wed, 27 Aug 2014 19:36:55 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id jvcu1o00Z1KKtkw3jvcvWM; Wed, 27 Aug 2014 19:36:55 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s7RJarQa011359
	for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:36:53 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s7RJarOh011358;
	Wed, 27 Aug 2014 15:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1409168215;
	bh=VVs6SyGExlZfRCFf4+gnh9MExmTdceyG8QIZV+D35o4=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=pTuvnXeCb0UNk1yEqjz//2tuVnl9VRFAuY+mMn8G4sIakwaz0yvhedM3M9zyAeqz2
	 Xv03ixYAU9xwBqO+EU7Lr6jG77I4roBEajOaKQVQqWt9exyRTL1/cEOyTivnZFtdw8
	 MQ8U2tUUmdQcWyxykdBnHiiqiE6bEq3ScNyORmKLp5s+O4ElVG+5uthVvJeKUHBzVY
	 ToVjYI3u58ER2/jYxGWQe1tVbgZRGVE/UyAFcC3U4qUWolYdB1mN31Y56P+PfU0LlJ
	 cvxEym3+vcer3KmSA2XKfkqa0HvmzVwuqV8PcU6VBj35e0nT/oT6+fGoZHo+qM6p72
	 02ianVeirBODg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256032>

[Previously sent to the git-users mailing list, but it probably should
be addressed here.]

A number of commands invoke "git gc --auto" to clean up the repository
when there might be a lot of dangling objects and/or there might be
far too many unpacked files.  The manual pages say:

    git gc:
       --auto
           With this option, git gc checks whether any housekeeping is
           required; if not, it exits without performing any work. Some git
           commands run git gc --auto after performing operations that could
           create many loose objects.

           Housekeeping is required if there are too many loose objects or too
           many packs in the repository. If the number of loose objects
           exceeds the value of the gc.auto configuration variable, then all
           loose objects are combined into a single pack using git repack -d
           -l. Setting the value of gc.auto to 0 disables automatic packing of
           loose objects.

    git config:
       gc.autopacklimit
           When there are more than this many packs that are not marked with
           *.keep file in the repository, git gc --auto consolidates them into
           one larger pack. The default value is 50. Setting this to 0
           disables it.

What happens when the amount of data in the repository exceeds
gc.autopacklimit * pack.packSizeLimit?  According to the
documentation, "git gc --auto" will then *always* repack the
repository, whether it needs it or not, because the data will require
more than gc.autopacklimit pack files.

And it appears from an experiment that this is what happens.  I have a
repository with pack.packSizeLimit = 99m, and there are 104 pack
files, and even when "git gc" is done, if I do "git gc --auto", it
will do git-repack again.

Looking at the code, I see:

builtin/gc.c:
static int too_many_packs(void)
{
	struct packed_git *p;
	int cnt;

	if (gc_auto_pack_limit <= 0)
		return 0;

	prepare_packed_git();
	for (cnt = 0, p = packed_git; p; p = p->next) {
		if (!p->pack_local)
			continue;
		if (p->pack_keep)
			continue;
		/*
		 * Perhaps check the size of the pack and count only
		 * very small ones here?
		 */
		cnt++;
	}
	return gc_auto_pack_limit <= cnt;
}

Yes, perhaps you *should* check the size of the pack!

What is a good strategy for making this function behave as we want it to?

Dale
