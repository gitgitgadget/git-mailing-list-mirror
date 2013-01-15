From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Tue, 15 Jan 2013 11:29:16 -0800
Message-ID: <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:29:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvCCb-0000R2-7p
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab3AOT3U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 14:29:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098Ab3AOT3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 14:29:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7BCFAA00;
	Tue, 15 Jan 2013 14:29:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=56ZKWgTlJvOv
	XuIpxttkELh7xxU=; b=VVD75mH3Q9IdOvRp2pqgofXuHhmhwDU6TLhV6OSgU0x2
	P55QHd2J5sgm0PswXBjygVO1OWUHzJm4MAe1MT4HFAyCcVlmcnNPIZ3tr0tBiFXM
	OVZgoVeyYzI36wj0zmhm6U1HiQ40OmSbTm7nUd9y87gGeOGV9k9SeIetd3Dh6wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=idxTla
	KhHAnTS0oAOu/kVUIRuipp+BG62fx50dwDeWfuquOZtDT+HVEcmlKHPp5FIME02X
	iGXcywX19USEw6WmAolE4kO4G40CbBYc13P+86074ZrqUaxe4RiNSUmEKWEISRp4
	+J2sl/lvMhuA954S/L6HmNq+j0ntGe7iDnNjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABBDFA9FF;
	Tue, 15 Jan 2013 14:29:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1383AA9FD; Tue, 15 Jan 2013
 14:29:18 -0500 (EST)
In-Reply-To: <201301152014.28433.avila.jn@gmail.com> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Tue, 15 Jan 2013 20:14:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB4A5FB6-5F49-11E2-9AF1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213665>

"Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:

> Thank you for the explanation.
>
> I did not monitor the system calls when writing that patch.=20
> Where is the perf framework?
>
> As the mistake is located in the "find_basename" function, I would pr=
opose a=20
> fix directly into it so that the output fits what the other functions=
 expect.

Isn't that a crazy semantics for the function, though?  I would
expect find_basename("/a/path/to/file") to return "file", not
"/file".

>
> Something in the line of:
>
> diff --git a/attr.c b/attr.c
> index d6d7190..b6e72f3 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -572,7 +572,7 @@ static const char *find_basename(const char *path=
)
>                 if (*cp =3D=3D '/' && cp[1])
>                         last_slash =3D cp;
>         }
> -       return last_slash ? last_slash + 1 : path;
> +       return last_slash ? last_slash : path;
>  }
> =20
>  static void prepare_attr_stack(const char *path)
> @@ -770,6 +770,10 @@ static void collect_all_attrs(const char *path)
>                 check_all_attr[i].value =3D ATTR__UNKNOWN;
> =20
>         basename =3D find_basename(path);
> +       /* the slash is included in the basename
> +          so that it can be matched by a directory pattern */
> +       if (basename !=3D path)
> +               basename++;
>         pathlen =3D strlen(path);
>         rem =3D attr_nr;
>         for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
