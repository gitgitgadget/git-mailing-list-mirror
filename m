From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] hashmap API: introduce for_each_hashmap_entry() helper macro
Date: Wed, 16 Mar 2016 11:09:30 -0700
Message-ID: <xmqq37rq5m79.fsf@gitster.mtv.corp.google.com>
References: <1458146346-27959-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:09:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFt4-0008Ry-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935161AbcCPSJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:09:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933388AbcCPSJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:09:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91B5E4BE71;
	Wed, 16 Mar 2016 14:09:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tpY+AfjBDX8vzdl1ZtBn020W/ks=; b=HPpbFl
	BExmLzRg422AcGwK6Vf2P1gzFE2kaauKqllHqTJsjLXD7AcGPFe9AQHzWLhOM4ZB
	IZQB7BcSuJIV67qlGL4nXb4kfpKWzR3r24D4SX/5kaU/rpmtgSd3ME9RA6/N+L5e
	wBZNry/JlSY4vr1Pb5PQbcCPal/Y8GUAILSho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fT2A2vXnEIEjBJMrmseiLug0X3nJ9g5+
	TuibqgOjieIXVG9bVjmfna4qG5EljjnrkOXZCVJTm+uV25OtJ+pcxRADxAu/OzFS
	ltHsNuQ4ERt2q3PcYL/mQCfj0U91kYLAtKXCgtsG+nB284nDNRpAukkw4iWCJrV7
	2j+VepyP8kw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89D2D4BE70;
	Wed, 16 Mar 2016 14:09:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CFA14BE6F;
	Wed, 16 Mar 2016 14:09:31 -0400 (EDT)
In-Reply-To: <1458146346-27959-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 16 Mar 2016 22:39:06 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B87F392-EBA2-11E5-B4D3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289010>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> diff --git a/hashmap.h b/hashmap.h
> index ab7958a..b8b158c 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -95,4 +95,11 @@ static inline const char *strintern(const char *string)
>  	return memintern(string, strlen(string));
>  }
>  
> +#define for_each_hashmap_entry(map, type)		\
> +	struct type *entry;				\
> +	struct hashmap_iter iter;			\
> +							\
> +	hashmap_iter_init(map, &iter);			\
> +	while ((entry = hashmap_iter_next(&iter)))
> +

This is an easy way to introduce decl-after-statement, i.e. needs an
extra pair of {} around the thing.  It also forbids the callers from
defining "entry" and "iter" as their own identifier outside the
scope of this macro and use them inside the block that is iterated
over by shadowing these two variables.

Other than that, it looks like a good concept.  The syntax however
needs more thought because of the above two issues, I think.
