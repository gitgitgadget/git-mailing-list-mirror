From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/22] lock_file(): always add lock_file object to
 lock_file_list
Date: Tue, 1 Apr 2014 16:16:59 -0400
Message-ID: <20140401201659.GE21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV57M-0002db-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbaDAURD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:17:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:52049 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751398AbaDAURB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:17:01 -0400
Received: (qmail 22072 invoked by uid 102); 1 Apr 2014 20:17:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:17:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:16:59 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-8-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245652>

On Tue, Apr 01, 2014 at 05:58:15PM +0200, Michael Haggerty wrote:

> diff --git a/lockfile.c b/lockfile.c
> index e679e4c..c989f6c 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -130,6 +130,22 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	 */
>  	static const size_t max_path_len = sizeof(lk->filename) - 5;
>  
> +	if (!lock_file_list) {
> +		/* One-time initialization */
> +		sigchain_push_common(remove_lock_file_on_signal);
> +		atexit(remove_lock_file);
> +	}
> +
> +	lk->owner = getpid();
> +	if (!lk->on_list) {
> +		/* Initialize *lk and add it to lock_file_list: */
> +		lk->fd = -1;
> +		lk->on_list = 1;
> +		lk->filename[0] = 0;
> +		lk->next = lock_file_list;
> +		lock_file_list = lk;
> +	}

Initializing here is good, since we might be interrupted by a signal at
any time. But what about during the locking procedure? We do:

    strcpy(lk->filename, path);
    if (!(flags & LOCK_NODEREF))
            resolve_symlink(lk->filename, max_path_len);
    strcat(lk->filename, ".lock");

So for a moment, lk->filename contains the name of the valuable file we
are locking.  If we get a signal at that moment, do we accidentally
delete it in remove_lock_file?

I think the answer is "no", because we check lk->owner before deleting,
which will not match our pid (it should generally be zero due to xcalloc
or static initialization, though perhaps we should clear it here).

But that makes me wonder about the case of a reused lock. It will have
lk->owner set from a previous invocation, and would potentially suffer
from this problem. In other words, I think the change you are
introducing does not have the problem, but the existing code does. :-/

I didn't reproduce it experimentally, though.  We should be able to just

    lk->owner = 0;

before the initial strcpy to fix it, I would think.

-Peff
