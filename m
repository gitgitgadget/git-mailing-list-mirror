Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD7EC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiCAVCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 16:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiCAVCc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 16:02:32 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B097086C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 13:01:50 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B771E3F4802;
        Tue,  1 Mar 2022 16:01:49 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5DE843F4808;
        Tue,  1 Mar 2022 16:01:49 -0500 (EST)
Subject: Re: [PATCH 07/23] fsmonitor-settings: virtual repos are incompatible
 with FSMonitor
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4e856d60e385d64158f17ec1226f97eb323bc55e.1644940774.git.gitgitgadget@gmail.com>
 <05747ff2-f839-5408-e25b-698b147ef158@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <49d981a6-be6e-c995-160f-593d3ef3cf27@jeffhostetler.com>
Date:   Tue, 1 Mar 2022 16:01:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <05747ff2-f839-5408-e25b-698b147ef158@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 10:11 AM, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Virtual repos, such as GVFS (aka VFS for Git), are incompatible
>> with FSMonitor.
> 
> I would swap all of your "GVFS (aka VFS for Git)" for just
> "VFS for Git".
> 
>> +/*
>> + * GVFS (aka VFS for Git) is incompatible with FSMonitor.
>> + *
>> + * Granted, core Git does not know anything about GVFS and we
>> + * shouldn't make assumptions about a downstream feature, but users
>> + * can install both versions.  And this can lead to incorrect results
>> + * from core Git commands.  So, without bringing in any of the GVFS
>> + * code, do a simple config test for a published config setting.  (We
>> + * do not look at the various *_TEST_* environment variables.)
>> + */
>> +static enum fsmonitor_reason is_virtual(struct repository *r)
>> +{
>> +	const char *const_str;
>> +
>> +	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
>> +		return FSMONITOR_REASON_VIRTUAL;
>> +
>> +	return FSMONITOR_REASON_ZERO;
>> +}
> 
> This reason seems to be specific to a config setting that only
> exists in the microsoft/git fork. Perhaps this patch should remain
> there.
> 
> However, there is also the discussion of vfsd going on, so something
> similar might be necessary for that system. Junio also mentioned
> wanting to collaborate on a common indicator that virtualization was
> being used, so maybe we _should_ make core.virtualFilesystem a config
> setting in the core Git project.
> 
> The reason for the incompatibility here is that VFS for Git has its
> own filesystem watcher and Git gets updates from it via custom code
> that is a precursor to this FS Monitor feature. I don't know if vfsd
> has plans for a similar setup. (It would probably be best to fit
> into the FS Monitor client/server model and use a different daemon
> for those virtualized repos, but I don't know enough details to be
> sure.)
> 
> CC'ing Jonathan Nieder for thoughts on this.

I was wondering whether this should be upstream or just in our
downstream forks, but I thought it better to include it so that
we don't try to monitor a virtualized repo and not mislead the
user.  It may be that we can correctly watch the repo and
generate correct results, but without knowing any details of
what the virtualization is doing behind the scenes, we would
be making some unsafe assumptions.  And since Windows users often
have multiple versions of Git installed (their CL tools and
whatever their IDE installed), promoting this check to upstream
felt important.

WRT the ongoing "vfsd" effort, I'm not sure what that looks like
yet and/or whether repos managed by "vfsd" have similar concerns.

I'll rename the variables in my patch here to be "vfs4git" rather
the generic "virtual".  This will avoid confusion later if another
case needs to be added for "vfsd".  My code is Win32-specific and
it is unclear it theirs will be Linux-only or cross-platform, so
hopefully with the rename we can coexist sanely.

Jeff


