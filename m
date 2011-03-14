From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make_absolute_path: Don't try to copy a string to
 itself
Date: Mon, 14 Mar 2011 13:25:30 -0700
Message-ID: <7v39mpcuv9.fsf@alter.siamese.dyndns.org>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:25:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzEKm-0006Sb-M4
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 21:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab1CNUZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2011 16:25:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1CNUZj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 16:25:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3E5E4B57;
	Mon, 14 Mar 2011 16:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xt1UGRnk8e0z
	jv+fmQejr9X9pe0=; b=toNx2NhEdaxVqZK7gRecgIzUFPwMhlxANMagheOHn+i8
	wHqQ3QdoZdJSRP3ecWGQbgfC5nIuSgnN9YqBIwRvIbn2r+5UxFl29DEkxDBUFK7G
	B9d5M3nLiULDAfOqwtYZXeyU/gmKYJrWkZXlSG0kEoJK0fyPAebsNDZN07briis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZtMsl6
	dmJQqEDVmnaWNmiCznbrHRPXSyziFcaI0g9/jiVjEZvYQ1BmSOCrSOdUIgq7dDD7
	/tDi1BQFD9b4dt+eLcZF6SkTpsSZLTj9d3+a+DBZT297uEjO8OFsLp8Yx6mmU//s
	klgPrHqHAKfoPKf75np+rx8ItQjq/vcCt8yk0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8172D4B55;
	Mon, 14 Mar 2011 16:27:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 96CAF4B54; Mon, 14 Mar 2011
 16:27:02 -0400 (EDT)
In-Reply-To: <1300130318-11279-2-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 14 Mar 2011 20:18:36
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D6586C0-4E79-11E0-9D54-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169024>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Sometimes (at least in t-0001-init.sh test 12), the return value of
> make_absolute_path() is passed to it as an argument, making the first

I don't think it is a bad idea per-se to avoid a copy from the same mem=
ory
location into the same memory location, but independent of the necessit=
y
of fixes at the low-level, shouldn't we fix the callers that do not che=
ck
if what they have is already absolute?

> and second arguments to strlcpy() the same, making the test fail when
> run under valgrind.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>
> This patch assumes the path returned by make_absolute_path() is never
> longer than PATH_MAX, which I think is a safe assumption.

>
>  abspath.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index 91ca00f..9149a98 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -24,7 +24,7 @@ const char *make_absolute_path(const char *path)
>  	char *last_elem =3D NULL;
>  	struct stat st;
> =20
> -	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
> +	if (buf !=3D path && strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX)
>  		die ("Too long path: %.*s", 60, path);
> =20
>  	while (depth--) {
