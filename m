From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Replace fork_with_pipe in bundle with run_command
Date: Mon, 12 Mar 2007 16:57:12 -0700
Message-ID: <7vslcaow13.fsf@assigned-by-dhcp.cox.net>
References: <20070312183815.GD15996@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:57:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQuOE-0008Ed-U7
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbXCLX5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbXCLX5O
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:57:14 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61992 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbXCLX5O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:57:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312235713.JJAI1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 12 Mar 2007 19:57:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZzxC1W00X1kojtg0000000; Mon, 12 Mar 2007 19:57:13 -0400
In-Reply-To: <20070312183815.GD15996@spearce.org> (Shawn O. Pearce's message
	of "Mon, 12 Mar 2007 14:38:15 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42095>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Now that the run_command family supports all of the redirection
> modes needed by builtin-bundle, we can use those functions rather
> than the underlying POSIX primitives.  This should help to make the
> bundle command slightly more portable to other systems, like Windows.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ...
> @@ -263,9 +202,10 @@ static int create_bundle(struct bundle_header *header, const char *path,
>  	int bundle_fd = -1;
>  	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
>  	const char **argv_pack = xmalloc(5 * sizeof(const char *));
> -	int pid, in, out, i, status, ref_count = 0;
> +	int i, status, ref_count = 0;
>  	char buffer[1024];
>  	struct rev_info revs;
> +	struct child_process rls;
>  
>  	bundle_fd = (!strcmp(path, "-") ? 1 :
>  			open(path, O_CREAT | O_EXCL | O_WRONLY, 0666));
> ...
>  			write_or_die(bundle_fd, buffer, i);
> @@ -303,11 +245,8 @@ static int create_bundle(struct bundle_header *header, const char *path,
>  			object->flags |= SHOWN;
>  		}
>  	}
> -	while ((i = waitpid(pid, &status, 0)) < 0)
> -		if (errno != EINTR)
> -			return error("rev-list died");
> -	if (!WIFEXITED(status) || WEXITSTATUS(status))
> -		return error("rev-list died %d", WEXITSTATUS(status));
> +	if (finish_command(&rls))
> +		return error("rev-list died");
> ...
> +	if (finish_command(&rls))
>  		return error ("pack-objects died");
>  
>  	return status;

As the variable 'status' is not used anymore, I think this should return 0.
