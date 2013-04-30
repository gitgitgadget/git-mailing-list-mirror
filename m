From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] sha1_name: refactor reinterpret()
Date: Tue, 30 Apr 2013 15:01:43 -0700
Message-ID: <7va9ofbrug.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Duy Nguyen\" <pclouds@gmail.com>"@b-sasl-quonix.pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIcQ-0005jL-Gx
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760697Ab3D3WBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:01:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078Ab3D3WBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:01:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44AFD1B31A;
	Tue, 30 Apr 2013 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iVKiQ6NZsMBuguBI/ShBezqBbnE=; b=XjDmPq
	/PNjJgDPbV1SvjG4kToS16g/9rof+fH0pOfPO5iC0Ewgon16ir2cOIWSyex8MDpf
	66VJ7A4iyN/3xIGcd7mNBcHqq3CQep05rHc09+YQ11cnjVfhy/M9T8oVBZfK4dhJ
	2GOHeeH2tkxEAOREX0T126HfHeTONOBgT3va0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnmtKskqt0k8AR3o8CikrVlCX3sflgA2
	tSZaOOh+klrVH2BL2MRP07tufv+A6kthXq17nkn1JTMrtg2LAKUGXcLQHsrspAjL
	OInGSjNhWOZ+o4pTDWlOxyOLGusMqv+P8TtYjlBSZ+ke77t4DmbI7ngJs3IcZRE/
	zXPftA+1PeM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C09B1B319;
	Tue, 30 Apr 2013 22:01:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871711B318;
	Tue, 30 Apr 2013 22:01:44 +0000 (UTC)
In-Reply-To: <1367358554-4257-5-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 16:49:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BCA989E-B1E1-11E2-95C0-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223022>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> This code essentially replaces part of ref with another ref, for example
> '@{-1}@{u}' is replaced with 'master@{u}', but this can be reused for
> other purposes other than nth prior checkouts.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Makes sense.


>  sha1_name.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 93c4e8c..76e3219 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -965,6 +965,27 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
>  	return st;
>  }
>  
> +static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
> +{
> +	/* we have extra data, which might need further processing */
> +	struct strbuf tmp = STRBUF_INIT;
> +	int used = buf->len;
> +	int ret;
> +
> +	strbuf_add(buf, name + len, namelen - len);
> +	ret = interpret_branch_name(buf->buf, &tmp);
> +	/* that data was not interpreted, remove our cruft */
> +	if (ret < 0) {
> +		strbuf_setlen(buf, used);
> +		return len;
> +	}
> +	strbuf_reset(buf);
> +	strbuf_addbuf(buf, &tmp);
> +	strbuf_release(&tmp);
> +	/* tweak for size of {-N} versus expanded ref name */
> +	return ret - used + len;
> +}
> +
>  /*
>   * This reads short-hand syntax that not only evaluates to a commit
>   * object name, but also can act as if the end user spelled the name
> @@ -998,25 +1019,8 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>  		return len; /* syntax Ok, not enough switches */
>  	if (len > 0 && len == namelen)
>  		return len; /* consumed all */
> -	else if (len > 0) {
> -		/* we have extra data, which might need further processing */
> -		struct strbuf tmp = STRBUF_INIT;
> -		int used = buf->len;
> -		int ret;
> -
> -		strbuf_add(buf, name + len, namelen - len);
> -		ret = interpret_branch_name(buf->buf, &tmp);
> -		/* that data was not interpreted, remove our cruft */
> -		if (ret < 0) {
> -			strbuf_setlen(buf, used);
> -			return len;
> -		}
> -		strbuf_reset(buf);
> -		strbuf_addbuf(buf, &tmp);
> -		strbuf_release(&tmp);
> -		/* tweak for size of {-N} versus expanded ref name */
> -		return ret - used + len;
> -	}
> +	else if (len > 0)
> +		return reinterpret(name, namelen, len, buf);
>  
>  	cp = strchr(name, '@');
>  	if (!cp)
