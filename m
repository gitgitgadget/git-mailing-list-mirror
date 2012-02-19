From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: refuse tag messages that contain NULs
Date: Sun, 19 Feb 2012 13:40:44 -0800
Message-ID: <7v39a6pkmb.fsf@alter.siamese.dyndns.org>
References: <1329651837-1102-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 19 22:40:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzEV1-00064J-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 22:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab2BSVkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 16:40:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab2BSVkq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 16:40:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEB096A65;
	Sun, 19 Feb 2012 16:40:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UB6orYYdX3WS
	RSwBaNuUB2fvCIs=; b=najGg8t1vPBCZU7JVh23PxUf+NOvh3IOSrN9sFv7tt2Z
	ZizNOtbLxnQ81LSD29jnILX5jrXws601/ncGSftmzWlSdE0utEwzxr0tg81Xige1
	6Q3r+ITM0sYxM0k9UELzqpMM+dIsBUBrZSLUNTor7WsG9eSiBS4kV6QdcY+IYpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QA1XfM
	pma6c5NHQgKIPTi2ofVi/tTS6/rTTH1fJpQmAEiSK8dite7ufp9N/Trip+Jifvbf
	WRnM6jbaWyZXzDRvIDVMT57SnnQ+Y/h+o3SZ4FysEcIXV0kyUVK5JwTwGnWIz65U
	gEhWKE1aGgo8nWaL5i2hxGVP07dbIanPsxDQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D596A64;
	Sun, 19 Feb 2012 16:40:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A17C6A63; Sun, 19 Feb 2012
 16:40:45 -0500 (EST)
In-Reply-To: <1329651837-1102-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 19 Feb
 2012 18:43:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 613BC9B4-5B42-11E1-984D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191031>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 640ab64..f51ce20 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -165,6 +165,9 @@ int cmd_mktag(int argc, const char **argv, const =
char *prefix)
>  	if (verify_tag(buf.buf, buf.len) < 0)
>  		die("invalid tag signature file");
> =20
> +	if (memchr(buf.buf, '\0', buf.len))
> +		die("a NUL byte in tag message not allowed.");
> +

Is there a good reason why you check _after_ calling verify_tag(), inst=
ead
of before?

>  	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
>  		die("unable to write tag file");
> =20
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 31f02e8..e66811e 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -259,6 +259,8 @@ static int build_tag_object(struct strbuf *buf, i=
nt sign, unsigned char *result)
>  {
>  	if (sign && do_sign(buf) < 0)
>  		return error(_("unable to sign the tag"));
> +	if (memchr(buf->buf, '\0', buf->len))
> +		return error("a NUL byte in tag message not allowed.");

Is there a good reason why you check _after_ calling do_sign(), instead=
 of
before?
