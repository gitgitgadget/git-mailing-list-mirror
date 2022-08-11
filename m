Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B9C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 19:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiHKTdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiHKTdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 15:33:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113D90C6E
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 12:33:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4B681413E6;
        Thu, 11 Aug 2022 15:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7UH0QQN2AG0utwC44Xol2c22EPFHechUh4/BWj
        jio/4=; b=ugtOfZTanVqNkpVfzY0quupQpv6BH8KCXFQj3uPJJScnZGNykKm8jU
        D6w+a2h824D5ictk1rZocqwSbmmsXNodfHDXT5aExiP5pU9dpfLQe6JNDWoIdtW4
        r+xbH6ppgvUNC9gRigVBFLvxvoGzHNOy9J5eICGyhI71IGB+xMdd8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB6731413E4;
        Thu, 11 Aug 2022 15:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23F021413E3;
        Thu, 11 Aug 2022 15:33:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v3] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
        <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 12:33:28 -0700
In-Reply-To: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Thu, 11 Aug 2022 18:32:32
        +0000")
Message-ID: <xmqqh72iefsn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AAD968C-19AC-11ED-9D9B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> Though perhaps not common, there are uses cases where users have large,
> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.
>
> Most modern Samba-based filers have the necessary support to enable
> fsmonitor on network-mounted repos. As a first step towards enabling
> fsmonitor to work against network-mounted repos, introduce a
> configuration option, 'fsmonitor.allowRemote'. Setting this option to
> true will override the default behavior (erroring-out) when a
> network-mounted repo is detected by fsmonitor.
>
> Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
> ---
> ...
>  compat/fsmonitor/fsm-settings-win32.c | 66 +++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
> index 907655720bb..32c0695c6c1 100644
> --- a/compat/fsmonitor/fsm-settings-win32.c
> +++ b/compat/fsmonitor/fsm-settings-win32.c
> @@ -24,6 +24,60 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
>  	return FSMONITOR_REASON_OK;
>  }
>  
> +/*
> + * Check if monitoring remote working directories is allowed.
> + *
> + * By default, monitoring remote working directories is
> + * disabled unless on a network filesystem that is known to
> + * behave well.  Users may override this behavior in enviroments where
> + * they have proper support.
> + */

After applying this patch, "unless on a network filesystem ..." part
is not exactly in effect yet; we could say that we start with no
known-to-behave-well network filesystems, but we can then update the
above comment when we start to know of at least one good one.

> +/*
> + * Check remote working directory protocol.
> + *
> + * Error if client machine cannot get remote protocol information.
> + */

Good, but void means that the caller of this function does not know
when we detected an error.  Perhaps return -1 on error, return 0 on
"not error", so that we can return 1 when we learn to recognize
"known to behave well" network filesystem to tell the caller?

That is,

> +static void check_remote_protocol(wchar_t *wpath)

"void" -> "int"

> +{
> +	HANDLE h;
> +	FILE_REMOTE_PROTOCOL_INFO proto_info;
> +
> +	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> +			FILE_FLAG_BACKUP_SEMANTICS, NULL);
> +
> +	if (h == INVALID_HANDLE_VALUE) {
> +		error(_("[GLE %ld] unable to open for read '%ls'"),
> +		      GetLastError(), wpath);
> +		return;

"return" -> "return -1"

> +	}
> +
> +	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
> +		&proto_info, sizeof(proto_info))) {
> +		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
> +		      GetLastError(), wpath);
> +		CloseHandle(h);
> +		return;

"return" -> "return -1"

> +	}
> +
> +	CloseHandle(h);
> +
> +	trace_printf_key(&trace_fsmonitor,
> +				"check_remote_protocol('%ls') remote protocol %#8.8lx",
> +				wpath, proto_info.Protocol);
> +
> +	return;

"return" -> "return 0" (or "-1")

> +}
> +
>  /*
>   * Remote working directories are problematic for FSMonitor.
>   *
> @@ -115,6 +169,18 @@ static enum fsmonitor_reason check_remote(struct repository *r)
>  		trace_printf_key(&trace_fsmonitor,
>  				 "check_remote('%s') true",
>  				 r->worktree);
> +
> +		check_remote_protocol(wfullpath);

And here

		ret = check_remote_protocol(wfullpath);
		if (ret < 0)
			/* definitely an error */
			return FSMONITOR_REASON_ERROR;

and then we can fall thru the non-error case below.  We'd of course
need to declare "int ret" at the beginning of the function.

> +		switch (check_config_allowremote(r)) {
> +		case 0: /* config overrides and disables */
> +			return FSMONITOR_REASON_REMOTE;
> +		case 1: /* config overrides and enables */
> +			return FSMONITOR_REASON_OK;
> +		default:
> +			break; /* config has no opinion */
> +		}
> +
>  		return FSMONITOR_REASON_REMOTE;
>  	}

In the future, when this "first step" graduates to the upcoming
release, we may want to have a follow-up enhancement patch that
changes the code like so:

 * we recognize ones like SMB in check_remote_protocol() as "known
   to be good", and return 1 from there

 * after the "switch" above determies that the configuration file
   does not have any opinion, instead of unconditionally returning
   REASON_REMOTE to refuse the request, pay attention to "ret", e.g.
   something like

-	return FSMONITOR_REASON_REMOTE;
+	if (!ret)
+		return FSMONITOR_REASON_REMOTE;
+	else /* known to be good ones */
+		return FSMONITOR_REASON_OK;

When we do so, we'd resurrect the "unless on a network filesystem
that is known to behave well" comment.  What this last part does is
exactly that.

Thanks.
