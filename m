Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD49B1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 12:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501983AbfJXMoC (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 08:44:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729939AbfJXMoB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 08:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571921039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWYcumV2C4zAbOnZ58KYpoCN0FLffpt5lnifpvyCcew=;
        b=Mbp/Ujs1wozvBo2HPslt2eiQQR87JihBjDZWJeDv6yR18Fc4omqIHeeE2bOmYvdNghVWbi
        rPwvxwAMRnCjgP9AI3tK4pxq/eV5GrBNXhdrIC4ZaohksDM7CtTVLe9Eora5grGuysH/cO
        dAcVVV10CFYI0GwLY9SRuysd19/LKYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-CTEkeN48NCWD6fP7zZyLjw-1; Thu, 24 Oct 2019 08:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 798D41005500;
        Thu, 24 Oct 2019 12:43:55 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE0595D9CA;
        Thu, 24 Oct 2019 12:43:54 +0000 (UTC)
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's
 username
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
References: <20191022232847.5212-1-prarit@redhat.com>
 <20191022234822.f4ixqcpfytimiscn@camp.crustytoothpaste.net>
 <xmqqa79qho4v.fsf@gitster-ct.c.googlers.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <4bc612f9-0b9a-1bab-9746-15ff25bd6f5f@redhat.com>
Date:   Thu, 24 Oct 2019 08:43:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqa79qho4v.fsf@gitster-ct.c.googlers.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CTEkeN48NCWD6fP7zZyLjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/23/19 10:29 PM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
>>> +=09if (part =3D=3D 'u' || part =3D=3D 'U') {=09/* username */
>>> +=09=09maillen =3D strstr(s.mail_begin, "@") - s.mail_begin;
>>> +=09=09strbuf_add(sb, mail, maillen);
>>> +=09=09return placeholder_len;
>>> +=09}
>>
>> This branch doesn't appear to do anything different for the mailmap and
>> non-mailmap cases.  Perhaps adding an additional test that demonstrates
>> the difference would be a good idea.
>=20
> Yes, and the bug that would be exposed is the lack of call to
> mailmap.
>=20
> Perhaps along this line (I may have off-by-one or two tho)?
>=20
>  pretty.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/pretty.c b/pretty.c
> index e4ed14effe..4b76d022c6 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -696,15 +696,27 @@ static size_t format_person_part(struct strbuf *sb,=
 char part,
>  =09mail =3D s.mail_begin;
>  =09maillen =3D s.mail_end - s.mail_begin;
> =20
> -=09if (part =3D=3D 'N' || part =3D=3D 'E') /* mailmap lookup */
> +=09if (part =3D=3D 'N' || part =3D=3D 'E' || part =3D=3D 'L') /* mailmap=
 lookup */
>  =09=09mailmap_name(&mail, &maillen, &name, &namelen);
> -=09if (part =3D=3D 'n' || part =3D=3D 'N') {=09/* name */
> +
> +=09switch (part) {
> +=09case 'n': case 'N':
>  =09=09strbuf_add(sb, name, namelen);
>  =09=09return placeholder_len;
> -=09}
> -=09if (part =3D=3D 'e' || part =3D=3D 'E') {=09/* email */
> +=09case 'l': case 'L':
> +=09=09{
> +=09=09=09const char *at =3D memchr(mail, '@', maillen);
> +=09=09=09if (at) {
> +=09=09=09=09maillen -=3D at - mail + 1;
> +=09=09=09=09mail =3D at + 1;

^^^  If the mail is 'prarit@redhat.com' the output of these lines is

=09maillen =3D maillen - at - mail - 1

=09which is (16 - [6] - 1) =3D 9.
=09
=09and mail =3D at + 1 points to "redhat.com"

This is the reverse of what we want.  IMO I suggest (sorry for the
cut-and-paste) which keeps the code easy to read.

diff --git a/pretty.c b/pretty.c
index b32f0369531c..93eb6e837071 100644
--- a/pretty.c
+++ b/pretty.c
@@ -696,7 +696,7 @@ static size_t format_person_part(struct strbuf *sb, cha=
r par
t,
        mail =3D s.mail_begin;
        maillen =3D s.mail_end - s.mail_begin;

-       if (part =3D=3D 'N' || part =3D=3D 'E') /* mailmap lookup */
+       if (part =3D=3D 'N' || part =3D=3D 'E' || part =3D=3D 'L') /* mailm=
ap lookup */
                mailmap_name(&mail, &maillen, &name, &namelen);
        if (part =3D=3D 'n' || part =3D=3D 'N') {       /* name */
                strbuf_add(sb, name, namelen);
@@ -706,6 +706,13 @@ static size_t format_person_part(struct strbuf *sb, ch=
ar pa
rt,
                strbuf_add(sb, mail, maillen);
                return placeholder_len;
        }
+       if (part =3D=3D 'l' || part =3D=3D 'L') {       /* local-part */
+               const char *at =3D memchr(mail, '@', maillen);
+               if (at)
+                       maillen =3D at - mail;
+               strbuf_add(sb, mail, maillen);
+               return placeholder_len;
+       }

        if (!s.date_begin)

Let me submit a v2 with all the suggested changes so that you can review my=
 work
so far.  We can continue the discussion there.

P.

> +=09=09=09}

> +=09=09}
> +=09=09/* fall through */
> +=09case 'e': case 'E':=20
>  =09=09strbuf_add(sb, mail, maillen);
>  =09=09return placeholder_len;
> +=09default:
> +=09=09break;
>  =09}
> =20
>  =09if (!s.date_begin)
>=20

