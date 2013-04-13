From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH v2] config: allow inaccessible configuration under $HOME
Date: Sat, 13 Apr 2013 06:28:16 +0200
Message-ID: <1365827296.4643.9.camel@marge.simpson.net>
References: <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
	 <20130412050550.GA15724@sigill.intra.peff.net>
	 <20130412112636.GC20178@odin.tremily.us>
	 <20130412144855.GA17968@sigill.intra.peff.net>
	 <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
	 <20130412161600.GA20492@sigill.intra.peff.net>
	 <20130412170505.GA2383@sigill.intra.peff.net>
	 <20130412191433.GR27070@google.com>
	 <20130412193755.GA5329@sigill.intra.peff.net>
	 <20130412203442.GT27070@google.com> <20130412210318.GU27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 06:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQs50-0002Sd-De
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 06:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3DME2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 00:28:31 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62631 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab3DME2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 00:28:30 -0400
Received: from [192.168.178.27] (p4FE190F2.dip0.t-ipconnect.de [79.225.144.242])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MGXWy-1UMULp2vYW-00DaQ3; Sat, 13 Apr 2013 06:28:19 +0200
In-Reply-To: <20130412210318.GU27070@google.com>
X-Mailer: Evolution 3.2.3 
X-Provags-ID: V02:K0:H7GXoAY+HVeCS1sFEMPP8ZB+dOzOJFw8lyIyUN5OhF4
 V6IZAcLMnwe6NZTvyCv8GLkiQDYt8WqD1qD35j6QVz46enqXpU
 wRFdyISo58KLQchMcKm6CRe5cWifFT6aRerO9nhEMdv25yJIIn
 eyBz2GjPa6qXsic0aVGZJcTs1Ho1jAtg3Ef6rFD7gbCg919JcO
 kj/L3pceh8hxiL6uy4C5yIM1A2kFwWVB0fOqQv0uBFLN+iUx6w
 oiDaXowpcB4NpYW2ifh4qmklvw/W7YPz3w5XkkIWo4V1/15OJv
 7B8g4Zx6l90fOTHokKmaAx3rASahV7gO/yH3httno9X/Uktqgm
 7+zIphzJmGAg+6vMyAwOPLSHjqp2XWkqAejvjXJl7hQsjjWB/S
 JqgJ49Yod0Q7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221046>

Tested, original setup works fine.

On Fri, 2013-04-12 at 14:03 -0700, Jonathan Nieder wrote: 
> The changes v1.7.12.1~2^2~4 (config: warn on inaccessible files,
> 2012-08-21) and v1.8.1.1~22^2~2 (config: treat user and xdg config
> permission problems as errors, 2012-10-13) were intended to prevent
> important configuration (think "[transfer] fsckobjects") from being
> ignored when the configuration is unintentionally unreadable (for
> example with EIO on a flaky filesystem, or with ENOMEM due to a DoS
> attack).  Usually ~/.gitconfig and ~/.config/git are readable by the
> current user, and if they aren't then it would be easy to fix those
> permissions, so the damage from adding this check should have been
> minimal.
> 
> Unfortunately the access() check often trips when git is being run as
> a server.  A daemon (such as inetd or git-daemon) starts as "root",
> creates a listening socket, and then drops privileges, meaning that
> when git commands are invoked they cannot access $HOME and die with
> 
>  fatal: unable to access '/root/.config/git/config': Permission denied
> 
> Any patch to fix this would have one of three problems:
> 
>   1. We annoy sysadmins who need to take an extra step to handle HOME
>      when dropping privileges (the current behavior, or any other
>      proposal that they have to opt into).
> 
>   2. We annoy sysadmins who want to set HOME when dropping privileges,
>      either by making what they want to do impossible, or making them
>      set an extra variable or option to accomplish what used to work
>      (e.g., a patch to git-daemon to set HOME when --user is passed).
> 
>   3. We loosen the check, so some cases which might be noteworthy are
>      not caught.
> 
> This patch is of type (3).
> 
> Treat user and xdg configuration that are inaccessible due to
> permissions (EACCES) as though no user configuration was provided at
> all.
> 
> An alternative method would be to check if $HOME is readable, but that
> would not help in cases where the user who dropped privileges had a
> globally readable HOME with only .config or .gitconfig being private.
> 
> This does not change the behavior when /etc/gitconfig or .git/config
> is unreadable (since those are more serious configuration errors),
> nor when ~/.gitconfig or ~/.config/git is unreadable due to problems
> other than permissions.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Improved-by: Jeff King <peff@peff.net>
> ---
> Jonathan Nieder wrote:
> 
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -408,11 +408,16 @@ void warn_on_inaccessible(const char *path)
> >  	warning(_("unable to access '%s': %s"), path, strerror(errno));
> >  }
> >  
> > +static int access_error_is_ok(int err, unsigned flag)
> > +{
> > +	return errno == ENOENT || errno == ENOTDIR ||
> 
> Sigh, I can't spell "err".  Here's a v2 incorporating that change and
> with commit message incorporating the latest discussion.
> 
>  builtin/config.c  |  4 ++--
>  config.c          | 10 +++++-----
>  dir.c             |  4 ++--
>  git-compat-util.h |  5 +++--
>  wrapper.c         | 14 ++++++++++----
>  5 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index 33c9bf9..19ffcaf 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -379,8 +379,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  			 */
>  			die("$HOME not set");
>  
> -		if (access_or_warn(user_config, R_OK) &&
> -		    xdg_config && !access_or_warn(xdg_config, R_OK))
> +		if (access_or_warn(user_config, R_OK, 0) &&
> +		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
>  			given_config_file = xdg_config;
>  		else
>  			given_config_file = user_config;
> diff --git a/config.c b/config.c
> index aefd80b..830ee14 100644
> --- a/config.c
> +++ b/config.c
> @@ -58,7 +58,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
>  		path = buf.buf;
>  	}
>  
> -	if (!access_or_die(path, R_OK)) {
> +	if (!access_or_die(path, R_OK, 0)) {
>  		if (++inc->depth > MAX_INCLUDE_DEPTH)
>  			die(include_depth_advice, MAX_INCLUDE_DEPTH, path,
>  			    cf && cf->name ? cf->name : "the command line");
> @@ -954,23 +954,23 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
>  
>  	home_config_paths(&user_config, &xdg_config, "config");
>  
> -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK)) {
> +	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
>  		ret += git_config_from_file(fn, git_etc_gitconfig(),
>  					    data);
>  		found += 1;
>  	}
>  
> -	if (xdg_config && !access_or_die(xdg_config, R_OK)) {
> +	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
>  		ret += git_config_from_file(fn, xdg_config, data);
>  		found += 1;
>  	}
>  
> -	if (user_config && !access_or_die(user_config, R_OK)) {
> +	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK)) {
>  		ret += git_config_from_file(fn, user_config, data);
>  		found += 1;
>  	}
>  
> -	if (repo_config && !access_or_die(repo_config, R_OK)) {
> +	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
>  		ret += git_config_from_file(fn, repo_config, data);
>  		found += 1;
>  	}
> diff --git a/dir.c b/dir.c
> index 91cfd99..9cb2f3d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1637,9 +1637,9 @@ void setup_standard_excludes(struct dir_struct *dir)
>  		home_config_paths(NULL, &xdg_path, "ignore");
>  		excludes_file = xdg_path;
>  	}
> -	if (!access_or_warn(path, R_OK))
> +	if (!access_or_warn(path, R_OK, 0))
>  		add_excludes_from_file(dir, path);
> -	if (excludes_file && !access_or_warn(excludes_file, R_OK))
> +	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
>  		add_excludes_from_file(dir, excludes_file);
>  }
>  
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cde442f..51a29b8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -691,8 +691,9 @@ int remove_or_warn(unsigned int mode, const char *path);
>   * Call access(2), but warn for any error except "missing file"
>   * (ENOENT or ENOTDIR).
>   */
> -int access_or_warn(const char *path, int mode);
> -int access_or_die(const char *path, int mode);
> +#define ACCESS_EACCES_OK (1U << 0)
> +int access_or_warn(const char *path, int mode, unsigned flag);
> +int access_or_die(const char *path, int mode, unsigned flag);
>  
>  /* Warn on an inaccessible file that ought to be accessible */
>  void warn_on_inaccessible(const char *path);
> diff --git a/wrapper.c b/wrapper.c
> index bac59d2..dd7ecbb 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -408,18 +408,24 @@ void warn_on_inaccessible(const char *path)
>  	warning(_("unable to access '%s': %s"), path, strerror(errno));
>  }
>  
> -int access_or_warn(const char *path, int mode)
> +static int access_error_is_ok(int err, unsigned flag)
> +{
> +	return err == ENOENT || err == ENOTDIR ||
> +		((flag & ACCESS_EACCES_OK) && err == EACCES);
> +}
> +
> +int access_or_warn(const char *path, int mode, unsigned flag)
>  {
>  	int ret = access(path, mode);
> -	if (ret && errno != ENOENT && errno != ENOTDIR)
> +	if (ret && !access_error_is_ok(errno, flag))
>  		warn_on_inaccessible(path);
>  	return ret;
>  }
>  
> -int access_or_die(const char *path, int mode)
> +int access_or_die(const char *path, int mode, unsigned flag)
>  {
>  	int ret = access(path, mode);
> -	if (ret && errno != ENOENT && errno != ENOTDIR)
> +	if (ret && !access_error_is_ok(errno, flag))
>  		die_errno(_("unable to access '%s'"), path);
>  	return ret;
>  }
