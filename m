Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA4C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 19:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiFBTwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbiFBTwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 15:52:36 -0400
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030B1FCD1
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 12:52:33 -0700 (PDT)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 938087E744;
        Thu,  2 Jun 2022 15:51:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1654199521;
        bh=JBDFb8IPeJLyknX11hcmFubTQK+0BhlUgO58b38L5os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7Vk6sr7FBfSGur/z3e0Y3rAHA1rST8EmbW3EhzePmaJ/LmepoOg7VVDeZKKHNVd4
         hdi4gVgWyOKa0wIt8Eq7LaFwY6l+Xbb0SkkooTLUtNhROuCkWhBwkTBJBhMXzr1JcT
         vvFL1Av9lQoS2iTKf+WRjr/vr9fde/jUY2o3B1Z+/A5uaHllJFgnpF4pFDIydPVBEt
         T6UKH3EyR5H1ahXPorJzAoLjYfza5F1DhdkdgsC4wFUDhXuZxTA95KzlyZSHCNMuHl
         bUqzZ3dBZzT77wHo/nJUSbF1VkGB4Fly9J6kBs7i8MBDMPrLb4H+rLp9oU7o8uNYnp
         tl0YnILxLU6yw==
From:   Jason Yundt <jason@jasonyundt.email>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
Date:   Thu, 02 Jun 2022 15:51:38 -0400
Message-ID: <3180470.44csPzL39Z@jason-lemur-pro>
In-Reply-To: <xmqqv8tinblc.fsf@gitster.g>
References: <20220601012647.1439480-1-jason@jasonyundt.email> <20220602114305.5915-1-jason@jasonyundt.email> <xmqqv8tinblc.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, June 2, 2022 2:50:55 PM EDT Junio C Hamano wrote:
> Jason Yundt <jason@jasonyundt.email> writes:
> > Subject: Re: [PATCH v2] gitweb: switch to an XHTML5 DOCTYPE
> >=20
> > According to the HTML Standard FAQ:
> > 	=E2=80=9CWhat is the DOCTYPE for modern HTML documents?
> >=20
> > ...
> > Compared to the first version of this patch, this version:
> > 1. makes it clear that XML parsers may used the linked DTD like brian
> >=20
> >    mentioned.
> >=20
> > 2. mentions HTML5 like Bagas suggested.
>=20
> So, is it XHTML5, or HTML5, we want to see on the title?

I chose XHTML5 since I didn=E2=80=99t think that it was accurate to say =E2=
=80=9CHTML5=20
DOCTYPE=E2=80=9D. The DOCTYPE that this patch uses is valid in the XML synt=
ax, but not=20
the HTML syntax.

> > +proper_doctype() {
> > +	gitweb_run "$@" &&
> > +	grep -F "<!DOCTYPE html [" gitweb.body &&
> > +	grep "<!ENTITY nbsp" gitweb.body &&
> > +	grep "<!ENTITY sdot" gitweb.body
> > +}
>=20
> Hmph, this test does not care what other cruft appears in the file,
> does not care in what order the three lines that match the patterns
> appear, and the second and third patterns are even allowed to match
> the same line.  I think that is OK (we do not even mind if the two
> ENTITY definitions get squashed on the same line).

While I was writing this patch, I was thinking something similar. Grep is n=
ot=20
a good tool for validating (X)HTML. I thought about creating a test that us=
es=20
the Nu Html Checker [1] to validate pages that Gitweb generates, but I deci=
ded=20
that that should be the topic of a separate patch.

> > +test_expect_success 'Proper DOCTYPE with entity declarations' '
> > +	proper_doctype &&
> > +	proper_doctype "p=3D.git" &&
> > +	proper_doctype "p=3D.git;a=3Dlog" &&
> > +	proper_doctype "p=3D.git;a=3Dtree"
> > +'
>=20
> As far as I can tell, git_header_html() is the only helper that
> deals with DOCTYPE, and responses to any request must call
> git_header_html() to produce the header (or the handler for a
> particular request type is buggy), but I do not think it is part of
> this topic's job to ensure that all request handlers call the
> git_header_html().  So we _could_ do with just a single test without
> trying different request types if we wanted to, as long as there are
> existing tests that make sure everybody uses git_header_html().
>=20
> Was there a particular reason why these four requests were chosen?
> Do they have different entry points and show the doctype from
> different codepath?

Not really. When I created a262585d81 (gitweb: remove invalid http-
equiv=3D"content-type", 2022-03-08), I chose those requests by running git=
=20
instaweb and then clicking on the first four links I saw. For this patch, I=
=20
just copied what I had done previously. I don=E2=80=99t know if they use di=
fferent=20
codepaths (I don=E2=80=99t understand Perl very well).

> Thanks.

[1]: <https://validator.w3.org/nu/>



