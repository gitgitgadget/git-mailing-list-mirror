Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B2C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354130AbhLBAVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:21:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60237 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354160AbhLBAVn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:21:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE77510363E;
        Wed,  1 Dec 2021 19:18:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kY7/Sl/jvd1wyDO8ulMUqvmE6MIxQhtVW+EgUBnKALY=; b=Bn57
        94WHbca+TmdJG8YCgLnNLn6bJPa/8Mkgs1NkcVnD0XYdLz6Dg3QATpxuXuIPh8ZO
        srfgA7Lf9xD7P2vq7H1fgxtT5IfOo3NwoBcwMDtMYeefJX5MRW2sqFonA2J6M1Q5
        NHACdRF9Rb0o45du9ez7GQjBV8EMiIZrujqMq0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D4410363D;
        Wed,  1 Dec 2021 19:18:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13FAB10363C;
        Wed,  1 Dec 2021 19:18:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
References: <20211117093529.13953-1-fs@gigacodes.de>
        <20211130141112.78193-1-fs@gigacodes.de>
        <20211130141112.78193-8-fs@gigacodes.de>
Date:   Wed, 01 Dec 2021 16:18:19 -0800
Message-ID: <xmqqczmfyi44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B28F932-5305-11EC-AC60-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Do a full ssh signing, find-principals and verify operation in the test
> prereq's to make sure ssh-keygen works as expected. Only generating the
> keys and verifying its presence is not sufficient in some situations.
> One example was ssh-keygen creating unusable ssh keys in cygwin because
> of unsafe default permissions for the key files. The other a broken
> openssh 8.7 that segfaulted on any find-principals operation. This
> extended prereq check avoids future test breakages in case ssh-keygen or
> any environment behaviour changes.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---

The way keys are set-up has become much easier to follow.

This unfortunately interacts with the old way of adding a test key
done in <20211119150707.3924636-2-fs@gigacodes.de> 350a2518 (ssh
signing: support non ssh-* keytypes, 2021-11-19)

Here is my attempt (which is in 'seen') to resolve the inevitable
merge conflicts between the topics. 

Thanks.

commit fa6c2973744b419c95b5eaf6a697c795ab7823fa
Merge: 2a8505f6a0 3b4b5a793a
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Dec 1 16:01:54 2021 -0800

    Merge branch 'fs/ssh-signing-other-keytypes' into jch
    
    * fs/ssh-signing-other-keytypes:
      ssh signing: make sign/amend test more resilient
      ssh signing: support non ssh-* keytypes

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index ff944f0548..3e7ee1386a 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -117,13 +117,14 @@ test_lazy_prereq GPGSSH '
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_PRIMARY}" >/dev/null &&
 	ssh-keygen -t rsa -b 2048 -N "" -C "git rsa2048 key" -f "${GPGSSH_KEY_SECONDARY}" >/dev/null &&
 	ssh-keygen -t ed25519 -N "${GPGSSH_KEY_PASSPHRASE}" -C "git ed25519 encrypted key" -f "${GPGSSH_KEY_WITH_PASSPHRASE}" >/dev/null &&
-<<<<<<< 2a8505f6a0 (Merge branch 'fs/ssh-signing-key-lifetime' into jch)
+	ssh-keygen -t ecdsa -N "" -f "${GPGSSH_KEY_ECDSA}" >/dev/null &&
 	ssh-keygen -t ed25519 -N "" -C "git ed25519 key" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null &&
 
 	cat >"${GPGSSH_ALLOWED_SIGNERS}" <<-EOF &&
 	"principal with number 1" $(cat "${GPGSSH_KEY_PRIMARY}.pub")"
 	"principal with number 2" $(cat "${GPGSSH_KEY_SECONDARY}.pub")"
 	"principal with number 3" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")"
+	"principal with number 4" $(cat "${GPGSSH_KEY_ECDSA}.pub")"
 	EOF
 
 	# Verify if at least one key and ssh-keygen works as expected
@@ -166,15 +167,6 @@ test_lazy_prereq GPGSSH_VERIFYTIME '
 	echo "testpayload" |
 	ssh-keygen -Y sign -n "git" -f "${GPGSSH_KEY_EXPIRED}" >gpgssh_verifytime_prereq.sig &&
 	! (ssh-keygen -Y verify -n "git" -f "${GPGSSH_ALLOWED_SIGNERS}" -I "principal with expired key" -s gpgssh_verifytime_prereq.sig)
-||||||| cd3e606211
-	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
-=======
-	echo "\"principal with number 3\" $(cat "${GPGSSH_KEY_WITH_PASSPHRASE}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ecdsa -N "" -f "${GPGSSH_KEY_ECDSA}" >/dev/null
-	echo "\"principal with number 4\" $(cat "${GPGSSH_KEY_ECDSA}.pub")" >> "${GPGSSH_ALLOWED_SIGNERS}" &&
-	ssh-keygen -t ed25519 -N "" -f "${GPGSSH_KEY_UNTRUSTED}" >/dev/null
->>>>>>> 3b4b5a793a (ssh signing: make sign/amend test more resilient)
 '
 
 sanitize_pgp() {
