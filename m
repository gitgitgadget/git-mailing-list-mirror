From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Sun, 27 Jan 2008 19:54:54 -0500
Message-ID: <20080128005454.GA24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <alpine.LSU.1.00.0801271402330.23907@racer.site> <20080127173212.GW24004@spearce.org> <alpine.LSU.1.00.0801271841230.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJIHv-0003X6-69
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 01:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbYA1Ay7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 19:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbYA1Ay7
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 19:54:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44329 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbYA1Ay6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 19:54:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJIGr-0003ot-Vx; Sun, 27 Jan 2008 19:54:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0766620FBAE; Sun, 27 Jan 2008 19:54:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801271841230.23907@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71843>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 27 Jan 2008, Shawn O. Pearce wrote:
> > 
> > Sure, $USER is set.  For "jdoe".  But due to the "chmod 700 foo.git" 
> > above jdoe isn't actually allowed access to the repository directory. So 
> > it doesn't matter what $USER is set to, jdoe cannot get to the files of 
> > the repository.
> 
> Ah, that's what I missed.  I thought you already used git-shell, and did 
> not really read the chmod part.

No, I'm not using git-shell.  I'm actually currently using a setuid
git-receive-pack, which we've both agreed is horribly ugly.  I want
to get away from that mess.
 
> > 2) Use the SSH key feature to have remote users login as
> >    the repository owner, but use the authorized_keys file
> >    to force them to only execute git-shell.
> >    This is uh, ugly, especially with 50+ users.
> 
> Slight variation: do not permit other users access to your machine, except 
> via git-shell.  Then you don't need chmod 0700.

This isn't an option.  At least 10% of the users need a real shell
on this system, but cannot be trusted to not directly edit the
repository.  I'm also not able to get them different user accounts
(one for git-shell, one for normal shell) because giving the same
human two different user accounts on the same UNIX system will
cause the world to explode.  At least according to some management
people who get paid 3x what I get paid.

Of course, note those same people have also said that a SAMBA server
cannot run on a system unless it is a SAMBA server.  Catch-22.
You cannot run SAMBA unless you are already running SAMBA.  :-\

> > 4) Add full user authentication to git-daemon and then do #3.
> >    The user authentication can provide data down into the update
> >    hook, such as by setting the $GIT_REMOTE_USER environment
> >    variable.  That's basically this change, except I'm using bog
> >    standard SSH to perform the authentication for me.
> 
> AFAIR the plan was to keep git-daemon as simple and stupid as possible; in 
> particular _not_ to add any authentication.

Yup.  I think its smart.  Defer authentication off to the standard OS
tools, so we don't have to deal with it in git itself.

Yet I'm offering a patch for comment that adds some level of
authentication to git-daemon.  At least it still just relies on
UNIX uids and doesn't actually try to link to PAM.  :-)
 
-- 
Shawn.
