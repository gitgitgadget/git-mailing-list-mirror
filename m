Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E4C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJMV60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJMV6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:58:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAAAB1DE5
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:58:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06AB51BDFA0;
        Thu, 13 Oct 2022 17:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gs+YGGwZ4pPYXgI+YDSMgaDKRaFfbF1VawBElX
        3pW90=; b=HlNqdQOWwzRUCLOpiC96Gza2w5Mgla0Y0C7ZdaC0Y2YaIhFlZ1O/Yx
        PNRDJX0DjSxlPGKAqQ3OMAng43aF6g//1N/8pL59h83DwXqAAnHNkcjGSMlcmNCj
        K7xUNSluDDa+A5eEh08ogcVytmyio//wD+jvaGMT4VhO5ikP8rWac=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3CF01BDF9F;
        Thu, 13 Oct 2022 17:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 345001BDF9E;
        Thu, 13 Oct 2022 17:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] mergetool: new config guiDefault supports auto-toggling
 gui by DISPLAY
References: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 14:58:20 -0700
In-Reply-To: <pull.1381.git.1665590389045.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Wed, 12 Oct 2022 15:59:48 +0000")
Message-ID: <xmqqedvbcrnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26FB5C6E-4B42-11ED-8EB5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +enum difftool_gui_mode {
> +	GUI_DISABLED = -1,
> +	GUI_BY_CONFIG = 0,
> +	GUI_ENABLED = 1
> +};
> +
> +static int difftool_opt_gui(const struct option *opt,
> +			      const char *optarg, int unset)
> +{
> +	enum difftool_gui_mode *mode;
> +	mode = opt->value;
> +
> +	BUG_ON_OPT_ARG(optarg);
> +
> +	if (unset)
> +		*mode = GUI_DISABLED;
> +	else
> +		*mode = GUI_ENABLED;
> +	return 0;
> +}
> +
>  int cmd_difftool(int argc, const char **argv, const char *prefix)
>  {
> -	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
> -	    tool_help = 0, no_index = 0;
> +	int dir_diff = 0, prompt = -1, symlinks = 0, tool_help = 0,
> +	    no_index = 0;
> +	enum difftool_gui_mode gui_mode;

This is left uninitialized ...


>  	static char *difftool_cmd = NULL, *extcmd = NULL;
>  	struct option builtin_difftool_options[] = {
> -		OPT_BOOL('g', "gui", &use_gui_tool,
> -			 N_("use `diff.guitool` instead of `diff.tool`")),
> +		OPT_CALLBACK_F('g', "gui", &gui_mode, NULL,
> +			       N_("use `diff.guitool` instead of `diff.tool`"),
> +			       PARSE_OPT_NOARG, difftool_opt_gui),

... and its address is used here.  When "--no-gui" or "--gui" option
is given, the callback function will fill either _DISABLED or _ENABLED
to it.

But without any command line argument?  Isn't gui_mode variable ...

>  		OPT_BOOL('d', "dir-diff", &dir_diff,
>  			 N_("perform a full-directory diff")),
>  		OPT_SET_INT_F('y', "no-prompt", &prompt,
> @@ -732,13 +755,16 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>  	} else if (dir_diff)
>  		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
>  

... still uninitialized here?  The old use_gui_tool was initialized
to 0 so it wouldn't have had this problem.

> -	die_for_incompatible_opt3(use_gui_tool, "--gui",
> +	die_for_incompatible_opt3(gui_mode == GUI_ENABLED, "--gui",
>  				  !!difftool_cmd, "--tool",
>  				  !!extcmd, "--extcmd");
>  
> -	if (use_gui_tool)
> +	if (gui_mode == GUI_ENABLED)
>  		setenv("GIT_MERGETOOL_GUI", "true", 1);

I suspect that there is no need to introduce a enum. The flow would
probably be

 * git_config(difftool_config) would learn to parse the .guiDefault
   option and initialize use_gui_tool to -1 when set to "auto" (and
   to 0 with "false", to 1 with "true").

 * Call to parse_options() then overwrites use_gui_tool with either
   0 or 1 when --no-gui or --gui is given.

 * After parse_options() returns, use_gui_tool can be examined and
   when it is 0 or 1, then nothing need to change.  The current code
   before this patch is doing what the user wants when an explicit
   command line option is given.

 * When use_gui_tool is -1, we need a new code that sets it to
   either 0 or 1 depending on the running environment.

But what is curious is that nothing in C code even looks at .guiDefault
configuration, so I am not sure why you would even need to change
anything in builtin/difftool.c file at all.

Puzzled.

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 9f99201bcca..8dbd04e5c5c 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -97,7 +97,33 @@ merge_mode () {
>  	test "$TOOL_MODE" = merge
>  }
>  
> +get_gui_default () {
> +	if diff_mode
> +	then
> +		GUI_DEFAULT_KEY="difftool.guiDefault"
> +	else
> +		GUI_DEFAULT_KEY="mergetool.guiDefault"
> +	fi
> +	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr '[:upper:]' '[:lower:]')

Avoid [:class:] when 'A-Z' 'a-z' is sufficient.  Easier to read and
you do not even need to worry about portability that way.

> +	if [ "$GUI_DEFAULT_CONFIG_LCASE" = "auto" ]
> +	then
> +		if [ -n "$DISPLAY" ]
> +		then
> +			GUI_DEFAULT=true
> +		else
> +			GUI_DEFAULT=false
> +		fi
> +	else
> +		GUI_DEFAULT=$(git config --default false --bool --get $GUI_DEFAULT_KEY)
> +	fi
> +	echo $GUI_DEFAULT
> +}

Check Documentation/CodingGuidelines with special attention to the
"for shell scripts" section?
