From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Sat, 13 Aug 2011 14:54:38 +0200
Message-ID: <20110813125438.GC4783@book.hvoigt.net>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu> <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 13 14:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsDmN-0008CO-T5
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 14:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab1HMMyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 08:54:41 -0400
Received: from darksea.de ([83.133.111.250]:48897 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751536Ab1HMMyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 08:54:40 -0400
Received: (qmail 31918 invoked from network); 13 Aug 2011 14:54:38 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Aug 2011 14:54:38 +0200
Content-Disposition: inline
In-Reply-To: <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179276>

Hi,

On Sat, Aug 13, 2011 at 12:36:29AM +0200, Michael Haggerty wrote:
> diff --git a/refs.c b/refs.c
> index 8d1055d..f02cf94 100644
> --- a/refs.c
> +++ b/refs.c

...

> @@ -205,23 +208,28 @@ struct cached_refs *create_cached_refs(const char *submodule)
>   */
>  static struct cached_refs *get_cached_refs(const char *submodule)
>  {
> -	if (! submodule) {
> -		if (!cached_refs)
> -			cached_refs = create_cached_refs(submodule);
> -		return cached_refs;
> -	} else {
> -		if (!submodule_refs)
> -			submodule_refs = create_cached_refs(submodule);
> -		else
> -			/* For now, don't reuse the refs cache for submodules. */
> -			clear_cached_refs(submodule_refs);
> -		return submodule_refs;
> +	struct cached_refs *refs = cached_refs;
> +	if (! submodule)
> +		submodule = "";

Maybe instead of searching for the main refs store a pointer to them
locally so you can immediately return here. That will keep the
performance when requesting the main refs the same.

If I see it correctly you are always prepending to the linked list and
in case many submodules get cached this could slow down the iteration
over the refs of the main repository.

> +	while (refs) {
> +		if (!strcmp(submodule, refs->name))
> +			return refs;
> +		refs = refs->next;
>  	}
> +
> +	refs = create_cached_refs(submodule);
> +	refs->next = cached_refs;
> +	cached_refs = refs;
> +	return refs;
>  }

...

Cheers Heiko
