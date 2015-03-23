From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/apply.c: fix a memleak (Fixup, squashable)
Date: Mon, 23 Mar 2015 10:27:13 -0700
Message-ID: <xmqqwq27aaku.fsf@gitster.dls.corp.google.com>
References: <xmqqsiczau9p.fsf@gitster.dls.corp.google.com>
	<1427130811-21222-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 18:27:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya68I-0000KX-Sx
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 18:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbbCWR1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 13:27:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753015AbbCWR1Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 13:27:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B6A83ED4C;
	Mon, 23 Mar 2015 13:27:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4ZkUZTdIeMVZ
	o+ktlmEgyVFvr3E=; b=pB5mlid6wDbHeHwAj9MudlW0yTzoIA+8OZfIGylhY5um
	dqBPKeAysTu+Vr0dKtXMahBFNh4MRq09bRALEPzOaADeSYWQme3a77TJRlREurdi
	fiOwLh48zdYzLt4oxVH70giknJ6Y6Wq4MxLYcrky1Q9ijlE4zexNErBbJdgc79U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rGNKgA
	V/J0iekLpQOUcm13Pcqzhz2yIhptuUijDrCvqYUfIuZkHGTGlL8Htaw5LyjAkOWj
	4Jtfc2rGP9nNzhV9p6eS3ekRQorx/iSM8kFYRfn5Igiy5Sj0zIGnBb00nIAcWAO9
	Smnqeqy6KX2Oa+PTPdhooqKubFh5DEvYlfiyQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93FB03ED4A;
	Mon, 23 Mar 2015 13:27:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA8F03ED49;
	Mon, 23 Mar 2015 13:27:14 -0400 (EDT)
In-Reply-To: <1427130811-21222-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 23 Mar 2015 10:13:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8F7E59C-D181-11E4-9EDF-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266151>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>> By the way, aren't the following also leaking here?
>>
>> =C2=A0- the strbuf newlines that starts out as "size"
>> =C2=A0- line[] arrays of preimage and postimage
>>
>
> yes :(
>
> I think a viable replacement may be below.

Yeah, that looks a lot more sensible and straight-forward.

Thanks.

> That way the returned value of the function is not -1, but 1.
> We're using the return value only as a boolean, so it doesn't
> really matter.
>
>  builtin/apply.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =20
> diff --git a/builtin/apply.c b/builtin/apply.c
> index e152c4d..0769b09 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -2776,8 +2776,8 @@ static int apply_one_fragment(struct image *img=
, struct fragment *frag,
>  		default:
>  			if (apply_verbosely)
>  				error(_("invalid start of line: '%c'"), first);
> -			free(oldlines);
> -			return -1;
> +			applied_pos =3D -1;
> +			goto out;
>  		}
>  		if (added_blank_line) {
>  			if (!new_blank_lines_at_end)
> @@ -2916,6 +2916,7 @@ static int apply_one_fragment(struct image *img=
, struct fragment *frag,
>  			      (int)(old - oldlines), oldlines);
>  	}
> =20
> +out:
>  	free(oldlines);
>  	strbuf_release(&newlines);
>  	free(preimage.line_allocated);
