Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9480DC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 19:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiHJTu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHJTu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 15:50:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083465808
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 12:50:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AA6B19E522;
        Wed, 10 Aug 2022 15:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RbQLl98ecWG3fR9MDgXySKhZb0p0UpQFasPiz4
        c5ras=; b=acNjUAw2a6SiFVfZffIIMrMtxkWoz42PKgUn8btUmwoOBcx7yH+XcT
        yr4ZpXTB6IGbJRpUODKqr1eNTptK+n7uiOQP+kFnQg/ZKuE87HwZvk8eOCLPTaHE
        37soccFh1VRaSyelrPE8/W04f6YkD7g9kuNVD2JieRVYgNLsDyIao=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0291D19E521;
        Wed, 10 Aug 2022 15:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E05C19E520;
        Wed, 10 Aug 2022 15:50:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric D <eric.decosta@gmail.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
        <xmqqmtccniw4.fsf@gitster.g>
        <CAMxJVdH3B2An7La9knM=QJojQ334O+Z2-tqNvqRZz2Eu6CV+-w@mail.gmail.com>
Date:   Wed, 10 Aug 2022 12:50:20 -0700
In-Reply-To: <CAMxJVdH3B2An7La9knM=QJojQ334O+Z2-tqNvqRZz2Eu6CV+-w@mail.gmail.com>
        (Eric D.'s message of "Wed, 10 Aug 2022 14:49:28 -0400")
Message-ID: <xmqqbksrlvyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB0259DE-18E5-11ED-8A8B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric D <eric.decosta@gmail.com> writes:

> Makes sense. How about FSMONITOR_OVERRIDE_REQUIRED ? The error message
> could then indicate that remote repos are normally unsupported but
> that setting the fsmonitor.allowRemote flag overrides this behavior.

I actually think check_allow_remote() should be renamed to have
"config" somewhere in its name, and return -1, 0 or 1 and not "enum
fsmonitor_reason".

	static int check_config_allowremote(...)
	{
		int allow;

		if (repor_config_get_bool(..., &allow))
			return allow;
		return -1; /* undecided */
	}

then caller can do

	switch (check_config_allowremote(...)) {
	case 0: /* config overrides and disables */
		return FSMONITOR_REASON_REMOTE;
	case 1: /* config overrides and enables */
		return FSMONITOR_REASON_OK;
	default:
		break; /* config has no opinion */
	}
        return check_smb(...);

> If we do as you suggest above, then fsmonitor.allowRemote=true would
> override regardless of the protocol being used.

Exactly.  The code should not try to outsmart the user.

If the user says they wants to use it on a particular remote, even
if you do not know if that particular remote system works, just let
them try and see if it works.  If it does not, they can easily
disable, because the enabiling was a deliberate act by them in the
first place.  They know how to fix it.

Thanks.

