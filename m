From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/33] refs: extract a function peel_entry()
Date: Mon, 15 Apr 2013 10:38:39 -0700
Message-ID: <7v38urwv6o.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 15 19:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnMl-0004En-V0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab3DORir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:38:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab3DORip (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D39315C25;
	Mon, 15 Apr 2013 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eAomRlwoqMtOHndetdrCfGuL5MU=; b=MEO7MG+110JlWUTkTGr/
	6PB3AM5OQQw0Mv6oGa5KLup9X9G/VKpDTjy2+lCGE3XvcsLKgiZwZ6oUDOpVQJMt
	qKVEc5zk2OBSvlOmHg9Mp6KqwuoTYi7uacEiHbBpiQs0ZfPBcjUcla+ViG0QCz2T
	xNnynODUS8oWpinkE+PycSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=xpCgpp9IdlCn+iFxq1BcKzXxM4YUuk21JrQThXQ2qR1kyM
	HJWpziR8ayJqw+hSfr72N0iw39WN15i1gDIT0p0gJmJmKg4Y+okVHaOtQ9njOfXN
	cnDyar+0rWhP408chsnAXcToghEacQgKHQOxs02mv3gIMzfREmXYQWMYUMqns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03DE715C24;
	Mon, 15 Apr 2013 17:38:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6132315C1C; Mon, 15 Apr
 2013 17:38:44 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51E3C03C-A5F3-11E2-9C35-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221262>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>  	if (read_ref_full(refname, base, 1, &flag))
>  		return -1;
>  
> -	if ((flag & REF_ISPACKED)) {
> +	/*
> +	 * If the reference is packed, read its ref_entry from the
> +	 * cache in the hope that we already know its peeled value.
> +	 * We only try this optimization on packed references because
> +	 * (a) forcing the filling of the loose reference cache could
> +	 * be expensive and (b) loose references anyway usually do not
> +	 * have REF_KNOWS_PEELED.
> +	 */
> +	if (flag & REF_ISPACKED) {
>  		struct ref_entry *r = get_packed_ref(refname);

This code makes the reader wonder what happens when a new loose ref
masks a stale packed ref, but the worry is unfounded because the
read_ref_full() wouldn't have gave us REF_ISPACKED in the flag in
such a case.

But somehow the calling sequence looks like such a mistake waiting
to happen.  It would be much more clear if a function that returns a
"struct ref_entry *" is used instead of read_ref_full() above, and
we checked (r->flag & REF_ISPACKED) in the conditional, without a
separate get_packed_ref(refname).

> -
> -		if (r && (r->flag & REF_KNOWS_PEELED)) {
> -			if (is_null_sha1(r->u.value.peeled))
> -			    return -1;
> +		if (r) {
> +			if (peel_entry(r))
> +				return -1;
>  			hashcpy(sha1, r->u.value.peeled);
>  			return 0;
>  		}
