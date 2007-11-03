From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Sat, 03 Nov 2007 15:27:53 -0700
Message-ID: <7vabpvx8uu.fsf@gitster.siamese.dyndns.org>
References: <472CC676.3000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 23:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoRTV-0001Wq-B1
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 23:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbXKCW2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 18:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbXKCW2A
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 18:28:00 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:37831 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbXKCW2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 18:28:00 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 95A502F0;
	Sat,  3 Nov 2007 18:28:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E925D91E26;
	Sat,  3 Nov 2007 18:28:16 -0400 (EDT)
In-Reply-To: <472CC676.3000603@gmail.com> (Francesco Pretto's message of "Sat,
	03 Nov 2007 20:05:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63319>

Francesco Pretto <ceztkoml@gmail.com> writes:

> Rationale: continuing the *nix tradition, git is very tied to fs ...
> ... please review it.

It is impossible to read, let alone comment on, your proposed
commit log message with such a looooooong line.  Please split
the lines to reasonable length, as all other people do.

I wonder if "--group" is given, wouldn't it make sense to
default to "shared_repository = group" even without --shared
(alternatively, if only --group is given without --shared, you
could error out).

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 763fa55..c8bed1e 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -376,6 +380,20 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)

>  	/*
> +	 * Complain if the repository is shared and no owner group have
> +	 * been selected. 
> +	 */
> +	if (shared_repository && !grouped_repository)
> +		printf("WARNING: You haven't selected any owner group!\n");
> +	

I think it is wrong to give this warning when --group is not
given, and it is doubly wrong to give the warning to stdout.

> +	/*
> +	 * Catch the error early if the group provided doesn't exist
> +	 */

No need to make this into three lines.

> +	if (getgrnam(owner_group) == NULL)
> +		die("The group '%s' doesn't esist",
> +		    owner_group);

No need to split this into two lines.

> @@ -417,11 +435,15 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		git_config_set("receive.denyNonFastforwards", "true");
>  	}
>  
> -	if (!quiet)
> +	if (!quiet) {
>  		printf("%s%s Git repository in %s/\n",
>  		       reinit ? "Reinitialized existing" : "Initialized empty",
>  		       shared_repository ? " shared" : "",
>  		       git_dir);
> +		if (shared_repository)
> +			printf("Put the commit users in the '%s' group\n",
> +		       	       grouped_repository ? owner_group : getgrgid(getgid())->gr_name);
> +	}

Only useful for the first time users; iow, too verbose for
common usage.

> diff --git a/environment.c b/environment.c
> index b5a6c69..a518619 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -23,6 +23,8 @@ int repository_format_version;
>  const char *git_commit_encoding;
>  const char *git_log_output_encoding;
>  int shared_repository = PERM_UMASK;
> +int grouped_repository = 0;
> +const char *owner_group = NULL;

Initialization to 0 and NULL should be left out, both for
readability and to keep these variables in BSS.

>  const char *apply_default_whitespace;
>  int zlib_compression_level = Z_BEST_SPEED;
>  int core_compression_level;
> diff --git a/path.c b/path.c
> index 4260952..1ec1379 100644
> --- a/path.c
> +++ b/path.c
> @@ -286,6 +286,9 @@ int adjust_shared_perm(const char *path)
>  		mode |= S_ISGID;
>  	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
>  		return -2;
> +	if (grouped_repository)
> +		if (chown(path, getuid(), getgrnam(owner_group)->gr_gid) < 0 )
> +			return -3;
>  	return 0;
>  }

I suspect this is good only for init-db.  When normal codepaths
create a new file under .git/ and call adjust_shared_perm(), who
initializes owner_group and to what value with your patch?

The way the world works is that adjust_shared_perm() relies on a
new directory and/or file in .git/ being created in the same
group as its parent directory .git/ ways the case).  So it is
just the matter of:

	$ mkdir myproject.git
        $ chgrp projectgroup myproject.git
        $ GIT_DIR=myproject.git git init --shared

I think what the patch attempts to achieve may be good, but only
to reduce a few keystrokes of doing the "chgrp".  Is it really
worth it, I have to wonder...
