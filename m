From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH 1.5.0.1.37] fix git-remote inconsistent about use of dots in remote names
Date: Wed, 21 Feb 2007 03:30:42 -0500
Message-ID: <20070221083042.GE23952@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 09:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJmsB-0000VT-R5
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 09:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbXBUIaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 03:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbXBUIaq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 03:30:46 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:44782 "EHLO jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161137AbXBUIap convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Feb 2007 03:30:45 -0500
Received: from tau.jukie.net ([10.10.10.211]:47329)
	by jukie.net with esmtp (Exim 4.50)
	id 1HJms6-0004yI-St
	for git@vger.kernel.org; Wed, 21 Feb 2007 03:30:42 -0500
Received: by tau.jukie.net (Postfix, from userid 1000)
	id 89173A74E91; Wed, 21 Feb 2007 03:30:42 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40288>

Hi,

I was trying to setup a git repository to use as a site 'alternative'
repo for various kernel projects.

I am currently using one with the .git/remotes/* method of specifying
remotes, but I decided to convert to .git/config method because of
git-remote update.

So here is what I am doing

$ git version
git version 1.5.0.1.37.g1e592

$ mkdir cache.git
$ cd cache.git
$ git init-db

$ git remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
$ git remote add v2.6.15.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.15.y.git
$ git remote add v2.6.16.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
$ git remote add v2.6.17.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.17.y.git 
$ git remote add v2.6.18.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git
$ git remote add v2.6.19.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.19.y.git
$ git remote add v2.6.20.y git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y.git

$ git remote 
linus
v2

$ git remote update
Fetching linus
...
Fetching v2
fatal: 'v2': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
Cannot get the repository state from v2
fetch v2: command returned error: 1

The problem seems obvious.  I have dots in my remote names, and
git-remote uses git-config to read the configuration.

Fix below.

-Bart

>From 781fc372ee0861fb93a3f97ac3b81a1dca823bf1 Mon Sep 17 00:00:00 2001
From: Bart Trojanowski <bart@jukie.net>
Date: Wed, 21 Feb 2007 03:28:01 -0500
Subject: [PATCH] allow git-remote to parse out names with periods in them

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 git-remote.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 6e473ec..f8f9ee7 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -67,7 +67,7 @@ sub list_remote {
 		$git->command(qw(config --get-regexp), '^remote\.');
 	};
 	for (@remotes) {
-		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
+		if (/^remote\.(.+)\.url\s+(.*)$/) {
 			add_remote_config(\%seen, $1, $2, $3);
 		}
 	}
-- 
1.5.0.1.37.g1e592
