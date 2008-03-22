From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3] Teach "git clone" to pack refs
Date: Fri, 21 Mar 2008 21:31:19 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803212123490.19665@iabervon.org>
References: <200803220210.30957.johan@herland.net> <200803220213.54923.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:32:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcsaY-0002H9-VR
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbYCVBbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 21:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbYCVBbV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:31:21 -0400
Received: from iabervon.org ([66.92.72.58]:59384 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbYCVBbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:31:21 -0400
Received: (qmail 2536 invoked by uid 1000); 22 Mar 2008 01:31:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2008 01:31:19 -0000
In-Reply-To: <200803220213.54923.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77788>

On Sat, 22 Mar 2008, Johan Herland wrote:

> In repos with many refs, it is unlikely that most refs will ever change.
> This fact is already exploited by "git gc" by executing "git pack-refs"
> to consolidate all refs into a single file.
> 
> When cloning a repo with many refs, it does not make sense to create the
> loose refs in the first place, just to have the next "git gc" consolidate
> them into one file. Instead, make "git clone" create the packed refs file
> immediately, and forego the loose refs completely.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  builtin-clone.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 0a9c873..01c595e 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -18,6 +18,7 @@
>  #include "transport.h"
>  #include "strbuf.h"
>  #include "dir.h"
> +#include "pack-refs.h"
>  
>  /*
>   * Overall FIXMEs:
> @@ -313,8 +314,11 @@ static struct ref *write_remote_refs(const struct ref *refs, struct refspec *ref
>  	get_fetch_map(refs, tag_refspec, &tail, 0);
>  
>  	for (r = local_refs; r; r = r->next)
> -		update_ref(reflog,
> -			   r->peer_ref->name, r->old_sha1, NULL, 0, DIE_ON_ERR);
> +		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);

Wow, clever. Yes, this should work perfectly.

> +
> +	pack_refs(PACK_REFS_ALL);
> +	clear_extra_refs();
> +
>  	return local_refs;
>  }
>  
> -- 
> 1.5.5.rc0.117.ga5237
> 
> 
