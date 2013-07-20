From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Fri, 19 Jul 2013 20:27:05 -0700
Message-ID: <7v1u6tud12.fsf@alter.siamese.dyndns.org>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
	<1374065234-870-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 05:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0NpL-0003i9-5D
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 05:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab3GTD1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 23:27:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab3GTD1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 23:27:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA67D1B13B;
	Sat, 20 Jul 2013 03:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=82MSs+zX5w8X
	+3BK/MW0PRCAvC0=; b=QseALfqyTPfdtlt3ye+ZUByzwK2hjgXYgu5HZi/YxgG1
	+UQ3V1GM/2ZfcuK9vzECzEN9cbBV74hxuHAKm8RugeFEEemATIVUrVrjfTn408Rp
	ItaAEqcB5AH5Mlfj5+G9LnwzT72NPgkCJu6VV9YJEgvRfJMSqyOKVBUphvV4Ue4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S47WRJ
	dM6BW7WrBAvG+y2h/ZoajHv5guG5sQVtTrfzgtxn5fDlqqS1LWRN4GVTtDhlN9aq
	JQtkHcz/Nam5hXwUnRr1oFXuCaAFX9OgyRkXMSayAEBbA43u+/vDVKcy/ljO1gKy
	Y0OXkwH9ykT9pnq9JOk6OKiaalA/XLoA4a+gM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC8621B13A;
	Sat, 20 Jul 2013 03:27:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF6FF1B135;
	Sat, 20 Jul 2013 03:27:06 +0000 (UTC)
In-Reply-To: <1374065234-870-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Wed, 17
 Jul 2013 19:47:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 411CA20C-F0EC-11E2-99C2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230871>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/cache.h b/cache.h
> index dd0fb33..7665e03 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1091,6 +1091,7 @@ struct extra_have_objects {
>  };
>  extern struct ref **get_remote_heads(int in, char *src_buf, size_t s=
rc_len,
>  				     struct ref **list, unsigned int flags,
> +				     struct extra_have_objects *,
>  				     struct extra_have_objects *);

When it is the sole parameter of a specific type (i.e. not "char *",
int, size_t, etc. but an application specific structure like "struct
extra_have_objects *"), it is perfectly fine (and even preferrable)
to omit the parameter name from the declaration, as it is clear what
the parameter is and means.

But when you add another of the same type, you need to give both of
them a descriptive name (e.g. the ones you use in the definition).

Otherwise, somebody who wants to write a caller cannot tell which
"struct extra_have_objects *" parameter is the extra and which one
is the shallow graft points list.
