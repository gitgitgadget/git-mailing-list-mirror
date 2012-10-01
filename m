From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 01 Oct 2012 14:53:17 -0700
Message-ID: <7v1uhhc10y.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
 <1349126586-755-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TInw1-0003bV-VW
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 23:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346Ab2JAVxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 17:53:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757486Ab2JAVxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 17:53:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213C98FF1;
	Mon,  1 Oct 2012 17:53:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qrMOweZ5Cg3Xd1qjJiGwNDGYcrU=; b=MiAw7f
	uULTMutwZGPqcLF9serHBdRDg7iMOUXGv228UT8vVhFqZ6uOh0aAbfbSW5xblv93
	ivIZmS+xoP284MvgU9dItwtNqrH2EBiYeyLb++QCitm/tJIKJV9llzp6STAHPoJh
	isXTSl1Wvt/QREQs6SeY6gap3IEtR68+kzdqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOZMkxpUt/OLqLbtzT6wfzYWq/cR5VGq
	drIZk405U+Oa8PfHPGOgfSMsOflGA8ZjB036cvaazq5QFje2Tuz4tKHvwaZ/7BML
	FyL7U9TK6iKd5Rr9d4/rs5RA3gT4UPPZYU06Dvxgre8sjCv2BzGGzRKKJYdkVoWU
	RFRmbt+CgbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F34E8FF0;
	Mon,  1 Oct 2012 17:53:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C66E8FEF; Mon,  1 Oct 2012
 17:53:18 -0400 (EDT)
In-Reply-To: <1349126586-755-1-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Mon, 1 Oct 2012 14:23:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68F75318-0C12-11E2-AF1A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206772>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +	for (attempts = 0; attempts < 2; attempts++) {
> +		if (start_active_slot(slot)) {
> +			run_active_slot(slot);
> +			if (slot->results->curl_result == CURLE_SSL_CONNECT_ERROR)
> +				continue;

Is it safe to continue and let start_active_slot() to add the same
curl handle again when USE_CURL_MULTI is in effect?

> +			ret = handle_curl_result(slot);
> +		} else {
> +			error("Unable to start HTTP request for %s", url);
> +			ret = HTTP_START_FAILED;
> +		}
> +		break;
>  	}
>  
>  	curl_slist_free_all(headers);
> diff --git a/remote-curl.c b/remote-curl.c
> index a269608..04a379c 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -353,6 +353,8 @@ static int run_slot(struct active_request_slot *slot)
>  
>  	slot->results = &results;
>  	slot->curl_result = curl_easy_perform(slot->curl);
> +	if (slot->curl_result == CURLE_SSL_CONNECT_ERROR)
> +		slot->curl_result = curl_easy_perform(slot->curl);
>  	finish_active_slot(slot);
>  
>  	err = handle_curl_result(slot);
