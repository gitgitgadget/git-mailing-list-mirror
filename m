Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1926CC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347662AbiCHOzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiCHOzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:55:19 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855C24D273
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:54:22 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 927137E74B;
        Tue,  8 Mar 2022 09:54:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646751261;
        bh=hgQgdzxUzcQvyhpiiOmRivScyuqY5bMRRQAXknoV+Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOVr7m1EFwp38wV5Zu/byET0tVukS+9+vn1SFZXfLKZ644c2xk0DPlf2fgQiTIgsZ
         LS++RJlOOJCetXiPiU51ZXftoP0K4UoQGvbMrDeN92MuIaYw38YjY9Sutrirx3VdRl
         1Uh0wlHbt66iBdcun+LaI+FiJmVizc+25iBJtbBuMO8ewn0RXoWdRJf40mHndpdNVF
         pmQpeZl/FvdSJ/3rB4ZRalX6PdBzMHjvKgNfnSAEuKjnD3xRQNh02s6gUGGW7x0B7C
         EhuMWvAgN0uO2WIAh0qfL0oHsgFoYjUltREkIF+IivXOT4OWi1jXLwInxRMwJP/4xS
         Hw5IEsqYwu3aQ==
From:   Jason Yundt <jason@jasonyundt.email>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] gitweb: remove invalid http-equiv="content-type"
Date:   Tue, 08 Mar 2022 09:54:21 -0500
Message-ID: <4175455.ejJDZkT8p0@jason-desktop-linux>
In-Reply-To: <220308.86cziwy595.gmgdl@evledraar.gmail.com>
References: <20220307033723.175553-1-jason@jasonyundt.email> <Yia2Y2zoOjvVdJ9O@camp.crustytoothpaste.net> <220308.86cziwy595.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, March 8, 2022 7:44:35 AM EST =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason wrote:
> Maybe I still don't understand this, but the commit message seems to me
> be conflating whether we send the *right* http-equiv with whether we
> send it at all,

The intent behind the commit message is to say that <meta
http-equiv=3D"content-type" =E2=80=A6> is never correct in XHTML.

> i.e. if the problem is that XML documents shouldn't be
> text/html isn't this correct?:
> =09
> 	diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> 	index fbd1c20a232..c1c5af0b197 100755
> 	--- a/gitweb/gitweb.perl
> 	+++ b/gitweb/gitweb.perl
> 	@@ -4049,7 +4049,13 @@ sub get_page_title {
> 	 	return $title;
> 	 }
> 	=20
> 	+sub get_content_type_xml {
> 	+	return 'application/xhtml+xml';
> 	+}
> 	+
> 	 sub get_content_type_html {
> 	+	my ($want_xml) =3D @_;
> 	+
> 	 	# require explicit support from the UA if we are to send the page as
> 	 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
> 	 	# we have to do this because MSIE sometimes globs '*/*', pretending to
> 	@@ -4057,7 +4063,7 @@ sub get_content_type_html {
> 	 	if (defined $cgi->http('HTTP_ACCEPT') &&
> 	 	    $cgi->http('HTTP_ACCEPT') =3D~ m/(,|;|\s|^)application\/xhtml\+xml=
(,|;|\s|$)/ &&
> 	 	    $cgi->Accept('application/xhtml+xml') !=3D 0) {
> 	-		return 'application/xhtml+xml';
> 	+		return get_content_type_html();

I=E2=80=99m guessing that you meant to call get_content_type_xml() here.

> 	 	} else {
> 	 		return 'text/html';
> 	 	}
> 	@@ -4214,6 +4220,7 @@ sub git_header_html {
> 	=20
> 	 	my $title =3D get_page_title();
> 	 	my $content_type =3D get_content_type_html();
> 	+	my $content_type_xml =3D get_content_type_html();

I=E2=80=99m also guessing that you meant to call get_content_type_xml() her=
e.

> 	 	print $cgi->header(-type=3D>$content_type, -charset =3D> 'utf-8',
> 	 	                   -status=3D> $status, -expires =3D> $expires)
> 	 		unless ($opts{'-no_http_header'});
> 	@@ -4225,7 +4232,7 @@ sub git_header_html {
> 	 <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <ka=
y.sievers\@vrfy.org>, Christian Gierke -->
> 	 <!-- git core binaries version $git_version -->
> 	 <head>
> 	-<meta http-equiv=3D"content-type" content=3D"$content_type; charset=3Du=
tf-8"/>
> 	+<meta http-equiv=3D"content-type" content=3D"$content_type_xml; charset=
=3Dutf-8"/>
> 	 <meta name=3D"generator" content=3D"gitweb/$version git/$git_version$mo=
d_perl_version"/>
> 	 <meta name=3D"robots" content=3D"index, nofollow"/>
> 	 <title>$title</title>

With those assumptions in mind, I don=E2=80=99t think that your code is cor=
rect if
the problem is that XML documents shouldn't be text/html. Here=E2=80=99s wh=
y:

1. XML documents shouldn=E2=80=99t contain http-equiv=3D"content-type" [1].
2. When a meta=E2=80=99s http-equiv attribute equals content-type, then its=
 content
    attribute should equal =E2=80=9Cthe literal string "text/html;", option=
ally
    followed by any number of ASCII whitespace, followed by the literal
    string "charset=3Dutf-8".=E2=80=9D [1]

[1]: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-=
equiv-content-type>



