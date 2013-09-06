From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] connect.c: save symref info from server capabilities
Date: Fri, 06 Sep 2013 10:56:51 -0700
Message-ID: <xmqqob85ygt8.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<20130906155655.GG12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI0JB-0000sV-3L
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab3IFR5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:57:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43995 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668Ab3IFR44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:56:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF6413F22C;
	Fri,  6 Sep 2013 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jP596n71scbZ54bzg2e+qRjI57g=; b=iomwQa
	pJ2xdLktj/jE/JLxXZo5KDb4FC4duj3oGxAinMpAJFa44VxWgUdYcq4yf+seBydg
	tBxVNKcSYIwmJpvT6vpono80F1SIFLaPM1+07iSVshstzIhfK+g2iE1R020WWimz
	nw7C3ILG0ZwliCEjafb77YKO1yC7lbISq7xCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pHTBQaJYrCyFVIjG0pLYr2wPGK3DHz8X
	LJL5iQpsQFZOYBXimaAzAwl36D85620+SrPHP1g3sGEGp/NcquoO1i2D88II2dW7
	vS0xyhMdW2h+jw1Ghg2Z3pqAE24/tZ1Sk5Xt5CHWqaIkRnMjMk7xU8e0z5NzFSY8
	+mA9fmK1AQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FD0E3F229;
	Fri,  6 Sep 2013 17:56:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95A313F225;
	Fri,  6 Sep 2013 17:56:53 +0000 (UTC)
In-Reply-To: <20130906155655.GG12966@inner.h.apk.li> (Andreas Krey's message
	of "Fri, 6 Sep 2013 17:56:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B699533E-171D-11E3-98BE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234078>

Andreas Krey <a.krey@gmx.de> writes:

> Signed-off-by: Andreas Krey <a.krey@gmx.de>
> ---
>  connect.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index a0783d4..98c4868 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -72,8 +72,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	for (;;) {
>  		struct ref *ref;
>  		unsigned char old_sha1[20];
> -		char *name;
> -		int len, name_len;
> +		char *name, *symref;
> +		int len, name_len, symref_len;
>  		char *buffer = packet_buffer;
>  
>  		len = packet_read(in, &src_buf, &src_len,
> @@ -94,9 +94,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  		name = buffer + 41;
>  
>  		name_len = strlen(name);
> +		symref = 0;
>  		if (len != name_len + 41) {
>  			free(server_capabilities);
>  			server_capabilities = xstrdup(name + name_len + 1);
> +			symref = parse_feature_value(server_capabilities,
> +						     "symref", &symref_len);
>  		}
>  		if (extra_have &&
> @@ -108,6 +111,10 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  		if (!check_ref(name, name_len, flags))
>  			continue;
>  		ref = alloc_ref(buffer + 41);
> +		if (symref) {
> +			ref->symref = xcalloc(symref_len + 1, 1);
> +			strncpy(ref->symref, symref, symref_len);
> +		}
>  		hashcpy(ref->old_sha1, old_sha1);
>  		*list = ref;
>  		list = &ref->next;


This looks utterly wrong.  HEAD may happen to be the first ref that
is advertised and hence capability list typically comes on it, but
that does not necessarily have to be the case from the protocol's
correctness point of view.

I think this function should do this instead.

    - inside the loop, collect the "symref=..." capabilities;

    - after the loop, look at the "symref=..." capabilities, and
      among the refs the loop added to the *list, find the "HEAD"
      ref and set its ->symref to point at an appropirate ref.
