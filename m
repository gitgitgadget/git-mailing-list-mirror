From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] strbuf: add strbuf_add*_urlencode
Date: Tue, 29 Nov 2011 10:19:00 -0800
Message-ID: <7vzkfessff.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110728.GI8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 19:19:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVSGr-0004t7-K4
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 19:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab1K2STE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 13:19:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294Ab1K2STD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 13:19:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C1A6895;
	Tue, 29 Nov 2011 13:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ylKLv55a7It9EQnxaeh6WagivwQ=; b=vLSvqjPLxZt33vS7HWC/
	v5hINuSu4p2/kD1EPyIKJIJtZg6DRJsoradgFcglut1DX0qj4Y15K75/IWhmxn4z
	h44sjUkDZtN3gtKTcE+7BwF8yYb2bTHmp5h0vYAOk+rP07sudYPq2JIIdu0YiS7G
	+jONpqOyKV0V1e5/ZoZmaw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=oUJo6Q+NbaCJ3Y6MI3Rnnm3A1Vjv7MJKbtOBL3ZcXP7tJt
	hUbQQQHnZJIpKUVg/8X3c9GqZ+Jc7+5Sw4vVmVE0T2UGpkyNjB0HiNSKK9vuQxxj
	afHUGNoMAi0nJ5ASLgQ4dFqM9ZTFdGsSkuXrC+dWlWGEzcTViqSTtG+OpoySA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A5A66894;
	Tue, 29 Nov 2011 13:19:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D1F6893; Tue, 29 Nov 2011
 13:19:01 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CF7D32A-1AB6-11E1-8121-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186069>

Jeff King <peff@peff.net> writes:

> This just follows the rfc3986 rules for percent-encoding
> url data into a strbuf.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strbuf.c |   37 +++++++++++++++++++++++++++++++++++++
>  strbuf.h |    5 +++++
>  2 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 3ad2cc0..60e5e59 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -397,3 +397,40 @@ int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
>  
>  	return len;
>  }
> +
> +static int is_rfc3986_reserved(char ch)
> +{
> +	switch (ch) {
> +	case '!': case '*': case '\'': case '(': case ')': case ';':
> +	case ':': case '@': case '&': case '=': case '+': case '$':
> +	case ',': case '/': case '?': case '#': case '[': case ']':
> +		return 1;
> +	}
> +	return 0;
> +}

Part of me wonders if we still have extra bits in sane_ctype[] array but
that one is cumbersome to update, and the above should be easier to read
and maintain.

> +void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
> +			  int reserved)

Does "reserved" parameter mean "must-encode-reserved", or
"may-encode-reserved" (the latter would be more like "if set to 0,
per-cent encoding the result would be an error")?
