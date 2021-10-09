Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FBCC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D46960F70
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 06:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhJIGqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 02:46:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50976 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhJIGqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 02:46:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC2DC147F90;
        Sat,  9 Oct 2021 02:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mRnHcWffPRmb1ft/B8Of0tGMO
        m6bOwoXQdz82L76K2k=; b=EedC53ZAc34l7eqHJMFCa0g06jqlG36o4uxxFxRgp
        zC/7DB5vPMZB4fB4Prd/FGT7u+pSXmbAiqY2xGEBokpYJr63utN0bnq6NbRWwa/z
        MCOHPteOhksu6H8F05tuyLDJ7JB7R3vRhAUE0Ph7yFAx6+Qy1Qe8e8edhR5kjBFf
        +U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8B7F147F8F;
        Sat,  9 Oct 2021 02:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 094C9147F8C;
        Sat,  9 Oct 2021 02:44:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v11 3/3] grep: fix an edge case concerning ascii
 patterns and UTF-8 data
References: <20211007203148.23888-1-someguy@effective-light.com>
        <20211007203148.23888-3-someguy@effective-light.com>
Date:   Fri, 08 Oct 2021 23:44:14 -0700
Message-ID: <xmqqlf32g0jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5247865C-28CC-11EC-BC3D-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-a=
scii.sh
> index e5d1e4ea68..42323b31c0 100755
> --- a/t/t7812-grep-icase-non-ascii.sh
> +++ b/t/t7812-grep-icase-non-ascii.sh
> @@ -53,6 +53,54 @@ test_expect_success REGEX_LOCALE 'pickaxe -i on non-=
ascii' '
> ...
> +	git add file5 &&
> +	export GIT_COMMITTER_NAME=3D"=C3=87 O M=C3=AEtter" &&
> +	export GIT_COMMITTER_EMAIL=3D"committer@example.com" &&

These lines are flagged as an error by test-lint; I've queued this
on top to make today's integration result to pass our tests.

Thanks.


 t/t7812-grep-icase-non-ascii.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asc=
ii.sh
index 42323b31c0..313d4894ad 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -72,8 +72,8 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log --committe=
r with an ascii pattern o
 	EOF
 	test_write_lines "fifth" >file5 &&
 	git add file5 &&
-	export GIT_COMMITTER_NAME=3D"=C3=87 O M=C3=AEtter" &&
-	export GIT_COMMITTER_EMAIL=3D"committer@example.com" &&
+	GIT_COMMITTER_NAME=3D"=C3=87 O M=C3=AEtter" GIT_COMMITTER_EMAIL=3D"comm=
itter@example.com" &&
+	export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
 	git -c i18n.commitEncoding=3Dlatin1 commit -m th=C3=AFrd &&
 	git -c i18n.logOutputEncoding=3Dlatin1 log -1 --pretty=3Dfuller --color=
=3Dalways --perl-regexp --committer=3D" O.*" >log &&
 	grep Commit: log >actual.raw &&
--=20
2.33.0-960-g8d902839aa

