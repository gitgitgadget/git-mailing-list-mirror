From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] count-objects: report garbage files in
 .git/objects/pack directory too
Date: Mon, 04 Feb 2013 10:16:23 -0800
Message-ID: <7v1ucw2bd4.fsf@alter.siamese.dyndns.org>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1359982145-10792-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Qb5-0002F2-Jr
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 19:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab3BDSQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2013 13:16:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab3BDSQ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 13:16:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BBA9DB98;
	Mon,  4 Feb 2013 13:16:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wxmLQL9nFsMx
	UWDzM+lnLqY6Vb0=; b=XgwRw8QZJXaJqhhlzcAI7wf6BLZmYlKvvMjwCA35g+JH
	4Q/ocOkguopRrAKZ86QjZRvb199TFuGD8KChOBcwhfj7tbq6UB5nQlpNWf7MUrkG
	mvMcSo2zOGXspCx4Hm4Jo51lpi5fGcZAVqi2dbEPfl7wMmxSVgN4qWe2m4n5lNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LI0l0y
	d4H24u2ngY++87D+ub06zvzlOUA/t4Juy+j+NZpHRgUo37O3A9WUhLV3lyArC1MH
	2fs0XO7HO0LFf18D3YqOO0nEx4g1j1zEZESFHpdy/z6foPpp+r4lfDFkm7OrN9Yr
	aJlUjZsTO4w/EMniSNOpIgeg0fWK+c/+mUPWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F81ADB97;
	Mon,  4 Feb 2013 13:16:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 017C6DB94; Mon,  4 Feb 2013
 13:16:24 -0500 (EST)
In-Reply-To: <1359982145-10792-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 4 Feb
 2013 19:49:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC66BB4C-6EF6-11E2-BE18-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215403>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -1024,11 +1035,15 @@ static void prepare_packed_git_one(char *objd=
ir, int local)
>  		int namelen =3D strlen(de->d_name);
>  		struct packed_git *p;
> =20
> -		if (!has_extension(de->d_name, ".idx"))
> +		if (!has_extension(de->d_name, ".idx")) {
> +			report_pack_garbage(path, len - 1, de->d_name);
>  			continue;
> +		}
> =20
> -		if (len + namelen + 1 > sizeof(path))
> +		if (len + namelen + 1 > sizeof(path)) {
> +			report_pack_garbage(path, len - 1, de->d_name);
>  			continue;
> +		}
> =20
>  		/* Don't reopen a pack we already have. */
>  		strcpy(path + len, de->d_name);
> @@ -1042,8 +1057,10 @@ static void prepare_packed_git_one(char *objdi=
r, int local)
>  		 * .pack file that we can map.
>  		 */
>  		p =3D add_packed_git(path, len + namelen, local);
> -		if (!p)
> +		if (!p) {
> +			report_pack_garbage(path, len - 1, de->d_name);
>  			continue;
> +		}
>  		install_packed_git(p);
>  	}
>  	closedir(dir);

I forgot to mention one more thing.  Your report_pack_garbage()
special cases ".pack" to see if it is a regular file, but this loop
structure causes a regular file whose name ends with ".pack" but
without corresponding ".idx" file to go unreported.

I think the loop should be restructured to iterate over all known
file types and report unknown ones, if you want to repurpose it for
the reporting, something along this line, perhaps:

	for (each name) {
		if (does it end with ".idx") {
			if (is it unusable ".idx") {
				report garbage;
			}
                        continue;
		}
		if (! we are in report mode)
			continue;
		if (does it end with ".pack") {
			if (!have we seen corresponding ".idx")
				remember it;
			continue;
		}
		report garbage;
	}
	for (remembered pack) {
		if (does it have corresponding ".idx" &&
			is it really usable ".pack")
			continue;
		report garbage;
	}
