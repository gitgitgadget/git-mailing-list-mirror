From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] is_dup_ref(): extract function from
 sort_ref_list()
Date: Thu, 13 Oct 2011 13:43:57 -0700
Message-ID: <7v1uug4o6q.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 22:44:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RES8O-0000ev-DM
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 22:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab1JMUoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 16:44:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab1JMUoA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 16:44:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED715A56;
	Thu, 13 Oct 2011 16:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfpVsNJS4DSvXcYVQ+A2KYH6sAY=; b=LxlX5W
	gnaxYFoPS3lB3uKZbk3YTW4Ev0Bh/eZBHSpxU5ezkLUOeOk5jItbci+cAzsLDGnV
	GUJyCyz2H0X76lkEl4TvThGUvsJCxyNmkaTG6J4rIcUfJNwZTZR8n6oDwEJatTGA
	5C7OTdKO1cd31GyyGGT138A2U/lEe/NnWus+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CFd2b91ZgGQE5zWW/tY9uymq3zzSowCh
	8kpb0uPRGP5rZWSaXmaBwoLvo7zetBa/SLsNEGpjNWbliUWQl+EIkAqKnaq54r13
	IXv9y76sSWwZXZLiNbKXlfb8EIopDAgJciFlAw15HRW9yBQgsezykzqYD2GOMLkW
	Z3HxofVH854=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5A025A55;
	Thu, 13 Oct 2011 16:43:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F4B75A54; Thu, 13 Oct 2011
 16:43:59 -0400 (EDT)
In-Reply-To: <1318492715-5931-11-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Thu, 13 Oct 2011 09:58:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13A5ABAA-F5DC-11E0-8FBE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183524>

mhagger@alum.mit.edu writes:

> ...
> @@ -94,15 +113,11 @@ static void sort_ref_array(struct ref_array *array)
>  
>  	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
>  
> -	/* Remove any duplicates from the ref_array */
> +	/* Remove any duplicates from the ref_list */

Eh... Also needs retitled.

>  	for (; j < array->nr; j++) {
>  		struct ref_entry *a = array->refs[i];
>  		struct ref_entry *b = array->refs[j];
> -		if (!strcmp(a->name, b->name)) {
> -			if (hashcmp(a->sha1, b->sha1))
> -				die("Duplicated ref, and SHA1s don't match: %s",
> -				    a->name);
> -			warning("Duplicated ref: %s", a->name);
> +		if (is_dup_ref(a, b)) {
>  			free(b);
>  			continue;
>  		}
