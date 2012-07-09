From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 2/2] Replace strlen() with ce_namelen()
Date: Sun, 08 Jul 2012 19:49:19 -0700
Message-ID: <7v4nphmyxc.fsf@alter.siamese.dyndns.org>
References: <7vtxxns4z4.fsf@alter.siamese.dyndns.org>
 <1341590850-15653-1-git-send-email-t.gummerer@gmail.com>
 <1341590850-15653-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 04:49:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So42n-0002uy-4M
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 04:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab2GICtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 22:49:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab2GICtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 22:49:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 563CE927D;
	Sun,  8 Jul 2012 22:49:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ft9OiP/hLolQL/Kv+7mZIHNtpOU=; b=rEHpRx
	aEBSKzrLiW1xBzcvjmJmzpwGMQzcBTCxsU7kdUqKhJN0Z+5MDkUqgEUU52sFcQn0
	x1syULkwERPJnahnJVJXY68v0DPWt2MeMNT4zc8ihmlbqA6R0Yf6P+jr4PizIMHp
	Hzaa7N9PV9T22JyxC3cmFbpsdZa07Gv/2WAxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u7rNxhDnULFCBoxvdCLLpyAqvAdtJRG9
	VTQVGIzQwqeHDuiE2kTwV01DzKkRwn3OtkS/Ta6wP/RY6CkcSzFDzbGUXbNzEYrA
	i3cPOtBJ3qzC5V5h+5vgYx6l7ZcjzSCADvDg6YC349DmCQyRkuFoNVJ7/KIWahwv
	IPy7IgVpQSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6F3927A;
	Sun,  8 Jul 2012 22:49:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C024A9279; Sun,  8 Jul 2012
 22:49:20 -0400 (EDT)
In-Reply-To: <1341590850-15653-3-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Fri, 6 Jul 2012 18:07:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF099DA0-C970-11E1-928E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201191>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Replace strlen(ce->name) with ce_namelen() in a couple
> of places which gives us some additional bits of
> performance.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>

Very sensible, with or without the previous patch.

I am kind of surprised that we are very good and have only these
three places that had these unnecessary pessimization.

> ---
>  read-cache.c   |    4 ++--
>  unpack-trees.c |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index ea75c89..a77877a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1124,7 +1124,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
>  			continue;
>  
>  		if (pathspec &&
> -		    !match_pathspec(pathspec, ce->name, strlen(ce->name), 0, seen))
> +		    !match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
>  			filtered = 1;
>  
>  		if (ce_stage(ce)) {
> @@ -1852,7 +1852,7 @@ int read_index_unmerged(struct index_state *istate)
>  		if (!ce_stage(ce))
>  			continue;
>  		unmerged = 1;
> -		len = strlen(ce->name);
> +		len = ce_namelen(ce);
>  		size = cache_entry_size(len);
>  		new_ce = xcalloc(1, size);
>  		memcpy(new_ce->name, ce->name, len);
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 9981dd3..abd0988 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1289,7 +1289,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce,
>  	 * First let's make sure we do not have a local modification
>  	 * in that directory.
>  	 */
> -	namelen = strlen(ce->name);
> +	namelen = ce_namelen(ce);
>  	for (i = locate_in_src_index(ce, o);
>  	     i < o->src_index->cache_nr;
>  	     i++) {
