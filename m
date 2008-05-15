From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 09:06:19 +0200
Message-ID: <482BE0EB.6040306@viscovery.net>
References: <482B935D.20105@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Thu May 15 09:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwXYY-0008SL-DN
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 09:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbYEOHGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 03:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYEOHGY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 03:06:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39037 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbYEOHGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 03:06:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JwXXf-0006DC-VM; Thu, 15 May 2008 09:06:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B8A43546; Thu, 15 May 2008 09:06:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <482B935D.20105@facebook.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82184>

David Reiss schrieb:
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
>  	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
> +	const char *env_ceiling_dirs = getenv(CEILING_DIRS_ENVIRONMENT);
>  	static char cwd[PATH_MAX+1];
>  	const char *gitdirenv;
>  	const char *gitfile_dir;
> -	int len, offset;
> +	int len, offset, ceil_offset;
>  
>  	/*
>  	 * Let's assume that we are in a git repository.
> @@ -415,6 +517,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		die("Unable to read current working directory");
>  
>  	/*
> +	 * Compute ceil_offset based on GIT_CEILING_DIRS.  It is actually the offset
> +	 * of the first character in cwd after the trailing slash of the ceiling.
> +	 * Putting it so far to the right is necessary in order to bail out of the
> +	 * "--offset" loop early enough.
> +	 */
> +	ceil_offset = 1 + longest_ancestor_length(cwd, env_ceiling_dirs);
> +
> +	/*
>  	 * Test in the following order (relative to the cwd):
>  	 * - .git (file containing "gitdir: <path>")
>  	 * - .git/
> @@ -443,9 +553,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			check_repository_format_gently(nongit_ok);
>  			return NULL;
>  		}
> -		chdir("..");
>  		do {
> -			if (!offset) {
> +			if (offset <= ceil_offset) {
>  				if (nongit_ok) {
>  					if (chdir(cwd))
>  						die("Cannot come back to cwd");
> @@ -455,6 +564,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  				die("Not a git repository");
>  			}
>  		} while (cwd[--offset] != '/');

If you make it so that the default value of ceil_offset is 0 (i.e. in the
absence of any GIT_CEILING_DIRS), and at this place you did

		} while (offset > ceil_offset && cwd[--offset] != '/');

you wouldn't have to bend backwards with this off-by-one magic, would you?
(But I admit that I haven't tried this code, I'm only comparing it to how
we do it mingw.git.)

-- Hannes
