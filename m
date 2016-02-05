From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] pack-objects: produce a stable pack when --skip is given
Date: Fri, 05 Feb 2016 10:43:57 -0800
Message-ID: <xmqq1t8rdmky.fsf@gitster.mtv.corp.google.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
	<1454662677-15137-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 19:44:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRlMX-0002r3-Bf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 19:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbcBESoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 13:44:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752509AbcBESoA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 13:44:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1FF44152B;
	Fri,  5 Feb 2016 13:43:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4DhhQ4kb6Sgv
	8UlD9apExjbV6OM=; b=Rs12PRTVnEpKLao6jSstF4LC/OvOU+WvRL9lczFI8Pk7
	nZdAfV/O+/0Hi+foEEq+a/fsT7nvc7lk3ZW0lhJsCsLLbzWCvpTEFBpBUK0BEXvw
	BKWlZkeybvA7o987fFdZ1rbG3FAgQSum92ywT8UhVG6oJeppKtUgr/n8J4lOiOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZRybU2
	hjRgAkg8H9ZsDTAsiJWJLGAsozL8QSm22D9y7/Brk+lNDfYYWsARRwWo28LS6nQn
	R8Kes5+hMFuDseUrfKvha0DKCZIA5QguKah4pzyXC6NZMjoa26QLn4xNFv/WOYcP
	EjwGNRuG/lKoz+btuExPfOcJ8CFwr/OqrKrv0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A997041523;
	Fri,  5 Feb 2016 13:43:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2201E41516;
	Fri,  5 Feb 2016 13:43:59 -0500 (EST)
In-Reply-To: <1454662677-15137-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 5 Feb
 2016 15:57:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B1622CA-CC38-11E5-8C19-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285592>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 417c830..c58a9cb 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2709,6 +2709,11 @@ int cmd_pack_objects(int argc, const char **ar=
gv, const char *prefix)
>  			if (get_oid_hex(skip_hash_hex, &skip_hash))
>  				die(_("%s is not SHA-1"), skip_hash_hex);
>  		}
> +
> +		/*
> +		 * Parallel delta search can't produce stable packs.
> +		 */
> +		delta_search_threads =3D 1;
>  	}
> =20
>  	argv_array_push(&rp, "pack-objects");

A multi-threaded packing is _one_ source of regenerating the same
pack for the same set of objects, but we shouldn't be tying our
hands by promising it will forever be the _only_ source of it by
doing things like this.  We may want to dynamically tweak the
packing behaviour depending on the load of the minute and such for
example.

This is an indication that the approach this series takes is taking
us in a wrong direction.

I think a more sensible approach for "resuming" is to attack cloning
first.  Take a reasonable baseline snapshot periodically (depending
on the activity level of the project, the interval may span between
12 hours to 2 weeks and you would want to make it configurable) to
create a bundle, teach "clone" to check the bundle first and perform
a resumable and bulk transfer for the stable part of the history
(e.g. up to the latest tag or a branch that does not rewind, the set
of refs to use as the stable anchors you would want to make
configurable), and then fill the gap between that baseline snapshot
and up-to-date state by doing another round of "git fetch" and then
you'd have solved the most serious problem already.
