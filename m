From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable
 and world-readable
Date: Fri, 11 Apr 2008 17:53:36 -0700
Message-ID: <7vfxtrnban.fsf@gitster.siamese.dyndns.org>
References: <20080411140916.GA30667@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sat Apr 12 02:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkU11-0006er-CF
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYDLAxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 20:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755511AbYDLAxt
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 20:53:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418AbYDLAxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 20:53:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9033720C9;
	Fri, 11 Apr 2008 20:53:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AA21120C7; Fri, 11 Apr 2008 20:53:44 -0400 (EDT)
In-Reply-To: <20080411140916.GA30667@zakalwe.fi> (Heikki Orsila's message of
 "Fri, 11 Apr 2008 17:09:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79320>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> diff --git a/cache.h b/cache.h
> index 2a1e7ec..4af6d62 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -474,10 +474,14 @@ static inline void hashclr(unsigned char *hash)
>  
>  int git_mkstemp(char *path, size_t n, const char *template);
>  
> +/* Warning: enum sharedrepo item order should not be changed since it will
> + * break backwards compatibility. */

That's not a "Warning" (which tends to mean "you can violate this if you
know what you are doing"), but should be stronger than that.  Something
like (also notice the multi-line comment style --- the first line ends
with "/*\n"):

/*
 * NOTE NOTE NOTE!!
 *
 * Do not reorder this list; numerically written core.sharedrepository
 * in config files have always been valid, and you would break existing
 * repositories if you move these around.
 */

>  enum sharedrepo {
>  	PERM_UMASK = 0,
>  	PERM_GROUP,
> -	PERM_EVERYBODY
> +	PERM_EVERYBODY,
> +	PERM_GROUP_READABLE,
> +	PERM_WORLD_READABLE,
>  };

But I have to wonder if this patch is necessary.

Neither am I convinced if this set is sufficient.

+	/*
	 * PERM_GROUP_READABLE:   g+r
+	 * PERM_GROUP:            g+rw
+	 * PERM_WORLD_READABLE:   g+r,  o+r
+	 * PERM_EVERYBODY:        g+rw, o+r
+	 */

For example, you may want to enforce "ug+rw,o=" in a repository.  How
would you do that?

Perhaps if you really wanted to have such a fine grained control, you
would be better off defining core.sharedrepository as a set/unset pair?

	core.sharedrepository = 0660,007 ;# ug+rw,o-rwx

Or even stronger "set to this bit pattern"?

	core.sharedrepository = 0660 ;# ug=rw,o=

(I think you would need to flip executable bit for directories if you go
this route).
