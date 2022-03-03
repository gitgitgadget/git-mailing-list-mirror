Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EEC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiCCVgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCCVgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:36:32 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2C15C1A3
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:35:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 337BE18BE62;
        Thu,  3 Mar 2022 16:35:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yxaAggWL3TPV62nPKffXzu/eaysHk/NFRhTLUw
        LJU/4=; b=ADczLE14Acrce/LhZZkPtXVFin7sYEUk5/M/Sw57PtP8lg6U0cjutP
        tRVxkG1Jjt+UOrb/jOo7ZME+gHydzWp6bgs/yT5SvXRhwZGE5nUOtM9TQpn7KuGh
        AS3itUvFFjlW3sy7zkNM/DcrGyGbLkRodnu44vWs9jUP3C5bxVX4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2AB2818BE61;
        Thu,  3 Mar 2022 16:35:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91B1618BE60;
        Thu,  3 Mar 2022 16:35:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 08/13] submodule--helper run-update-procedure: learn
 --remote
References: <20220301044132.39474-1-chooglen@google.com>
        <20220303005727.69270-1-chooglen@google.com>
        <20220303005727.69270-9-chooglen@google.com>
Date:   Thu, 03 Mar 2022 13:35:40 -0800
In-Reply-To: <20220303005727.69270-9-chooglen@google.com> (Glen Choo's message
        of "Wed, 2 Mar 2022 16:57:22 -0800")
Message-ID: <xmqq4k4eafdf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0A6F2AE-9B39-11EC-8F82-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> @@ -3033,6 +3004,25 @@ static int update_submodule2(struct update_data *update_data)
>  		die(_("Unable to find current revision in submodule path '%s'"),
>  			update_data->displaypath);
>  
> +	if (update_data->remote) {
> +		char *remote_name = get_default_remote_submodule(update_data->sm_path);
> +		const char *branch = remote_submodule_branch(update_data->sm_path);
> +		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
> +
> +		if (!update_data->nofetch) {
> +			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
> +					      0, NULL))
> +				die(_("Unable to fetch in submodule path '%s'"),
> +				    update_data->sm_path);
> +		}
> +
> +		if (resolve_gitlink_ref(update_data->sm_path, remote_ref, &update_data->oid))
> +			die(_("Unable to find %s revision in submodule path '%s'"),
> +			    remote_ref, update_data->sm_path);
> +
> +		free(remote_ref);
> +	}

This, and ...

> @@ -409,21 +395,6 @@ cmd_update()
>  			just_cloned=
>  		fi
>  
> -		if test -n "$remote"
> -		then
> -			branch=$(git submodule--helper remote-branch "$sm_path")
> -			if test -z "$nofetch"
> -			then
> -				# Fetch remote before determining tracking $sha1
> -				fetch_in_submodule "$sm_path" $depth ||
> -				die "fatal: $(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
> -			fi
> -			remote_name=$(sanitize_submodule_env; cd "$sm_path" && git submodule--helper print-default-remote)
> -			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
> -				git rev-parse --verify "${remote_name}/${branch}") ||
> -			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
> -		fi

... this change would "fix" the temporary breakage [05/13] may have
brought us.  From the series structure's point of view, doing
[05/13] after this would be more sensible.  If we leave the call to
"displaypath" still in the script after this series, [05/13] or its
equivalent should mention that ensure-core-worktree does not matter
for that particular call when it delays the call to it by moving it
to the beginning of the update_submodule2() from the much earlier
part of the script.

>  		out=$(git submodule--helper run-update-procedure \
>  			  ${wt_prefix:+--prefix "$wt_prefix"} \
>  			  ${GIT_QUIET:+--quiet} \
> @@ -434,6 +405,7 @@ cmd_update()
>  			  ${update:+--update "$update"} \
>  			  ${prefix:+--recursive-prefix "$prefix"} \
>  			  ${sha1:+--oid "$sha1"} \
> +			  ${remote:+--remote} \
>  			  "--" \
>  			  "$sm_path")
