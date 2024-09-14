Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236C1CF7D7
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322796; cv=none; b=F9T8ZVHLooX/6mKO5u2mfp6B6fr/VUqrRUv/WipAy+1CSlH5VuZKtP5O3BtWpJGzFpvGFW5V+eykJKdU2Rb75S3uK24K3ZCNxrTBnzWNkMOgoiFweZcbFUwD27fikz9L/6NaLP5+p8b5pMSa+gbRhaBqSTTf3QkVjJAazTN6n8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322796; c=relaxed/simple;
	bh=If3HZQNMUcdlakopUmMD0SX3CA3/KjftLY+W+Y3Yi6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9OUeavhoHOWprt91plnrwEdOovL7nbAaCfSznm2/xfdPUdisg8BuXJPVu/pjNrs1HkpZe2I9deDkUr2yVwjg0yQmxVL6cDLRZGi1V0zOwDi0wYbIroBuqsOrAKGh6HOGUtZXd8GW4ygqIjEpLB4dptP+B0FQPhrGVjfgM2oBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4X5XDN697xz5vPv
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 15:32:52 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4X5XDC0YbfzRnlK;
	Sat, 14 Sep 2024 15:32:41 +0200 (CEST)
Message-ID: <2ee3a148-23eb-48cb-8e10-551437fb03d3@kdbg.org>
Date: Sat, 14 Sep 2024 15:32:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] git gui: add directly calling merge tool from
 configuration
To: ToBoMi <tobias.boesch@miele.com>
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1773.v4.git.1726064619705.gitgitgadget@gmail.com>
 <pull.1773.v5.git.1726136277300.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1773.v5.git.1726136277300.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.09.24 um 12:17 schrieb ToBoMi via GitGitGadget:
> Configuration example:
> [merge]
> 	tool = vscode
> [mergetool "vscode"]
> 	path = the/path/to/Code.exe
> 	cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"

This example is not up-to-date anymore, is it?

Also, below are two cases where "mergetool.cmd" is mentioned
incorrectly.

> Without the "mergetool.cmd" configuration and an unsupported "merge.tool"
> entry, git gui behaves mainly as before this change and informs the user
> about an unsupported merge tool. In addtition it also shows a hint to add
> a configuration entry to use the tool as an unsupported tool with degraded
> support.
> 
> If a wrong "mergetool.cmd" is configured by accident, it gets handled
> by git gui already. In this case git gui informs the user that the merge
> tool couldn't be opened. This behavior is preserved by this change and
> should not change.

> --- a/git-gui/lib/mergetool.tcl
> +++ b/git-gui/lib/mergetool.tcl
> @@ -272,8 +272,26 @@ proc merge_resolve_tool2 {} {
>  		}
>  	}
>  	default {
> -		error_popup [mc "Unsupported merge tool '%s'" $tool]
> -		return
> +		set tool_cmd [get_config mergetool.$tool.cmd]
> +		if {$tool_cmd ne {}} {
> +			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
> +				error_popup [mc "Unable to process square brackets in mergetool.$tool.cmd configuration option.

This $tool in the format string breaks [mc]. It must be %s and an
argument. I'll fix this up while queuing.

> +
> +Please remove the square brackets."]
> +				return
> +			} else {
> +				set cmdline {}
> +				foreach command_part $tool_cmd {
> +					lappend cmdline [subst -nobackslashes -nocommands $command_part]
> +				}
> +			}
> +		} else {
> +			error_popup [mc "Unsupported merge tool '%s'.
> +
> +To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config\> +manual page." $tool $tool]

I am surprised that the backslash does not paste the two lines together
without a space. "git-config" and "manual" do appear as separate words
in the error message. Nevertheless, since I do not know how this pans
out in the translation files, I will remove the line continuation and
write all on one line.

> +			return
> +		}
>  	}
>  	}

Thank you for your contribution! Below is the range-diff between this
submission and the queued version.

-- Hannes

1:  03e92d6 ! 1:  8ff65c7 git gui: add directly calling merge tool from configuration
    @@ Commit message
         [merge]
                 tool = vscode
         [mergetool "vscode"]
    -            path = the/path/to/Code.exe
    -            cmd = \"Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
    +            cmd = \"the/path/to/Code.exe\" --wait --merge \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
     
    -    Without the "mergetool.cmd" configuration and an unsupported "merge.tool"
    -    entry, git gui behaves mainly as before this change and informs the user
    -    about an unsupported merge tool. In addtition it also shows a hint to add
    -    a configuration entry to use the tool as an unsupported tool with degraded
    -    support.
    +    Without the "mergetool.<mergetool name>.cmd" entry and an unsupported
    +    "merge.tool" entry, git gui behaves mainly as before this change and
    +    informs the user about an unsupported merge tool. In addtition, it also
    +    shows a hint to add a configuration entry to use the tool as an
    +    unsupported tool with degraded support.
     
    -    If a wrong "mergetool.cmd" is configured by accident, it gets handled
    -    by git gui already. In this case git gui informs the user that the merge
    -    tool couldn't be opened. This behavior is preserved by this change and
    -    should not change.
    +    If a wrong "mergetool.<mergetool name>.cmd" is configured by accident,
    +    it gets handled by git gui already. In this case git gui informs the
    +    user that the merge tool couldn't be opened. This behavior is preserved
    +    by this change and should not change.
     
         "Beyond Compare 3" and "Visual Studio Code" were tested as manually
         configured merge tools.
     
         Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
    +    Signed-off-by: Johannes Sixt <j6t@kdbg.org>
     
      ## lib/mergetool.tcl ##
     @@ lib/mergetool.tcl: proc merge_resolve_tool2 {} {
    @@ lib/mergetool.tcl: proc merge_resolve_tool2 {} {
     +		set tool_cmd [get_config mergetool.$tool.cmd]
     +		if {$tool_cmd ne {}} {
     +			if {([string first {[} $tool_cmd] != -1) || ([string first {]} $tool_cmd] != -1)} {
    -+				error_popup [mc "Unable to process square brackets in mergetool.$tool.cmd configuration option.
    ++				error_popup [mc "Unable to process square brackets in \"mergetool.%s.cmd\" configuration option.
     +
    -+Please remove the square brackets."]
    ++Please remove the square brackets." $tool]
     +				return
     +			} else {
     +				set cmdline {}
    @@ lib/mergetool.tcl: proc merge_resolve_tool2 {} {
     +		} else {
     +			error_popup [mc "Unsupported merge tool '%s'.
     +
    -+To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config\
    -+manual page." $tool $tool]
    ++To use this tool, configure \"mergetool.%s.cmd\" as shown in the git-config manual page." $tool $tool]
     +			return
     +		}
      	}

