Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C8B5684
	for <git@vger.kernel.org>; Sat, 24 Aug 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508785; cv=none; b=E6TlneI9AjpwFk/5WMYKyuQXx2SzTl7g62ieYQVg3YUSbpOsLYJd3Wp2bXKr45GQlj1xnr8uUFFxVv8CNkS6YQkYqb3flxzoCC1dKHmvcPjJ0muZXHY1TDdvmQDYhb09Tc3Sbuk5//G/qFB6VS+eSbK79kToy+TXZxr8RkG+tGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508785; c=relaxed/simple;
	bh=WIN+YmNVxOitL10BCtIQPpV6+NStjXRZ6/KRuriNKQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEYWEzeN4VP/iHZKa6ui37pBFmZvRm+8eN7mWKG0UgCVTPD98wjHl/tU7RsH1GO0PeksB8vt4alaE3q8BYb+/ypOzTwxxbSYf3d2eLdZJAL4PgUpooa5neu3/CHZEIi1bEwWKT4h4VJt+1hcwD/Z7lnB/5F0SnjENUW1G4OiP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WrdLc1Qzgz5v89
	for <git@vger.kernel.org>; Sat, 24 Aug 2024 15:38:32 +0200 (CEST)
Received: from [192.168.1.102] (089144221034.atnat0030.highway.webapn.at [89.144.221.34])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4WrdLS100DzRnmF;
	Sat, 24 Aug 2024 15:38:23 +0200 (CEST)
Message-ID: <57d00f50-c652-4357-bf9b-02b93f99cfb5@kdbg.org>
Date: Sat, 24 Aug 2024 15:38:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git gui: add directly calling merge tool from gitconfig
To: ToBoMi <tobias.boesch@miele.com>
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 19.08.24 um 13:29 schrieb ToBoMi via GitGitGadget:
> From: deboeto <tobias.boesch@miele.com>
> 
> * git Gui can open a merge tool when conflicts are
>     detected. The merge tools that are allowed to
>     call have to be hard coded into git Gui
>     althgough there are configuration options for
>     merge tools git in the git config. Git calls
>     the configured merge tools directly from the
>     config while git Gui doesn't.
> * git Gui can now call the tool configured in the
>     gitconfig directly.
> * Can be enabled through setting
>     gui.mergeToolFromConfig

Can we do better than having a new configuration variable? Let's say you
have configured merge.tool=vscode. This tool is not supported, but you
have configured mergetool.vscode.cmd suitably. Can we not use the latter
configuration variable unconditionally?

Likewise, say, you have configured merge.tool=bc3. This one *is*
supported. What could go wrong if mergetool.bc3.cmd is used instead of
the built-in command line? The behavior would change for users that
configured mergetool.$tool.cmd for a supported tool. But would it change
for the worse?

BTW, the code builds different command lines depending on whether a base
file is available or not. How does mergetool.$tool.cmd handle the cases?

> * Disabled by default, since option is most likely
>     never set
> * bc3 and vscode tested
> 
> Signed-off-by: deboeto <tobias.boesch@miele.com>

Some remarks on the commit message:

- The Signed-off-by line has legal consequences. Therefore, we require
that authors use their genuine name, not an alias. Also, the From line
must match the Signed-off-by line.

- Please have a look at the commit messages in the code base. The
formatting presented here is very unusual. Please write in full
sentences including punctuation, and use paragraphs where needed.

- Please state the problem that is being solved (in present tense). This
should motivate the change, i.e., provide a convincing argument why the
change is needed. Then state what the solution is in imperative mood,
that is, an instruction to the code to change in such and such way. Use
examples to clarify how the new feature can be used.

> ---
>     git gui: add directly calling merge tool from gitconfig
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1773%2FToBoMi%2Fadd_merge_tool_from_config_file-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1773/ToBoMi/add_merge_tool_from_config_file-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1773
> 
>  Documentation/config/gui.txt |  4 ++++
>  git-gui/lib/mergetool.tcl    | 11 +++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/gui.txt b/Documentation/config/gui.txt
> index 171be774d24..e63d0b46e7c 100644
> --- a/Documentation/config/gui.txt
> +++ b/Documentation/config/gui.txt
> @@ -55,3 +55,7 @@ gui.blamehistoryctx::
>  	linkgit:gitk[1] for the selected commit, when the `Show History
>  	Context` menu item is invoked from 'git gui blame'. If this
>  	variable is set to zero, the whole history is shown.
> +
> +gui.mergeToolFromConfig::
> +	If true, allow to call the merge tool configured in gitconfig
> +	in git gui directly.
> \ No newline at end of file

Unfortunately, Documentation/config/gui.txt is not part of the Git GUI
repository. Any changes to the documentation must be submitted as
separate patch.

Please be careful not to introduce an incomplete last lines. Take note
of "No newline at end of file". It should not be there.

> diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
> index e688b016ef6..fbd0889612a 100644
> --- a/git-gui/lib/mergetool.tcl
> +++ b/git-gui/lib/mergetool.tcl
> @@ -272,8 +272,15 @@ proc merge_resolve_tool2 {} {
>  		}
>  	}
>  	default {
> -		error_popup [mc "Unsupported merge tool '%s'" $tool]
> -		return
> +		if {[is_config_true gui.mergetoolfromconfig]} {
> +			set path [get_config mergetool.$tool.path]

At this point, the value assigned to $path here is already available in
$merge_tool_path.

> +			set cmdline_config [get_config mergetool.$tool.cmd]
> +			set cmdline_substituted [subst -nobackslashes -nocommands $cmdline_config]
> +			set cmdline [lreplace $cmdline_substituted 0 0 $path]

I haven't yet taken the time to study what these lines do (I am far from
fluent in Tcl) and have no opinion, yet.

> +		} else {
> +			error_popup [mc "Unsupported merge tool '%s'" $tool]
> +			return
> +		}
>  	}
>  	}
>  
> 
> base-commit: b9849e4f7631d80f146d159bf7b60263b3205632

-- Hannes

