Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A03C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 16:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiHJQtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHJQtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 12:49:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58F24BCA
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 09:49:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44BC7131502;
        Wed, 10 Aug 2022 12:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m73QkxVCL4+yML4NwTG6PLxTb8y6dUkcmdsnmP
        Xilkc=; b=jZGlm+40K+1VCL9rwbFinvITiWsN9tQjhj+jYNyVCrnqYEIwaUIvMQ
        iIHUW9HDxN43YGfyMV+YCVAhrZVxh4dUpBwN5K5DI9fsw6d8QdDMHYFBDIywE6MG
        YhXa8BKAhiGUgzXvWJX/5k1DCYohBy9282JzGmsgIpGXsAtNLixiY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B855131501;
        Wed, 10 Aug 2022 12:49:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5067F131500;
        Wed, 10 Aug 2022 12:49:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
References: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 09:49:31 -0700
In-Reply-To: <pull.1317.git.1660067049965.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Tue, 09 Aug 2022 17:44:09
        +0000")
Message-ID: <xmqqmtccniw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6878DA20-18CC-11ED-B1C5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Most modern Samba-based filers have the necessary support to enable
> fsmonitor on network-mounted repos.

My impression from the earlier discussion [*] was that having the
necessary support and the support working well are two different
things, and the network mounted directory being served via SMB was
not enough sign of the latter.

https://lore.kernel.org/git/16832f8a-c582-23bb-dda9-b7b2597a42eb@jeffhostetler.com/

I do not do Windows, so I'll leave it up to the experts, but if
everybody who talks SMB behaves well, then the updated code that
enables fsmonitor for SMB talkers and disables it for all other
remotely mounted directories, with a configuration override, does
sound like a good way to go.  I think the new code in check_remote()
is broken, though (see below).

> +/*
> + * Check if monitoring remote working directories is allowed.
> + *
> + * By default monitoring remote working directories is not allowed,
> + * but users may override this behavior in enviroments where they
> + * have proper support.
> +*/

All existing multi-line comments in this file (and properly
formatted ones for this project) ends with "*/" where the asterisk
aligns with the asterisk on the previous line.  

The three-line design goal is well written, but as you are special
casing SMB, perhaps

	By default, monitoring remote working directories is
	disabled unless on a network filesystem that is known to
	behave well.  Users may override ...

or something like that may be warranted.

> +static enum fsmonitor_reason check_allow_remote(struct repository *r)
> +{
> +	int allow;
> +
> +	if (repo_config_get_bool(r, "fsmonitor.allowremote", &allow) || !allow)
> +		return FSMONITOR_REASON_REMOTE;
> +
> +	return FSMONITOR_REASON_OK;
> +}

This is not wrong per se, but it probably is easier to follow if you
write them the other way around.

	if (!repo_config_get_bool(..., &allow) && allow)
		return FSMONITOR_REASON_OK;

	return FSMONITOR_REASON_REMOTE;

After all, as the big comment before the function says, by default
we deny and only on exceptions we allow.

Actually, the above is not quite right.  You'd probably want a "not
set" or "undecided" bit.  I.e. something like

	if (!repo_config_get_bool(..., &allow))
		return allow ? FSMONITOR_REASON_OK : FSMONITOR_REASON_REMOTE;

	return FSMONITOR_REASON_UNDECIDED; /* invented... */

> +/*
> + * Check if the remote working directory is mounted via SMB
> + *
> + * For now, remote working directories are only supported via SMB mounts
> +*/

"*/" -> " */".

> +static enum fsmonitor_reason check_smb(wchar_t *wpath)
> +{
> +	HANDLE h;
> +	FILE_REMOTE_PROTOCOL_INFO proto_info;
> +
> +	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
> +					FILE_FLAG_BACKUP_SEMANTICS, NULL);
> +
> +	if (h == INVALID_HANDLE_VALUE) {
> +		error(_("[GLE %ld] unable to open for read '%ls'"),
> +		      GetLastError(), wpath);
> +		return FSMONITOR_REASON_ERROR;
> +	}
> +
> +	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
> +									&proto_info, sizeof(proto_info))) {

Overly deep indentation that unnecessarily causes an overly long
line. "&" in "&proto_info" should align with "h" in
"...HandleEx(h,", we use fixed-width font, and our tab-width is 8.

The second line of CreateFileW() call is also overly indented and
may want to be fixed, but it does not overly extend to the right end
of the display (we aim to fit in 80-columns, as CodingGuideline says)
so it would be nice if it gets fixed, but it may be tolerated.  This
one is not.

> +		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
> +		      GetLastError(), wpath);

This line gets it right ;-)

> +		CloseHandle(h);
> +		return FSMONITOR_REASON_ERROR;
> +	}
> +
> +	CloseHandle(h);
> +
> +	if (proto_info.Protocol == WNNC_NET_SMB)
> +		return FSMONITOR_REASON_OK;
> +
> +	return FSMONITOR_REASON_ERROR;

Is it?  Shouldn't it be REASON_REMOTE, not ERROR?  Unlike the
earlier case where you couldn't figure out the protocol information,
at this point you know you learned what protocol is in use, and it
is just that the protocol was not what you liked.

> +}
> +
>  /*
>   * Remote working directories are problematic for FSMonitor.
>   *
> @@ -76,6 +128,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
>   */
>  static enum fsmonitor_reason check_remote(struct repository *r)
>  {
> +	enum fsmonitor_reason reason;
>  	wchar_t wpath[MAX_PATH];
>  	wchar_t wfullpath[MAX_PATH];
>  	size_t wlen;
> @@ -115,7 +168,11 @@ static enum fsmonitor_reason check_remote(struct repository *r)
>  		trace_printf_key(&trace_fsmonitor,
>  				 "check_remote('%s') true",
>  				 r->worktree);
> -		return FSMONITOR_REASON_REMOTE;
> +
> +		reason = check_smb(wfullpath);
> +		if (reason != FSMONITOR_REASON_OK)
> +			return reason;
> +		return check_allow_remote(r);

This does not fulfill the promise you made in front of
check_allow_remote().  As we saw, check_smb() returns something
other than REASON_OK when it is talking to a remote that is not SMB,
and when that happens, you are not giving check_allow_remote() a
chance to intervene and override.  It should be more like

	reason = check_allow_remote(r);
        if (reason == FSMONITOR_REASON_OK || reason == FSMONITOR_REASON_REMOTE)
		return reason;
	/*
	 * check_allow_remote() did not decide, so use the default
	 * based on the network filesystem.
	 */
	return check_smb(wfullpath);

I would think.

>  	}
>  
>  	return FSMONITOR_REASON_OK;
>
> base-commit: c50926e1f48891e2671e1830dbcd2912a4563450
