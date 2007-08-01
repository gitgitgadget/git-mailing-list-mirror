From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Clean up work-tree handling
Date: Wed, 01 Aug 2007 01:59:55 -0700
Message-ID: <7vvebz7hpw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
	<Pine.LNX.4.64.0708010058130.14781@racer.site>
	<Pine.LNX.4.64.0708010129530.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 11:00:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGA47-0000Vp-P5
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 11:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419AbXHAI76 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 04:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756176AbXHAI76
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 04:59:58 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61635 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbXHAI75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 04:59:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801085957.NVCA11888.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 04:59:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WYzw1X0021kojtg0000000; Wed, 01 Aug 2007 04:59:56 -0400
In-Reply-To: <Pine.LNX.4.64.0708010129530.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 01:30:14 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54419>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/builtin-ls-files.c b/builtin-ls-files.c
> index 61577ea..d36181a 100644
> --- a/builtin-ls-files.c
> +++ b/builtin-ls-files.c
> @@ -469,9 +469,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
>  		break;
>  	}
>  
> -	if (require_work_tree &&
> -			(!is_inside_work_tree() || is_inside_git_dir()))
> -		die("This operation must be run in a work tree");
> +	if (require_work_tree && !is_inside_work_tree()) {
> +		const char *work_tree = get_git_work_tree();
> +		if (!work_tree || chdir(work_tree))
> +			die("This operation must be run in a work tree");
> +	}
>  
>  	pathspec = get_pathspec(prefix, argv + i);
>  

Similarly to this change, I am wondering if we would want to fix
verify_non_filename() in setup.c, which does this:

/*
 * Verify a filename that we got as an argument for a pathspec
 * entry. Note that a filename that begins with "-" never verifies
 * as true, because even if such a filename were to exist, we want
 * it to be preceded by the "--" marker (or we want the user to
 * use a format like "./-filename")
 */
void verify_filename(const char *prefix, const char *arg)
{
...
}

/*
 * Opposite of the above: the command line did not have -- marker
 * and we parsed the arg as a refname.  It should not be interpretable
 * as a filename.
 */
void verify_non_filename(const char *prefix, const char *arg)
{
        const char *name;
        struct stat st;

        if (!is_inside_work_tree() || is_inside_git_dir())
                return;
        if (*arg == '-')
                return; /* flag */
        name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
        if (!lstat(name, &st))
                die("ambiguous argument '%s': both revision and filename\n"
                    "Use '--' to separate filenames from revisions", arg);
        if (errno != ENOENT)
                die("'%s': %s", arg, strerror(errno));
}

At this point, we are given an ambiguous parameter, that could
be naming a path in the work tree.  If we are not in the work
tree, then it is understandable that we do not have to barf.
The other check (i.e. "|| is_inside_git_dir()") does not hurt
(iow, it is not an incorrect check per-se), because if you did
"cd .git && git log HEAD" then the HEAD parameter cannot be
naming the path ".git/HEAD" in the work tree, but (1) that is
already covered by .git/ being "outside of work tree", and (2)
it is not something this function wants to check anyway
(i.e. "can the parameter be naming a file in the work tree?").

Am I mistaken and/or confused?
