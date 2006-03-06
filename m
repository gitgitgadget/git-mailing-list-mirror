From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git clone downloads objects that are in GIT_OBJECT_DIRECTORY
Date: Sun, 5 Mar 2006 21:57:02 -0500
Message-ID: <20060306025702.GH25790@spearce.org>
References: <20060306010825.GF20768@kvack.org> <20060306014253.GD25790@spearce.org> <7vfylwcncn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 03:57:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG5uQ-00080w-W9
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 03:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWCFC5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWCFC5G
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 21:57:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46780 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750891AbWCFC5F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 21:57:05 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FG5u0-0000mC-UZ; Sun, 05 Mar 2006 21:56:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1F37C20FBBF; Sun,  5 Mar 2006 21:57:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfylwcncn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17267>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Benjamin LaHaise <bcrl@kvack.org> wrote:
> >> Hi folks,
> >> 
> >> Doing a fresh git clone git://some.git.url/ foo seems to download the 
> >> entire remote repository even if all the objects are already stored in 
> >> GIT_OBJECT_DIRECTORY=/home/bcrl/.git/object .  Is this a known bug?  
> >> At 100MB for a kernel, this takes a *long* time.
> >
> > I believe it is a known missing feature.  :-) git-clone doesn't
> > prep HEAD to have some sort of starting point so the pull it uses
> > to download everything literally downloads everything as nothing
> > is in common.
> 
> You would first 'clone -l -s' from your local repository and
> then clone into that from whatever remote, perhaps.

Yea but that's about as much fun as creating a bare repository
by hand.  (Which I've been doing up until this thread prompted me
to read git-clone.sh and learn the existance of --bare.)

It might be nicer if the user could place a list of locally (here
locally being possibly remote but closer network-wise) available
repositories which should be considered as sources for faster
cloning.  When cloning a remote repository git-clone would try to
examine each of the designated repositories to see if any of them
have commits in common with the remote; if so clone off that and
then pull from the remote, but designating the remote as `origin'.

This could be ugly if you have a large number of locally available
candidates or if the candidates are many (e.g. 1000s) commits
behind the remote being cloned.  But it would save the user from
pulling down 100+MB of objects they already have while making it
very convient to establish a new repository+working directory based
on someone else's publically available repository.


Or we could just tell the user to create their own clone script,
e.g. kernel-clone:

	#!/bin/sh
	git-clone -l -n -s ~/kernel-base "$2" &&
	cd "$2" &&
	echo "URL: $1" >.git/remotes/origin &&
	echo "Pull: master:origin" >>.git/remotes/origin &&
	git-pull


But it would be better if it was more integrated, and somehow
slightly more automatic...

-- 
Shawn.
