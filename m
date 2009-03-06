From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Use the matching function to generate the match
 results
Date: Fri, 06 Mar 2009 00:18:34 -0800
Message-ID: <7vy6vjt679.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903052355240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 09:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfVHz-0001xR-SN
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbZCFISr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 03:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZCFISr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:18:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbZCFISq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 03:18:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0468A9FA82;
	Fri,  6 Mar 2009 03:18:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 434379FA81; Fri,
  6 Mar 2009 03:18:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6870F020-0A27-11DE-BD7D-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112402>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This puts all of the interpretation of the pattern representation in a
> single function for easy manipulation.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

I think this makes sense, but the helper function is not about "does this
name match the pattern?" boolean anymore, and may want to be renamed to
e.g. map_name_with_pattern().

> -static int name_fits_pattern(const char *key, const char *name)
> +static int name_fits_pattern(const char *key, const char *name,
> +			     const char *value, char **result)
>  {
> -	int ret = !prefixcmp(key, name);
> +	size_t klen = strlen(key);
> +	int ret = !strncmp(key, name, klen);
> +	if (ret && value) {
> +		size_t vlen = strlen(value);
> +		*result = xmalloc(vlen +
> +				  strlen(name) -
> +				  klen + 1);
> +		strcpy(*result, value);
> +		strcpy(*result + vlen, name + klen);
> +	}

> @@ -1080,11 +1085,9 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
>  
>  		} else {
>  			const char *dst_side = pat->dst ? pat->dst : pat->src;
> -			dst_name = xmalloc(strlen(dst_side) +
> -					   strlen(src->name) -
> -					   strlen(pat->src) + 2);
> -			strcpy(dst_name, dst_side);
> -			strcat(dst_name, src->name + strlen(pat->src));
> +			if (!name_fits_pattern(pat->src, src->name,
> +					       dst_side, &dst_name))
> +				die("Didn't think it matches any more");
>  		}

Hmm, we have been overallocating and nobody noticed so far?
