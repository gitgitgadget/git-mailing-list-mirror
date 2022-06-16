Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5069C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiFPR4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiFPR4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 13:56:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1C34D9F0
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 10:56:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 766391AF228;
        Thu, 16 Jun 2022 13:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9UMAi2JNxXri
        g8PvPnvmO4zNbEgunm0ZM7dUGj5IuD4=; b=d4J0O1PIaqjNwcblEPfPtliCIs81
        Yy0LUe3TchUcllH3NnWRdOoU+zzaUXNVgvX0sUlApuWSW7k4orY6lpOCimHm8UeQ
        N9vj2tFe3XFvSax2n9oxFM5nmWsfxSjzRCulE/B7wvAOWC16X7hVaawATlrttz8S
        lm3YYrREp1XtGt8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D7251AF227;
        Thu, 16 Jun 2022 13:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0EF311AF223;
        Thu, 16 Jun 2022 13:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] relative_url(): fix incorrect condition
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
        <220616.86k09gwx6i.gmgdl@evledraar.gmail.com>
Date:   Thu, 16 Jun 2022 10:55:57 -0700
In-Reply-To: <220616.86k09gwx6i.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 16 Jun 2022 15:09:38 +0200")
Message-ID: <xmqqr13otrv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9406DBA6-ED9D-11EC-85D4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> -	while (url) {
>> +	while (*url) {
>>  		if (starts_with_dot_dot_slash_native(url)) {
>>  			url +=3D 3;
>>  			colonsep |=3D chop_last_dir(&remoteurl, is_relative);
>
> Which I tested with this:
> =09
> 	diff --git a/remote.c b/remote.c
> 	index 9b9bbfe80ec..e049bbb791c 100644
> 	--- a/remote.c
> 	+++ b/remote.c
> 	@@ -2846,14 +2846,17 @@ char *relative_url(const char *remote_url, con=
st char *url,
> 	 	 * When the url starts with '../', remove that and the
> 	 	 * last directory in remoteurl.
> 	 	 */
> 	-	while (url) {
> 	+	while (1) {
> 	 		if (starts_with_dot_dot_slash_native(url)) {
> 	 			url +=3D 3;
> 	 			colonsep |=3D chop_last_dir(&remoteurl, is_relative);
> 	-		} else if (starts_with_dot_slash_native(url))
> 	+		} else if (starts_with_dot_slash_native(url)) {
> 	 			url +=3D 2;
> 	-		else
> 	-			break;
> 	+		} else if (!*url) {
> 	+			BUG("ran off the end of our url?");
> 	+		} else {
> 	+			break;=20
> 	+		}
> 	 	}
> 	 	strbuf_reset(&sb);
> 	 	strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
> =09
> Which will fail e.g. on this test in t3420-rebase-autostash.sh:
>
> 	+ git submodule add ./ sub
> 	BUG: remote.c:2856: ran off the end of our url?
> 	Aborted

Sorry, but I am confused.  I do not see the point of that test
before the BUG.

I agree that this loop over url is "we want to loop forever, and
stop immediately when url does not start with ../ or ./" infinite
loop, and it is better written with "while(1)".  If you do not make
any other changes that confuses me, we'll get this:

-	while (*url) {
+	while (1) {
		if (starts_with_dot_dot_slash_native(url)) {
			url +=3D 3;
			colonsep |=3D chop_last_dir(&remoteurl, is_relative);
		} else if (starts_with_dot_slash_native(url))
			url +=3D 2;
		else
			break;
	}

We know url upon entry is not NULL.  starts_with_dot_*() ends up
calling dir.c:path_match_flags() and the first thing it does is to
return if the byte is not '.'.  So the difference is whether you
leave the loop with the "while" condition, or you fail the two
starts_with_dot_*() calls and hit the "break" at the end in the
loop.

IOW, running of the end of the URL is not a BUG, is it?

