Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF234171A1
	for <git@vger.kernel.org>; Sat, 31 Aug 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725112338; cv=none; b=CBqvatpeW1DwGuKJLW+o+S9yUTd6LwFrd6exFpPkvhVB/O6UWT10RgRdWg7dqllmyHGJYZRyz8fhjhwixM2MR9pAo0s/miOtmNKnO6mTAKNArhP9qhQczh0/QlNLlyi+NevxzMulAaIVB3XZSTQhc3gJe7TTy09u88k+ishGCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725112338; c=relaxed/simple;
	bh=mDL63Mv63h36wzOlMMOsi+tbYeRzbTyJl/w6CwkRcok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc8/mAg5//xw9iZg4Cr7vXZsVVYnqol9HSt4z6PmFtbsrrwy8RTYOAekzt8y5OVrwdFzZ07JLJ6LUBNfrF2He3ckB3OO8Et42OYtvFeW6S9NzJP2LCx30P4EPQzswYf8ASIy4NjWj9A2cE76CQKW3qxRWQ4+Pvqkzu4NadjrTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4WwxK35Nk3z5vdP
	for <git@vger.kernel.org>; Sat, 31 Aug 2024 15:52:07 +0200 (CEST)
Received: from [192.168.1.102] (089144221034.atnat0030.highway.webapn.at [89.144.221.34])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4WwxJs62lczRnmK;
	Sat, 31 Aug 2024 15:51:56 +0200 (CEST)
Message-ID: <61b9b041-97cf-47ac-84ef-1467aba873e3@kdbg.org>
Date: Sat, 31 Aug 2024 15:51:55 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git gui: add directly calling merge tool from
 gitconfig
To: ToBoMi <tobias.boesch@miele.com>
Cc: ToBoMi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
 <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.08.24 um 10:31 schrieb ToBoMi via GitGitGadget:
> From: deboeto <tobias.boesch@miele.com>
> 
> git gui can open a merge tool when conflicts are
> detected (Right click in the diff of the file with
> conflicts).
> The merge tools that are allowed to
> use are hard coded into git gui.
> 
> If one wants to add a new merge tool it has to be
> added to git gui through a source code change.
> This is not convenient in comparison to how it
> works in git (without gui).
> 
> git itself has configuration options for a merge tools
> path and command in the git config.
> New merge tools can be set up there without a
> source code change.
> 
> Those options are used only by pure git in
> contrast to git gui. git calls the configured
> merge tools directly from the config while git
> Gui doesn't.
> 
> With this change git gui can call merge tools
> configured in the gitconfig directly without a
> change in git gui source code.
> It needs a configured merge.tool and a configured
> mergetool.cmd config entry.

OK.

> gitconfig example:
> [merge]
> 	tool = vscode
> [mergetool "vscode"]
> 	path = the/path/to/Code.exe
> 	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"

I found it annoying that I had to configure .path in addition to .cmd.
Typically, you would put the correct path into the .cmd configuration.
In fact, `git mergetool` works without .path and fails when .cmd does
not contain the correct path.

> Without the mergetool.cmd configuration and an
> unsupported merge.tool entry, git gui behaves
> mainly as before this change and informs the user
> about an unsupported merge tool, but now also
> shows a hint to add a config entry for the tool
> in gitconfig.

Good.

While testing I configured meld incorrectly once and got no feedback
whatsoever, but I would not attribute this to this patch.

There is no such thing called "gitconfig". Just strike "in gitconfig".

> If a wrong mergetool.cmd is configured by accident
> it is beeing handled by git gui already. In this
> case git gui informs the user that the merge tool
> couldn't be opened. This behavior is preserved by
> this change and should not change.

Good.

> 
> Beyond compare 3 and Visual Studio code were
> tested as manually configured merge tools.
> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>

You updated this line, but not the From: line. Would you mind
configuring your user.name and then `git commit --amend --reset-author`?

>  git-gui/lib/mergetool.tcl | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
> index e688b016ef6..4c4e8f47bb0 100644
> --- a/git-gui/lib/mergetool.tcl
> +++ b/git-gui/lib/mergetool.tcl
> @@ -272,8 +272,14 @@ proc merge_resolve_tool2 {} {
>  		}
>  	}
>  	default {
> -		error_popup [mc "Unsupported merge tool '%s'" $tool]
> -		return
> +		set tool_cmd [get_config mergetool.$tool.cmd]
> +		if {$tool_cmd ne {}} {
> +			set tool_cmd_file_vars_resolved [subst -nobackslashes -nocommands $tool_cmd]

I just learnt that a string value containing double-quotes is broken
into a list in the expected way (keeps quoted parts together as a single
element). However, this form of substitution replaces variable values
with arbitrary text without taking into account that the original string
is actually a list. Should we not break the string into a list first,
and apply the substitution on the list elements?

If there is a straight-forward way to do this (say, an obvious two-liner
at most), we should do it. Otherwise, I can live with this solution for
now because it requires file names with double-quotes to break the
expected list nature.

There is another thing, though, that I would not want to take as
lightly: The -nocommands modifier of `subst` does not live up to its
promises, and it is even the documented behavior: command substitutions
in array indexes are still executed. Consider this configuration:

[merge]
        tool = evil
[mergetool "evil"]
        cmd = meld \"$REMOTE([exit])\"

Guess what happens when I run the merge tool? It exits Git GUI!

I suggest to reject any configuration that contains an opening bracket
'[' or anything else that introduces a command execution.

> +			set cmdline [lreplace $tool_cmd_file_vars_resolved 0 0 $merge_tool_path]
> +		} else {
> +			error_popup [mc "Unsupported merge tool '%s'. Is the tool command and path configured properly in gitconfig?" $tool]

Can we not have a more helpful text? How about

			error_popup [mc "Unsupported merge tool '%s'.

See the git-config manual page how to configure mergetool.%s.cmd
suitably." $tool $tool]

> +			return
> +		}
>  	}
>  	}
>  

-- Hannes

