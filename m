Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F7C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiECPbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbiECPbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 11:31:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972726127
        for <git@vger.kernel.org>; Tue,  3 May 2022 08:27:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6012418D72A;
        Tue,  3 May 2022 11:27:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8KpUZxPQtxRIXkVS3YlWJg3bsfJRtq0dqeCD86
        Uvs8w=; b=GnQ1rw+s+O4mrTPCgiRKvkYragwWx3STKG4Cza2Ng0VUSeLhiNdPIF
        uMZqKe1kuYuF9091v+VMGYFy2ShtwFMZTEwRdMKDh48mGKBeNVJtSmvezlygrk2R
        b/WwAcDwvvrbcCiJb6jg4gfollJH3IWckhLroNihHV5HCrCfImoU8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5650918D729;
        Tue,  3 May 2022 11:27:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDD5518D728;
        Tue,  3 May 2022 11:27:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH v3 3/3] t0034: enhance framework to allow testing more
 commands under sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-4-carenas@gmail.com>
        <af4dd56d-f301-9c3d-2fc3-929a24596e82@gmail.com>
Date:   Tue, 03 May 2022 08:27:36 -0700
In-Reply-To: <af4dd56d-f301-9c3d-2fc3-929a24596e82@gmail.com> (Phillip Wood's
        message of "Tue, 3 May 2022 15:12:30 +0100")
Message-ID: <xmqqv8umr5zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9045C2E0-CAF5-11EC-AD2D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

(I'd be brief as it is my day-off today).

>> +test_expect_success SUDO 'cannot access with sudo' '
>> +	(
>> +		# TODO: test_must_fail needs additional functionality
>> +		# 6a67c759489 blocks its use with sudo
>> +		cd root/p &&
>> +		! sudo git status
>> +	)
>> +'
>
> I think Junio suggested that this should work and showed it was simple
> to make it work. It seems funny that if sudo is started as root it
> does not work.

It does feel odd.  Any attacker who can prepare a root-owned trap do
not have to trick "sudo git" to fall there, so I personally do not
see much value in stopping this particular pattern, but since
workarounds are easy (like double sudo), I do not mind if this does
not work *IF* there is a good reason to stop this.

>> +test_expect_success SUDO 'can access using a workaround' '
>> +	# run sudo twice
>> +	(
>> +		cd root/p &&
>> +		run_with_sudo <<-END
>> +			sudo git status
>> +		END
>> +	) &&
>> +	# provide explicit GIT_DIR
>> +	(
>> +		cd root/p &&
>> +		run_with_sudo <<-END
>> +			GIT_DIR=.git &&
>> +			GIT_WORK_TREE=. &&
>> +			export GIT_DIR GIT_WORK_TREE &&
>> +			git status
>
> I'm confused by this. Does this mean we don't do the ownership checks
> if GIT_DIR and or GIT_WORK_TREE are set in the environment?

That's by design.  Remember, we are protecting people from "cd"ing
into a (sub)directory, unknowingly, that happens to be controled by
a Git repository somebody else prepared as a trap.  So we try to
ensure who owns such a repository when we do the discovery.  Users
who set these environment variables to tell Git that they are aware
that they are working with that directory are different from the
target audience.

> Thanks for working on this

Ditto.  And thanks for reviewing and raising questions.  I agree
with all the things you said in the part of the message I did not
touch in this reply.

