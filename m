Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD9381C4
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281543; cv=none; b=HNTSpNe6O0XgDR/22dVhtViCGnzlVI4YshBPdhjrhtAaKOKj0W3JEsc9E1OKIx+OWPHrplDjZakRDckOlsiwdqbRroYwktiuxIFZxWWjSD3v9aUGjcBuOwwII9HYlLyt/qdWEWKMGHW2KvdXLLtk0eYIK52/1JcGrX93+4H7BJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281543; c=relaxed/simple;
	bh=xGxGcPzp+qlXvVFPOmcHe3YaOYM6LK/1uAvzQ0XRzsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJ0uUuZXjA5224ymlhrWToiST7Up/q2dgWOQ1vESr2WhLZc+Wo4Jm3M08CC371hgy1l1ZBHtXEh74Fmi3gf3paxGLJpRGjpoLxQxpKL6fv51JvGxlF/HLQtpPg8JJMZRad+SdrRQbOPNfgx3jpmKkCEXBUjsVi//IkPOoZcVO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4d1GZV5RH0z7R4wh
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 19:05:06 +0100 (CET)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4d1GZL0dLwzRq1q;
	Tue,  4 Nov 2025 19:04:57 +0100 (CET)
Message-ID: <1a180754-bbb1-48ca-84d4-8915201d086f@kdbg.org>
Date: Tue, 4 Nov 2025 19:04:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] gitk: add external diff file rename detection
To: tobias.boesch@miele.com
Cc: git@vger.kernel.org, ToBoMi via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1774.v6.git.1750755954011.gitgitgadget@gmail.com>
 <pull.1774.v7.git.1761905371163.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1774.v7.git.1761905371163.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 31.10.25 um 11:09 schrieb ToBoMi via GitGitGadget:
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

Make a mental note of this sentence.

> 
> Signed-off-by: Tobias Boesch <tobias.boesch@miele.com>
> ---

>     Changes since v6:
>      * Change logic that checks the renames and gathers the file paths to
>        use the difffilestart variable for efficient file path extraction

Nice to see this change!

>  gitk-git/gitk | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index c02db0194d..8f8f1cb9ab 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -3788,6 +3788,34 @@ proc external_diff_get_one_file {diffid filename diffdir} {
>                 "revision $diffid"]
>  }
>  
> +proc check_for_renames_in_diff {filepath} { # renames
> +    global difffilestart ctext
> +
> +    set filename [file tail $filepath]
> +    set renames {}
> +    
> +    foreach loc $difffilestart {
> +        set loclineend [string map {.0 .end} $loc]
> +        set ctextline [$ctext get $loc $loclineend]
> +        if {[string first $filename $ctextline] != -1} {

At this point, we are looking at the separator line, which contains the
renamed-to file name. This means that we skip the following if the
renamed-from file name was selected in the file list. The consequence is
that the external diff shows differences between renamed files only when
the renamed-to file name was selected, in contrast to what the commit
message announces.

I suggest to check the file names extracted from the "renamed from" and
"renamed to" lines instead.

> +            set fromlineloc "$loc + 2 lines"
> +            set tolineloc "$loc + 3 lines"
> +            set renfromline [$ctext get $fromlineloc [string map {.0 .end} $fromlineloc]]
> +            set rentoline [$ctext get $tolineloc [string map {.0 .end} $tolineloc]]
> +            if {[string match "rename from *" $renfromline]
> +                && [string match "rename to *" $rentoline]} {

These could be [string equal ...] with -length 12 and 10, respectively.

> +                set renfrom [string range $renfromline 12 end]
> +                set rento [string range $rentoline 10 end]

Here we now have a problem if the file names are not plain ASCII. Then
we see escaped file names here. I consider this an independent bug in
Gitk, and we can ignore the problem for now in this patch.

> +                lappend renames $renfrom
> +                lappend renames $rento
> +                break
> +            }
> +        }
> +    }
> +    
> +    return $renames
> +}
> +
>  proc external_diff {} {
>      global nullid nullid2
>      global flist_menu_file
> @@ -3818,8 +3846,16 @@ proc external_diff {} {
>      if {$diffdir eq {}} return
>  
>      # gather files to diff
> -    set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
> -    set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
> +    set renames [check_for_renames_in_diff $flist_menu_file]
> +    set renamefrom [lindex $renames 0]
> +    set renameto [lindex $renames 1]
> +    if { ($renamefrom != {}) && ($renameto != {}) } {

Please let's write this as

    if {$renamefrom ne {} && $renameto ne {}} {

> +        set difffromfile [external_diff_get_one_file $diffidfrom $renamefrom $diffdir]
> +        set difftofile [external_diff_get_one_file $diffidto $renameto $diffdir]
> +    } else {
> +        set difffromfile [external_diff_get_one_file $diffidfrom $flist_menu_file $diffdir]
> +        set difftofile [external_diff_get_one_file $diffidto $flist_menu_file $diffdir]
> +    }
>  
>      if {$difffromfile ne {} && $difftofile ne {}} {
>          set cmd [list [shellsplit $extdifftool] $difffromfile $difftofile]
> 
> base-commit: 57da342c786f59eaeb436c18635cc1c7597733d9

-- Hannes

