From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Sun, 27 Jan 2008 12:32:13 -0500
Message-ID: <20080127173212.GW24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <alpine.LSU.1.00.0801271402330.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:32:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJBNC-0000mT-Hq
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 18:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbYA0RcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 12:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYA0RcR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 12:32:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38681 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbYA0RcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 12:32:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJBMW-00020N-DK; Sun, 27 Jan 2008 12:32:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 759C520FBAE; Sun, 27 Jan 2008 12:32:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801271402330.23907@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71822>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 27 Jan 2008, Shawn O. Pearce wrote:
> 
> >     ## Owner (not jdoe)
> >     ##
> >   cat >foo.git/hooks/update <<'EOF'
> >   #!/bin/sh
> >   test -z "$GIT_REMOTE_USER" || exit
> >   case "$GIT_REMOTE_USER" in
> >   jdoe)     exit 0;;
> >   spearce)  exit 0;;
> >   *)        exit 1
> >   esac
> >   EOF
> >   chmod u+x foo.git/hooks/update
> >   chmod 700 foo.git
> > 
> >   git daemon \
> >       --export-all \
> >       --enable=receive-pack \
> >       --base=`pwd` \
> >       --listen=/tmp/shawn-git
> > 
> >     ## Other User
> >     ##
> >   git push jdoe@server:/tmp/shawn-git/foo.git master
> 
> I probably miss something, but if you already go through SSH, the $USER is 
> set appropriately, no?

Sure, $USER is set.  For "jdoe".  But due to the "chmod 700 foo.git"
above jdoe isn't actually allowed access to the repository directory.
So it doesn't matter what $USER is set to, jdoe cannot get to the
files of the repository.
 
> So you could do without git-daemon entirely, and replace the 
> GIT_REMOTE_USER variable in the hook by USER.

No, you can't.

If you give write access to a repository such that a user can push into
it, there is little point in using the update hook to control access to
the repository.  Why?  Because anyone with write access can just use the
standard Git commands (e.g. `git --git-dir=foo.git branch -D next`)
to maniplate the repository in ways that the update hook wouldn't like.

So if you want to give out write access, but have it be limited
to what `git receive-pack` will permit (especially when coupled
with an update hook like contrib/hooks/update-paranoid) you need
to limit what a user can do to *only* executing git-receive-pack,
but you also need to allow that receive-pack to actually have write
permission on the repository.

So you come down to four options:

1) Make git-receive-pack setuid to the repository owner.
   This is uh, ugly.

2) Use the SSH key feature to have remote users login as
   the repository owner, but use the authorized_keys file
   to force them to only execute git-shell.
   This is uh, ugly, especially with 50+ users.

3) Export git-daemon over TCP and --enable=receive-pack.
   This doesn't get us any authentication.  Sure the
   user is limited to what the update hook allows, but
   the update hook has no way to trust who the remote
   peer is.  You might as well not bother.

4) Add full user authentication to git-daemon and then do #3.
   The user authentication can provide data down into the update
   hook, such as by setting the $GIT_REMOTE_USER environment
   variable.  That's basically this change, except I'm using bog
   standard SSH to perform the authentication for me.

If we don't do something like this then I think we need to teach
git-daemon how to accept SSL connections, and then once you give it
SSL you need to implement peer authentication by certificates, and
then have git_connect() in connect.c also implement setting up SSL
connections, and doing peer authentication with certificates.  Ick.

Relying on SSH is the better approach in my opinion.  It comes with
a set of well trusted servers (OpenSSH) and user client tools that
many users and administrators already understand (e.g. ssh-agent).

Someone on #git yesterday mentioned that a problem half-deferred
(user authentication) is a problem half-solved.  I've half-deferred
the authentication problem to SSH, much as we already have it
deferred to SSH...  :-)

-- 
Shawn.
