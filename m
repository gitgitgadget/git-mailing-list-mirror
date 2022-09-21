Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF898ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 18:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiIUSrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIUSra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 14:47:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A782A285B
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 11:47:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8C6B140CC6;
        Wed, 21 Sep 2022 14:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQZylcUHonNRFpI9oKm91QF5s1+qEVRXj040RX
        Dh7PM=; b=RoUVrPslUIPGbhmvZlyXCltXcw4AwJ46pWr88np25WKiudl1UIwj17
        Yc09/zgsvusWsKL8u2jniHQ3uEmLeiXeUNK6VCCOaF5h2h/jgRdnMq06F2BA4z2S
        gvVyHSC6f9Vo7O7+k5l4gYPgBSyYANyM8QaT53o+DdoaAJQvdPUXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF3F7140CC4;
        Wed, 21 Sep 2022 14:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18611140CC3;
        Wed, 21 Sep 2022 14:47:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH v2] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
References: <xmqqleqfcoz3.fsf@gitster.g>
        <20220920031140.1220220-1-aclopte@gmail.com>
Date:   Wed, 21 Sep 2022 11:47:26 -0700
In-Reply-To: <20220920031140.1220220-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Mon, 19 Sep 2022 22:11:40 -0500")
Message-ID: <xmqqa66s36pt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D74E7B8A-39DD-11ED-9768-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> +test_expect_success 'auto squash that matches regex' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m "hay needle hay" &&
> +	git commit --allow-empty -m "fixup! :/needle" &&
> +	GIT_SEQUENCE_EDITOR="cat >tmp" git rebase --autosquash -i HEAD^^ &&
> +	sed -ne "/^[^#]/{s/[0-9a-f]\{7,\}/HASH/g;p;}" tmp >actual &&
> +	cat <<-EOF >expect &&
> +	pick HASH hay needle hay # empty
> +	fixup HASH fixup! :/needle # empty
> +	EOF
> +	test_cmp expect actual
> +'

hint: Waiting for your editor to close the file...
Successfully rebased and updated refs/heads/main.
--- expect      2022-09-21 18:45:27.617530848 +0000
+++ actual      2022-09-21 18:45:27.613530478 +0000
@@ -1,2 +1,2 @@
 pick HASH hay needle hay # empty
-fixup HASH fixup! :/needle # empty
+pick HASH fixup! :/needle # empty
not ok 11 - auto squash that matches regex

That does not look very good X-<.
