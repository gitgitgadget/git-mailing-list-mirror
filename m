From: Johan Herland <johan@herland.net>
Subject: [PATCH] Add test for cloning with "--reference" repo being a subset of
 source repo
Date: Mon, 03 Mar 2008 10:04:16 +0100
Message-ID: <200803031004.16568.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <alpine.LSU.1.00.0803020743170.22527@racer.site>
 <alpine.LNX.1.00.0803021128510.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 10:05:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW6c4-0008Hx-AD
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 10:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYCCJE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 04:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYCCJE5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 04:04:57 -0500
Received: from smtp.getmail.no ([84.208.20.33]:58662 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522AbYCCJEz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 04:04:55 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JX500H1CD7UN700@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 03 Mar 2008 10:04:42 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX500GOFD74YP00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 03 Mar 2008 10:04:16 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX500LCZD74KDE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 03 Mar 2008 10:04:16 +0100 (CET)
In-reply-to: <alpine.LNX.1.00.0803021128510.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75908>

The first test in this series tests "git clone -l -s --reference B A C",
where repo B is a superset of repo A (A has one commit, B has the same
commit plus another). In this case, all objects to be cloned are already
present in B.

However, we should also test the case where the "--reference" repo is a
_subset_ of the source repo (e.g. "git clone -l -s --reference A B C"),
i.e. some objects are not available in the "--reference" repo, and will
have to be found in the source repo.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 02 March 2008, Daniel Barkalow wrote:
> In any case, I've got my current version at
> 
> git://iabervon.org/~barkalow/git.git builtin-clone

Thanks, it already looks much better than the initial version. :)

However, this added test currently fails for me with the following output:

repo is /home/johan/git/git/t/trash/B/.git
dir is E
Initialize E/.git
Initialized empty Git repository in E/.git/
Okay
Wrote /home/johan/git/git/t/trash/A/.git/objects
 to E/.git/objects/info/alternates
Wrote /home/johan/git/git/t/trash/B/.git/objects
 to E/.git/objects/info/alternates
Get for /home/johan/git/git/t/trash/B/.git
error: Trying to write ref refs/remotes/origin/master with nonexistant object 276cf9e94287a7c4e6f79b2724460e9650fa4871
fatal: Cannot update the ref 'refs/remotes/origin/master'.
Remove junk E/.git
Remove junk E

The same test work well with git-clone.sh.
Not sure what's going on here, yet, but I thought I'd give you a heads up.

...Johan


 t/t5700-clone-reference.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index b6a5486..d318780 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -113,4 +113,9 @@ diff expected current'
 
 cd "$base_dir"
 
+test_expect_success 'cloning with reference being subset of source (-l -s)' \
+'git clone -l -s --reference A B E'
+
+cd "$base_dir"
+
 test_done
-- 
1.5.4.3.328.gcaed

