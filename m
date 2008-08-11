From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-revert.c: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 17:47:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111737270.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <cover.1218374062.git.vmiklos@frugalware.org> <1218467003-14591-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:44:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZZG-0002zM-Od
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbYHKPnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYHKPnT
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:43:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:49903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752175AbYHKPnS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:43:18 -0400
Received: (qmail invoked by alias); 11 Aug 2008 15:43:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 11 Aug 2008 17:43:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/FQYjuBi/NZ2bNKmb7FqcYN1GeOK/a/nyAed7u3
	ztpLTAtp7qCkgB
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1218467003-14591-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91947>

Hi,

On Mon, 11 Aug 2008, Stephan Beyer wrote:

> diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
> index 09aa830..d8bd21f 100644
> --- a/builtin-merge-recursive.c
> +++ b/builtin-merge-recursive.c
> @@ -1327,7 +1327,7 @@ static const char *better_branch_name(const char *branch)
>  	return name ? name : branch;
>  }
>  
> -static struct commit *get_ref(const char *ref)
> +struct commit *get_ref(const char *ref)

The name get_ref() is way too generic to be non-static.  But I have a 
hunch that peel_to_type() does a lot of what we want here, if not all of 
it.

> diff --git a/builtin-revert.c b/builtin-revert.c
> index 27881e9..c54cf8a 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -219,15 +216,21 @@ static int merge_recursive(const char *base_sha1,
>  	 * and $prev on top of us (when reverting), or the change between
>  	 * $prev and $commit on top of us (when cherry-picking or replaying).
>  	 */
> -	argv[i++] = "merge-recursive";
> -	if (base_sha1)
> -		argv[i++] = base_sha1;
> -	argv[i++] = "--";
> -	argv[i++] = head_sha1;
> -	argv[i++] = next_sha1;
> -	argv[i++] = NULL;
> -
> -	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
> +	if (base_sha1) {
> +		struct commit *base = get_ref(base_sha1);
> +		commit_list_insert(base, &ca);
> +	}
> +	h1 = get_ref(head_sha1);
> +	h2 = get_ref(next_sha1);
> +
> +	index_fd = hold_locked_index(lock, 1);
> +	clean = merge_recursive(h1, h2, head_name, next_name, ca, &result);

h1 and h2 are not expressive.  head_commit and next_commit would be.

Rest looks good to me -- even if I had to spend too much time (therefore 
being not really thorough in the end) verifying that merge_recursive() 
does not lock the index itself, and that GITHEAD_* definitions are not 
necessary anymore, since merge_recursive() takes the arguments directly; 
you might want to make it easier for this reviewer in the future, if you 
want this reviewer to review your patches, that is.

Ciao,
Dscho
