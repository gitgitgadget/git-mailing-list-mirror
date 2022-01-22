Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6CC433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 00:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiAVAp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 19:45:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56427 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVApZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 19:45:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B842186756;
        Fri, 21 Jan 2022 19:45:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GN7BQ1fPoDDg
        PX5HfCSl2oDAu0a4BpQG5u6Mcwy0EH0=; b=BzeAaFWUvrBCga1CDJ8FP0WMhP3y
        vPCAUGgWvSNEADNLWpZZKgykHPKXqozsqi4Wm4lGhMYaYeOqSAVrIloeH9HeF0nW
        igAyv79k3HGgcQQAfw0Tr0UgM3F1RuP3+F4PNVlWtnRRYdSw1JnshkCkreDCWR8S
        rLovMjnubTwvefQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43C20186755;
        Fri, 21 Jan 2022 19:45:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B213B186754;
        Fri, 21 Jan 2022 19:45:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
References: <YemTGQZ97vAPUPY0@pobox.com>
        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
Date:   Fri, 21 Jan 2022 16:45:21 -0800
In-Reply-To: <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 20 Jan
 2022 22:26:57 +0100")
Message-ID: <xmqqlez8d2e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94CD8E16-7B1C-11EC-B4A4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +test_expect_success REFFILES 'checkout a branch without refs/heads/* p=
refix' '
> +	git clone --no-tags . repo-odd-prefix &&
> +	(
> +		cd repo-odd-prefix &&
> +
> +		cp .git/refs/remotes/origin/HEAD .git/refs/heads/a-branch &&

I already said that I do not think we want the exact behaviour (like
"remote-tracking branches are moved when we change the local branch")
to be cast in stone like this, but we should be able to lose the
REFFILES prerequisite by using proper plumbing, e.g. these two lines

		origin=3D$(git symbolic-ref refs/remotes/origin/HEAD) &&
		git symbolic-ref refs/heads/a-branch "$origin" &&

instead of the direct manipulation of filesystem with "cp".

I am tempted to say that checking the command does not trigger
BUG(), like the attached, may be sufficient.  I do not care too
deeply either way, though.

diff --git i/t/t2018-checkout-branch.sh w/t/t2018-checkout-branch.sh
index 93be1c0eae..5dda5ad4cb 100755
--- i/t/t2018-checkout-branch.sh
+++ w/t/t2018-checkout-branch.sh
@@ -85,6 +85,19 @@ test_expect_success 'setup' '
 	git branch -m branch1
 '
=20
+test_expect_success 'checkout a branch without refs/heads/* prefix' '
+	git clone --no-tags . repo-odd-prefix &&
+	(
+		cd repo-odd-prefix &&
+
+		origin=3D$(git symbolic-ref refs/remotes/origin/HEAD) &&
+		git symbolic-ref refs/heads/a-branch "$origin" &&
+
+		git checkout -f a-branch &&
+		git checkout -f a-branch
+	)
+'
+
 test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	test_when_finished "
 		git checkout branch1 &&
