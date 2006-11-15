X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:17:22 +0100
Message-ID: <200611150917.23756.andyparkins@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 09:17:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i4l9Gpm3nAKr7rNAenSbraSqBnJrXNGu1N6NolweRnkw0FHQ3LSCqmfXjemFFBp/bk0G/nGsd+/H1BtfIYRlyGLFMzU4nKZFREla3bx0byGMeKQOaQqntbjJL+DCaesX5s4BXgoDnGpWk/d6CHKUvHYSJ0Zc3nQeIt6Z3erhnzM=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31426>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkGtm-0004IX-Dw for gcvg-git@gmane.org; Wed, 15 Nov
 2006 10:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966708AbWKOJRc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 04:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966714AbWKOJRc
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 04:17:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:58445 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966708AbWKOJRb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 04:17:31 -0500
Received: by ug-out-1314.google.com with SMTP id m3so81128ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 01:17:30 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr2528014ugj.1163582248528; Wed, 15
 Nov 2006 01:17:28 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id j2sm503013ugf.2006.11.15.01.17.27; Wed, 15 Nov 2006 01:17:28 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 15 04:32, Nicolas Pitre wrote:

> OK..... let's pretend this is my follow-up to your "If I were redoing

Personally, I agree with almost everything in this email.  Except the 
implementation of point 3.

> 3) remote branch handling should become more straight forward.

I was completely confused by this origin/master/clone stuff when I started 
with git.  In hindsight, now I understand git a bit more, this is what I 
would have liked:

 * Don't use the name "origin" twice.  In fact, don't use it at all.  In a 
distributed system there is no such thing as a true origin.

 * .git/remotes/origin should be ".git/remotes/default".   "origin" is only 
special because it is the default to push and pull - it's very nice to have a 
default, but it should therefore be /called/ "default".

 * Whatever git-clone calls the remote, it should be matched by a directory 
in .git/refs/remotes.  So .git/remotes/$name contains "Pull"s to get all the 
remote branches to .git/refs/remotes/$name/*.   This implies that 
git /always/ does --use-separate-remote in clone.  If a branch is practically 
read-only it should be technically read-only too.

 * If clone really wants to have a non-read-only master, then that should 
be .git/refs/heads/master and will initialise 
to .git/refs/remotes/$name/master after cloning.  Personally I think this is 
dangerous because it assumes there is a "master" upstream - which git doesn't 
mandate at all.  Maybe it would be better to take the upstream HEAD and 
create a local branch for /that/ branch rather than require that it is 
called "master".

 * Ensuring we have /all/ upstream branches at a later date is hard, and not 
automatic.  Here is the .git/remotes/default file that should be possible:
    URL: git://host/project.git
    Pull: refs/heads/*:refs/remotes/default/*
   Now, every git-pull would check for new upstream branch refs and sync them 
into the local remotes list.  These are read-only so it'd be perfectly safe 
to delete any locally that no longer exist upstream.

 * git-clone should really just be a small wrapper around
    - git-init-db
    - create .git/remotes/default
    - maybe create specific .git/config
    - git-fetch default
   If git-clone does anything that can't be done with settings in the config 
and the remotes/default file then it's wrong.  The reason I say this is that 
as soon as git-clone has special capabilities (like --shared, --local 
and --reference) then you are prevented from doing magic with existing 
repositories.  For example; how do you create a repository that contains 
branches from two other local repositories that have the objects hard linked?

While I'm writing wishes, I'd like to jump on Junio's integration with other 
fetch-backends wish.  I use git-svn, and it would be fantastic if I could 
replace:

git-svn init --id upstream/trunk svn://host/path/trunk
git-svn fetch --id upstream/trunk
git-svn init --id upstream/stable svn://host/path/branches/stable
git-svn fetch --id upstream/stable

With a .git/remotes/svn
 SVN-URL: svn://host/path
 Pull: trunk:refs/remotes/upstream/trunk
 Pull: branches/stable:refs/remotes/upstream/stable
and
 git fetch svn

Obviously, the syntax is just made up; but you get the idea.  Even better, 
would be if it could cope with my "*" syntax suggested above:
 SVN-URL: svn://host/path
 Pull: trunk:refs/remotes/upstream/trunk
 Pull: branches/*:refs/remotes/upstream/*


There have been lots of "wishlist" posts lately; would it be useful if I tried 
to collect all these suggestions from various people into one place to try 
and get a picture of any consensus?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
