Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F1DC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 15:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiEEPyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiEEPyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 11:54:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB64A3E5
        for <git@vger.kernel.org>; Thu,  5 May 2022 08:50:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 28BFD1ABBE1;
        Thu,  5 May 2022 11:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bSwVbaj7dC/G5uEWcpYRalezC9RKaMjsf4/Lzf
        c2rDE=; b=oZ+MiMeGSu7sBEl4ToYRCOI+S3i+MZSq17gLCsuGTcfdgRpb6+pW45
        WVIvlZr9mASXelFMGfuuuUIHJgAJ3mSL1xONb9HNJmvgcq/ZbOvuQnbok4E2lbUZ
        uTULG3dbc0XgQMw6D25QbGeANvPLd7tqlCUkKzg/VmChSQqokxA9Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20C1F1ABBE0;
        Thu,  5 May 2022 11:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A37301ABBDF;
        Thu,  5 May 2022 11:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-2-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
Date:   Thu, 05 May 2022 08:50:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 5 May 2022 15:44:34 +0200 (CEST)")
Message-ID: <xmqqsfpof06a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25B62388-CC8B-11EC-A42D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> A new SUDO prerequisite is provided that does some sanity checking
>> to make sure the sudo command that will be used allows for passwordless
>> execution as root and doesn't mess with git execution paths, but
>> otherwise additional work will be required to ensure additional
>> commands behave as expected and that will be addressed in a later patch.

This part probably needs to be stressed, not just here but near the
part where we require IKNOWWHATIAMDOING=YES to be set.  For regular
interactive boxes, this test should pretty much be useless, as on a
normally configured machine with human users, it is likely that
"sudo" updates/restricts PATH to a limited set of directories and
exclude the path to our just-built-and-being-tested "git".

IOW, this is primarily (and likely to be solely) for a specialized
CI job in a very controlled environment.

>> +# this prerequisite should be added to all the tests, it not only prevents
>> +# the test from failing but also warms up any authentication cache sudo
>> +# might need to avoid asking for a password
>> +test_lazy_prereq SUDO '
>> +	sudo -n id -u >u &&
>> +	id -u root >r &&
>> +	test_cmp u r &&
>> +	command -v git >u &&
>> +	sudo command -v git >r &&
>
> In my Ubuntu setup, `/bin/sh` is a symbolic link to `/bin/dash`, which
> does not understand the `command`. It might make more sense to use `type`
> here, but it is quite possible that `type git` uses a different output
> format than `sudo type git` if they use different shells.

So with that in mind, shell portability is still an issue, but ...

> Another complication is that the `/etc/sudoers` I have over here specifies

... /etc/sudoers (both people allowed to use and how environments
are futzed with) is not.  If your /etc/sudoers do not allow SUDO
prereq here to pass, then that is OK.
