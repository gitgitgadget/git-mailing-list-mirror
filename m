Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F315A86B
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750832622; cv=none; b=rE3T9Led7poi/0CFopFaJfeQMBYGCpc40nJtnQeXEjIamHDw/yvcnX6kiH6+ur4mFsQmDydNM2YlwUPy+q4Qxo2yXkZrY2p+5aohfXlVCTbuMJCrGDOM4d6eEVUXH4DRsFZisVGs4uRZ71OoNIkE6fx18QWw5J6hhN02mZ6mhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750832622; c=relaxed/simple;
	bh=WJJ1MY2chFYnW+Jau4ZYM1QZkCIJwGZLTer2kCK82+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1VgCSKGQBh+iAMw5GuDYrut9qyMNfroG5PgTJ/sKpQWZRe8/lAJxrGWHpHULd6fkl/Umo3OUb4UX7VssO9yOP4LXCqt3MW+HZnDZna8GwhUTp2oYCmBEvNJewwtZPOyEUW/4l3KHLis42PzseQKwnnainzN3wiuROOraMhgLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bRsFv5btXz7RMh9
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:23:31 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bRsFl4J1XzRmwt;
	Wed, 25 Jun 2025 08:23:23 +0200 (CEST)
Message-ID: <be10d14f-d6f6-487a-b520-0bd56e5550e8@kdbg.org>
Date: Wed, 25 Jun 2025 08:23:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] gitk: add external diff file rename detection
To: tobias.boesch@miele.com
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1774.v5.git.1749544174590.gitgitgadget@gmail.com>
 <pull.1774.v6.git.1750755954011.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1774.v6.git.1750755954011.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.06.25 um 11:05 schrieb ToBoMi via GitGitGadget:
> From: Tobias Boesch <tobias.boesch@miele.com>
> 
> If a file is renamed between commits and an external diff is started
> through gitk on the original or the renamed file name,
> gitk is unable to open the renamed file in the external diff editor.
> It fails to fetch the renamed file from git, because it fetches it
> using its original path in contrast to using the renamed path of the
> file.
> Detect the rename and open the external diff with the original and
> the renamed file instead of no file (fetch the renamed file path and
> name from git) no matter if the original or the renamed file is
> selected in gitk.
> Since moved or renamed file are handled the same way do this also
> for moved files.

In Git parlance, when we talk about "renamed" files, we always mean
files that have any part of the path name changed (and not just the last
path component). Therefore, this last sentence is redundant.

>     Changes sine v4:
>     
>      * Use a git command to gather the changed file paths rather than
>        parsing the text from the diff window panel for efficiency and to
>        avoid regex containing the filename as a variable.

An earlier round parsed the rename information from the patch text
panel. I argued that it should not be necessary, because the file list
already knows how to scroll the diff text panel to the correct section
and should already what was renamed. It turns out it's not that simple.

But I still think that this information can be leveraged for this new
purpose and that it is not necessary to invoke an external process. At a
minimum, it should be possible to parse off the rename information from
a smaller section of the patch text, because we know where the section
pertaining to the file of interest starts. Look for uses of the variable
'difffilestart'.

I think that the goal of this patch can be achieved easier by parsing
the patch text panel rather than parsing the output of another `git`
command. I'll still comment on the presented solution just in case it
turns out we must invoke `git` anyway.

> +    set renames [list {}]

This constructs a list with one element that is the empty string. I
assume you meant one of these:

    set renames [list]
    set renames {}

> +    if {[catch {eval exec git diff $rev --find-renames --stat --raw --diff-filter=R} cmd_result]} {

A few things I have to note here:

- Don't use porcelain commands, use plumbing commands, i.e., `git
diff-tree`, `git diff-index`, and `git diff-files` instead of `git diff`.
- Place non-option arguments after all options.
- Why use --stat?
- --numstat may be easier to parse than --raw, but see below.

> +        error_popup "[mc "Error getting file rename info for file \"%s\" from commit %s to %s." \
> +                            $filepath $diffidfrom $diffidto] $cmd_result.\n\n"
> +    }
> +    set filename [file tail $filepath]
> +    set esc_chars {\\ | ? ^ * . $ \[ \] + \( \) \{ \}}
> +    foreach char $esc_chars {
> +        set filename [string map [list $char \\$char] $filename]
> +    }
> +    set regex_base {\d+\s\d+\s\S+\s\S+\s\S+\s+}
> +    set regex_ren_from $regex_base[subst -nobackslashes -nocommands {(\S+$filename)\s+(\S+)}]

This regular expression wants to parse the first of the two file names
that are on the output line. But it assumes that the second of the two
names cannot contain spaces: '(\S+)'. This is not a valid assumption.

Note that the output format of --raw is very restricted. In particular,
the file names are separated from the rest not by space of any kind, but
by TAB. A much stricter regular expression can be used. But still, TAB
is a character that is permitted in file names, and the regular
expression could match still match incorrectly. You can use -z to
separate the parts with a zero byte in an unambiguous way and split the
parts without a regular expression.

> +    set regex_ren_to $regex_base[subst -nobackslashes -nocommands {(\S+)\s+(\S+$filename)}]

I don't understand the purpose of 'subst' here. Is this not just

    set regex_ren_to $regex_base{(\S+)\s+(\S+}$filename{)}

> @@ -3805,8 +3847,16 @@ proc external_diff {} {
>      if {$diffdir eq {}} return
>  
>      # gather files to diff
> -    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
> -    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
> +    set renamed_filenames [check_for_renames_in_diff $diffidfrom $diffidto $flist_menu_file]
> +    set rename_from_filename [lindex $renamed_filenames 1]
> +    set rename_to_filename [lindex $renamed_filenames 2]
> +    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {

This expression doesn't follow the pattern that we see elsewhere, e.g.,
in the context below.

Please lose the redundant "_filename" in the variable names. In this
context, it's clear that these are names, not indices or somehthing
else. Also, when you look around, you notice that we normally don't use
the underscore in variable names.

> +        set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
> +        set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
> +    } else {
> +        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
> +        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
> +    }
>  
>      if {$difffromfile ne {} && $difftofile ne {}} {
>          set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]

-- Hannes

