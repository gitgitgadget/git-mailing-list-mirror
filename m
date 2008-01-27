From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Secure central repositories by UNIX socket
 authentication
Date: Sun, 27 Jan 2008 18:51:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801271841230.23907@racer.site>
References: <20080127103934.GA2735@spearce.org> <alpine.LSU.1.00.0801271402330.23907@racer.site> <20080127173212.GW24004@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 19:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJCbn-00005N-Ig
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 19:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbYA0Sv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 13:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYA0Sv1
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 13:51:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:35834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753583AbYA0Sv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 13:51:26 -0500
Received: (qmail invoked by alias); 27 Jan 2008 18:51:24 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp045) with SMTP; 27 Jan 2008 19:51:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XBesve2uXUQ78twfs2d9IaHwOxIngxt+YI2/BP6
	pKeaYbzrx5a671
X-X-Sender: gene099@racer.site
In-Reply-To: <20080127173212.GW24004@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71826>

Hi,

On Sun, 27 Jan 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 27 Jan 2008, Shawn O. Pearce wrote:
> > 
> > >     ## Owner (not jdoe)
> > >     ##
> > >   cat >foo.git/hooks/update <<'EOF'
> > >   #!/bin/sh
> > >   test -z "$GIT_REMOTE_USER" || exit
> > >   case "$GIT_REMOTE_USER" in
> > >   jdoe)     exit 0;;
> > >   spearce)  exit 0;;
> > >   *)        exit 1
> > >   esac
> > >   EOF
> > >   chmod u+x foo.git/hooks/update
> > >   chmod 700 foo.git
> > > 
> > >   git daemon \
> > >       --export-all \
> > >       --enable=receive-pack \
> > >       --base=`pwd` \
> > >       --listen=/tmp/shawn-git
> > > 
> > >     ## Other User
> > >     ##
> > >   git push jdoe@server:/tmp/shawn-git/foo.git master
> > 
> > I probably miss something, but if you already go through SSH, the 
> > $USER is set appropriately, no?
> 
> Sure, $USER is set.  For "jdoe".  But due to the "chmod 700 foo.git" 
> above jdoe isn't actually allowed access to the repository directory. So 
> it doesn't matter what $USER is set to, jdoe cannot get to the files of 
> the repository.

Ah, that's what I missed.  I thought you already used git-shell, and did 
not really read the chmod part.

> So if you want to give out write access, but have it be limited to what 
> `git receive-pack` will permit (especially when coupled with an update 
> hook like contrib/hooks/update-paranoid) you need to limit what a user 
> can do to *only* executing git-receive-pack, but you also need to allow 
> that receive-pack to actually have write permission on the repository.
> 
> So you come down to four options:
> 
> 1) Make git-receive-pack setuid to the repository owner.
>    This is uh, ugly.

Concur.

> 2) Use the SSH key feature to have remote users login as
>    the repository owner, but use the authorized_keys file
>    to force them to only execute git-shell.
>    This is uh, ugly, especially with 50+ users.

Slight variation: do not permit other users access to your machine, except 
via git-shell.  Then you don't need chmod 0700.

> 3) Export git-daemon over TCP and --enable=receive-pack.
>    This doesn't get us any authentication.  Sure the
>    user is limited to what the update hook allows, but
>    the update hook has no way to trust who the remote
>    peer is.  You might as well not bother.

Right.  --enable=receive-pack was meant for environments where you have to 
trust everybody anyway (think "Visual" SourceSafe, or PVCS with 
repositories on network shares).

> 4) Add full user authentication to git-daemon and then do #3.
>    The user authentication can provide data down into the update
>    hook, such as by setting the $GIT_REMOTE_USER environment
>    variable.  That's basically this change, except I'm using bog
>    standard SSH to perform the authentication for me.

AFAIR the plan was to keep git-daemon as simple and stupid as possible; in 
particular _not_ to add any authentication.

> If we don't do something like this then I think we need to teach 
> git-daemon how to accept SSL connections, and then once you give it SSL 
> you need to implement peer authentication by certificates, and then have 
> git_connect() in connect.c also implement setting up SSL connections, 
> and doing peer authentication with certificates.  Ick.

I never tried anything like this, but it should not be _that_ difficult, 
should it?  Of course, I should read up on it before I say something about 
it first ;-)

Ciao,
Dscho
