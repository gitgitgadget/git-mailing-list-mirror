From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: allow cloning local paths with colons in them
Date: Sat, 27 Apr 2013 14:16:49 -0700
Message-ID: <7vip37u11a.fsf@alter.siamese.dyndns.org>
References: <20130422153516.GB11886@sigill.intra.peff.net>
	<1367033778-13923-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCUN-0006qd-3a
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab3D0VQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 17:16:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab3D0VQw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Apr 2013 17:16:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3B251A39F;
	Sat, 27 Apr 2013 21:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BWJKh8iQPS8Z
	kwDd/PtjsqZ2Afc=; b=jHdXiwnELO2HD6t+1umtg/3IfvVVrFVOXfwG08DyUQeo
	8NLOPH4VBZOWXK0ojIaY6z94sYSTQ73hO9PjZ3cmSt37iCldnntH8UoHCM+atMv4
	+xh7cfQsfpqg5iw3yLhqEQIpKml20pykL0CB+VSXGDggAQBVDnsp2n3MAfsrM00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iZbPnO
	rtxOfG5EQxakcLkUdSA8lbGccqWtgUgcxE3oP8NNvp8mQUPzBS253qB9Iol3MmYh
	RzD+4pVvJoUwWk29IBylNCWMVbvMRXYS9nnPhXqkeA7vkGOsmRrNan8462egRUgB
	1Yh1i38lQsZyaxv2V1ZgbBgqovey3RHp5Saj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAEF21A39E;
	Sat, 27 Apr 2013 21:16:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23C711A39D;
	Sat, 27 Apr 2013 21:16:51 +0000 (UTC)
In-Reply-To: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 27
 Apr 2013 10:36:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7353B5A-AF7F-11E2-9374-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222699>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/connect.c b/connect.c
> index f57efd0..b568f10 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -551,8 +551,11 @@ struct child_process *git_connect(int fd[2], con=
st char *url_orig,
>  	path =3D strchr(end, c);
>  	if (path && !has_dos_drive_prefix(end)) {
>  		if (c =3D=3D ':') {
> -			protocol =3D PROTO_SSH;
> -			*path++ =3D '\0';
> +			if (!strchr(url, '/') || strchr(url, '/') >=3D path) {
> +				protocol =3D PROTO_SSH;
> +				*path++ =3D '\0';
> +			} else
> +				path =3D end;
>  		}

That was fairly hard to grok. Is that equivalent to this?

                if (c =3D=3D ':' && path < strchrnul(host, '/')) {
			/* is the first slash past the colon? */
                        protocol =3D PROTO_SSH;
                        *path++ =3D '\0';
                } else {
                        path =3D end;
                }
