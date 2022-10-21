Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E39C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJUV7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJUV7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:59:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E22A935E
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:59:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 848E01C013E;
        Fri, 21 Oct 2022 17:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CApB/HkWRMBP
        /ajChfMX0sOQB0KUaT5AwEH6kYILJyE=; b=k+2+BjAqhIat2bZyPxk3tygKwUys
        f6FVKGSabRU2cG3JrgxvN4pFKhFsiBTDvBcomjg25tpPaqCz/y/ax5Pqrc7Mhjc6
        9ol1UhyAAKcf32yh5wpMPWG4Lk/rT63tsgstcRBgveSbem5XL/tHlXLZ4tC/BEcK
        cixjjJkizddG48o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CBA11C013C;
        Fri, 21 Oct 2022 17:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A80AD1C013B;
        Fri, 21 Oct 2022 17:59:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220914151333.3309-1-tboegi@web.de> <xmqqpmfx52qj.fsf@gitster.g>
        <20220926184308.5oaaoopod36igq6i@tb-raspi4>
        <xmqq35bv1gu5.fsf@gitster.g>
        <20221020154608.jndql5sio3jyii3z@tb-raspi4>
        <xmqqy1tas85w.fsf@gitster.g>
        <20221021151909.z3nejpnnt2wmmkry@tb-raspi4>
Date:   Fri, 21 Oct 2022 14:59:09 -0700
In-Reply-To: <20221021151909.z3nejpnnt2wmmkry@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 21 Oct 2022 17:19:09
 +0200")
Message-ID: <xmqq35bgkfde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97C6BFB6-518B-11ED-9C65-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> For the moment I don't have any spare time to spend on Git.
> All your comments are noted, and I hope to get time to address them lat=
er.
> If you kick out the branch from seen and the whats cooking list,
> that would be fine with me.

I'd rather not waste the efforts so far.  I am tempted to queue the
following on top or squash it in.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] diff: leave NEEDWORK notes in show_stats() function

The previous step made an attempt to correctly compute display
columns allocated and padded different parts of diffstat output.
There are at least two known codepaths in the function that still
mixes up display widths and byte length that need to be fixed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/diff.c b/diff.c
index 2751cae131..1d222d87b2 100644
--- a/diff.c
+++ b/diff.c
@@ -2675,6 +2675,11 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
 	 * making the line longer than the maximum width.
 	 */
=20
+	/*
+	 * NEEDSWORK: line_prefix is often used for "log --graph" output
+	 * and contains ANSI-colored string.  utf8_strnwidth() should be
+	 * used to correctly count the display width instead of strlen().
+	 */
 	if (options->stat_width =3D=3D -1)
 		width =3D term_columns() - strlen(line_prefix);
 	else
@@ -2750,6 +2755,16 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
 			char *slash;
 			prefix =3D "...";
 			len -=3D 3;
+			/*
+			 * NEEDSWORK: (name_len - len) counts the display
+			 * width, which would be shorter than the byte
+			 * length of the corresponding substring.
+			 * Advancing "name" by that number of bytes does
+			 * *NOT* skip over that many columns, so it is
+			 * very likely that chomping the pathname at the
+			 * slash we will find starting from "name" will
+			 * leave the resulting string still too long.
+			 */
 			name +=3D name_len - len;
 			slash =3D strchr(name, '/');
 			if (slash)
--=20
2.38.1-320-g901e6a2134

