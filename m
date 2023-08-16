Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B86C001E0
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 16:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242906AbjHPQQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbjHPQQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 12:16:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6242704
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 09:16:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4C9F36455;
        Wed, 16 Aug 2023 12:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O1ngh/Znh9l8hSS28v8twykW3cJOEr2Itm2lyK
        UOxmM=; b=ydji6kaROcb0yZk/gg217n1o2pGkvV6B3VZzIA4YWFY17mH+oPyVX+
        JkJpvugBH1riuuC9vcc28ujeWGYUNt/Sl7j3jO0FWaeFbuO67JjWE6DbUZf9S4CM
        nwdXNhw3I7yZVvVg7bFQK77imUnRH2c2YzvEcCSBDiebZrcUQr8Zk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD3EB36454;
        Wed, 16 Aug 2023 12:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 78A0A36452;
        Wed, 16 Aug 2023 12:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] upload-pack: fix exit code when denying fetch of
 unreachable object ID
References: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
        <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
Date:   Wed, 16 Aug 2023 09:16:00 -0700
In-Reply-To: <fe028981d353158e9840eb035194ca15e6a2c15e.1692165840.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 16 Aug 2023 08:06:59 +0200")
Message-ID: <xmqqjztvezen.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 312C8046-3C50-11EE-9660-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> In 7ba7c52d76 (upload-pack: fix race condition in error messages,
> 2023-08-10), we have fixed a race in t5516-fetch-push.sh where sometimes
> error messages got intermingled. This was done by splitting up the call
> to `die()` such that we print the error message before writing to the
> remote side, followed by a call to `exit(1)` afterwards.
> ...
> We have found this issue in our CI pipeline in Gitaly, which explicitly
> checks for the error code. It is very much debatable whether we should
> even be doing that in the first place given that error codes are not
> even explicitly documented here. But I think this is worth fixing anyway
> given that it seems like an unintended side effect to me and might be
> biting others, as well.
>
> If you folks agree with my reasoning, then I think we should pick this
> up before Git v2.42.0 is released.

Thanks.

The change to the code sounds sensible in that it is a move to
restore the status quo, and we know that the original never intended
to "fix" the exit status from 128 to 1.  The test change etches the
status quo in stone, which is a bit more than that and might be
debatable, but when we someday formally declare that users should
not be relying on the exit status that are not documented, we would
hunt for the uses of test_expect_code in the tests and turn this one
back, and probably do the same to others that are too strict on the
exact exit status, so I think that half of the change is OK, at
least for now.

Comments?

>  t/t5703-upload-pack-ref-in-want.sh | 2 +-
>  upload-pack.c                      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index df74f80061..fe6e056700 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -483,7 +483,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
>  	rm -rf local &&
>  	cp -r "$LOCAL_PRISTINE" local &&
>  	inconsistency main $(test_oid numeric) &&
> -	test_must_fail git -C local fetch 2>err &&
> +	test_expect_code 128 git -C local fetch 2>err &&
>  	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
>  '
>  
> diff --git a/upload-pack.c b/upload-pack.c
> index ece111c629..15f3318d6d 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -782,7 +782,7 @@ static void check_non_tip(struct upload_pack_data *data)
>  			packet_writer_error(&data->writer,
>  					    "upload-pack: not our ref %s",
>  					    oid_to_hex(&o->oid));
> -			exit(1);
> +			exit(128);
>  		}
>  	}
>  }
