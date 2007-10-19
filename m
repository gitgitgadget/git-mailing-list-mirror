From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
 help docs
Date: Fri, 19 Oct 2007 16:27:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191616490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071019065931.GB1463@srparish.net> <47185DAF.7060809@viscovery.net>
 <20071019130402.GD1463@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 16:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IispQ-00062u-JL
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 16:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbXJSO1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 10:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758352AbXJSO1o
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 10:27:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756481AbXJSO1n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 10:27:43 -0400
Received: (qmail invoked by alias); 19 Oct 2007 14:27:41 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp047) with SMTP; 19 Oct 2007 16:27:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WteY5IGaWyTnrT/LCwArptLNEGf+DjzYtDknIud
	L798VsxqvcO7cm
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071019130402.GD1463@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61715>

Hi,

On Fri, 19 Oct 2007, Scott Parish wrote:

>  + check PATH for the location of git

Okay, but better do it only if the current exec_path did not succeed to 
find something, to stay as backwards compatible as possible.

>  + the checking of argv[0] was restricted to absolute paths; remove
>    that restriction so it also works when called with a relative
>    path (eg ../../otheruser/usr/bin/git)

This will utterly break down when you try to do things in a subdirectory 
of your project.  git will cd up, and the relative path will no longer be 
relative.

>  + try to guess and set the env for the typical relative locations for
>    MANPATH and PERL5LIB based off exec_path

Now this is ugly.  At least make it a separate patch.

> +/* Return the first path in PATH that git is found in or NULL if not found */
> +char *git_path_from_env(void)
> +{
> +	const char *env_paths = getenv("PATH");
> +	const char *git = "/git";
> +	int git_len = strlen(git);
> +	char *paths, *path, *colon, *git_path;
> +	int path_len;
> +	struct stat st;
> +
> +	if (!env_paths)
> +		return NULL;
> +
> +	path_len = strlen(env_paths);
> +	path = paths = xmalloc(path_len + 1);
> +	memcpy(paths, env_paths, path_len + 1);
> +
> +	while ((char *)1 != path) {
> +		if ((colon = strchr(path, ':')))
> +		    *colon = 0;
> +
> +		path_len = strlen(path);
> +		git_path = xmalloc(path_len + git_len + 1);
> +		memcpy(git_path, path, path_len);
> +		memcpy(git_path + path_len, git, git_len + 1);
> +
> +		if (!stat(git_path, &st)) { /* found */
> +			free(paths);
> +			git_path[path_len] = 0;
> +			return git_path;
> +		}
> +
> +		free(git_path);
> +		path = colon + 1;
> +	}
> +
> +	free(paths);
> +	return NULL;
> +}

I am convinced that this function will look a lot less ugly when you use 
strbufs.  And I'd call it "find_git_in_path()".

>  /* Returns the highest-priority, location to look for git programs. */
>  const char *git_exec_path(void)
>  {
> -	const char *env;
> +	const char *env, *path;
>  
>  	if (current_exec_path)
>  		return current_exec_path;
>  
>  	env = getenv(EXEC_PATH_ENVIRONMENT);
>  	if (env && *env) {
> +		current_exec_path = env;
>  		return env;
>  	}
>  
> +	if ((path = git_path_from_env())) {
> +		current_exec_path = path;
> +		return path;
> +	}
> +
> +	current_exec_path = builtin_exec_path;
>  	return builtin_exec_path;
>  }

As I said, I'd rather have git try with builtin_exec_path first, and only 
if that fails, search through the PATH, for the _current_ command.

> -static void prepend_to_path(const char *dir, int len)
> +static void prepend_to_env(const char *env, const char *basedir,

I do not like this rename.  It makes things more obscure, rather than 
clearing things up.

> +			   const char *subdir, const char *env_default)
>  {
> -	const char *old_path = getenv("PATH");
> -	char *path;
> -	int path_len = len;
> -
> -	if (!old_path)
> -		old_path = "/usr/local/bin:/usr/bin:/bin";
> -
> -	path_len = len + strlen(old_path) + 1;
> -
> -	path = xmalloc(path_len + 1);
> +	const char *old = getenv(env);
> +	int basedir_len = strlen(basedir);
> +	int subdir_len = strlen(subdir);
> +	char *new;
> +	int old_len;
> +	
> +	if (!old)
> +		old = env_default;
> +
> +	old_len = strlen(old);
> +
> +	new = xmalloc(basedir_len + subdir_len + old_len + 1);
> +	
> +	memcpy(new, basedir, basedir_len);
> +	memcpy(new + basedir_len, subdir, subdir_len);
> +	memcpy(new + basedir_len + subdir_len, old, old_len + 1);
> +	
> +	if (setenv(env, new, 1))
> +		fprintf(stderr, "Setenv failed: %s\n", strerror(errno));
> +
> +	free(new);
> +}

Again, this would be so much more elegant using strbufs.

>  
> -	memcpy(path, dir, len);
> -	path[len] = ':';
> -	memcpy(path + len + 1, old_path, path_len - len);
> +static void prepend_to_envs(const char *dir, int len)
> +{
> +	char *slash;
> +	char *basedir;
> +
> +	/* basedir is dir with "/bin" stripped off */
> +	basedir = xmalloc(len + 1);
> +	memcpy(basedir, dir, len + 1);
> +	
> +	if ((slash = strrchr(basedir, '/'))) {
> +		*slash = 0;
> +		while (slash == basedir + --len) /* found trailing slash */
> +			if ((slash = strrchr(basedir, '/')))
> +				*slash = 0;
> +	}
>  
> -	setenv("PATH", path, 1);
> +	prepend_to_env("PATH", basedir, "/bin:",
> +		       "/usr/local/bin:/usr/bin:/bin");
> +	prepend_to_env("MANPATH", basedir, "/share/man:",
> +		       "/usr/local/share/man:/usr/share/man");
> +	prepend_to_env("PERL5LIB", basedir, "/lib/perl5:",
> +		       "/usr/lib/perl5");
>  
> -	free(path);
> +	free(basedir);
>  }

As I said, this is so controversial it belongs into an own patch.

> @@ -414,8 +444,7 @@ int main(int argc, const char **argv)
>  	 */
>  	if (slash) {
>  		*slash++ = 0;
> -		if (*cmd == '/')
> -			exec_path = cmd;
> +		exec_path = cmd;

As I said, this breaks down.  This alone is enough reason to move it to 
its own patch.  And I strongly suggest the use of make_path_absolute() 
(with an xstrdup()).

> @@ -453,14 +482,15 @@ int main(int argc, const char **argv)
>  	/*
>  	 * We execute external git command via execv_git_cmd(),
>  	 * which looks at "--exec-path" option, GIT_EXEC_PATH
> -	 * environment, and $(gitexecdir) in Makefile while built,
> -	 * in this order.  For scripted commands, we prepend
> -	 * the value of the exec_path variable to the PATH.
> +	 * environment, PATH environment, and $(gitexecdir) in
> +	 * Makefile while built, in this order.  For scripted
> +	 * commands, we prepend the value of the exec_path
> +	 * variable to the PATH.

While reading this, I have to wonder why it is not just simpler to try 
with builtin_exec_path first, and if that fails, just let exec() find the 
program in the PATH?

Ciao,
Dscho
