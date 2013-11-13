From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] for-each-ref: introduce %(color:...) for color
Date: Wed, 13 Nov 2013 12:01:19 -0800
Message-ID: <xmqqbo1odqb4.fsf@gitster.dls.corp.google.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
	<1384335406-16332-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 21:01:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vggcz-0000fK-OU
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 21:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757698Ab3KMUB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 15:01:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757359Ab3KMUBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 15:01:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63F4C5069F;
	Wed, 13 Nov 2013 15:01:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JdznbmmlU/6gHss4FGbWwx3OlBg=; b=Bf8VgD
	itTi4Jow1k7plrl6aPq4Qwk2PoFoa5exQ633MXKtZ8NOAa9+Okn6U9r9ObhLrJaJ
	wdEToENn2HP4o6aFx8hscOmFtmJ+fttA3FHBAg1y4GrrG57Q5bTLxnIgNSym6vW8
	Rdy0QQ94fCWPCN617mfzftmy4gAm1jp2cvGF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Um2zDE+93C7ZltRCGMgw5TfxS60/EvNB
	2rQJAIcqkYrNhicYZ4C0iYzLknHAZTkeeN+Wn8yuCVEiVk93dA7jAxEcp5ZXr+tv
	ptCQd1PLXPesSPgauafHkxpzDhvKiVgR/Sm6Ecshp4qUeo2KSjIGipEUTj1cBCYp
	xsPJeI4Fx6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7C05069D;
	Wed, 13 Nov 2013 15:01:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0CAE50691;
	Wed, 13 Nov 2013 15:01:23 -0500 (EST)
In-Reply-To: <1384335406-16332-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 13 Nov 2013 15:06:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5F2E81D0-4C9E-11E3-9236-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237800>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +		} else if (!prefixcmp(name, "color")) {
> +			;

How is "%(color:short)" parsed with this code?

This part says, "Yeah, I see something starting with color", and
then later strchr(name, ':') will point formatp to "short".

Luckily, "%(colorgarbage:short)" does not even come this far because
parse_atom() would not have allowed the codeflow to, but comparing
with "color:" here may be a lot more defensive and safe, I think.

And find the color-value here, stuffing v->s inside this "else if",
continue, without letting the formatp part work on refname this
piece of code does not even set.  Just like how we handle "flag"
without falling thru to the formatp code.


> +		} else if (!strcmp(name, "flag")) {
>  			char buf[256], *cp = buf;
>  			if (ref->flag & REF_ISSYMREF)
>  				cp = copy_advance(cp, ",symref");
> @@ -729,6 +732,12 @@ static void populate_value(struct refinfo *ref)
>  				else
>  					v->s = "<>";
>  				continue;
> +			} else if (!prefixcmp(name, "color")) {
> +				char color[COLOR_MAXLEN] = "";
> +
> +				color_parse(formatp, "--format", color);
> +				v->s = xstrdup(color);
> +				continue;
>  			} else
>  				die("unknown %.*s format %s",
>  				    (int)(formatp - name), name, formatp);
