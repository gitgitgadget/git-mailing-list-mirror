From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 3/3] Teach Girocco to mirror http:// style SVN repos
Date: Thu, 6 May 2010 11:18:42 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20100506071842.GA3436@tugrik.mns.mnsspb.ru>
References: <cover.1269255835.git.kirr@mns.spb.ru> <b7d25a4325c26bed2351257521878109b71ad771.1269255835.git.kirr@mns.spb.ru> <20100505185409.GV11185@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: admin@repo.or.cz, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 06 09:33:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9vaX-0006kI-Ke
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 09:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411Ab0EFHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 03:33:37 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:49345 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab0EFHdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 03:33:35 -0400
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2010 03:33:35 EDT
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1O9vKR-0007LY-5r; Thu, 06 May 2010 11:17:03 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1O9vM2-0000w2-Jf; Thu, 06 May 2010 11:18:42 +0400
Content-Disposition: inline
In-Reply-To: <20100505185409.GV11185@machine.or.cz>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146453>

On Wed, May 05, 2010 at 08:54:09PM +0200, Petr Baudis wrote:
> On Mon, Mar 22, 2010 at 02:08:01PM +0300, Kirill Smelkov wrote:
> > From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> > 
> > Currently we can mirror svn:// repos, but http:// is assumed to be used
> > for Git. Teach the tool to use svn+http:// style urls for http:// svn
> > repositories.
> > 
> > This is very needed, because most SVN hosting services only provide
> > http:// style access to their services. e.g. google code, python.org,
> > etc...
> > 
> > This has not been tested on full Girocco installation - just partly. But
> > if it works, let's also add svn+https later.
> 
> Thanks, applied.
> 
> (BTW, it would be much better if you sent patches to admin@repo.or.cz
> instead.

I see, and thanks for applying this one finally.

Btw, would you please also apply those two important (one of them) fixes
to svn mirroring setup?

*Please*


>From bdb55d014374c0f594ab70d7b22617fc61201d81 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Sun, 21 Feb 2010 20:02:00 +0300
Subject: [PATCH 1/2] taskd/clone: Don't forget to use 'git config --add' for multivars setup

Neat Trick suggested by Miklos Vajna setups origin remote as '.' and
also setups 3 refspecs for remotes.origin.fetch.

The trick is nice indeed, but in order to setup config multivar, one
have to use explicit --add option for `git config' (*) or else old var
value is just replaced.

The problem showed in svn-mirror repositories with stale master (was not
updating from trunk) and also as lack of branches -- that's
understandable -- we had '+refs/remotes/tags/*:refs/tags/*' config last,
and tags were working OK.

Fix it.

(*) explicit --add was needed since 89c4afe0 (Add --add option to
    git-repo-config) in git.git, which dates to git v1.4.4.2-225-g89c4afe
---
 taskd/clone.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index f99d046..270626c 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -30,8 +30,8 @@ case "$url" in
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
 		GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
-		GIT_DIR=. git config remote.origin.fetch +refs/remotes/trunk:refs/heads/master
-		GIT_DIR=. git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
+		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/trunk:refs/heads/master
+		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
 		GIT_DIR=. git fetch
 		;;
 	darcs://*)
-- 
1.7.1.16.g5dc5



>From 0db9ccc033ac6b82ff3026fa89846616a9b74f9e Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Sun, 21 Feb 2010 20:11:09 +0300
Subject: [PATCH 2/2] taskd/clone: quote shell metacharacters where appropriate

At present this involves svn mirror setup -- refspec mappings contain
shell wildcards. Quote them just in case.
---
 taskd/clone.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index 270626c..e634388 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -29,9 +29,9 @@ case "$url" in
 		GIT_DIR=. git svn fetch
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
-		GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
-		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/trunk:refs/heads/master
-		GIT_DIR=. git config --add remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
+		GIT_DIR=. git config remote.origin.fetch '+refs/remotes/heads/*:refs/heads/*'
+		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/trunk:refs/heads/master'
+		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/tags/*:refs/tags/*'
 		GIT_DIR=. git fetch
 		;;
 	darcs://*)
-- 
1.7.1.16.g5dc5




> At least in theory - if anyone is interested helping out with
> various rather badly needed repo.or.cz tasks
> [http://repo.or.cz/w/girocco.git/blob/rorcz:/TODO], please let me know
> and I will give you some admin permissions.)

Thanks for the offer. Unfortunately I can't commit to this task :(


Thanks,
Kirill
