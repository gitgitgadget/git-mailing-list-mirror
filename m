From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] cat-file: do not die on --textconv without textconv filters
Date: Fri, 19 Apr 2013 11:15:57 -0700
Message-ID: <7vli8e1j4y.fsf@alter.siamese.dyndns.org>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
	<06f2d51bf0479f3231b707d88d8d04fcd306c973.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:16:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFqv-0004qg-JG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab3DSSQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 14:16:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947Ab3DSSP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 14:15:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 598E515515;
	Fri, 19 Apr 2013 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+48rbBWufUcRrXMGiw21hBFK8m8=; b=wME+So
	J/oI0om0CRkoMniwMzu5JZJUiNrhz0krio4J1MbvrZ6c2+vta/hyTGWyiMmdRvBE
	RKwVEZYgZDe/kCNeAtCXRlfmde5izjcCBe36EagslWFu+kfrNUU8wiC6odRi2Cvz
	0UHdCAP1qaObHoMOKrHodVdP55wgKlibYwNRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d2aVPaNfIxKNVMp5YaAUojPbGJXfmnEL
	YS8WPTyp78mRiswQsrDSMMlcZQSii7qWBkn2yqIGk8kMqEx+Va8cfU8RYtrM6kiG
	Ca6OSGqEkOZ7yVJaM/i4OIaWpXIG0Fej9EUDxASrMwYFDPLk4XXu8rmMLUDbqWDz
	z4RzPb4misU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5045615513;
	Fri, 19 Apr 2013 18:15:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1CA115511;
	Fri, 19 Apr 2013 18:15:58 +0000 (UTC)
In-Reply-To: <06f2d51bf0479f3231b707d88d8d04fcd306c973.1366389739.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 19 Apr 2013 18:44:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F589ECA-A91D-11E2-B876-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221790>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When a command is supposed to use textconv filters (by default or with
> "--textconv") and none are configured then the blob is output without
> conversion; the only exception to this rule is "cat-file --textconv".

I am of two minds.  Because cat-file is mostly a low-level plumbing,
I do not necessarily think it is a bad behaviour for it to error out
when it was asked to apply textconv where there is no filter or when
the filter fails to produce an output.  On the other hand, it
certainly makes it more convenient for callers that do not care too
deeply, taking textconv as a mere hint just like Porcelains do.

But assuming that this is the direction we would want to go...

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 40f87b4..dd4e063 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -146,10 +146,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  			die("git cat-file --textconv %s: <object> must be <sha1:path>",
>  			    obj_name);
>  
> -		if (!textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> -			die("git cat-file --textconv: unable to run textconv on %s",
> -			    obj_name);
> -		break;
> +		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> +			break;
> +
> +		/* otherwise expect a blob */
> +		exp_type = "blob";

Please use the constant string blob_type that is available for all
callers including this one.
