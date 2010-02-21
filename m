Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 15388 invoked by uid 107); 21 Feb 2010 17:43:52 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 12:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab0BURnc (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 12:43:32 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:49330 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0BURnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 12:43:31 -0500
X-Greylist: delayed 1429 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Feb 2010 12:43:31 EST
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 08FCD17B663; Sun, 21 Feb 2010 20:19:40 +0300 (MSK)
Date:	Sun, 21 Feb 2010 20:19:40 +0300
From:	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To:	Miklos Vajna <vmiklos@frugalware.org>, Petr Baudis <pasky@ucw.cz>
Cc:	Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
Subject: Re: [BUG] girocco + git-svn: trunk is not propagated to master
Message-ID: <20100221171939.GA10166@landau.phys.spbu.ru>
References: <20100219132206.GA13734@tugrik.mns.mnsspb.ru> <20100220234200.GS12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100220234200.GS12429@genesis.frugalware.org>
Organization: St.Petersburg State University
User-Agent: Mutt/1.5.6i
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Feb 21, 2010 at 12:42:00AM +0100, Miklos Vajna wrote:
> On Fri, Feb 19, 2010 at 04:22:07PM +0300, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > ---- taskd/clone.sh ----
> > svn://*)
> >     GIT_DIR=. git svn fetch
> >     # Neat Trick suggested by Miklos Vajna
> >     GIT_DIR=. git config remote.origin.url .
> >     GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
> >     GIT_DIR=. git config remote.origin.fetch +refs/remotes/trunk:refs/heads/master
> >     GIT_DIR=. git config remote.origin.fetch +refs/remotes/tags/*:refs/tags/*
> >     GIT_DIR=. git fetch
> 
> Here is the original blog post:
> 
> http://vmiklos.hu/blog/svn-ggit-conversion-using-git-svn

Thanks

> > ---- jobd/update.sh ----
> > svn://*)
> >         GIT_DIR=. bang git svn fetch
> >         GIT_DIR=. bang git fetch
> > 
> > 
> > But it seems it does not work. First I see there is a need for quoting,
> > so e.g. 
> > 
> > -   GIT_DIR=. git config remote.origin.fetch +refs/remotes/heads/*:refs/heads/*
> > +   GIT_DIR=. git config remote.origin.fetch '+refs/remotes/heads/*:refs/heads/*'
> > 
> > but I'm not sure it will fix the problem.
> 
> When I tried this technique in ooo-build, I did not need quoting. Though
> it won't hurt, sure.

Yes it should work as is, but quoting wildcards is defensive. Just in
case.

> > Can we do something about it please?
> 
> Did you get any error message?

No, it sent me an email that cloning was ok and that was it...


... I think I've found the problem -- it's that we need to use
`git config --add` in order to setup multivars. Please find patches below.
Petr, if everything is ok with them, could you please apply it? Thanks.


From fd625c71d1f6ec88bd58faaca24da29c1fb8b5b3 Mon Sep 17 00:00:00 2001
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
index 962c526..0f5d6fa 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -28,8 +28,8 @@ case "$url" in
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
1.7.0.50.g50c1



From 79477bd2cdc60574eb4a07d2dc2c97d9fa663e27 Mon Sep 17 00:00:00 2001
From: Kirill Smelkov <kirr@mns.spb.ru>
Date: Sun, 21 Feb 2010 20:11:09 +0300
Subject: [PATCH 2/2] taskd/clone: quote shell metacharacters where appropriate

At present this involves svn mirror setup -- refspec mappings contain
shell wildcards. Quote them just in case.
---
 taskd/clone.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index 0f5d6fa..cfcb3b1 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -27,9 +27,9 @@ case "$url" in
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
1.7.0.50.g50c1

