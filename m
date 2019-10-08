Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6371F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 14:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJHOnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 10:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfJHOnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 10:43:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B0820659;
        Tue,  8 Oct 2019 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570545786;
        bh=J9j+dRzFTca2mYU2ltd0V41zicLFWmh2uwtAj+Dm/IM=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=da0Y/CniqFPpfVmguGqbZonUq8rrLeXCfsgzygY3asKQqUFjobH/wJygaKEDhnXEM
         AMbe+lehTmBb2YfxRUjAZVg3GveikkMoHATtFxyUIVAnvI/wtKQH7HxZtQ6+1zqd5d
         QDVXMjrdsd2cekJXQohJOWxt62LX6acW+Pi3NtNo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c3a054d9-2646-e440-40c5-b0aecf21e690@kdbg.org>
References: <20191004213029.145027-1-sboyd@kernel.org> <c3a054d9-2646-e440-40c5-b0aecf21e690@kdbg.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] userdiff: Fix some corner cases in dts regex
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 07:43:05 -0700
Message-Id: <20191008144306.B2B0820659@mail.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting Johannes Sixt (2019-10-05 07:09:11)
> Am 04.10.19 um 23:30 schrieb Stephen Boyd:
> > While reviewing some dts diffs recently I noticed that the hunk header
> > logic was failing to find the containing node. This is because the regex
> > doesn't consider properties that may span multiple lines, i.e.
> >=20
> >       property =3D <something>,
> >                  <something_else>;
>=20
> What if the property spans more than two lines?
>=20
>         property =3D <something>,
>                    more,
>                    <something_else>;
>=20
> Can the second line "more," begin with a word, or are the angle brackets
> mandatory?

Angle brackets aren't mandatory, but it is very odd to have a property
with mixed numbers and strings because parsing becomes difficult.

>=20
> I understand that the continuation lines can begin with a word when the
> property is an expression that is distributed over a number of lines.
> Such continuation lines could be picked up as hunk headers.
>=20
> But I don't want to complicate things: The hunk header patterns do not
> have to be perfect; it is sufficient when they are helpful in a good
> majority of cases that occur in practice.
>=20
> > and it got hung up on comments inside nodes that look like the root node
> > because they start with '/*'. Add tests for these cases and update the
> > regex to find them. Maybe detecting the root node is too complicated but
> > forcing it to be a backslash with any amount of whitespace up to an open
> > bracket seemed OK. I tried to detect that a comment is in-between the
> > two parts but I wasn't happy so I just dropped it.
> >=20
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  t/t4018/dts-nodes-multiline-prop | 12 ++++++++++++
> >  t/t4018/dts-root                 |  2 +-
> >  t/t4018/dts-root-comment         |  8 ++++++++
> >  userdiff.c                       |  3 ++-
> >  4 files changed, 23 insertions(+), 2 deletions(-)
> >  create mode 100644 t/t4018/dts-nodes-multiline-prop
> >  create mode 100644 t/t4018/dts-root-comment
> >=20
> > diff --git a/t/t4018/dts-nodes-multiline-prop b/t/t4018/dts-nodes-multi=
line-prop
> > new file mode 100644
> > index 000000000000..f7b655935429
> > --- /dev/null
> > +++ b/t/t4018/dts-nodes-multiline-prop
> > @@ -0,0 +1,12 @@
> > +/ {
> > +     label_1: node1@ff00 {
> > +             RIGHT@deadf00,4000 {
> > +                     multilineprop =3D <3>,
> > +                                     <4>;
>=20
> You could insert more lines to demonstrate that "<x>," on a line by
> itself is not picked up.

Maybe I should add another test?

>=20
> > +
> > +
> > +> +                  ChangeMe =3D <0xffeedd00>;
>=20
> Sufficient distance to the incorrect candidates above. Good.
>=20
> > +             };
> > +     };
> > +};
> > diff --git a/t/t4018/dts-root b/t/t4018/dts-root
> > index 2ef9e6ffaa2c..4353b8220c91 100644
> > --- a/t/t4018/dts-root
> > +++ b/t/t4018/dts-root
> > @@ -1,4 +1,4 @@
> > -/RIGHT { /* Technically just supposed to be a slash */
> > +/ { RIGHT /* Technically just supposed to be a slash and brace */
>=20
> Do I understand correctly that the updated form, "/ {", is the common
> way to spell a root node, but "/" or "/word" are not?

Correct. A root node is '/' and the '{' opens the node. There is the
possibility of something like '/delete-node nodename;' or
'/delete-property property;', where the latter exists inside some node.
The regex would need to avoid all of those.

>=20
> >       #size-cells =3D <1>;
> > =20
> >       ChangeMe =3D <0xffeedd00>;
> > diff --git a/t/t4018/dts-root-comment b/t/t4018/dts-root-comment
> > new file mode 100644
> > index 000000000000..333a625c7007
> > --- /dev/null
> > +++ b/t/t4018/dts-root-comment
> > @@ -0,0 +1,8 @@
> > +/ { RIGHT /* Technically just supposed to be a slash and brace */
>=20
> Devil's advocate here: insert ';' or '=3D' in the comment, and the line
> would not be picked up. Does that hurt in practice?

I don't think it hurts in practice so I'd like to ignore it.

>=20
> > +     #size-cells =3D <1>;
> > +
> > +     /* This comment should be ignored */
> > +
> > +     some-property =3D <40+2>;
> > +     ChangeMe =3D <0xffeedd00>;
> > +};
> > diff --git a/userdiff.c b/userdiff.c
> > index 86e3244e15dd..651b56caec56 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -25,8 +25,9 @@ IPATTERN("ada",
> >        "|=3D>|\\.\\.|\\*\\*|:=3D|/=3D|>=3D|<=3D|<<|>>|<>"),
> >  PATTERNS("dts",
> >        "!;\n"
> > +      "!.*=3D.*\n"
>=20
> This behaves the same way as just
>=20
>         "!=3D\n"
>=20
> no?
>=20

Not exactly. Properties don't always get assigned. There are boolean
properties that can be tested for by the presence of some string with an
ending semi-colon, like 'this-is-true;'. If we just check for not equal
to a line with a semicolon and newline then we'll see boolean
properties. Should I add that as another test?

