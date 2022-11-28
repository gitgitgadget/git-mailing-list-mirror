Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A58DC433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiK1Sfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiK1SfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 13:35:11 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66BB6169
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 10:34:03 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1ozix5-0008Re-F6; Mon, 28 Nov 2022 13:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:To:From:
        Subject; bh=9VsuKwamX1DpGh7OQCrZ0JkEAB90TN5viQxey52J3kM=; b=HgygjDaWZ3xVvM3lK
        U/4A+uFpXc+joeyvz3rhwkn+A3Un/q18rfcvgtd2XAl+z2g6PT21z20FTfBNaS8DoKeNaDDO5iJmH
        NzTd+Z5iUxyoddXoGg39PrfoGUUa4YiBLjQL+bkCj2+Qi+sYLfRTdn4o5loVz8ow7HE236+k4bKxQ
        HdVDTcDNmbeux0+ab6EbS1F2xgmuzWEJ6z19vDGCMcZLYHXbWhdp9jtY2oZEjNJH0XKsIWvm9/3nP
        B1jYH4pHm2qvkOZZetaBB8Ku9AvB6LsBQTeMXHkENZpiC91UPQiDOqrt1NV3emFVe1ZrZ+IjxOxZw
        FfgSnCsPBWZn1JRPw==;
Received: from [160.231.0.90] (helo=llin-psh13-dsa.dsone.3ds.com)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1ozix4-0002ql-6j; Mon, 28 Nov 2022 13:33:58 -0500
Message-ID: <43914959458ef34a0f29271afa9c9d981c2b3553.camel@gnu.org>
Subject: Re: [PATCH 1/1] Avoid multiple patterns when recipes generate one
 file
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Alexander Kanavin <alex.kanavin@gmail.com>
Date:   Mon, 28 Nov 2022 13:33:57 -0500
In-Reply-To: <221128.86mt8bkyqt.gmgdl@evledraar.gmail.com>
References: <20221127224251.2508200-1-psmith@gnu.org>
         <20221127224251.2508200-2-psmith@gnu.org>
         <221128.86mt8bkyqt.gmgdl@evledraar.gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (by Flathub.org) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2022-11-28 at 14:08 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason w=
rote:
> Whether we use eval/define or not (I just tried to avoid the
> repetition) I think referring to $(DOC_MAN[157]) here probably makes
> more sense if we're poking at these rules.
>=20
> I.e. in this case the rest of the Makefile is carrying forward what
> manpages we're generating exactly, so rather than a wildcard %.1 to
> %.xml we can narrow it down to just the %.1 files we're going to b
> generating (but maybe that's best left for later...):

I have no opinion on which is better :).

I'm not sure what the above comment is asking for though: are you going
to take over pushing this change?  Or do you want me to reroll the
commit with these changes instead?  Or are we waiting for more
opinions?

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 5e1a7f655c2..7404cead084 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -351,8 +351,12 @@ $(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
> =C2=A0manpage-base-url.xsl: manpage-base-url.xsl.in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(QUIET_GEN)sed "s|@@MAN_=
BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
> =C2=A0
> -%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(QUIET_XMLTO)$(XMLTO) -m $(MA=
NPAGE_XSL) $(XMLTO_EXTRA) man $<
> +define doc-man-tmpl
> +$$(DOC_MAN$(1)): %.$(1) : %.xml manpage-base-url.xsl $$(wildcard manpage=
*.xsl)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$$(QUIET_XMLTO)$$(XMLTO) -m $$=
(MANPAGE_XSL) $$(XMLTO_EXTRA) man $$<
> +
> +endef
> +$(eval $(foreach n,1 5 7,$(call doc-man-tmpl,$(n))))
> =C2=A0
> =C2=A0%.xml : %.txt $(ASCIIDOC_DEPS)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(QUIET_ASCIIDOC)$(TXT_TO=
_XML) -d manpage -o $@ $<

