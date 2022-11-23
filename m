Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69127C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 10:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiKWKxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 05:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiKWKxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 05:53:13 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B826120
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 02:40:18 -0800 (PST)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oxnAp-0006Mu-BO;
        Wed, 23 Nov 2022 10:40:16 +0000
Message-ID: <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
Date:   Wed, 23 Nov 2022 10:40:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 21/11/2022 19:19, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is relatively common for users to maintain identical `~/.gitconfig`
> files across all of their setups, using the `includeIf` construct
> liberally to adjust the settings to the respective setup as needed.
>
> In case of Operating System-specific adjustments, Git currently offers
> no support to the users and they typically use a work-around like this:
>
> 	[includeIf "gitdir:/home/"]
> 		path = ~/.gitconfig-linux
> 	[includeIf "gitdir:/Users/"]
> 		path = ~/.gitconfig-mac
> 	[includeIf "gitdir:C:"]
> 		path = ~/.gitconfig-windows
>
> However, this is fragile, as it would not even allow to discern between
> Operating Systems that happen to host their home directories in
> `/home/`, such as Linux and the BSDs.
>
> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
> system name, i.e. the output of `uname -s`.

This `uname -s` doesn't work well on Git-for-Windows (GfW) / Windows
because GfW has its own internal compatibility code to spoof the result.
Internally GfW sets it to "Windows" (see
https://github.com/git/git/blob/master/compat/mingw.c#L3084-L3095).

If I ask for `uname -s` on the GfW bash, for me it returns
`MINGW64_NT-10.0-19045`, both on the normal GfW install, and the GfW-SDK.

If I (as dumb user) try the CMD window prompt it's
    'uname' is not recognized as an internal or external command,
    operable program or batch file.

The Windows PowerShell also doesn't recognise the uname command.

My WSL reports `Linux`, though I haven't played with that for a while
(do all *nix variants report that?).

Thus we'll need some way of assisting the users in determining the
internal system name that their local Git will find. It maybe that the
man page just needs to be explicit about using "Windows" for the
Git-for-Windows implementation.

Or less helpful, maybe a `git-uname` command to disambiguate any other
systems with a compat::uname() variant.

Or just drop the mentions of "<uname-s>" in this commit message and
rename it 'sysname' to match the field of the struct utsname?

>
> This addresses https://github.com/git-for-windows/git/issues/4125
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     config: introduce an Operating System-specific includeIf condition
>     
>     I was about to write up guidelines how to write this patch, but it
>     turned out that it was much faster to write the patch instead.
>     
>     Changes since v1:
>     
>      * The documentation now avoids mentioning uname -s and clarifies what
>        it means by offering examples.
>      * Replaced a double space in the test case with a single one.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1429%2Fdscho%2Finclude-if-os-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1429/dscho/include-if-os-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1429
>
> Range-diff vs v1:
>
>  1:  a7eb4a9d438 ! 1:  45231533883 config: introduce an Operating System-specific `includeIf` condition
>      @@ Documentation/config.txt: As for the naming of this keyword, it is for forwards
>        
>       +`os`::
>       +	The data that follows this keyword is taken as the name of an
>      -+	Operating System; If it matches the output of `uname -s`, the
>      -+	include condition is met.
>      ++	Operating System, e.g. `Linux` or `Windows`; If it matches the
>      ++	current Operating System, the include condition is met.
>       +
>        A few more notes on matching via `gitdir` and `gitdir/i`:
>        
>      @@ t/t1309-early-config.sh: test_expect_success 'onbranch config outside of git rep
>       +		uname_s="$(uname -s)"
>       +	fi &&
>       +	test_config "includeIf.os:not-$uname_s.path" xyz &&
>      -+	test 0 = "$(git  config x.y)" &&
>      ++	test 0 = "$(git config x.y)" &&
>       +	test_config "includeIf.os:$uname_s.path" xyz &&
>       +	test z = "$(git config x.y)"
>       +'
>
>
>  Documentation/config.txt |  5 +++++
>  config.c                 | 11 +++++++++++
>  t/t1309-early-config.sh  | 16 ++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e376d547ce0..b90bcd8ecfe 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibiliy with
>  a naming scheme that supports more variable-based include conditions,
>  but currently Git only supports the exact keyword described above.
>  
> +`os`::
> +	The data that follows this keyword is taken as the name of an
> +	Operating System, e.g. `Linux` or `Windows`; If it matches the
> +	current Operating System

Is 'matches' the appropriate way to indicate that we compare just the
characters from the data string and ignore any trailing chars in the
uname.sysname field?

> , the include condition is met.
> +
>  A few more notes on matching via `gitdir` and `gitdir/i`:
>  
>   * Symlinks in `$GIT_DIR` are not resolved before matching.
> diff --git a/config.c b/config.c
> index 9b0e9c93285..9ab311ae99b 100644
> --- a/config.c
> +++ b/config.c
> @@ -394,6 +394,15 @@ static int include_by_remote_url(struct config_include_data *inc,
>  					     inc->remote_urls);
>  }
>  
> +static int include_by_os(const char *cond, size_t cond_len)
> +{
> +	struct utsname uname_info;
> +
> +	return !uname(&uname_info) &&
> +		!strncasecmp(uname_info.sysname, cond, cond_len) &&
> +		!uname_info.sysname[cond_len];
> +}
> +
>  static int include_condition_is_true(struct config_include_data *inc,
>  				     const char *cond, size_t cond_len)
>  {
> @@ -408,6 +417,8 @@ static int include_condition_is_true(struct config_include_data *inc,
>  	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
>  				   &cond_len))
>  		return include_by_remote_url(inc, cond, cond_len);
> +	else if (skip_prefix_mem(cond, cond_len, "os:", &cond, &cond_len))
> +		return include_by_os(cond, cond_len);

(as above) We compare only on the basis of the few/many characters in
the config file so, IIUC, we could use `Win`, or `Lin` as the os:
string. Should this be noted in the man text? I'm thinking of users who
may be confused by having to change Win10 to Windows, but are happy to
shorten to `Win`.
>  
>  	/* unknown conditionals are always false */
>  	return 0;
> diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
> index 537435b90ae..b36afe1a528 100755
> --- a/t/t1309-early-config.sh
> +++ b/t/t1309-early-config.sh
> @@ -100,4 +100,20 @@ test_expect_success 'onbranch config outside of git repo' '
>  	nongit git help
>  '
>  
> +test_expect_success '[includeIf "os:..."]' '
> +	test_config x.y 0 &&
> +	echo "[x] y = z" >.git/xyz &&
> +
> +	if test_have_prereq MINGW
> +	then
> +		uname_s=Windows

This (correctly) copies/follows the compat code
(https://github.com/git/git/blob/master/compat/mingw.c#L3088), but isn't
what a GfW user sees if `uname-s` is run in their bash. Maybe change
uname_s to sysname, as noted above.
> +	else
> +		uname_s="$(uname -s)"
> +	fi &&
> +	test_config "includeIf.os:not-$uname_s.path" xyz &&
> +	test 0 = "$(git config x.y)" &&
> +	test_config "includeIf.os:$uname_s.path" xyz &&
> +	test z = "$(git config x.y)"
> +'
> +
>  test_done
>
> base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
--
Philip
