From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 12:25:16 -0800
Message-ID: <7vfxvcj0b7.fsf@gitster.siamese.dyndns.org>
References: <87wsop188j.fsf@wine.dyndns.org>
 <alpine.LNX.1.00.0802281058190.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpL9-0001JW-2H
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759354AbYB1UZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757951AbYB1UZp
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:25:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758930AbYB1UZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:25:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD7DA2666;
	Thu, 28 Feb 2008 15:25:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0A8502664; Thu, 28 Feb 2008 15:25:33 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802281058190.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 28 Feb 2008 10:58:59 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75442>

Daniel Barkalow <barkalow@iabervon.org> writes:

> We need to rewrite the index file when we check out files, even if we
> haven't modified the blob info by reading from another tree, so that
> we get the stat cache to include the fact that we just modified the
> file so it doesn't need to be refreshed.

Thanks, Alexandre, for spotting.

> -static int checkout_paths(const char **pathspec)
> +static int checkout_paths(const char **pathspec, int newfd, struct lock_file *lock_file)
>  {
> ...
> @@ -554,11 +549,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  			}
>  		}
>  
> +		int newfd;
> +		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
> +		newfd = hold_locked_index(lock_file, 1);
> +		read_cache();
> +
>  		if (source_tree)
>  			read_tree_some(source_tree, pathspec);
> -		else
> -			read_cache();
> -		return checkout_paths(pathspec);
> +		return checkout_paths(pathspec, newfd, lock_file);

Aside from decl-after-statement, I suspect that at this point
these all should go to checkout_paths() function itself, that
takes pathspec and source_tree (which could be NULL), but that
is only "logical code organization" issue.  Thanks for fixing.

I however would have liked if this were caught while the topic
was still cooking in 'next'.

There was a process failure somewhere, which makes me worry more
than just this single bug that escaped to 'master'.  Alex
Riesen's segv fix in another thread makes it double X-<.
