From: Plamen Totev <plamen.totev@abv.bg>
Subject: Re: [PATCH v2 7/9] grep/pcre: support utf-8
Date: Sat, 11 Jul 2015 11:07:25 +0300 (EEST)
Message-ID: <1115951657.770231.1436602045776.JavaMail.apache@nm32.abv.bg>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com> <1436351919-2520-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 10:07:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDpou-0005eH-Aa
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 10:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbbGKIHb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jul 2015 04:07:31 -0400
Received: from smtp-out.abv.bg ([194.153.145.99]:60870 "EHLO smtp-out.abv.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbbGKIHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 04:07:31 -0400
Received: from nm32.abv.bg (nm32.ni.bg [192.168.151.8])
	by smtp-out.abv.bg (Postfix) with ESMTP id A4BCC14EC55;
	Sat, 11 Jul 2015 11:07:25 +0300 (EEST)
DomainKey-Signature: a=rsa-sha1; s=smtp-out; d=abv.bg; c=simple; q=dns;
	b=F3O5xMt2Y+epbSBWA0awItX4EEPxfplwilMmexuEWjhxSQMPWK14DkKRHwPhMX82f
	Sr2wPTZHByFDIyeSh3YHUGnwvv41NU6XvR5iM8n8vTtlalQar/BzpXl+r/RU5GinKF5
	XnjYbJkoxJhydd3D/CsIT0zmEg+7KCKRfdTb8uM=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=abv.bg; s=smtp-out;
	t=1436602045; bh=qgs1wKgormIk0OjVcWZvwDgI1mYdOxlw3qMKLeOI2xM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM; b=Qw/26r
	3GCVFvkwKd5QehrI3T0gXv/5hC1ph/GUfRxz/KAxDHhy5TYQWKyAgriQkYdkJqRyJVc
	uZwplMUaczeH6yV66CbptkI1psPXGkn8Q7wSCOFM1A7ci5v7tXSlgYsnl8p/BOfsB9N
	OBIDEsMN/3M+QWmWlZVf6bmJi6Z4WXg=
Received: from nm32.abv.bg (localhost.localdomain [127.0.0.1])
	by nm32.abv.bg (Postfix) with ESMTP id BE34122A02C;
	Sat, 11 Jul 2015 11:07:25 +0300 (EEST)
In-Reply-To: <1436351919-2520-8-git-send-email-pclouds@gmail.com>
X-Mailer: AbvMail 3.0
X-Originating-IP: 95.111.52.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273867>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=C2=A0writ=
es:
> In the previous change in this function, we add locale support for=20
> single-byte encodings only. It looks like pcre only supports utf-* as=
=20
> multibyte encodings, the others are left in the cold (which is=20
> fine). We need to enable PCRE_UTF8 so pcre can parse the string=20
> correctly before folding case.=20

> if (opt->ignore_case) {=20
> p->pcre_tables =3D pcre_maketables();=20
> +	if (is_utf8_locale())=20
> +	options |=3D PCRE_UTF8;=20
> options |=3D PCRE_CASELESS;=20
> }=20

We need to set the PCRE_UTF8 flag in all cases when the locale is UTF-8
not only when the search is case insensitive.
Otherwise pcre threats the encoding as single byte and if the regex con=
tains
quantifiers it will not work as expected. The quantifier will try to ma=
tch the
second byte of the multi-byte symbol instead of the whole symbol.

=46or example lets have file that contains the string

TILRAUN: HALL=C3=93=C3=93=C3=93 HEIMUR!

the following command

git grep -P "HALL=C3=93{3}"

will not match the file while=C2=A0

git grep -P "HAL{2}=C3=93=C3=93=C3=93"

will. That's because the L symbol is a single byte.

Regards,
Plamen Totev
