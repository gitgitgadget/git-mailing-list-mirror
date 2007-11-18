From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: fix partial-commit support
Date: Sun, 18 Nov 2007 02:57:19 -0800
Message-ID: <7vr6inx1m8.fsf@gitster.siamese.dyndns.org>
References: <1195381287-26823-1-git-send-email-gitster@pobox.com>
	<1195381287-26823-2-git-send-email-gitster@pobox.com>
	<1195381287-26823-3-git-send-email-gitster@pobox.com>
	<1195381287-26823-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthqS-0007Om-BQ
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXKRK50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXKRK50
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:57:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33811 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbXKRK5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:57:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EB9222EF;
	Sun, 18 Nov 2007 05:57:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 79EB7961D9;
	Sun, 18 Nov 2007 05:57:43 -0500 (EST)
In-Reply-To: <1195381287-26823-4-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sun, 18 Nov 2007 02:21:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65365>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> Additionally:

   - read the index file after pre-commit hook returns, as the
     hook can modify it to affect the contents of the commit.

>  - remove the temporary index file .git/next-index-* after
>    commit is done or aborted.
>
>  - run post-commit hook with the real index file to be used
>    after the commit (previously it gave the temporary commit if
>    a partial commit was made).
>
>  - resurrect the safety mechanism to refuse partial commits
>    during a merge to match the scripted version.

>  static char *prepare_index(const char **files, const char *prefix)
>  {
>  	int fd;
>  	struct tree *tree;
> -	struct lock_file *next_index_lock;
> +	struct path_list partial;
> +	const char **pathspec = NULL;
>  
>  	if (interactive) {
>  		interactive_add();
> +		commit_style = COMMIT_NORMAL;

This should be COMMIT_AS_IS, to match the scripted version.

> +	/*
> +	 * A partial commit.
> +	 *
> +	 * (0) find the set of affected paths [NEEDSWORK]

This [NEEDSWORK] has been resolved.

> +	 * (1) get lock on the real index file;
> +	 * (2) update the_index with the given paths;
> +	 * (3) write the_index out to the real index (still locked);
> +	 * (4) get lock on the false index file;
> +	 * (5) reset the_index from HEAD, but keep the addition;

This ", but keep the addition" is no longer necessary; the set
of paths discovered in step (0) _will_ include the added paths
that are named by the user in **files.

> +	 * (6) update the_index the same way as (2);
> +	 * (7) write the_index out to the false index file;
> +	 * (8) return the name of the false index file (still locked);
> +	 *
> +	 * The caller should run hooks on the locked false index, and

 ... "create the commit using the false index", of course.

> +	 * (A) if all goes well, commit the real index;
> +	 * (B) on failure, rollback the real index;
> +	 * In either case, rollback the false index.
> +	 */
