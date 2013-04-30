From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] sha1_name: allow @@{u} to work
Date: Tue, 30 Apr 2013 15:21:28 -0700
Message-ID: <7vwqrjacd3.fsf@alter.siamese.dyndns.org>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
	<1367358554-4257-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	"Duy Nguyen\" <pclouds@gmail.com>"@b-sasl-quonix.pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:21:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIvb-00074w-TU
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933835Ab3D3WVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:21:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642Ab3D3WVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:21:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EAAD1BC56;
	Tue, 30 Apr 2013 22:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DEmimqh8B1M8S4n95+28rM6YFoU=; b=vPYm1t
	HdMhRWxeCdEnqYbwXtgghz3ZjbIpwKwBz11MwsXlgLTLgtqhLNGRcKIxCLnKzeHE
	e8w5LsB6apq1QW/cQRePs4ORZFEp6IgSn6y+jeMDDwDJcZhOq1a/oiV7ye6Tc/O1
	FfzZYNgscb4HhPbf0kYDoO/g3xT54/VR+grE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1EsEpFC4ZA+gde0ASHmJqorjtFKllE4
	tbGwWvVN7Gi9TMCAI58wphQPWGJZvjYkoequdCCxUaMlOB+zux0nf8BFnyBxHzLk
	1f1By2mbu6P6u8Qlil46gabyozMYj0ChAzZHqVgwFDwZhhR6BbGIOOR56FnpjhOI
	FyYluNZbV/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 115191BC55;
	Tue, 30 Apr 2013 22:21:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B6ED1BC51;
	Tue, 30 Apr 2013 22:21:32 +0000 (UTC)
In-Reply-To: <1367358554-4257-7-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 16:49:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FC9CF6A-B1E4-11E2-891C-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223029>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  sha1_name.c                | 21 +++++++++++++++++++++
>  t/t1508-at-combinations.sh |  2 +-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 887de6c..8f65bad 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -969,6 +969,21 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
>  	return st;
>  }
>  
> +static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)

Can we have a comment to clarify what "empty"-ness this name refers to?
Is it <empty>@<something>?  <something>@<empty>?  Something else?

> +{
> +	if (namelen - len <= 1 || name[len + 1] == '{')
> +		return -1;
> +
> +	strbuf_reset(buf);
> +	if (len == 0) {
> +		strbuf_add(buf, "HEAD", 4);
> +		return 1;
> +	} else {
> +		strbuf_add(buf, name, len);
> +		return len + 1;
> +	}
> +}
> +
>  static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
>  {
>  	/* we have extra data, which might need further processing */
> @@ -1029,9 +1044,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>  	cp = strchr(name, '@');
>  	if (!cp)
>  		return -1;
> +
> +	len = interpret_empty_at(name, namelen, cp - name, buf);
> +	if (len > 0)
> +		return reinterpret(name, namelen, len, buf);
> +
>  	tmp_len = upstream_mark(cp, namelen - (cp - name));
>  	if (!tmp_len)
>  		return -1;
> +
>  	len = cp + tmp_len - name;
>  	cp = xstrndup(name, cp - name);
>  	upstream = branch_get(*cp ? cp : NULL);
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index 50035cd..65584c0 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -47,7 +47,7 @@ check "@{-1}@{u}" master-two
>  check "@{-1}@{u}@{1}" master-one
>  check "@" new-two
>  check "HEAD@{u}" upstream-two
> -check "@@{u}" upstream-two failure
> +check "@@{u}" upstream-two
>  nonsense "@{u}@{-1}"
>  nonsense "@{1}@{u}"
