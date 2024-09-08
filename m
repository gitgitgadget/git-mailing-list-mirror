Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1B1366
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798097; cv=none; b=MSpLNcGb2XToZJRodHoMs1ZlN/3HCXw1D22zVs4ofMWS3i8O2Eze2RUOEwl7cNwdv5DwYEzwnqjDph7R0va306QkbRn+MDZTBSb90YSBrmZpl2OcctHXb15NpnwUWM/l3Lbp9laZUdyHrqKbfGTK1wRUqRJCAmCbCPtQaxkbQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798097; c=relaxed/simple;
	bh=NJ1h81uyJC48GDpbN8lkLxykIoAHQO5bm5YczQTqfRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECPHZvI/32tbF7F3k3v4yA77iERWYeMrjUY4tj8/As16mw96I2LXZ0NcXWUN9qdi8Zzo3NKqZMVXueSHRyb8PqJq6P1KAVMpM5+A+NLLJWL10aWJPSUfBnoCsF6QEuRhConfxT+79YqZsFVnz4oxTfANtDP55KKZy48hFIHsfTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4X1pwj4lz0zRnlK;
	Sun,  8 Sep 2024 14:21:24 +0200 (CEST)
Message-ID: <9c7475c8-a666-4033-a4b1-79819ba7717f@kdbg.org>
Date: Sun, 8 Sep 2024 14:21:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] git gui: add directly calling merge tool from
 gitconfig
To: ToBoMi <tobias.boesch@miele.com>
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
 <pull.1773.v3.git.1725607643479.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1773.v3.git.1725607643479.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.09.24 um 09:27 schrieb ToBoMi via GitGitGadget:
> From: Tobias Boesch <tobias.boesch@miele.com>
> 
> git gui can open a merge tool when conflicts are detected (Right click
> in the diff of the file with conflicts).
> The merge tools that are allowed to use are hard coded into git gui.
> 
> If one wants to add a new merge tool it has to be added to git gui
> through a source code change.
> This is not convenient in comparison to how it works in git (without gui).
> 
> git itself has configuration options for a merge tools path and command
> in the git config.
> New merge tools can be set up there without a source code change.
> 
> Those options are used only by pure git in contrast to git gui. git calls
> the configured merge tools directly from the config while git Gui doesn't.
> 
> With this change git gui can call merge tools configured in the gitconfig
> directly without a change in git gui source code.
> It needs a configured merge.tool and a configured mergetool.cmd config
> entry.

The configuration is "mergetool.$tool.cmd"!

Personally, I would avoid the words "gitconfig" and "config" (here and
in the rest of the commit message), neither of which are English.
"Configuration" would be OK, IMO.

> 
> gitconfig example:
> [merge]
> 	tool = vscode
> [mergetool "vscode"]
> 	path = the/path/to/Code.exe
> 	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
> 
> Without the mergetool.cmd configuration and an unsupported merge.tool
> entry, git gui behaves mainly as before this change and informs the user
> about an unsupported merge tool. In addtition it also shows a hint to add
> a config entry to use the tool as an unsupported tool with degraded
> support.
> 
> If a wrong mergetool.cmd is configured by accident, it gets handled
> by git gui already. In this case git gui informs the user that the merge
> tool couldn't be opened. This behavior is preserved by this change and
> should not change.
> 
> "Beyond Compare 3" and "Visual Studio Code" were tested as manually
> configured merge tools.
> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
> ---

>  git-gui/lib/mergetool.tcl | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
> index e688b016ef6..ccbc1a46554 100644
> --- a/git-gui/lib/mergetool.tcl
> +++ b/git-gui/lib/mergetool.tcl
> @@ -272,8 +272,24 @@ proc merge_resolve_tool2 {} {
>  		}
>  	}
>  	default {
> -		error_popup [mc "Unsupported merge tool '%s'" $tool]
> -		return
> +		set tool_cmd [get_config mergetool.$tool.cmd]
> +		if {$tool_cmd ne {}} {
> +			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
> +				error_popup [mc "Unable to process square brackets in mergetool.cmd configuration option.\
> +								Please remove the square brackets."]
> +				return

Condition and error text are OK. But see below.

> +			} else {
> +				foreach command_part $tool_cmd {
> +					lappend cmdline [subst -nobackslashes -nocommands $command_part]
> +				}

Good.

I have seen a few examples in the Tcl manual with lappend in the loop
body, and it seems to be customary to set the list variable to an empty
value before the loop, i.e.

				set cmdline {}

> +			}
> +		} else {
> +			error_popup [mc "Unsupported merge tool '%s'.\n
> +							Currently unsupported tools can be added and used as unsupported tools with degraded support\
> +							by adding the command of the tool to the \"mergetool.cmd\" option in the config.
> +							See the configuration documentation for more details." $tool]

This error message needs a bit more work (some of this also applies to
the message above):

- A tool is only unsupported as long as there is no usable
configuration. Once mergetool.$tool.cmd is set to something we can
handle, calling the tool "unsupported" isn't appropriate, I would think.
How about

Unsupported merge tool '%s'.

To use this tool, configure "mergetool.%s.cmd" as shown in the
git-config manual page.

- The configuration variable that we use is not mergetool.cmd, but
mergetool.$tool.cmd.

- Continuation lines must not be indented. Indented text appears
indented in the error message.

- Watch out whether an explicit \n is given, whether the line-break is
escaped or not; all of this has meaning.

- Looking at other multi-line error messages in git-gui.sh, the
convention is

	mc["First paragraph goes here.

Second paragraph. All of it is on one line in the source code.

Third paragraph. No \n appears anywhere."]

> +			return
> +		}
>  	}
>  	}

As a matter of personal taste, I prefer to structure code with error
exits like so (but it is totally acceptable if you disagree):

   if {check for error 1} {
       error msg1
       return
   }
   if {check for error 2} {
       error msg2
       return
   }
   regular case
   goes here
   without indentation

Note that there are no else-branches. This reduces the indentation levels.

-- Hannes

