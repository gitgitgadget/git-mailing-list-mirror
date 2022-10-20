Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBEC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 16:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiJTQNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJTQNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 12:13:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046A188100
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 09:13:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75D5D1B504E;
        Thu, 20 Oct 2022 12:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z3qCeVNWXyP70qjgRc8nf2Rx0tYZIUbnUrkfqy
        0oZw0=; b=pNln3lMShC2aJY4Hwn3pym5n4Gt8EyDFEzNB15KjufPJftyBvCAF9Q
        UDnjitc43aZESimDhPPD5YkECRxDgh9xDjE1YzeBiREj0seI3+0GhdXKz36TrdVi
        xAUHKkaW2zeFcHKFt/uSF87bsUR7DyeZbnnJV6pdkOAodoxDUpmYc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D2BF1B504C;
        Thu, 20 Oct 2022 12:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 993051B5049;
        Thu, 20 Oct 2022 12:13:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqo7u9wyt7.fsf@gitster.g>
Date:   Thu, 20 Oct 2022 09:13:02 -0700
In-Reply-To: <xmqqo7u9wyt7.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        17 Oct 2022 21:17:08 -0700")
Message-ID: <xmqq8rlamq29.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 133AFBEE-5092-11ED-9AB1-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Possible action items:
>
>  * See what configurations our two macOS jobs are using.  If neither
>    is using sha1dc, I would say that is criminal [*] and at least
>    one of them should be updated to do so right away.

So here is my "panda-see-panda-do" attempt.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH] ci: use DC_SHA1=1 on osx-clang job for CI

All other jobs were using the default DC_SHA1 (which is a
recommended practice), but the default for macOS jobs being Apple's
common crypt, we didn't catch recent breakage soon enough.

We may want to give similar diversity for Linux jobs so that some of
them build with other implementations of SHA-1, but let's start
small and fill only the immediate need.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 1b0cc2b57d..5a115704cb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -259,6 +259,8 @@ macos-latest)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
+		MAKEFLAGS="$MAKEFLAGS NO_APPLE_COMMON_CRYPTO=NoThanks"
+		MAKEFLAGS="$MAKEFLAGS DC_SHA1=1 NO_OPENSSL=1"
 	fi
 	;;
 esac
-- 
2.38.1-267-g82836053dd

