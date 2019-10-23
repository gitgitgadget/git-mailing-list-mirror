Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4501F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbfJWP6Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 11:58:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42261 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390259AbfJWP6Y (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Oct 2019 11:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571846301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klM3DEPPteqdaM5v2SyvBIBNIzeF6FfAu7w+R8FbtGo=;
        b=Gi0OxzwPFbL33GDW0z4NOMYbzHEInXQQSwRrK1TfXufOTwpgnKEm+tlFhNkUJvVp5JQm9I
        BgirrJjHhfe/I4yH5n3CIrUYMWHvk12JrlZmUve9FnEZd5tzWi/oQWrbqJCYEHaDrZTisf
        OTJVdN0ljGwS0Mj3Tv3xR0laBNAGtOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-M98AiZz3PMqKA9dp8AUKkg-1; Wed, 23 Oct 2019 11:58:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2CFE1800D6B;
        Wed, 23 Oct 2019 15:58:17 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B40019C78;
        Wed, 23 Oct 2019 15:58:17 +0000 (UTC)
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's
 username
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20191022232847.5212-1-prarit@redhat.com>
 <20191023050206.GA29779@sigill.intra.peff.net>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <8d57a33b-0f0e-4e4b-1cd3-069ee5d7520e@redhat.com>
Date:   Wed, 23 Oct 2019 11:58:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191023050206.GA29779@sigill.intra.peff.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: M98AiZz3PMqKA9dp8AUKkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/23/19 1:02 AM, Jeff King wrote:
> On Tue, Oct 22, 2019 at 07:28:47PM -0400, Prarit Bhargava wrote:
>=20
>> In many projects the number of contributors is low enough that users kno=
w
>> each other and the full email address doesn't need to be displayed.
>> Displaying only the author's username saves a lot of columns on the scre=
en.
>> For example displaying "prarit" instead of "prarit@redhat.com" saves 11
>> columns.
>>
>> Add a "%aU"|"%au" option that outputs the author's email username.
>=20
> Like others, this seems potentially useful even if I probably wouldn't
> use it myself. Another more complicated way to think of it would be to
> give a list of domains to omit (so if 90% of the committers are
> @redhat.com, we can skip that, but the one-off contributor from another
> domain gets their fully qualified name.>
> But that's a lot more complicated. I don't mind doing the easy thing
> now, and even if we later grew the more complicated thing, I wouldn't be
> sad to still have this easy one as an option.

FWIW, I went through the exact same thought process as you did and came to =
the
same conclusion.

>=20
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb,=
 char part,
>>  =09=09strbuf_add(sb, mail, maillen);
>>  =09=09return placeholder_len;
>>  =09}
>> +=09if (part =3D=3D 'u' || part =3D=3D 'U') {=09/* username */
>> +=09=09maillen =3D strstr(s.mail_begin, "@") - s.mail_begin;
>> +=09=09strbuf_add(sb, mail, maillen);
>> +=09=09return placeholder_len;
>> +=09}
>=20
> What happens if the email doesn't have an "@"? I think you'd either end
> up printing a bunch of extra cruft (because you're not limiting the
> search for "@" to the boundaries from split_ident_line) or you'd
> crash (if there's no "@" at all, and you'd get a huge maillen).
>=20
> There's also no need to use the slower strstr() when looking for a
> single character. So perhaps:
>=20
>   const char *at =3D memchr(mail, '@', maillen);
>   if (at)
>           maillen =3D at - mail;
>   strbuf_add(sb, mail, maillen);

TBH I had assumed that the email address was RFC2822 compliant.  Thanks for=
 the
code.  I've incorporated it into v2.

>=20
>> +test_expect_success 'log pretty %an %ae %au' '
>=20
> As others noted, this could cover %aU, too (which is broken; you need to
> handle 'U' alongside 'E' and 'N' earlier in format_person_part()).

Whups.  Thanks for the pointer.  Also fixed in v2.

>=20
>> +=09git checkout -b anaeau &&
>> +=09test_commit anaeau_test anaeau_test_file &&
>> +=09git log --pretty=3D"%an" > actual &&
>> +=09git log --pretty=3D"%ae" >> actual &&
>> +=09git log --pretty=3D"%au" >> actual &&
>=20
> Maybe:
>=20
>   git log --pretty=3D"%an %ae %au"
>=20
> or
>=20
>   git log --pretty=3D"%an%n%ae%n%au"
>=20
> which is shorter and runs more efficiently?
>=20
>> +=09git log > full &&
>> +=09name=3D$(cat full | grep "^Author: " | awk -F "Author: " " { print \=
$2 } " | awk -F " <" " { print \$1 } ") &&
>> +=09email=3D$(cat full | grep "^Author: " | awk -F "<" " { print \$2 } "=
 | awk -F ">" " { print \$1 } ") &&
>> +=09username=3D$(cat full | grep "^Author: " | awk -F "<" " { print \$2 =
} " | awk -F ">" " { print \$1 } " | awk -F "@" " { print \$1 } " ) &&
>> +=09echo "${name}" > expect &&
>> +=09echo "${email}" >> expect &&
>> +=09echo "${username}" >> expect &&
>=20
> These values come from our hard-coded test setup, so it would be more
> readable to just expect those:
>=20
>   {
> =09echo "$GIT_AUTHOR_NAME" &&
> =09echo "$GIT_AUTHOR_EMAIL" &&
> =09echo "$GIT_AUTHOR_EMAIL" | sed "s/@.*//"
>   } >expect

Added to v2 (along with Brian's suggestion to test %aE, %aN, and %aL).

>=20
> For the last one, also I wouldn't be upset to see test-lib.sh do
> something like:
>=20
>   TEST_AUTHOR_USERNAME=3Dauthor
>   TEST_AUTHOR_DOMAIN=3Dexample.com
>   GIT_AUTHOR_NAME=3D$TEST_AUTHOR_USERNAME@$TEST_AUTHOR_DOMAIN

I like this suggestion a lot.  I'm incorporating into v2 as well as similar
changes for the COMMITTER fields.

P.

>=20
> to let tests like this pick out the individual values if they want.
>=20
> -Peff
>=20

