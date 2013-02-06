From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Wed, 06 Feb 2013 07:56:08 -0800
Message-ID: <7v4nhpo2qv.fsf@alter.siamese.dyndns.org>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <51122F69.9060704@elegosoft.com>
 <20130206103952.GA5267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Schubert <mschub@elegosoft.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37MQ-00035l-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab3BFP4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:56:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab3BFP4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:56:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E3BB638;
	Wed,  6 Feb 2013 10:56:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jQxfLLev+V00xNlVBJEyy6u/UjY=; b=FrrtK9
	ZJqJ0yvxeUVYE07kPezO1M505XfJm5B/ejmKsa2R6Qt6PrR91I1c/4eSmej66cWM
	hn9HEm2umMr5oPWafp3ydNPF6ttbIaEbu++Ed6pXUnfpAOjc2VTo3ApwYHmcpmOY
	kKmU8p1rJpcPgTmWxStRpA0qRvEx9Hf2ALP4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jfUrRYhuGIezJKS1K9n3U0M+R5ZAwhaV
	dpTVwFWXkra6MAyCOGtG712JBRUh05fFAnZWPToVSQjsJGPsikSGQ4KAcPmC+GOG
	kzH0Cc9s1H5awAQ3R7uHswysnKfH4fvMIMI5n6kahExQZS3jNlB1zVzxUdGhNAR9
	VHY3UonHMY8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8E95B637;
	Wed,  6 Feb 2013 10:56:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 274E4B62F; Wed,  6 Feb 2013
 10:56:10 -0500 (EST)
In-Reply-To: <20130206103952.GA5267@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 05:39:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9971C6E-7075-11E2-A436-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215591>

Jeff King <peff@peff.net> writes:

> Is it worth having a strbuf_set* family of functions to match the
> strbuf_add*? We seem to have these sorts of errors with strbuf from time
> to time, and I wonder if that would make it easier (and more readable)
> to do the right thing.

Possibly.

The callsite below may be a poor example, though; you would need the
_reset() even if you change the _addstr() we can see in the context
to _setstr() to make sure later strbuf_*(type) will start from a
clean slate when !t anyway, no?

>
>  http.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/http.c b/http.c
> index d868d8b..d9d1aad 100644
> --- a/http.c
> +++ b/http.c
> @@ -841,6 +841,7 @@ static int http_request(const char *url, struct strbuf *type,
>  
>  	if (type) {
>  		char *t;
> +		strbuf_reset(type);
>  		curl_easy_getinfo(slot->curl, CURLINFO_CONTENT_TYPE, &t);
>  		if (t)
>  			strbuf_addstr(type, t);
