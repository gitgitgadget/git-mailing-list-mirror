Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B311C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJNPpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJNPps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:45:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FD5F6C
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:45:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED5F01C2A30;
        Fri, 14 Oct 2022 11:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4yVTkklNxLwNNvDWX1nNyS4tDXGvFOjNXHu6rF
        BVeiA=; b=NO/BoLjYQlOpkRIYXUI9iXa8hlEQLBV0QGT3Niskw+CvuWFvwUB2qZ
        bacx9Ac9V/beS+ftRDdXKfIL9Aw98xca3sBAp9piA517h4XawJCO/1SMXPAVLb44
        R8kVyQpsqP8I8EOQvtdIkHUJUZZxumfg+JV3HaXfOpEDzHQIvEX2I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6CF81C2A2E;
        Fri, 14 Oct 2022 11:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2321C1C2A2C;
        Fri, 14 Oct 2022 11:45:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] RFC: mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
        <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:45:43 -0700
In-Reply-To: <pull.1381.v2.git.1665734440009.gitgitgadget@gmail.com> (Tao
        Klerks via GitGitGadget's message of "Fri, 14 Oct 2022 08:00:39
        +0000")
Message-ID: <xmqqczaube8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 438B381E-4BD7-11ED-A347-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      * In git-mergetool--lib.sh the way I implemented the "auto" special
>        value means that if you put an arbitrary value in the config, eg the
>        typo "uato", you get an error about it being an invalid boolean
>        config value; is that OK? Is there a better way to handle "boolean or
>        special value" config validation? Are there any examples?

I think the ideal behaviour would be:

 * Unless running difftool and difftool.guiChoice has a wrong value,
   or running mergetool and mergetool.guiChoice has a wrong value,
   we should not even complain.

 * If the command line says --gui or --no-gui that makes the setting
   irrelevant, it is OK for us to give a warning to remind the user
   that they may want to fix the spelling of the variable, but
   otherwise go ahead and perform the action as they asked us to.

 * If the command line lacks --gui or --no-gui, we do need to have a
   usable value in the configuration, and we should error out
   without spawning either gui or no-gui tool backend.

It may be usable without the second one and always fail difftool and
mergetool until the setting gets fixed, but that is less than ideal.
We do allow less than ideal code in, as long as it is an improvement
over the status quo, and its presence does not make it harder to
later get closer to the ideal.

Thanks.
