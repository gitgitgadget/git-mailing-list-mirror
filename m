From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Sat, 30 Dec 2006 21:09:12 -0800
Message-ID: <7vy7ook5xj.fsf@assigned-by-dhcp.cox.net>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
	<20061231043019.GC5823@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Dec 31 06:09:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0swm-00068z-AX
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbWLaFJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbWLaFJP
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:09:15 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61973 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbWLaFJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:09:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231050914.HIPB19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 00:09:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5H8T1W0141kojtg0000000; Sun, 31 Dec 2006 00:08:28 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231043019.GC5823@spearce.org> (Shawn O. Pearce's message of
	"Sat, 30 Dec 2006 23:30:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35668>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  This is in response to Theodore Tso's email asking why 'git log'
>  doesn't work in a bare repository.  Now it does.  :-)

Does it?

> +static int is_git_directory(const char *suspect)
>  {
> +	char path[PATH_MAX];
> ...
> +
>  	return 1;
>  }

I think this is a good refactoring.

> @@ -160,36 +178,17 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	 * to do any discovery, but we still do repository
>  	 * validation.
>  	 */
> -	if (getenv(GIT_DIR_ENVIRONMENT)) {
> -		char path[PATH_MAX];
> -		int len = strlen(getenv(GIT_DIR_ENVIRONMENT));
> -		if (sizeof(path) - 40 < len)
> +	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
> +	if (gitdirenv) {
> +		if (PATH_MAX - 40 < strlen(gitdirenv))
>  			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
> -		memcpy(path, getenv(GIT_DIR_ENVIRONMENT), len);
> -		
> -		strcpy(path + len, "/refs");
> -		if (access(path, X_OK))
> -			goto bad_dir_environ;
> -		strcpy(path + len, "/HEAD");
> -		if (validate_symref(path))
> -			goto bad_dir_environ;
> -		if (getenv(DB_ENVIRONMENT)) {
> -			if (access(getenv(DB_ENVIRONMENT), X_OK))
> -				goto bad_dir_environ;
> -		}
> -		else {
> -			strcpy(path + len, "/objects");
> -			if (access(path, X_OK))
> -				goto bad_dir_environ;
> -		}
> -		return NULL;
> -	bad_dir_environ:
> +		if (is_git_directory(gitdirenv))
> +			return NULL;
>  		if (nongit_ok) {
>  			*nongit_ok = 1;
>  			return NULL;
>  		}

I do not think this is correct.

What happens when GIT_DIR is set, and nongit_ok is passed?
Earlier code returned NULL after setting *nongit_ok so that the
caller knows the environment points at a directory that is not
yet a git repository control area.

> @@ -197,11 +196,17 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  
>  	offset = len = strlen(cwd);
>  	for (;;) {
> -		if (is_toplevel_directory())
> +		if (is_git_directory(".git"))
>  			break;
>  		chdir("..");
>  		do {
>  			if (!offset) {
> +				if (is_git_directory(cwd)) {
> +					if (chdir(cwd))
> +						die("Cannot come back to cwd");
> +					setenv(GIT_DIR_ENVIRONMENT, cwd, 1);
> +					return NULL;
> +				}
>  				if (nongit_ok) {
>  					if (chdir(cwd))
>  						die("Cannot come back to cwd");

I do not know what the new behaviour of this part of the code is
trying to do.  This is supposed to see if "." is the toplevel
(equivalently, ".git" is the git_dir, in your implementation),
otherwise chdir("..") repeatedly until it finds one, and the
normal return condition is for the working directory of the
process to be at the toplevel.  So chdir(cwd) you introduced is
obviously changing the behaviour.

The existing chdir(cwd) is for an error return -- when there was
no directory that has ".git" even when you went all the way up
to the root level, we give up and come back to where we started,
only when the caller suspected that there was no git directory
and is prepared to handle that case, which is signalled by us
storing 1 to *nongit_ok.
