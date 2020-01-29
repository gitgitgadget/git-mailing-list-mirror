Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E6C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 06:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098C72070E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 06:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YFJD6Rzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgA2G5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:57:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63831 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgA2G5X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 01:57:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95FB3B44B8;
        Wed, 29 Jan 2020 01:57:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eCgeBS3AWv0xM5EEvPXq4s1OH68=; b=YFJD6R
        zoDEV7xkdi20/5cY3YsDEMMO1oafO/wecMM97yZfR4sjO5nVT8/eHftYiSqhyZNX
        gV9pGE3n4uzj4k6nhvlORi09p9tANHLPFgFcrwsJKwxa9WMRaS93LLmba6G+vznW
        FE6THAHgxDWWCFB+ZbeAIjucNuAr3Q5xOq7AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ItQeTHZvNpKJFXYMOtKkTfFOwNd+KCqq
        KJFNsYQSO6BB+siW3HDOzJ3UPxSRtNZc86NuzbxPN4njRmOWWCwN+OrSkV2iTEY6
        OeYimiKV5ONOfRrgwrE7i0PAY6+Ofw+H3axdAeOUOvOrAPP2E6+WoeHhCORTK3n4
        fXefTpvKB5A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71A60B44B6;
        Wed, 29 Jan 2020 01:57:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 917E5B44B5;
        Wed, 29 Jan 2020 01:57:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v3 6/6] remote rename/remove: gently handle remote.pushDefault config
References: <965b587f5834c88532476b56da95ead605d16000.1580110970.git.bert.wesarg@googlemail.com>
Date:   Tue, 28 Jan 2020 22:57:16 -0800
In-Reply-To: <965b587f5834c88532476b56da95ead605d16000.1580110970.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Mon, 27 Jan 2020 09:15:54 +0100")
Message-ID: <xmqqv9ou6983.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97056462-4264-11EA-BABE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 082042b05a..bbff8c5770 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -737,6 +737,7 @@ test_expect_success 'rename a remote' '
>  	git clone one four &&
>  	(
>  		cd four &&
> +		test_config_global remote.pushDefault origin &&
>  		git config branch.master.pushRemote origin &&
>  		git remote rename origin upstream &&
>  		test -z "$(git for-each-ref refs/remotes/origin)" &&

You cannot use test_config and test_config_global inside a subshell,
as they rely on test_when_finished to rewind their effect, which
cannot be used inside a subshell.  As you are doing "global" config,
there is no reason to make "git config --global" call in a particular
repository anyway, so just do this upfront as the first thing in the
test sequence.  There are a few others in this file.

Tentatively I applied the following fix-up on top of the series to
unblock tonight's integration cycle.

Thanks.

 t/t5505-remote.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index bbff8c5770..dda81b7d07 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -734,10 +734,10 @@ test_expect_success 'reject adding remote with an invalid name' '
 # the last two ones check if the config is updated.
 
 test_expect_success 'rename a remote' '
+	test_config_global remote.pushDefault origin &&
 	git clone one four &&
 	(
 		cd four &&
-		test_config_global remote.pushDefault origin &&
 		git config branch.master.pushRemote origin &&
 		git remote rename origin upstream &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
@@ -761,10 +761,10 @@ test_expect_success 'rename a remote renames repo remote.pushDefault' '
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault but ignores global' '
+	test_config_global remote.pushDefault other &&
 	git clone one four.2 &&
 	(
 		cd four.2 &&
-		test_config_global remote.pushDefault other &&
 		git config remote.pushDefault origin &&
 		git remote rename origin upstream &&
 		test "$(git config --global remote.pushDefault)" = "other" &&
@@ -773,10 +773,10 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but ignores
 '
 
 test_expect_success 'rename a remote renames repo remote.pushDefault but keeps global' '
+	test_config_global remote.pushDefault origin &&
 	git clone one four.3 &&
 	(
 		cd four.3 &&
-		test_config_global remote.pushDefault origin &&
 		git config remote.pushDefault origin &&
 		git remote rename origin upstream &&
 		test "$(git config --global remote.pushDefault)" = "origin" &&
@@ -823,10 +823,10 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 '
 
 test_expect_success 'remove a remote' '
+	test_config_global remote.pushDefault origin &&
 	git clone one four.five &&
 	(
 		cd four.five &&
-		test_config_global remote.pushDefault origin &&
 		git config branch.master.pushRemote origin &&
 		git remote remove origin &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
@@ -847,10 +847,10 @@ test_expect_success 'remove a remote removes repo remote.pushDefault' '
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault but ignores global' '
+	test_config_global remote.pushDefault other &&
 	git clone one four.five.2 &&
 	(
 		cd four.five.2 &&
-		test_config_global remote.pushDefault other &&
 		git config remote.pushDefault origin &&
 		git remote remove origin &&
 		test "$(git config --global remote.pushDefault)" = "other" &&
@@ -859,10 +859,10 @@ test_expect_success 'remove a remote removes repo remote.pushDefault but ignores
 '
 
 test_expect_success 'remove a remote removes repo remote.pushDefault but keeps global' '
+	test_config_global remote.pushDefault origin &&
 	git clone one four.five.3 &&
 	(
 		cd four.five.3 &&
-		test_config_global remote.pushDefault origin &&
 		git config remote.pushDefault origin &&
 		git remote remove origin &&
 		test "$(git config --global remote.pushDefault)" = "origin" &&
