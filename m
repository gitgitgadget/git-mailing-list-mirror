From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Sun, 31 Dec 2006 00:26:06 -0500
Message-ID: <20061231052606.GA5722@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043019.GC5823@spearce.org> <7vy7ook5xj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Dec 31 06:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tD5-0007cQ-V5
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbWLaF0M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932890AbWLaF0M
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:26:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44376 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932839AbWLaF0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:26:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0tDB-0002IY-QJ; Sun, 31 Dec 2006 00:26:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3991820FB65; Sun, 31 Dec 2006 00:26:07 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7ook5xj.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35669>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  This is in response to Theodore Tso's email asking why 'git log'
> >  doesn't work in a bare repository.  Now it does.  :-)
> 
> Does it?

It did in my testing.  ;-)
 
> > @@ -160,36 +178,17 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  	 * to do any discovery, but we still do repository
> >  	 * validation.
> >  	 */
> > -	if (getenv(GIT_DIR_ENVIRONMENT)) {
> > -		char path[PATH_MAX];
> > -		int len = strlen(getenv(GIT_DIR_ENVIRONMENT));
> > -		if (sizeof(path) - 40 < len)
> > +	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
> > +	if (gitdirenv) {
> > +		if (PATH_MAX - 40 < strlen(gitdirenv))
> >  			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
> > -		memcpy(path, getenv(GIT_DIR_ENVIRONMENT), len);
> > -		
> > -		strcpy(path + len, "/refs");
> > -		if (access(path, X_OK))
> > -			goto bad_dir_environ;
> > -		strcpy(path + len, "/HEAD");
> > -		if (validate_symref(path))
> > -			goto bad_dir_environ;
> > -		if (getenv(DB_ENVIRONMENT)) {
> > -			if (access(getenv(DB_ENVIRONMENT), X_OK))
> > -				goto bad_dir_environ;
> > -		}
> > -		else {
> > -			strcpy(path + len, "/objects");
> > -			if (access(path, X_OK))
> > -				goto bad_dir_environ;
> > -		}
> > -		return NULL;
> > -	bad_dir_environ:
> > +		if (is_git_directory(gitdirenv))
> > +			return NULL;
> >  		if (nongit_ok) {
> >  			*nongit_ok = 1;
> >  			return NULL;
> >  		}
> 
> I do not think this is correct.
>
> What happens when GIT_DIR is set, and nongit_ok is passed?
> Earlier code returned NULL after setting *nongit_ok so that the
> caller knows the environment points at a directory that is not
> yet a git repository control area.

The new code is correct, or at least does what the old code did.

If GIT_DIR is set we call is_git_directory(); if that returns 1
then the checks passed.  In this case the old code returned NULL
and ignored nongit_ok.  We do the same in the new code.

If GIT_DIR is set and we fail is_git_directory() then one of the
checks failed.  In this case the old code jumped to bad_dir_env.
In the new code we don't return NULL and fall through into the if
nongit_ok testing, or into the die("Not a git repository").
 
> > @@ -197,11 +196,17 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  
> >  	offset = len = strlen(cwd);
> >  	for (;;) {
> > -		if (is_toplevel_directory())
> > +		if (is_git_directory(".git"))
> >  			break;
> >  		chdir("..");
> >  		do {
> >  			if (!offset) {
> > +				if (is_git_directory(cwd)) {
> > +					if (chdir(cwd))
> > +						die("Cannot come back to cwd");
> > +					setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
> > +					return NULL;
> > +				}
> >  				if (nongit_ok) {
> >  					if (chdir(cwd))
> >  						die("Cannot come back to cwd");
> 
> I do not know what the new behaviour of this part of the code is
> trying to do.  This is supposed to see if "." is the toplevel
> (equivalently, ".git" is the git_dir, in your implementation),
> otherwise chdir("..") repeatedly until it finds one, and the
> normal return condition is for the working directory of the
> process to be at the toplevel.  So chdir(cwd) you introduced is
> obviously changing the behaviour.

No, its not.

We only bother to look to see if the original cwd (before we started
chdir("..")'ing up) is a git directory if we did not find one during
that chdir up loop.  This means our current working directory is now
"/" but we found a valid repository in cwd.

In this case we chdir back to the repository directory before
returning back to the caller, as what's the point of being in "/"
when running in a bare repository?  Probably better to be in the
repository directory itself.

One could argue that maybe we should run in "/", or in "/tmp" in
this case as there is no working directory associated with this
repository, but that argument is about the same as just saying we
go back into the now discovered GIT_DIR.

-- 
Shawn.
