From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git branch -D: give a better error message when
 lockfile creation fails
Date: Fri, 25 Sep 2009 23:31:43 -0400
Message-ID: <20090926033143.GA9917@coredump.intra.peff.net>
References: <1253923602-17818-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 05:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrO0h-0004sF-Bd
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 05:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbZIZDbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 23:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbZIZDbe
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 23:31:34 -0400
Received: from peff.net ([208.65.91.99]:35406 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758AbZIZDbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 23:31:33 -0400
Received: (qmail 13999 invoked by uid 107); 26 Sep 2009 03:34:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 25 Sep 2009 23:34:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Sep 2009 23:31:43 -0400
Content-Disposition: inline
In-Reply-To: <1253923602-17818-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129141>

On Sat, Sep 26, 2009 at 02:06:42AM +0200, Miklos Vajna wrote:

> diff --git a/refs.c b/refs.c
> index 24865cf..221d49c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -972,8 +972,10 @@ static int repack_without_ref(const char *refname)
>  	if (!found)
>  		return 0;
>  	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
> -	if (fd < 0)
> +	if (fd < 0) {
> +		unable_to_lock_index_die(git_path("packed-refs"), errno);
>  		return error("cannot delete '%s' from packed refs", refname);
> +	}
>  
>  	for (list = packed_ref_list; list; list = list->next) {
>  		char line[PATH_MAX + 100];

I have several concerns about this patch:

  1. We used to return error(), but now we die. Are there any callers
     which care about the difference?

  2. If we did want to die, then the "return error()" just below is
     unreachable, and should be removed.

  3. If we did want to die, should we not just pass LOCK_DIE_ON_ERROR to
     hold_lock_file_for_update?

I suspect (2) and (3) are irrelevant because the answer to (1) is that
yes, some callers do care (e.g., it looks like builtin-remote calls
delete_ref, and notes an error but continues to do useful work
afterwards). So probably you would need to first refactor
unable_to_lock_index_die() to handle just printing the error without
dying.

-Peff
