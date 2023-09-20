Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA4CE79CE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 13:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjITNF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbjITNFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F1C2
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 06:05:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 482C14000D;
        Wed, 20 Sep 2023 13:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadavpratyush.com;
        s=gm1; t=1695215117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDyNzEMV4NDhXPAJNv/HJ8uufKmSfuW/BETT/54m+lg=;
        b=gn9DLIGMAA/SLgBIhnFAGY6R6C2sZ9Lwrhebw3KSXiEl3GOBTUp/4cYHX90ld/1um5lhy+
        NaVz457AmKk3Qc1Z9mGCCQiKm/4pQv2EQ2JFsUDJE28EylGmk+Zmr3pxiv0fxsPNJ7AeQl
        a+rZiDaqZEV6KW8G4u7M3PATaH9h53dpq1mg3CmEocjdTB1lBJ0cuy5AFR+q/tUgdN+P7P
        ag1Q2fX3QwU/IAiX6SOPBNtlEFyfO5yQJpvxIhQGT4IIwKRVoPMLDJdym0t3MPTcXNakun
        PsRNKx9uQzRqALyzjcoI7/UDQMgkCIGv+c4yaQQN5eW8vfYL2BtXxtBvr/12Xw==
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        me@yadavpratyush.com, git@vger.kernel.org
Subject: Re: [PATCH] git-gui - use git-hook, honor core.hooksPath
In-Reply-To: <20230917192431.101775-1-mlevedahl@gmail.com> (Mark Levedahl's
        message of "Sun, 17 Sep 2023 15:24:31 -0400")
References: <fa876f80-02dc-2c04-0db3-bf3f6269b427@gmail.com>
        <20230917192431.101775-1-mlevedahl@gmail.com>
Date:   Wed, 20 Sep 2023 15:05:15 +0200
Message-ID: <mafs01qetq9kk.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: me@yadavpratyush.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the patch.

On Sun, Sep 17 2023, Mark Levedahl wrote:

> git-gui currently runs some hooks directly using its own code written
> before 2010, long predating git v2.9 that added the core.hooksPath
> configuration to override the assumed location at $GIT_DIR/hooks.  Thus,
> git-gui looks for and runs hooks including prepare-commit-msg,
> commit-msg, pre-commit, post-commit, and post-checkout from
> $GIT_DIR/hooks, regardless of configuration. Commands (e.g., git-merge)
> that git-gui invokes directly do honor core.hooksPath, meaning the
> overall behaviour is inconsistent.
>
> Furthermore, since v2.36 git exposes its hook exection machinery via
> git-hook run, eliminating the need for others to maintain code
> duplicating that functionality.  Using git-hook will both fix git-gui's
> current issues on hook configuration and (presumably) reduce the
> maintenance burden going forward. So, teach git-gui to use git-hook.

In the past, git-gui has tried to keep backward compatibility with all
versions of Git, not just the latest ones. v2.36 is relatively new and
this code would not work for anyone using an older version of Git.

I have largely followed this practice for all the code I have written
but I am not sure if it is a good idea to insist on it -- especially if
it would end up adding some more complexity. I would be interested to
hear what other people think about this.

Junio, I was under the impression that I would keep maintaining the tree
until we found a replacement maintainer. If you are okay with being the
interim maintainer, that sounds good to me. Let me know what works best.

I have applied another patch since my last pull request. So I can apply
this one, send you a new one and sync our trees.

>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 8603437..3e5907a 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -661,31 +661,8 @@ proc git_write {args} {
>  }
>  
>  proc githook_read {hook_name args} {
> -	set pchook [gitdir hooks $hook_name]
> -	lappend args 2>@1
> -
> -	# On Windows [file executable] might lie so we need to ask
> -	# the shell if the hook is executable.  Yes that's annoying.
> -	#
> -	if {[is_Windows]} {
> -		upvar #0 _sh interp
> -		if {![info exists interp]} {
> -			set interp [_which sh]
> -		}
> -		if {$interp eq {}} {
> -			error "hook execution requires sh (not in PATH)"
> -		}
> -
> -		set scr {if test -x "$1";then exec "$@";fi}
> -		set sh_c [list $interp -c $scr $interp $pchook]
> -		return [_open_stdout_stderr [concat $sh_c $args]]
> -	}
> -
> -	if {[file executable $pchook]} {
> -		return [_open_stdout_stderr [concat [list $pchook] $args]]
> -	}
> -
> -	return {}
> +	set cmd [concat git hook run --ignore-missing $hook_name -- $args 2>@1]
> +	return [_open_stdout_stderr $cmd]

LGTM, other than my concerns with backward compatibility.

>  }
>  
>  proc kill_file_process {fd} {

-- 
Regards,
Pratyush Yadav
