From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] credential: let empty credential specs reset helper list
Date: Fri, 26 Feb 2016 09:23:24 -0800
Message-ID: <xmqqa8mnl71v.fsf@gitster.mtv.corp.google.com>
References: <20160226105135.GA30215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Guilherme <guibufolo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZM72-0003DP-PW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbcBZRX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:23:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753981AbcBZRX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:23:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FC52444C9;
	Fri, 26 Feb 2016 12:23:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UGTN8tbZnpnm/xjqXgwHBznkq8M=; b=LmwCwx
	bYrJpzlbyYCbl2ixlUh8u0o3+1KeB30LvF5D+yA6jGCRUA7eEMp3FqivsZcGFkzj
	vbqGI3AQlesGlxENa++B7DrDGkq9/UjN4rP+/7ZkPkox0WyllN0CFDs7Kq7OhnGo
	7YHb3pJW3ryABAyyj9RThPJCXtnk6lc3YlG1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qWKDbkmxnK0DsWWfTzVxKokkyz/HgYmN
	0mYqm1iEuwxFOLJJt5Q6O7TJ9OQKbq6K0qrOXLiHw8BP28+XDeyNh4XF7dzItTf9
	LSwmy4qj3g3mSaJ/X0bd1tkNZ9Z3SPhUW8D487WDEqiOvA652nv5u672m1KrV73q
	EW0hqUo1WyE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37B2D444C8;
	Fri, 26 Feb 2016 12:23:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 89C3F444C7;
	Fri, 26 Feb 2016 12:23:25 -0500 (EST)
In-Reply-To: <20160226105135.GA30215@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 26 Feb 2016 05:51:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4BA69A2-DCAD-11E5-82F2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287596>

Jeff King <peff@peff.net> writes:

> Sine the credential.helper key is a multi-valued config

s/Sine/Since/;

> diff --git a/credential.c b/credential.c
> index 7d6501d..aa99666 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -63,9 +63,12 @@ static int credential_config_callback(const char *var, const char *value,
>  		key = dot + 1;
>  	}
>  
> -	if (!strcmp(key, "helper"))
> -		string_list_append(&c->helpers, value);
> -	else if (!strcmp(key, "username")) {
> +	if (!strcmp(key, "helper")) {
> +		if (*value)
> +			string_list_append(&c->helpers, value);
> +		else
> +			string_list_clear(&c->helpers, 0);
> +	} else if (!strcmp(key, "username")) {

I wondered why neither the existing code nor the updated one has a
check for !value, but this callback assumes no credential
configuration variable will ever be a boolean and rejects it
upfront, so this code before or after the change is safe.

Not pointing out anything that needs to be changed; demonstrating
that I did read this sufficiently well to say that I have reviewed
it ;-)
