X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: updating only changed files source directory?
Date: Tue, 24 Oct 2006 15:12:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610241435420.9789@iabervon.org>
References: <ehjqgf$ggb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 24 Oct 2006 19:13:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ehjqgf$ggb$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30002>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcRhe-0008Uh-Ps for gcvg-git@gmane.org; Tue, 24 Oct
 2006 21:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161196AbWJXTMn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 15:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJXTMn
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 15:12:43 -0400
Received: from iabervon.org ([66.92.72.58]:30736 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1161196AbWJXTMm (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 15:12:42 -0400
Received: (qmail 21323 invoked by uid 1000); 24 Oct 2006 15:12:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 24
 Oct 2006 15:12:41 -0400
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

On Tue, 24 Oct 2006, Han-Wen Nienhuys wrote:

> 
> Hello there,
> 
> I'm just starting out with GIT.  Initially, I want to use experiment with
> integrating it into our binary builder structure for LilyPond.
> 
> The binary builder roughly does this:
> 
>  1. get source code updates from a server to a single, local
>     repository. This is currently a git repository that is that
>     tracks our CVS server.
> 
>  2. copy latest commit from a branch to separate source directory.
>     This copy should only update files that changed.
> 
>  3. Incrementally compile from that source directory

The terminology in the git world is, I think, a little different from what 
you expect. We call the thing that contains all of the tracked information 
(what you're calling the repository) the "object database"; what we call 
the "repository" is a bit different: it primarily keeps track of the heads 
of branches, in addition to either containing an object database or 
referencing an external one. So you need a repository for each source 
directory (because it keeps track of what commit is currently in the 
source directory), but it doesn't need to have its own complete object 
database, which is what you're trying to share between all of them.

You have a single repository with no source directory that contains the 
database and the heads according to the upstream source, and then each 
source directory has a repository that contains the head as far as you've 
built it in that directory. You fetch into the single bare repository 
from upstream, and then pull into each source directory from the bare 
repository; this will do the minimal update to the contents of the source 
directory automatically.

I think that you want to request a few git features:

 - support having a bare repository not on a branch, so that it can fetch 
   all heads from its upstream. You're not doing anything branch-specific 
   in the bare repository anyway, but git currently wants a valid HEAD to
   accept a path as containing a git repository

 - support getting an origin remote configuration with a bare repository

 - support cloning a branch of a repository, such that the clone's 
   "origin" is the upstream's chosen branch, not its "master".

 - support cloning without generating a "master" branch in the clone, and 
   instead starting on "origin"

Then you do:

git clone --bare --no-head --with-origin <upstream> REPOSITORY.git

for each branch:

  git clone --shared --branch=<branch> --no-master REPOSITORY.git <branch>

When you want to update:

GIT_DIR=REPOSITORY.git git fetch

for each branch:

 (cd <branch>; git pull; make)

Note that all of the features you need are in "clone" for setting things 
up nicely automatically; if you arrange everything by hand just right, you 
can already to the updating procedure I give.

	-Daniel
