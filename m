From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): tighten up pointer arithmetic
Date: Thu, 09 Jan 2014 15:01:48 -0800
Message-ID: <xmqqtxdc92ub.fsf@gitster.dls.corp.google.com>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
	<1389192220-13913-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 10 00:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Obs-0004so-S5
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 00:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbaAIXBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 18:01:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbaAIXBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 18:01:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2395E627DC;
	Thu,  9 Jan 2014 18:01:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/hbfVp+eGO/fhvknKxRByDADZ+A=; b=fd9r17
	5eC1eCSX+fZ78M+BQQ6NOguNJV3fmZOApkNVBfeyTl8Iv/aSM9t/+tMRG8RQS7jg
	DFe2SAh1Ecf7xkgtuxp7hANPti+6DPLlYYXKBmRJyM86e0NqFeTEB21lfUvqJhh0
	nxY3n3m2PqbbaGv01R8cYytRlNmrHvKFXrUHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RTia34kHJyyBdX5oH+FqDnVXlvKAW5Kf
	/Kh066C0AOrxYe/G/09IYbD0HFjeE+TwWNstWiW8KXPxvBg+LcNt8yjxEoo8P9WU
	vvHo3vfKIvBRrh7oNrdq2TKc2pSA0QeqH2G2iWV6FGfht1Mljb6n+sn/EwqzczMH
	xlhMfSyXn7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E11627DB;
	Thu,  9 Jan 2014 18:01:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52B41627D8;
	Thu,  9 Jan 2014 18:01:51 -0500 (EST)
In-Reply-To: <1389192220-13913-4-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 8 Jan 2014 15:43:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0687479A-7982-11E3-92B3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240285>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> As long as we're being pathologically stingy with mallocs, we might as
> well do the math right and save 6 (!) bytes.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> It is left to the reader to show how another 7 bytes could be saved
> (11 bytes on a 64-bit architecture!)
>
> It probably wouldn't kill performance to use a string_list here
> instead.
>
>  refs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ef9cdea..63b3a71 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3351,10 +3351,10 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
>  		size_t total_len = 0;
>  		size_t offset = 0;
>  
> -		/* the rule list is NULL terminated, count them first */
> +		/* the rule list is NUL terminated, count them first */

I think this _is_ wrong; it talks about the NULL termination of the
ref_rev_parse_rules[] array, not each string that is an element of
the array being NUL terminated.

Output from "git grep -e refname_match -e ref_rev_parse_rules"
suggests me that we actually could make ref_rev_parse_rules[] a
file-scope static to refs.c, remove its NULL termination and convert
all the iterators of the array to use ARRAY_SIZE() on it, after
dropping the third parameter to refname_match().  That way, we do
not have to count them first here.

But that is obviously a separate topic.

>  		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
> -			/* no +1 because strlen("%s") < strlen("%.*s") */
> -			total_len += strlen(ref_rev_parse_rules[nr_rules]);
> +			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
> +			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
>  
>  		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
