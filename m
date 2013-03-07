From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of
 string
Date: Thu, 07 Mar 2013 13:48:18 -0800
Message-ID: <7vobeulw4d.fsf@alter.siamese.dyndns.org>
References: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 22:48:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDigC-0001Ym-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 22:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3CGVsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 16:48:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356Ab3CGVsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 16:48:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 145AAAA73;
	Thu,  7 Mar 2013 16:48:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vSOj/lDZByf4zrPenhFZEXsx/gQ=; b=LpoZ9R
	J3U0PUr6qeNtMYYyOjhmjSJaB01plcNwtRppjbT69CNTEN8xex3ekgiIkSIrvDNr
	xqCGo3FbHimap++in7TkruuuCqHj23YVZPoUIbAl9MTOcoy1tkiJh/3UElmbIWA7
	OQAuCJ+A9UiKQuPmzTfkoFTsMa6xnP4PfDKmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gqh0kyfORDFZYhECfbK+XlK0kezvMBdc
	6claiLFEJWPKhmaaFycZcdK8qXr17/v/e1qaI0H0aTUJievdZKoFtVdAkKmswZWu
	+RNdTe0Fs227cXBKAgrCzo8XnZ+2E2Q31PpRpeJzVuseUyYs3r+x45mutPR1lpw4
	9kCCGTYJxYA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A44DAA72;
	Thu,  7 Mar 2013 16:48:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A4B1AA70; Thu,  7 Mar 2013
 16:48:20 -0500 (EST)
In-Reply-To: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Thu, 7 Mar 2013 11:36:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA3B85E4-8770-11E2-8486-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217618>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> The previous code was assuming length ends at either `)` or `,`, and was
> not handling the case where strcspn returns length due to end of string.
> So specifying ":(top" as pathspec will cause the loop to go pass the end
> of string.

Thanks.

The parser that goes past the end of the string may be a bug worth
fixing, but is this patch sufficient to diagnose such an input as an
error?




> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  setup.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 1dee47e..f4c4e73 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -207,9 +207,11 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
>  		     *copyfrom && *copyfrom != ')';
>  		     copyfrom = nextat) {
>  			size_t len = strcspn(copyfrom, ",)");
> -			if (copyfrom[len] == ')')
> +			if (copyfrom[len] == '\0')
>  				nextat = copyfrom + len;
> -			else
> +			else if (copyfrom[len] == ')')
> +				nextat = copyfrom + len;
> +			else if (copyfrom[len] == ',')
>  				nextat = copyfrom + len + 1;
>  			if (!len)
>  				continue;
