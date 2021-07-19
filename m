Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BDBC636C9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC58D60FE9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354457AbhGSWTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:19:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:32800 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387207AbhGST4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 15:56:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2CC753F4104;
        Mon, 19 Jul 2021 16:36:55 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DB7143F40F4;
        Mon, 19 Jul 2021 16:36:54 -0400 (EDT)
Subject: Re: [PATCH v3 06/34] fsmonitor: config settings are
 repository-specific
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <8b64b7cd3674163adb0588d42eccf4873b30974b.1625150864.git.gitgitgadget@gmail.com>
 <87im1uc57c.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <40ab8cbc-a0fd-92a8-dd97-883c8752127d@jeffhostetler.com>
Date:   Mon, 19 Jul 2021 16:36:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87im1uc57c.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 12:46 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
> In a reference to a discussion[1] about an earlier version of this patch
> you said:
> 
>      I'm going to ignore all of the thread responses to this patch
>      dealing with how we acquire config settings and macros and etc.
>      Those issues are completely independent of FSMonitor (which is
>      already way too big).
> 
> Since then the changes to repo-settings.c have become a lot larger, so
> let's take a look...
> 
> 1. https://lore.kernel.org/git/87mttkyrqq.fsf@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/4552971c-0a23-c19a-6a23-cb5737e43b2a@jeffhostetler.com/

Yes, there was a large conversation about re-doing how config
values are acquired or whatever and it was nested inside of
the context of a completely unrelated topic.  It still is.

I would like to focus on FSMonitor using the existing config API.
I'm only looking up ~2 config values.  And that code is fairly
minor considering everything else in this patch series.

Yes, there's a bizarre initialization with memset(-1), but it
can wait.

Later (in a clean context) we can address and focus on the config
API and/or structure initialization that you're talking about here.

FWIW, in V4 I'll refactor the block of code that I added into the
body of prepare_repo_settings() to address your later concerns.
This version will hopefully be more readable.

> 
> 
>> diff --git a/repo-settings.c b/repo-settings.c
>> index 0cfe8b787db..faf197ff60a 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -5,10 +5,42 @@
>>   
>>   #define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
>>   
>> +/*
>> + * Return 1 if the repo/workdir is incompatible with FSMonitor.
>> + */
>> +static int is_repo_incompatible_with_fsmonitor(struct repository *r)
>> +{
>> +	const char *const_strval;
>> +
>> +	/*
>> +	 * Bare repositories don't have a working directory and
>> +	 * therefore, nothing to watch.
>> +	 */
>> +	if (!r->worktree)
>> +		return 1;
> 
> Looking ahead in this series you end up using
> FSMONITOR_MODE_INCOMPATIBLE in two places in the codebase. In
> builtin/update-index.c to throw a "repository is incompatible with
> fsmonitor" error.
> 
> Can't that case just be replaced with setup_work_tree()? Other sub-modes
> of update-index already die implicitly on that, e.g.:
> 
> 	$ git update-index test
> 	fatal: this operation must be run in a work tree

I will refactor that static function in V4, but I want it to return
an indication of whether the repo is compatible only and let the
command print the error/die as is appropriate for the daemon and/or
update-index.  The daemon should not start on an incompatible repo.
Likewise, update-index should not enable the extension in the index.

We share some of that code with the client side code, like status,
which wants to talk to the hook or daemon if supported/present/allowed.
If the repo is incompatible, then status should just behave in the
classic manner.  So I don't want the detection code to print those
error messages or die.

> 
> The other case is:
> 	
> 	+       prepare_repo_settings(the_repository);
> 	+       if (!the_repository->worktree)
> 	+               return error(_("fsmonitor-daemon does not support bare repos '%s'"),
> 	+                            xgetcwd());
> 	+       if (the_repository->settings.fsmonitor_mode == FSMONITOR_MODE_INCOMPATIBLE)
> 	+               return error(_("fsmonitor-daemon is incompatible with this repo '%s'"),
> 	+                            the_repository->worktree);
> 
> I.e. we just checked the_repository->worktree, but it's not that, but....

yes, I currently have 2 types of repos that I want to disable
both the hook and daemon version of FSMonitor.  I'll update the
error messages to specify the reason why we are incompatible.

> 
>> +
>> +	/*
>> +	 * GVFS (aka VFS for Git) is incompatible with FSMonitor.
>> +	 *
>> +	 * Granted, core Git does not know anything about GVFS and
>> +	 * we shouldn't make assumptions about a downstream feature,
>> +	 * but users can install both versions.  And this can lead
>> +	 * to incorrect results from core Git commands.  So, without
>> +	 * bringing in any of the GVFS code, do a simple config test
>> +	 * for a published config setting.  (We do not look at the
>> +	 * various *_TEST_* environment variables.)
>> +	 */
>> +	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_strval))
>> +		return 1;
> 
> I'm skeptical of us hardcoding a third-party software config
> variable. Can't GitVFS handle this somehow on its end?

Adding the test for a GVFS-specific config setting is questionable.
And perhaps we should move it to our downstream fork.

The value in putting it here for now (at least) is that it makes
clear the structure for supporting other types of incompatible
repos.

For example, perhaps we want to disallow repos that are on remote
file systems (since we might not be able to get FS events).  It
would be nice to be able to prevent the daemon from starting and/or
from status from trying to connect to a daemon that will be a
disappointment.  The code I have here serves as a model for adding
such additional restrictions.  And keeps us from trying to prematurely
collapse the code into a simple expression.

> 
> But just in terms of implementation it seems the end result of that is
> to emit a very confusing error to the user. Sinc we already checked for
> bare repos we run into this and instead of sayingwhen we should really
> say "hey, maybe disable your core.virtualFileSystem setting", we say
> "your repo is incompatible".
> 

I'll update the error messages to make that clear.

>> +
>> +	return 0;
>> +}
>> +
>>   void prepare_repo_settings(struct repository *r)
>>   {
>>   	int value;
>>   	char *strval;
>> +	const char *const_strval;
> 
> Can be declared in the "else" below.
> 
>>   
>>   	if (r->settings.initialized)
>>   		return;
>> @@ -26,6 +58,22 @@ void prepare_repo_settings(struct repository *r)
>>   	UPDATE_DEFAULT_BOOL(r->settings.commit_graph_read_changed_paths, 1);
>>   	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>>   
>> +	r->settings.fsmonitor_hook_path = NULL;
>> +	r->settings.fsmonitor_mode = FSMONITOR_MODE_DISABLED;
> 
> With the memset earlier (b.t.w. I've got a patch to fix all this bizarre
> behavior in repo-settings.c, but have been waiting on this series we
> implicitly set it to FSMONITOR_MODE_UNSET (-1) with the memset, but then
> never use that ever.

I'm working around the bogus -1 value that the structure has
been initialize with and that I'm inheriting.  I'll completely
set my `fsmonitor_mode` variable so that I don't care what it
is initialized to.

I created the _UNSET value as a reminder that there is this memset(-1)
there and that must be attended to.

In my V4 I'll add comments to that effect.

> 
> Your code in update-index.c then for a check against
> "FSMONITOR_MODE_DISABLED" says "core.useBuiltinFSMonitor is unset;".
> 
>> +	if (is_repo_incompatible_with_fsmonitor(r))
>> +		r->settings.fsmonitor_mode = FSMONITOR_MODE_INCOMPATIBLE;
> 
> Style: should have {} braces on all arms.
> 
>> +	else if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value)
>> +		   && value)
>> +		r->settings.fsmonitor_mode = FSMONITOR_MODE_IPC;
> 
> Here you're conflating false with whether the variable is set at all. I
> guess that works out here since if it's false we want to fall through
> to...
> 
>> +	else {
> 
> ...ignoring it and looing at core.fsmonitor instead.

yes, if core.useBuiltinFSMonitor is true, we do not need to look
at the hook pathname.

> 
>> +		if (repo_config_get_pathname(r, "core.fsmonitor", &const_strval))
>> +			const_strval = getenv("GIT_TEST_FSMONITOR");
> 
> If it's not set we pay attention to GIT_TEST_FSMONITOR, so the behavior
> from the old git_config_get_fsmonitor(). So even if the env variable is
> set we want to take the config variable over it, correct?

GIT_TEST_FSMONITOR sets the hook path for testing and we're not using
the hook API at all.  So it is kind of ill-defined what that test env
var should do if you have IPC turned on, so I'm ignoring it.

> 
>> +		if (const_strval && *const_strval) {
>> +			r->settings.fsmonitor_hook_path = strdup(const_strval);
> 
> We had a strbuf_detach()'d string in the case of
> repo_config_get_pathname(), but here we strdup() it again in case we
> were in the getenv() codepath. This code probably leaks memory now
> anyway, but perhaps it's better to split up the two so we make it easier
> to deal with who owns/frees what in the future.
> 

repo_config_get_pathname() returns a const char** which implies that
it is not a detached buffer.  it is a deep trek thru the config code,
but it eventually gets to git_configset_get_*() which is documented as
returning a pointer into a configset cache and that the caller should
not free it.  so dup'ing it is appropriate.

Similarly, getenv() is also returning a pointer to a buffer that the
caller does not own.  so dup'ing it here is also appropriate.

Thanks,
Jeff
