From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_tag_buffer(): do not prefixcmp() out of range
Date: Tue, 15 Feb 2011 13:18:50 -0800
Message-ID: <7vsjvpm1xh.fsf@alter.siamese.dyndns.org>
References: <20110212144706.GA25124@do>
 <1297688571-1962-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 22:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpSIg-0003M3-6K
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 22:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab1BOVTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 16:19:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1BOVTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 16:19:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4625C4257;
	Tue, 15 Feb 2011 16:20:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0Cc0oK/qWowa
	pNQeWqb9Y2Evc+Y=; b=p2bwBE0uhg0Cc6wIsIFwMVpC/n9SnxgIEpsKROAL4b1q
	o2Lra/9CwD8EsgU8jFGb8vqfd36in5FItnqrPY9K3tFqh4l0GIen41dGtPXyY49Z
	/wu4KuAGYmE1dayWYk9w1swU3w83J4R1vpb6W5BizPrcXy3E33B8xmLM7pKPuLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LjE3BI
	x/go5sl8eADXXQ6pgpapbkye6RZ2eW1C/UsaZP1nC9i1Xx2L5f5EgyFPDBwjb6UL
	JdGuIYHcSHMKZP5rH2OGpUDsZ9sIgqTLzfYZgYlodZIgxhBdzagz24H3gwzRYLhX
	NFlhLImOf7F/8RDXfqclk8tHW8o+3mc2P04os=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 134AB4256;
	Tue, 15 Feb 2011 16:20:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 943EC4253; Tue, 15 Feb 2011
 16:19:58 -0500 (EST)
In-Reply-To: <1297688571-1962-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 14 Feb
 2011 20\:02\:51 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AD4B250-3949-11E0-A77D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166877>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> There is a check (size < 64) at the beginning of the function, but
> that only covers object+type lines.
>
> Strictly speaking the current code is still correct even if it
> accesses outside 'data' because 'tail' is used right after
> prefixcmp() calls.

What do you mean by this?  I don't get it.

> diff --git a/tag.c b/tag.c
> index ecf7c1e..9318ae5 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -97,7 +97,9 @@ int parse_tag_buffer(struct tag *item, const void *=
data, unsigned long size)
>  		item->tagged =3D NULL;
>  	}
> =20
> -	if (prefixcmp(bufptr, "tag "))
> +	if (bufptr + 4 < tail && !prefixcmp(bufptr, "tag "))
> +		; 		/* good */
> +	else
>  		return -1;
>  	bufptr +=3D 4;
>  	nl =3D memchr(bufptr, '\n', tail - bufptr);

If there weren't enough bytes between bufptr and tail, prefixcmp may st=
ill
match with "tag " while later part of the matched string might be comin=
g
from trailing garbage outside our memory.  Unless we correctly fail the
prefixcmp() part, memchr() would be fed negative value, no?
