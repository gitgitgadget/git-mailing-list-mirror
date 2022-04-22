Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C5C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiDVW7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiDVW6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:58:55 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D0289346
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 15:23:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE1A317DE86;
        Fri, 22 Apr 2022 18:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XDcKc9/M7K9+
        ZR3uago3LylqbSUVRuy6Hw5OULiqIik=; b=N57802fWCpcP/whKlKQzrvLOH8YS
        Xava3UQ/hcv5LcI9FOZRWsbRb20HEI/arJuzYU8TwdyhbQYzIzf2Xzgkv05RxXq6
        D6oBnGVjunazMduRrbMH2vWxD7VY0IUWbRR+zE35tsaOuztIfDf2nWQGmOSOru4V
        lnfmUXlF/NrV+2Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A6F1017DE84;
        Fri, 22 Apr 2022 18:23:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 311D617DE83;
        Fri, 22 Apr 2022 18:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] ci: make failure to find perforce more user
 friendly
References: <20220421225515.6316-1-carenas@gmail.com>
        <20220422013911.7646-1-carenas@gmail.com>
        <20220422013911.7646-2-carenas@gmail.com> <xmqqo80td5wj.fsf@gitster.g>
Date:   Fri, 22 Apr 2022 15:23:29 -0700
In-Reply-To: <xmqqo80td5wj.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        21 Apr 2022 22:49:16 -0700")
Message-ID: <xmqq5yn069lq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6883D5A-C28A-11EC-B558-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This may be in the "POSIX may say this but the real world may not
> work that way" territory.  As far as I can tell, "command -v" [*1*]
> and "type" [*2*] both ought to give diagnostic messages to their
> standard error stream, and they both should signal an error with
> non-zero exit status.  It may be that the shell implementation you
> have tried had "command -v" that is less noisy than "type" when
> given a command that is not installed, but I wonder if the next
> shell implementation you find has "command -v" that is as noisy and
> scary as "type", in which case this patch amounts to a no-op.
>
> I wonder if "type p4d >/dev/null 2>/dev/null" (or "command -v" with
> the same) is a more futureproof fix.

So, how about replacing it with something like this?

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

In preparation for a future change that will make perforce installation
optional in macOS, make sure that the check for it is done without
triggering scary looking errors and add a user friendly message instead.

All other existing uses of 'type <cmd>' in our shell scripts that
check the availability of a command <cmd> send both standard output
and error stream to /dev/null to squelch "<cmd> not found" diagnostic
output, but this script left the standard error stream shown.

Redirect it just like everybody else to squelch this error message that
we fully expect to see.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb..e598dc28df 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -78,14 +78,16 @@ linux-gcc-default)
 	;;
 esac
=20
-if type p4d >/dev/null && type p4 >/dev/null
+if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
 	p4d -V | grep Rev.
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
 	p4 -V | grep Rev.
+else
+	echo "WARNING: perforce wasn't installed, see above for clues why"
 fi
-if type git-lfs >/dev/null
+if type git-lfs >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
 	git-lfs version
--=20
2.36.0-184-gca3de164ba

