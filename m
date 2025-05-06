Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFFF1F3FF8
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560357; cv=none; b=tdA9RZq8aGl5o/o3+TsKL8CVsNTEUqoLgkHM/fkR/dmiqN+sL4gEVv+rO/ojiBdS2b0/mC6wdtTZgSaCjdCbw5LCIGWm6DjZs/McDOIaBqfJOuJKmxekDffZDcoEa+fiGG8TNk9c6b4vsgO5sm5J6j/bKsGc4X11SGeAApSYZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560357; c=relaxed/simple;
	bh=0W/M0R+gb5xzs4cVvCfGEXv+eLMUXVTHwoPxk4/Cc9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLZnK+dCajh9ZitxYLMicpw7wBwtw+Bnv81JyOHLC+0rEBHL9HTLLz2BpMqxxcoTbRYcTfLFRrRiJ5ndeYnAyqm2K0TxdGxP0tiC6mQo0regGDocBdWZ9C0b6cBJ6kZ2IMItakjKjGdNZN+TYbupQlsr7rs7pnYw9krd9/cNO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4ZsTH46JwHzRq1h;
	Tue,  6 May 2025 21:39:12 +0200 (CEST)
Message-ID: <39a90178-5989-403d-8e4e-290827eb44a3@kdbg.org>
Date: Tue, 6 May 2025 21:39:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] gitk: add external diff file rename detection
Content-Language: en-US
To: ToBoMi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: ToBoMi <tobias.boesch@miele.com>
References: <pull.1774.v3.git.1741093275742.gitgitgadget@gmail.com>
 <pull.1774.v4.git.1745830037917.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1774.v4.git.1745830037917.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.04.25 um 10:47 schrieb ToBoMi via GitGitGadget:
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
> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>

Thank you. Sorry for taking so long to respond.

In general, I like the goal of this patch.

I am not familar, yet, how renamed files are represented in Gitk.

I wonder whether it is necessary to parse diff text to find renamed file
names. When you click on a renamed file in the file list, the diff panel
jumps to the corresponding text for both the original file name and the
renamed file name. Is the information about those two names not already
available?

Would it make sense to support also copied files?

>  gitk-git/gitk | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index bc9efa18566..ddbe60398f2 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -3806,6 +3806,39 @@ proc external_diff_get_one_file {diffid filename diffdir} {
>                 "revision $diffid"]
>  }
>  
> +proc check_for_renames_in_diff {filepath} {
> +    global ctext
> +
> +    set renamed_filenames [list {}]
> +    set filename [file tail $filepath]
> +    set rename_from_text_identifier_length 12
> +    set rename_to_text_identifier_length 10
> +    set reg_expr_rename_from {^rename from (.*$filename)}

$filename can certainly have characters that are special for a regular
expression, such as the fullstop, right? They need to be escaped or this
will find the wrong file if one at all.

If this search wants to find one side of the rename, why does it ignore
the directories?

> +    set reg_expr_rename_from [subst -nobackslashes -nocommands $reg_expr_rename_from]
> +    set rename_from_text_index [$ctext search -elide -regexp -- $reg_expr_rename_from 0.0]
> +    if { ($rename_from_text_index != {})} {

Here and elsewhere in this patch we have a string comparison that uses
'!='. It should use 'ne'.

Please avoid the extra set of parentheses, even around && (below). Also,
in this code base, we do not have spaces around the condition inside {}.

> +        set reg_expr_rename_to {^rename to (.*)}
> +        set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to $rename_from_text_index]
> +        if { ($rename_from_text_index != {}) && ($rename_to_text_index != {}) } {
> +            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
> +            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
> +        }
> +        return $renamed_filenames
> +    }
> +    set reg_expr_rename_to {^rename to (.*$filename)}
> +    set reg_expr_rename_to [subst -nobackslashes -nocommands $reg_expr_rename_to]
> +    set rename_to_text_index [$ctext search -elide -regexp -- $reg_expr_rename_to 0.0]
> +    if { ($rename_to_text_index != {})} {
> +        set reg_expr_rename_from {^rename from (.*)}
> +        set rename_from_text_index [$ctext search -backwards -elide -regexp -- $reg_expr_rename_from $rename_to_text_index]
> +        if { ($rename_to_text_index != {}) && ($rename_from_text_index != {}) } {
> +            lappend renamed_filenames [$ctext get "$rename_from_text_index + $rename_from_text_identifier_length chars" "$rename_from_text_index lineend"]
> +            lappend renamed_filenames [$ctext get "$rename_to_text_index + $rename_to_text_identifier_length chars" "$rename_to_text_index lineend"]
> +        }
> +        return $renamed_filenames
> +    }
> +}
> +

Can we please have shorter variable names? They are all local variables.
I have to spend so mucht time to find the end of the variable names
before I can understand what the lines do...

>  proc external_diff {} {
>      global nullid nullid2
>      global flist_menu_file
> @@ -3836,8 +3869,16 @@ proc external_diff {} {
>      if {$diffdir eq {}} return
>  
>      # gather files to diff
> -    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
> -    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
> +    set renamed_filenames [check_for_renames_in_diff $flist_menu_file]
> +    set rename_from_filename [lindex $renamed_filenames 1]
> +    set rename_to_filename [lindex $renamed_filenames 2]
> +    if { ($rename_from_filename != {}) && ($rename_to_filename != {}) } {
> +        set difffromfile [external_diff_get_one_file $diffidfrom $rename_from_filename $diffdir]
> +        set difftofile [external_diff_get_one_file $diffidto $rename_to_filename $diffdir]
> +    } else {
> +        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
> +        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
> +    }
>  
>      if {$difffromfile ne {} && $difftofile ne {}} {
>          set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
> 
> base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff

-- Hannes

