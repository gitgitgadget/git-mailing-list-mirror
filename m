Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D32C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 22:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiCGWus (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiCGWuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 17:50:46 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF8A6F485
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 14:49:51 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id 76AE27F270;
        Mon,  7 Mar 2022 17:49:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646693389;
        bh=SKL8o6syiNZAERZ6Gqci/mPKR3bpoLdGBHG+PkBD2Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZ50wVv2dCnQZoV9RJEFHzvhm19lm1l2TpEpsNEJJ/LvmdP9pgag8pVpZvRMZAcMa
         O49hVkuttdbKfuVFVeENDM/U7WPG5cl8zHRe8i3ulQ17Q2M903CO/0LljKxxRg/K4j
         cruF7Jt6d3K6mOhVX0wbb/z5e1FS4k1HczIfGHbmDZPeZhXIFqflkYSH6vKpY6Xep6
         v0hxznzZwpw1Pt9/2uBp9kkSSgCIxw8Mm4LK5khSb0xymcM1aW1IxRfeM161nVV/8n
         bgVOjq/z5MKySj8HYtCyz5/34jDtwqwQ7HoaQs/b0hs34OaNywpmlth5jWEaQvfUdA
         jQE6EG0Ppv5tw==
From:   Jason Yundt <jason@jasonyundt.email>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitweb: remove invalid http-equiv="content-type"
Date:   Mon, 07 Mar 2022 17:49:48 -0500
Message-ID: <109813056.nniJfEyVGO@jason-desktop-linux>
In-Reply-To: <220307.861qze0wv9.gmgdl@evledraar.gmail.com>
References: <20220307033723.175553-1-jason@jasonyundt.email> <20220307033723.175553-3-jason@jasonyundt.email> <220307.861qze0wv9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, March 7, 2022 7:23:49 AM EST =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son wrote:
> I'm not sure I understand this change really. The result in always XML,
> so application/xhtml+xml is redundant, text/html, or both?

To be honest, using an http-equiv=3D"content-type" in XHTML is confusing. W=
hen=20
you do use one, your goal shouldn=E2=80=99t really be to specify the docume=
nt=E2=80=99s MIME=20
type. After all, the first three lines of each page say

	<?xml version=3D"1.0" encoding=3D"utf-8"?>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.or=
g/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns=3D"http://www.w3.org/1999/xhtml" xml:lang=3D"en-US" lang=3D"en=
=2DUS">

Those lines are more than enough to determine that something is using XHTML=
=20
and UTF-8. Instead, the idea is to help out a parser that is incorrectly=20
parsing the document as HTML (instead of as XHTML). Historical W3C document=
s =20
(that were applicable when http-equiv=3D"content-type" was allowed in XHTML=
) [1]
[2][3] indicate that http-equiv=3D"content-type" should be used like this:

	<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8"/>

In other words, to use http-equiv=3D"content-type" properly in XHTML, you h=
ad to=20
lie about the document=E2=80=99s type. The fact that this is confusing is p=
robably=20
part of why WHATWG disallowed it in the HTML Standard.

> But aside from that: I have seen browsers get the lack of encoding=3D""
> "wrong" with data at rest, don't some still default to ISO-8859-1?
>=20
> So won't this result in badly decoded data if you save the web page &
> view it locally?

I tested this idea in ungoogled-chromium, Firefox and Pale Moon. Other than=
=20
Pale Moon in one specific circumstance, they all used UTF-8 as the encoding=
=2E=20
Pale Moon used windows-1252, but only when the file ended with .html. When =
the=20
file ended with .xhtml, Pale Moon used UTF-8. That being said, we don=E2=80=
=99t have to=20
use an http-equiv=3D"content-type" to fix the problem. Instead, we can use =
a=20
<meta charset=3D"utf-8"> which is allowed by the HTML Standard [4].

[1]: <https://www.w3.org/TR/xhtml1/#C_9>
[2]: <https://www.w3.org/TR/html-polyglot/#character-encoding>
[3]: <https://www.w3.org/Bugs/Public/show_bug.cgi?id=3D21818>

[4]: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-chars=
et>



