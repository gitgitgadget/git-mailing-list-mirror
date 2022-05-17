Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC8C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 19:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352662AbiEQT1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiEQT1A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 15:27:00 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DBD17047
        for <git@vger.kernel.org>; Tue, 17 May 2022 12:26:58 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1BE233F4128;
        Tue, 17 May 2022 15:26:58 -0400 (EDT)
Received: from REPLICASERVER01.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B447A3F4104;
        Tue, 17 May 2022 15:26:57 -0400 (EDT)
Subject: Re: [PATCH v6 01/28] fsm-listen-win32: handle shortnames
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten B??gershausen <tboegi@web.de>, rsbecker@nexbridge.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
 <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <8b7c5f4e234e5b139b640652fcfdafb2e24e9db8.1650662994.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2205121617460.352@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <59cfe53d-4529-b594-014c-ade72ba86c41@jeffhostetler.com>
Date:   Tue, 17 May 2022 15:26:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2205121617460.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/22 10:20 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach FSMonitor daemon on Windows to recognize shortname paths as
>> aliases of normal longname paths.  FSMonitor clients, such as `git
>> status`, should receive the longname spelling of changed files (when
>> possible).
>>
[...]

>> +/*
>> + * See if the worktree root directory has shortnames enabled.
>> + * This will help us decide if we need to do an expensive shortname
>> + * to longname conversion on every notification event.
>> + *
>> + * We do not want to create a file to test this, so we assume that the
>> + * root directory contains a ".git" file or directory.  (Our caller
>> + * only calls us for the worktree root, so this should be fine.)
>> + *
>> + * Remember the spelling of the shortname for ".git" if it exists.
>> + */
>> +static void check_for_shortnames(struct one_watch *watch)
>> +{
>> +	wchar_t buf_in[MAX_PATH + 1];
>> +	wchar_t buf_out[MAX_PATH + 1];
>> +	wchar_t *last_slash = NULL;
>> +	wchar_t *last_bslash = NULL;
>> +	wchar_t *last;
>> +
>> +	/* build L"<wt-root-path>/.git" */
>> +	wcscpy(buf_in, watch->wpath_longname);
>> +	wcscpy(buf_in + watch->wpath_longname_len, L".git");
> 
> Could you use `wcsncpy()` here (with the appropriate length designed not
> to overrun the `buf_in` buffer?
> 
> Or even better: use `swprintf()` (which has a `count` parameter)? The
> performance impact should be negligible because we only do this once,
> right?

The RHS is a MAX_PATH buffer, so I don't think it was exploitable,
but yes it is good to make it explicit.  Good catch. Thanks.


>> +
>> +	if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
>> +		return;
>> +
>> +	last_slash = wcsrchr(buf_out, L'/');
>> +	last_bslash = wcsrchr(buf_out, L'\\');
>> +	if (last_slash > last_bslash)
>> +		last = last_slash + 1;
>> +	else if (last_bslash)
>> +		last = last_bslash + 1;
>> +	else
>> +		last = buf_out;
> 
> While this is all correct, I would find it clearer to write this as
> following:
> 
> 	for (filename = p = buf_out; *p; p++)
> 		/* We can be sure that `buf_out` does not end in a slash */
> 		if (*p == L'/' || *p == '\\')
> 			filename = p + 1;

sure.

> 
>> +
>> +	if (!wcscmp(last, L".git"))
>> +		return;
>> +
>> +	watch->has_shortnames = 1;
>> +	wcsncpy(watch->dotgit_shortname, last,
>> +		ARRAY_SIZE(watch->dotgit_shortname));
>> +
>> +	/*
>> +	 * The shortname for ".git" is usually of the form "GIT~1", so
>> +	 * we should be able to avoid shortname to longname mapping on
>> +	 * every notification event if the source string does not
>> +	 * contain a "~".
>> +	 *
>> +	 * However, the documentation for GetLongPathNameW() says
>> +	 * that there are filesystems that don't follow that pattern
>> +	 * and warns against this optimization.
>> +	 *
>> +	 * Lets test this.
>> +	 */
>> +	if (wcschr(watch->dotgit_shortname, L'~'))
>> +		watch->has_tilda = 1;
>> +}
>> +
>> +enum get_relative_result {
>> +	GRR_NO_CONVERSION_NEEDED,
>> +	GRR_HAVE_CONVERSION,
>> +	GRR_SHUTDOWN,
>> +};
>> +
>> +/*
>> + * Info notification paths are relative to the root of the watch.
>> + * If our CWD is still at the root, then we can use relative paths
>> + * to convert from shortnames to longnames.  If our process has a
>> + * different CWD, then we need to construct an absolute path, do
>> + * the conversion, and then return the root-relative portion.
>> + *
>> + * We use the longname form of the root as our basis and assume that
>> + * it already has a trailing slash.
>> + *
>> + * `wpath_len` is in WCHARS not bytes.
>> + */
>> +static enum get_relative_result get_relative_longname(
>> +	struct one_watch *watch,
>> +	const wchar_t *wpath, DWORD wpath_len,
>> +	wchar_t *wpath_longname)
>> +{
>> +	wchar_t buf_in[2 * MAX_PATH + 1];
>> +	wchar_t buf_out[MAX_PATH + 1];
>> +	DWORD root_len;
>> +
>> +	/* Build L"<wt-root-path>/<event-rel-path>" */
>> +	root_len = watch->wpath_longname_len;
>> +	wcsncpy(buf_in, watch->wpath_longname, root_len);
>> +	wcsncpy(buf_in + root_len, wpath, wpath_len);
> 
> Here, too, I would like to have a check to prevent an overrun. Maybe
> `swprintf()` again? I guess we could invent `xswprintf()` which would
> return an error if the return value is -1 or if it used up the entire
> buffer (i.e. if it overran).

The relative portion is not necessarily null terminated.  It comes
from the FILE_NOTIFY_INFOMATION buffer from the kernel.  We could
use swprintf() here, to prevent the overflow, but we might miss the
fact that it was truncated.  I'll add checks to make sure the sum
is within limits or give up.

> 
>> +	buf_in[root_len + wpath_len] = 0;
>> +
>> +	/*
>> +	 * We don't actually know if the source pathname is a
>> +	 * shortname or a longname.  This routine allows either to be
>> +	 * given as input.
>> +	 */
>> +	if (!GetLongPathNameW(buf_in, buf_out, MAX_PATH)) {
>> +		/*
>> +		 * The shortname to longname conversion can fail for
>> +		 * various reasons, for example if the file has been
>> +		 * deleted.  (That is, if we just received a
>> +		 * delete-file notification event and the file is
>> +		 * already gone, we can't ask the file system to
>> +		 * lookup the longname for it.  Likewise, for moves
>> +		 * and renames where we are given the old name.)
>> +		 *
>> +		 * Since deleting or moving a file or directory by its
>> +		 * shortname is rather obscure, I'm going ignore the
>> +		 * failure and ask the caller to report the original
>> +		 * relative path.  This seems kinder than failing here
>> +		 * and forcing a resync.  Besides, forcing a resync on
>> +		 * every file/directory delete would effectively
>> +		 * cripple monitoring.
>> +		 *
>> +		 * We might revisit this in the future.
>> +		 */
>> +		return GRR_NO_CONVERSION_NEEDED;
>> +	}
>> +
>> +	if (!wcscmp(buf_in, buf_out)) {
>> +		/*
>> +		 * The path does not have a shortname alias.
>> +		 */
>> +		return GRR_NO_CONVERSION_NEEDED;
>> +	}
>> +
>> +	if (wcsncmp(buf_in, buf_out, root_len)) {
>> +		/*
>> +		 * The spelling of the root directory portion of the computed
>> +		 * longname has changed.  This should not happen.  Basically,
>> +		 * it means that we don't know where (without recomputing the
>> +		 * longname of just the root directory) to split out the
>> +		 * relative path.  Since this should not happen, I'm just
>> +		 * going to let this fail and force a shutdown (because all
>> +		 * subsequent events are probably going to see the same
>> +		 * mismatch).
>> +		 */
>> +		return GRR_SHUTDOWN;
>> +	}
>> +
>> +	/* Return the worktree root-relative portion of the longname. */
>> +
>> +	wcscpy(wpath_longname, buf_out + root_len);
>> +	return GRR_HAVE_CONVERSION;
>> +}
>> +
>>   void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
>>   {
>>   	SetEvent(state->backend_data->hListener[LISTENER_SHUTDOWN]);
>> @@ -111,7 +274,9 @@ static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
>>   	DWORD share_mode =
>>   		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
>>   	HANDLE hDir;
>> -	wchar_t wpath[MAX_PATH];
>> +	DWORD len_longname;
>> +	wchar_t wpath[MAX_PATH + 1];
>> +	wchar_t wpath_longname[MAX_PATH + 1];
>>
>>   	if (xutftowcs_path(wpath, path) < 0) {
>>   		error(_("could not convert to wide characters: '%s'"), path);
>> @@ -128,6 +293,20 @@ static struct one_watch *create_watch(struct fsmonitor_daemon_state *state,
>>   		return NULL;
>>   	}
>>
>> +	if (!GetLongPathNameW(wpath, wpath_longname, MAX_PATH)) {
>> +		error(_("[GLE %ld] could not get longname of '%s'"),
>> +		      GetLastError(), path);
>> +		CloseHandle(hDir);
>> +		return NULL;
>> +	}
>> +
>> +	len_longname = wcslen(wpath_longname);
> 
> Let's assign the return value of `GetLongPathNameW()` to `len_longname`,
> in case of success it contains the number of characters, too.

Good idea.  Thanks!

> 
> The rest of the patch looks good to me!
> 
> Thank you,
> Dscho

Thanks for you attention to detail here.
Jeff
