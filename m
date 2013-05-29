From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 24/25] register_ref(): make a copy of the bad reference SHA-1
Date: Wed, 29 May 2013 09:53:43 -0700
Message-ID: <7vk3mhviaw.fsf@alter.siamese.dyndns.org>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
	<1369472904-12875-25-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 29 18:53:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhjdG-0005P1-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 18:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759015Ab3E2Qxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 12:53:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757728Ab3E2Qxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 12:53:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F02782304B;
	Wed, 29 May 2013 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Z2LBwXzR0IEl6mfIN2pv3dWeg2s=; b=XAu1tXgg4T7ClDrzGgrG
	Jv8bHy6lcTQaClqP0m35rdpjxpUK3Q200iczWNJjB7/hL9/hO2NivbSoTlso4PqI
	rcBlOzaduAIe4dVs5t9dDuWfFZ96X90U9SHEc18x52K0jEqKPX5onH9cL0jIHyk0
	Dp/jcYT2DAcKpnXARJxBU+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IO3wC2lXr2yiX8Z4si5oJLneB1qFJJo778FAlgRZOUpeeC
	NLbETxcJ9auaNoF4BSC5QCbO68D6F3lQCiJ3Qsc7uk3Q1F0ta7dQlMlmPgtFRCdA
	0knlGSwTddO1T5GCrTcB5h1KMkL0BFo83JWLTEvwJ7w3HVoNXwO5XZ9oPRIK8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E27F22304A;
	Wed, 29 May 2013 16:53:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49FDE23048;
	Wed, 29 May 2013 16:53:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53482EEA-C880-11E2-B8E7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225842>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The lifetime of the sha1 parameter passed to an each_ref_fn callback
> is not guaranteed, so make a copy for later use.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  bisect.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 374d9e2..71c1958 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -15,7 +15,7 @@
>  static struct sha1_array good_revs;
>  static struct sha1_array skipped_revs;
>  
> -static const unsigned char *current_bad_sha1;
> +static unsigned char *current_bad_sha1;
>  
>  static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
>  static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
> @@ -404,7 +404,8 @@ static int register_ref(const char *refname, const unsigned char *sha1,
>  			int flags, void *cb_data)
>  {
>  	if (!strcmp(refname, "bad")) {
> -		current_bad_sha1 = sha1;
> +		current_bad_sha1 = xmalloc(20);
> +		hashcpy(current_bad_sha1, sha1);

This, together with 18/25, may hint that we want hashdup()?

>  	} else if (!prefixcmp(refname, "good-")) {
>  		sha1_array_append(&good_revs, sha1);
>  	} else if (!prefixcmp(refname, "skip-")) {
