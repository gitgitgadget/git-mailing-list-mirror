From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 7/8] Provide API access to init_db()
Date: Sat, 19 Apr 2008 20:11:50 +0200
Message-ID: <200804192011.50628.johan@herland.net>
References: <alpine.LNX.1.00.0804171932050.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:35:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnHYI-0006TG-6I
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 20:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762372AbYDSSL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756133AbYDSSL7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 14:11:59 -0400
Received: from smtp.getmail.no ([84.208.20.33]:60134 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758052AbYDSSL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 14:11:58 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JZL0060F3VXVT00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 20:11:57 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZL0020D3VT2620@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 20:11:53 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JZL006JR3VTGB10@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 19 Apr 2008 20:11:53 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0804171932050.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79916>

On Friday 18 April 2008, Daniel Barkalow wrote:
> The caller first calls set_git_dir() to specify the GIT_DIR, and then
> calls init_db() to initialize it. This also cleans up various parts of
> the code to account for the fact that everything is done with GIT_DIR
> set, so it's unnecessary to pass the specified directory around.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  builtin-init-db.c |  180 +++++++++++++++++++++++++++-------------------------
>  cache.h           |    4 +
>  2 files changed, 97 insertions(+), 87 deletions(-)
> 
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 2854868..f5ee209 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c

[... snip snip ...]

> @@ -354,64 +392,32 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		    GIT_WORK_TREE_ENVIRONMENT,
>  		    GIT_DIR_ENVIRONMENT);
>  
> -	guess_repository_type(git_dir);
> -
> -	if (is_bare_repository_cfg <= 0) {
> -		git_work_tree_cfg = xcalloc(PATH_MAX, 1);
> -		if (!getcwd(git_work_tree_cfg, PATH_MAX))
> -			die ("Cannot access current working directory.");
> -		if (access(get_git_work_tree(), X_OK))
> -			die ("Cannot access work tree '%s'",
> -			     get_git_work_tree());
> -	}
> -
>  	/*
>  	 * Set up the default .git directory contents
>  	 */
> -	git_dir = getenv(GIT_DIR_ENVIRONMENT);
>  	if (!git_dir)
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> -	safe_create_dir(git_dir, 0);
>  
> -	/* Check to see if the repository version is right.
> -	 * Note that a newly created repository does not have
> -	 * config file, so this will not fail.  What we are catching
> -	 * is an attempt to reinitialize new repository with an old tool.
> -	 */
> -	check_repository_format();
> -
> -	reinit = create_default_files(git_dir, template_dir);
> +	if (is_bare_repository_cfg < 0)
> +		is_bare_repository_cfg = guess_repository_type(git_dir);
>  
> -	/*
> -	 * And set up the object store.
> -	 */
> -	sha1_dir = get_object_directory();
> -	len = strlen(sha1_dir);
> -	path = xmalloc(len + 40);
> -	memcpy(path, sha1_dir, len);
> -
> -	safe_create_dir(sha1_dir, 1);
> -	strcpy(path+len, "/pack");
> -	safe_create_dir(path, 1);
> -	strcpy(path+len, "/info");
> -	safe_create_dir(path, 1);
> -
> -	if (shared_repository) {
> -		char buf[10];
> -		/* We do not spell "group" and such, so that
> -		 * the configuration can be read by older version
> -		 * of git.
> -		 */
> -		sprintf(buf, "%d", shared_repository);
> -		git_config_set("core.sharedrepository", buf);
> -		git_config_set("receive.denyNonFastforwards", "true");
> +	if (!is_bare_repository_cfg) {
> +		if (git_dir) {
> +			const char *git_dir_parent = strrchr(git_dir, '/');
> +			if (git_dir_parent)
> +				git_work_tree_cfg = strdup(make_absolute_path(xstrndup(git_dir, git_dir_parent - git_dir)));

1. Aren't we leaking the xstrndup()?
2. s/strdup/xstrdup/?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
