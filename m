Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F46C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD1961186
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhHFQ7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:59:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52600 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhHFQ7x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:59:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC9FD1487F8;
        Fri,  6 Aug 2021 12:59:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lxwE555GPN8Q
        sy+6ojFAmAu+dFkYYDk7DEDHk1zndls=; b=ZXJNPuiB/Rj2gEesFIPxOR2lVw4V
        qIpjVvShCscvlp0Tv9ygJp2QnXehzuACjHYCYY22VUKBUR+64jLmMazuo7g+/rDB
        xzvwCwjfmZ/pzmMO+BLq26BpVlIRO29UAHcxjPU+aQp+H+mIhm1YmbnY4ZXrcFcC
        P9SJ1CHrE9//Dco=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4C1B1487F7;
        Fri,  6 Aug 2021 12:59:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C33E1487F5;
        Fri,  6 Aug 2021 12:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        ZheNing Hu <adlternative@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] test: fix for COLUMNS and bash 5
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
        <20210806144911.GA1388237@szeder.dev>
Date:   Fri, 06 Aug 2021 09:59:33 -0700
In-Reply-To: <20210806144911.GA1388237@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Fri, 6 Aug 2021 16:49:11 +0200")
Message-ID: <xmqqmtpuik5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AD5E5754-F6D7-11EB-A368-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> @@ -419,6 +419,12 @@ COLUMNS=3D80
>
> COLUMNS is set just before the start of the hunk context ...
>
>>  export LANG LC_ALL PAGER TZ COLUMNS
>>  EDITOR=3D:
>
> ... so these two "commands" above are executed while COLUMNS is
> already set but checkwinsize is not yet disabled.  The reason I put
> quotes around that commands is that while exporting and setting
> variables are indeed commands as defined in the POSIX Shell Command
> Language specs, Bash with checkwinsize enabled only "checks the window
> size after each extern (non-builtin) command" (quoting 'man bash').
>
> So even though it is safe to execute these variable setting and
> exporting commands after setting COLUMNS but disabling checkwinsize, I
> think it would be prudent to disable checkwinsize before initializing
> COLUMNS.  (And perhaps adding "non-builtin" to the comment below.)

OK.  I tend to agree that a less invasive solution like this is
preferred over adding new code to only help tests in the everyday
binary, especially this close to the final.  Taking the above, I'd
queue this and hopefully I can merge it by -rc2 at the latest.

---- >8 ------- >8 ------- >8 ------- >8 ------- >8 ------- >8 ----
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Thu, 5 Aug 2021 14:48:25 -0500
Subject: [PATCH] test: fix for COLUMNS and bash 5

Since c49a177bec (test-lib.sh: set COLUMNS=3D80 for --verbose
repeatability, 2021-06-29) multiple tests have been failing when using
bash 5 because checkwinsize is enabled by default, therefore COLUMNS is
reset using TIOCGWINSZ even for non-interactive shells.

It's debatable whether or not bash should even be doing that, but for
now we can avoid this undesirable behavior by disabling this option.

Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
[jc: with SZEDER G=C3=A1bor's suggestion to do this before setting COLUMN=
S]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4d4439a917..52701afaea 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -395,6 +395,12 @@ then
 	verbose=3Dt
 fi
=20
+# Since bash 5.0, checkwinsize is enabled by default which does
+# update the COLUMNS variable every time a non-builtin command
+# completes, even for non-interactive shells.
+# Disable that since we are aiming for repeatability.
+test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
+
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
 LANG=3DC
--=20
2.33.0-rc0-215-ge3efc65752

