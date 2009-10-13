From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 16/16] Smart HTTP fetch: gzip requests
Date: Tue, 13 Oct 2009 01:38:42 -0700
Message-ID: <7vocobzo19.fsf@alter.siamese.dyndns.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
 <1255400715-10508-17-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 10:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxcyz-0002fH-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 10:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193AbZJMIjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 04:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759192AbZJMIjf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 04:39:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758414AbZJMIje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 04:39:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2C4E56673;
	Tue, 13 Oct 2009 04:38:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Zz/7YCRiUrk7xP4RQbFdw1HdIQ=; b=dtqZgi
	yckm3eKR/odZ9ekF0vVXjv0gjdgSOuNAg+c0UTgsX3TTVKUItlEqEnIb+Ab5pm0V
	4wxTot7sEGOz+SqlSyaapZGkj/ea/RFwSBFxj/spzSTlwTMp+zpe11YAAjzHadl6
	j43sT7knH8MvOWK+D/ImzatCY7rMNx7JCDDR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G4VsRC6mKWPwTyJ8Ukhbzg7OPqj1OX00
	cjWfrxlsM+zCj/EPISfl909AdPAJVxOzWXqVH6uNdsifxClbFS8PM0IFxuRRgGGs
	VU6Ukv6hXdKxJWaAG8L1XOhqOoS1QODsXNoTvifom4d8iu885gdP/iZZkuM9LfSI
	PWQ/NkjJgII=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CBFF056670;
	Tue, 13 Oct 2009 04:38:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 375285666F; Tue, 13 Oct
 2009 04:38:43 -0400 (EDT)
In-Reply-To: <1255400715-10508-17-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Mon\, 12 Oct 2009 19\:25\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2AB291A-B7D3-11DE-8B82-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130146>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> diff --git a/remote-curl.c b/remote-curl.c
> index 31d1d34..d53215d 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -261,11 +261,12 @@ static size_t rpc_in(const void *ptr, size_t eltsize,
>  	return size;
>  }
>  
> -static int post_rpc(struct rpc_state *state)
> +static int post_rpc(struct rpc_state *state, int use_gzip)
>  {
>  	struct active_request_slot *slot;
>  	struct slot_results results;
>  	struct curl_slist *headers = NULL;
> +	unsigned char *gzip_body = NULL;
>  	int err = 0, large_request = 0;
>  
>  	/* Try to load the entire request, if we can fit it into the
> @@ -311,6 +313,48 @@ static int post_rpc(struct rpc_state *state)
> ...
> +		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);

cc1: warnings being treated as errors
In function 'post_rpc',
    inlined from 'one_shot_rpc_service' at remote-curl.c:433:
remote-curl.c:350: error: call to '_curl_easy_setopt_err_postfields' declared with attribute warning: curl_easy_setopt expects a void* or char* argument for this option
make: *** [remote-curl.o] Error 1
