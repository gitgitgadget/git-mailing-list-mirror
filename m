Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD154C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhK2V6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:58:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60822 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhK2V4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:56:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B67616E907;
        Mon, 29 Nov 2021 16:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=H4jDdxdlBnlP
        BPFyBqg4UN07xnhHchdCfWbqT94100g=; b=bUphvz3QMCMXO/eRkGO13s+lDiyP
        vI770FTQhiiqFQYh/DPjrqYCxXwNVnOohtEQS5XnzDPxiQwhu9dkkB6CMGHfEeNV
        rDsd0KvCB6slKUiV0BEp6uBQkEduq82AQGbi0vuQdyIu93eDPTW1qxYGyR8csvfG
        ffgUOaMFAl3YyPU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93B6C16E906;
        Mon, 29 Nov 2021 16:52:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2D1516E901;
        Mon, 29 Nov 2021 16:52:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/7] grep tests: add missing "grep.patternType"
 config test
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
        <patch-v3-3.7-fcad1b1664b-20211129T143956Z-avarab@gmail.com>
Date:   Mon, 29 Nov 2021 13:52:37 -0800
In-Reply-To: <patch-v3-3.7-fcad1b1664b-20211129T143956Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 29 Nov
 2021 15:50:49
        +0100")
Message-ID: <xmqqbl22634q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB7C7100-515E-11EC-B7D2-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the grep tests to assert that setting
> "grep.patternType=3Dextended" followed by "grep.patternType=3Ddefault"
> will behave as if "--extended-regexp" was provided, and not as
> "--basic-regexp".

grep.patternType is the usual "last-one wins".  If the last value
set to patternType is the default, the setting to grep.extendedRegexp
should take effect (so if it is set to true, we'd see ERE behavour).

Back in the days when the "return to the default matching behavior"
part was written in 84befcd0 (grep: add a grep.patternType
configuration setting, 2012-08-03), grep.extendedRegexp was the only
way to configure the behaviour since b22520a3 (grep: allow -E and -n
to be turned on by default via configuration, 2011-03-30).  It was
understandable that we referred to the behaviour that honors the
older configuration variable as "the default matching" behaviour.
It is fairly clear in its log message:

    When grep.patternType is set to a value other than "default", the
    grep.extendedRegexp setting is ignored. The value of "default" restor=
es
    the current default behavior, including the grep.extendedRegexp
    behavior.

So, unless your description is a typo, I am somewhat surprised by
your findings that =3Ddefault that comes later does not defeat an
earlier =3Dextended.

It should just clear that earlier extended set by grep.patternType
and only pay attention to grep.extendedRegexp variable.  Doing
anything else is a bug, I think.

Thanks.

diff --git i/Documentation/config/grep.txt w/Documentation/config/grep.tx=
t
index 44abe45a7c..95fcb3ca29 100644
--- i/Documentation/config/grep.txt
+++ w/Documentation/config/grep.txt
@@ -8,7 +8,8 @@ grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended'=
,
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp=
`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
+	value 'default' will return to the default matching behavior, which is,
+	to honor `grep.extendedRegexp` option and choose either basic or extend=
ed.
=20
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This

