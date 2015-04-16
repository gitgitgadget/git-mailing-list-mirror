From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 08:39:55 -0700
Message-ID: <xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:40:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yiltc-00031x-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbbDPPj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 11:39:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753303AbbDPPj5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2015 11:39:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F246E484EF;
	Thu, 16 Apr 2015 11:39:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ul3JVE4k5FOG
	zlNGTqieQXFu7+8=; b=FHOPXrrgAXb7UhUmywyuCrnJoVqPkjtNyESaQ3rkd0wp
	7HgJxo4izlRNTNSN7CCu1IVKdnN91SGRis93g1vXWKLRj35jfBL8cFengWeNJ/Zp
	mv6c69alZB3ErdB6QFG8apFtZa97J3Mjkkg4Nz45pYaoFSc66DYB3z+ApP1A7+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vYfAvZ
	LpL53JEIZLUb7pv9JtteZP7GDIN/6Lnvy+u85XPJ5MoTVSZ1ZCx6eorThVM0jf2F
	/fnS0t3yRwlAkVmIjbyLVAir+wjboAL3KRtPdECz/UXy3WIOh5jv659a9kyPcu4D
	n4HeQT9ApRuVrRaB0/oilxlRbnMk1SY9G11yM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA52D484EE;
	Thu, 16 Apr 2015 11:39:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A6FB484EA;
	Thu, 16 Apr 2015 11:39:56 -0400 (EDT)
In-Reply-To: <1429193112-41184-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Thu, 16 Apr 2015 16:05:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5431B58-E44E-11E4-9128-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267298>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> diff --git a/dir.c b/dir.c
> index 0943a81..6368247 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -581,6 +581,7 @@ int add_excludes_from_file_to_list(const char *fn=
ame,
>  	struct stat st;
>  	int fd, i, lineno =3D 1;
>  	size_t size =3D 0;
> +	static const unsigned char *utf8_bom =3D (unsigned char *) "\xef\xb=
b\xbf";
>  	char *buf, *entry;
> =20
>  	fd =3D open(fname, O_RDONLY);
> @@ -617,7 +618,12 @@ int add_excludes_from_file_to_list(const char *f=
name,
>  	}
> =20
>  	el->filebuf =3D buf;
> -	entry =3D buf;
> +
> +	if (size >=3D 3 && !memcmp(buf, utf8_bom, 3))

OK.

> +		entry =3D buf + 3;
> +	else
> +		entry =3D buf;
> +
>  	for (i =3D 0; i < size; i++) {
>  		if (buf[i] =3D=3D '\n') {
>  			if (entry !=3D buf + i && entry[0] !=3D '#') {
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index 460789b..0a06fbf 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -13,6 +13,8 @@ EOF
> =20
>  test_expect_success 'status untracked directory with --ignored' '
>  	echo "ignored" >.gitignore &&
> +	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
> +	mv .gitignore.new .gitignore &&

Is this "write literal in \xHEX on the replacement side of sed
substitution" potable?  In any case, replacing the above three with
something like:

	printf "<bom>ignored\n" >.gitignore

may be more sensible, no?

Also do we need a similar change to the attribute side, or are we
already covered and we forgot to do the same for the ignore files?


>  	mkdir untracked &&
>  	: >untracked/ignored &&
>  	: >untracked/uncommitted &&
