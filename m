Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9133C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 02:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiCJCKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCJCKE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 21:10:04 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FB9DCE35
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 18:09:04 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC53F10F64C;
        Wed,  9 Mar 2022 21:09:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oi/EIbLYJoMTiaG6W6Md0qGH+wA21SK3D+MCGQ
        uVmcs=; b=Dmbd/5rtP1F9KFekItPBZRPpZox28sclLIGlaPcrN9VDU312Wloj2z
        vtmjQmcLTeuqM8j/8ZNRriXeRmOkp935FcLTzYODpxRyqq2B6dUWM6kTa7BTsAYG
        F8hERwMDzgOtF9fZ/BzhuZl/le7omdjUPp7s6lR0x1BjM0cTa60Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BD5510F64B;
        Wed,  9 Mar 2022 21:09:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B68A110F64A;
        Wed,  9 Mar 2022 21:09:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
References: <20220310004423.2627181-1-emilyshaffer@google.com>
        <20220310004423.2627181-3-emilyshaffer@google.com>
Date:   Wed, 09 Mar 2022 18:09:01 -0800
In-Reply-To: <20220310004423.2627181-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 9 Mar 2022 16:44:22 -0800")
Message-ID: <xmqqtuc6h83m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E62143A-A017-11EC-A894-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>  
>  	free(prefixed_path);
>  
> +	/*
> +	 * This entry point is always called from a submodule, so this is a
> +	 * good place to set a hint that this repo is a submodule.
> +	 */
> +	git_config_set("submodule.hasSuperproject", "true");
> +
>  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
>  		return do_run_update_procedure(&update_data);

In Glen's update to rewrite "submodule update" in C, this part is
replaced with a call to update_submodule2().  I am not sure what the
current repository is at this point of the code with and without
Glen's topic, but are we sure we are in a submodule we discovered?

builtin/submodule--helper.c::run_update_procedure() takes sm_path to
the path to the submodule, presumably from superproject's point of
view, and the callchain leads to a call to run_update_command()
eventually, which uses run_command_v_opt_cd_env() to go in to the
submodule repository and run an external git command (like
"checkout"), so it looks like what git_config_set() updates is the
superprojects' configuration, not the configuration of a particular
submodule being updated.

The other one, where cmd_clone() sets the variable in submodule's
configuration file, looks good, but I am not sure about this one.
