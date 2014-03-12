From: Andrew Keller <andrew@kellerfarm.com>
Subject: Borrowing objects from nearby repositories
Date: Tue, 11 Mar 2014 23:37:49 -0400
Message-ID: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 04:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNZzS-0003oV-2z
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 04:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbaCLDhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 23:37:54 -0400
Received: from atl4mhob05.myregisteredsite.com ([209.17.115.43]:43305 "EHLO
	atl4mhob05.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754782AbaCLDhx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 23:37:53 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.210])
	by atl4mhob05.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s2C3boUu023029
	for <git@vger.kernel.org>; Tue, 11 Mar 2014 23:37:50 -0400
Received: (qmail 26306 invoked by uid 0); 12 Mar 2014 03:37:50 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.103?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 12 Mar 2014 03:37:50 -0000
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243918>

Hi all,

I am considering developing a new feature, and I'd like to poll the group for opinions.

Background: A couple years ago, I wrote a set of scripts that speed up cloning of frequently used repositories.  The scripts utilize a bare Git repository located at a known location, and automate providing a --reference parameter to `git clone` and `git submodule update`.  Recently, some coworkers of mine expressed an interest in using the scripts, so I published the current version of my scripts, called `git repocache`, described at the bottom of <https://github.com/andrewkeller/ak-git-tools>.

Slowly, it has occurred to me that this feature, or something similar to it, may be worth adding to Git, so I've been thinking about the best approach.  Here's my best idea so far:

1)  Introduce '--borrow' to `git-fetch`.  This would behave similarly to '--reference', except that it operates on a temporary basis, and does not assume that the reference repository will exist after the operation completes, so any used objects are copied into the local objects database.  In theory, this mechanism would be distinct from '--reference', so if both are used, some objects would be copied, and some objects would be accessible via a reference repository referenced by the alternates file.

2)  Teach `git fetch` to read 'repocache.path' (or a better-named configuration), and use it to automatically activate borrowing.

3)  For consistency, `git clone`, `git pull`, and `git submodule update` should probably all learn '--borrow', and forward it to `git fetch`.

4)  In some scenarios, it may be necessary to temporarily not automatically borrow, so `git fetch`, and everything that calls it may need an argument to do that.

Intended outcome: With 'repocache.path' set, and the cached repository properly updated, one could run `git clone <url>`, and the operation would complete much faster than it does now due to less load on the network.

Things I haven't figured out yet:

*  What's the best approach to copying the needed objects?  It's probably inefficient to copy individual objects out of pack files one at a time, but it could be wasteful to copy entire pack files just because you need one object.  Hard-linking could help, but that won't always be available.  One of my previous ideas was to add a '--auto-repack' option to `git-clone`, which solves this problem better, but introduces some other front-end usability problems.
*  To maintain optimal effectiveness, users would have to regularly run a fetch in the cache repository.  Not all users know how to set up a scheduled task on their computer, so this might become a maintenance problem for the user.  This kind of problem I think brings into question the viability of the underlying design here, assuming that the ultimate goal is to clone faster, with very little or no change in the use of git.


Thoughts?

Thanks,
Andrew Keller
