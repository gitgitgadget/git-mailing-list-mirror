From: Ben Jackson <ben@ben.com>
Subject: git-svn dcommit to HTTP proxy can fail
Date: Sat, 22 Jan 2011 11:58:17 -0800
Message-ID: <20110122195816.GA12162@kronos.home.ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 22 21:18:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgjuQ-0004gG-JW
	for gcvg-git-2@lo.gmane.org; Sat, 22 Jan 2011 21:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957Ab1AVUNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jan 2011 15:13:14 -0500
Received: from kronos.home.ben.com ([71.117.242.19]:57452 "EHLO
	kronos.home.ben.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1AVUNN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jan 2011 15:13:13 -0500
X-Greylist: delayed 894 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jan 2011 15:13:13 EST
Received: from kronos.home.ben.com (localhost [127.0.0.1])
	by kronos.home.ben.com (8.14.3/8.14.3) with ESMTP id p0MJwIuT017540
	for <git@vger.kernel.org>; Sat, 22 Jan 2011 11:58:18 -0800 (PST)
Received: (from bjj@localhost)
	by kronos.home.ben.com (8.14.3/8.14.3/Submit) id p0MJwHCo017538
	for git@vger.kernel.org; Sat, 22 Jan 2011 11:58:17 -0800 (PST)
	(envelope-from bjj)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165415>

git-svn dcommit turns each new git commit into an SVN commit, then uses
its normal fetch mechanism to pull the new revision back from the SVN
server.  It compares the fetched version to the git version with diff-tree.
If they don't match you generally get a very cryptic error message.

The primary reason for the mismatches seems to be SVN HTTP proxies.  When
the svn-remote is an HTTP proxy the commit is delegated to the actual
SVN server.  It acknowledges the commit as usual and then updates the
proxies with a post-commit hook.  This means that the commit+fetch combo
is often fast enough to catch the proxy in the pre-commit state and no
new revisions are fetched at all.

Someone has described this with examples on stackoverflow:
http://stackoverflow.com/questions/4238876/git-svn-fails-to-dcommit-even-after-clean-checkout

I wrote an answer to that question including a patch which adds retries
(polling the proxy until the expected revision appears).  I am currently
using that patch at work and it is a big improvement.  I keep meaning to
"productize" it and send it to this list, but there are two remaining
problems:

1.  The proxy update seems to have at least two phases: one that creates
the commit and one that sets metadata (such as author).  The new code is
pretty good at racing in and catching the new commit in an intermediate
state with the author "syncuser" (instead of me).  I don't think that
"syncuser" is a fixed name and I worry that waiting for the commit author
email address to match will break if there is any user mapping going on.

2.  My linear backoff retries total about 10 seconds, and I've blown
that budget with commits of large binaries (eg FPGA images).  You do get
a much more informative error ("New revision 1234 did not appear in
repository after 30 retries.") but it still fails.  Of course I can
increase it, but what's reasonable?

Suggestions?

-- 
Ben Jackson AD7GD
<ben@ben.com>
http://www.ben.com/
