From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 3/8] Pass unknown protocols to external protocol
 handlers
Date: Tue, 08 Dec 2009 15:35:17 -0800
Message-ID: <7vskbl59ai.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:35:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9ae-00054R-BP
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbZLHXfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbZLHXfV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:35:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965235AbZLHXfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:35:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 364D7862EE;
	Tue,  8 Dec 2009 18:35:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rc7uinzM/wRnTPmwHYFrsCossYQ=; b=pEF+7Jg5MmZD2LKeX63Gx0F
	MhgZJFPX2pM2TXGlB56u1p164cgE5Ynfipu1re3FV+KFJyB7Ft9fCc+SUF4Hekyh
	OmBFI/i2JCUWsXH026OPHd4jCFPGbDma83LTzhqMmx44bUnhWv6KEELULmx+Cie7
	qaryPvMAzS6X4nWVUWaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aVly1jVXvWJ2OayYpRU/hm7//XhmW2oGZ0y5tm2P4MTbvTUyq
	NnyHVAwDp6mibUCxEZQ7lT+J17GmIj9EGXQvKSW9XKtby6BWYgMlmQ6eahxs7SG+
	iVWteusrKHyAuV6QCPxk6Dq3N8j0Si4f5kr6pKFhCWH0FE+1jaAehWNojE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14FB3862EB;
	Tue,  8 Dec 2009 18:35:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AE93862E8; Tue,  8 Dec
 2009 18:35:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C0CFFE4-E452-11DE-B52E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134923>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> +const char *remove_ext_force(const char *url)
> +{
> +	const char *url2 = url;
> +	const char *first_colon = NULL;
> +
> +	if (!url)
> +		return NULL;
> +
> +	while (*url2 && !first_colon)
> +		if (*url2 == ':')
> +			first_colon = url2;
> +		else
> +			url2++;
> +
> +	if (first_colon && first_colon[1] == ':')
> +		return first_colon + 2;
> +	else
> +		return url;
> +}

Sorry, I am slow today, but is this any different from:

	if (url) {
		const char *colon = strchr(url, ':');
	        if (colon && colon[1] == ':')
	        	return url2 + 2;
	}
	return url;

> diff --git a/transport.c b/transport.c
> index 3eea836..e42a82b 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -780,6 +780,58 @@ static int is_file(const char *url)
>  	return S_ISREG(buf.st_mode);
>  }
>  
> +static const char *strchrc(const char *str, int c)
> +{
> +	while (*str)
> +		if (*str == c)
> +			return str;
> +		else
> +			str++;
> +	return NULL;
> +}

I cannot spot how this is different from strchr()...

> +static int is_url(const char *url)
> +{
> +	const char *url2, *first_slash;
> +
> +	if (!url)
> +		return 0;
> +	url2 = url;
> +	first_slash = strchrc(url, '/');
> +
> +	/* Input with no slash at all or slash first can't be URL. */
> +	if (!first_slash || first_slash == url)
> +		return 0;
> +	/* Character before must be : and next must be /. */
> +	if (first_slash[-1] != ':' || first_slash[1] != '/')
> +		return 0;
> +	/* There must be something before the :// */
> +	if (first_slash == url + 1)
> +		return 0;
> +	/*
> +	 * Check all characters up to first slash. Only alpha, num and
> +	 * colon (":") are allowed. ":" must be followed by ":" or "/".
> +	 */

Hmm, so "a::::bc:://" is ok?

Is the reason this does not to check the string up to (first_slash-1) for
a valid syntax for <scheme> (as in "<scheme>://") because this potentially
has "<helper>::" in front of it?

I cannot tell if you want to allow "<helper1>::<helper2>::<scheme>://..."
by reading this code.

> +static int external_specification_len(const char *url)
> +{
> +	return strchrc(url, ':') - url;
> +}

Does the caller guarantee url has at least one colon in it?

>  struct transport *transport_get(struct remote *remote, const char *url)
>  {
>  	struct transport *ret = xcalloc(1, sizeof(*ret));
> @@ -805,30 +857,23 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  
>  	if (remote && remote->foreign_vcs) {
>  		transport_helper_init(ret, remote->foreign_vcs);
> +	} else if (!prefixcmp(url, "rsync:")) {
>  		ret->get_refs_list = get_refs_via_rsync;
>  		ret->fetch = fetch_objs_via_rsync;
>  		ret->push = rsync_transport_push;
>  	} else if (is_local(url) && is_file(url)) {
>  		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
>  		ret->data = data;
>  		ret->get_refs_list = get_refs_from_bundle;
>  		ret->fetch = fetch_refs_from_bundle;
>  		ret->disconnect = close_bundle;
> +	} else if (!is_url(url)
> +		|| !prefixcmp(url, "file://")
> +		|| !prefixcmp(url, "git://")
> +		|| !prefixcmp(url, "ssh://")
> +		|| !prefixcmp(url, "git+ssh://")
> +		|| !prefixcmp(url, "ssh+git://")) {
> +		/* These are builtin smart transports. */

Hmm, what is !is_url(url) at the beginning for, if this lists "builtin"
smart transports?

> @@ -845,6 +890,21 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  		data->receivepack = "git-receive-pack";
>  		if (remote->receivepack)
>  			data->receivepack = remote->receivepack;
> +	} else if (!prefixcmp(url, "http://")
> +		|| !prefixcmp(url, "https://")
> +		|| !prefixcmp(url, "ftp://")) {
> +		/* These three are just plain special. */
> +		transport_helper_init(ret, "curl");
> +#ifdef NO_CURL
> +		error("git was compiled without libcurl support.");
> +#endif
> +	} else {
> +		/* Unknown protocol in URL. Pass to external handler. */
> +		int len = external_specification_len(url);
> +		char *handler = xmalloc(len + 1);
> +		handler[len] = 0;
> +		strncpy(handler, url, len);
> +		transport_helper_init(ret, handler);

Hmph, external_specification_len() may get passed a colon-less string
after all, I think.
