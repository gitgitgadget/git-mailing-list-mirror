Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AC1367
	for <git@vger.kernel.org>; Thu,  8 May 2025 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685263; cv=none; b=S2xbgFgfAKLEVpiKoK0+qen0pi1031tuWYyyv13ANC66CMpaMUMTLnMo3P56xOvjobatAW3wvxGEBNyZkCYGJtKacNN9N7pj+3wf1Km1VB8C4xUGge6YtSn0lcgXu/5LmtGPQjIJRcJBThcu4huF7Eib+4+ua9GXCA7mZ0zoOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685263; c=relaxed/simple;
	bh=JFTzsC7HpapNR+RDhrHvQbHkjpWGx2cShUGYLQz0k7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSph7D9K50IfyBk9sqROXAFJYAxl23LuVz3db4ZLVNL/gfJM+U3t0/e2ioSqFt6lEHafmnZesxq4Ef8HRK/1p4iKJMLc/HpSTiMDH+A8EkyXg2/XZpuewXH+o/Ei9GbkisEfIDqwLlJnbO7YLiitSS1rGSXcwLauA6MzCqD8YQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZtMT60QwPzRpLC;
	Thu,  8 May 2025 08:20:57 +0200 (CEST)
Message-ID: <d3922b07-d9eb-477c-aa91-35ea709ad626@kdbg.org>
Date: Thu, 8 May 2025 08:20:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gitk: Add auto-select length preference for SHA256
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, git@vger.kernel.org
Cc: Denton Liu <liu.denton@gmail.com>, Eric Huber <echuber2@illinois.edu>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Avi Halachmi <avihpit@yahoo.com>, Christoph Sommer <sommer@cms-labs.org>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20250320154136.23262-1-tiwai@suse.de>
 <20250320154136.23262-3-tiwai@suse.de>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250320154136.23262-3-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.03.25 um 16:41 schrieb Takashi Iwai:
> This implements the missing preference setup of the auto select length
> for SHA256. The variable set via the preference menu is switched
> depending on the hash algorithm.
> 
> The default auto-select length is set to 64 for SHA256, and
> saved/restored as "autosellensha256" in the config.

I think the purpose of this change is to offer different settings for
the selected length depending on the hash algorithm. If that is the
case, the commit message could do a better job describing that: it says
only what happens implementationwise, but not what the user sees.

I do not think this is necessary. If I had set the option to, say, 12, I
would not want it to be set to something else when I go to a repository
that has a different hash algorithm. (But I do not know for certain,
because I do not have any SHA256 repositories, yet.)

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  gitk-git/gitk | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 1e85cfef2ee3..b364d9e7dc93 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -7488,6 +7488,16 @@ proc make_idmark {id} {
>      $canv raise $t
>  }
>  
> +proc get_autosellen {} {
> +    global hashalgorithm autosellen autosellensha256
> +
> +    if {$hashalgorithm == "SHA256"} {
> +        return $autosellensha256
> +    } else {
> +        return $autosellen
> +    }
> +}
> +
>  proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
>      global canv ctext commitinfo selectedline
>      global canvy0 linespc parents children curview
> @@ -7496,7 +7506,7 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
>      global mergemax numcommits pending_select
>      global cmitmode showneartags allcommits
>      global targetrow targetid lastscrollrows
> -    global autocopy autoselect autosellen jump_to_here
> +    global autocopy autoselect jump_to_here
>      global vinlinediff
>  
>      unset -nocomplain pending_select
> @@ -7563,11 +7573,11 @@ proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
>      $sha1entry delete 0 end
>      $sha1entry insert 0 $id
>      if {$autoselect && [haveselectionclipboard]} {
> -        $sha1entry selection range 0 $autosellen
> +        $sha1entry selection range 0 [get_autosellen]
>      }
>      if {$autocopy} {
>          clipboard clear
> -        clipboard append [string range $id 0 [expr $autosellen - 1]]
> +        clipboard append [string range $id 0 [expr [get_autosellen] - 1]]
>      }
>      rhighlight_sel $id
>  
> @@ -9629,13 +9639,14 @@ proc mktaggo {} {
>  }
>  
>  proc copyreference {} {
> -    global rowmenuid autosellen
> +    global rowmenuid
>      global hashlength
>  
>      set format "%h (\"%s\", %ad)"
>      set cmd [list git show -s --pretty=format:$format --date=short]
> -    if {$autosellen < $hashlength} {
> -        lappend cmd --abbrev=$autosellen
> +    set alen [get_autosellen]
> +    if {$alen < $hashlength} {
> +        lappend cmd --abbrev=$alen
>      }
>      set reference [eval exec $cmd $rowmenuid]
>  
> @@ -11741,8 +11752,9 @@ proc create_prefs_page {w} {
>  proc prefspage_general {notebook} {
>      global NS maxwidth maxgraphpct showneartags showlocalchanges
>      global tabstop wrapcomment wrapdefault limitdiffs
> -    global autocopy autoselect autosellen extdifftool perfile_attrs
> +    global autocopy autoselect extdifftool perfile_attrs
>      global hideremotes want_ttk have_ttk maxrefs web_browser
> +    global hashalgorithm hashlength
>  
>      set page [create_prefs_page $notebook.general]
>  
> @@ -11771,7 +11783,13 @@ proc prefspage_general {notebook} {
>              -variable autoselect
>          grid x $page.autoselect -sticky w
>      }
> -    spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
> +
> +    if {$hashalgorithm == "SHA256"} {
> +        set autolenvar "autosellensha256"
> +    } else {
> +        set autolenvar "autosellen"
> +    }
> +    spinbox $page.autosellen -from 1 -to $hashlength -width 4 -textvariable $autolenvar
>      ${NS}::label $page.autosellenl -text [mc "Length of commit ID to copy"]
>      grid x $page.autosellenl $page.autosellen -sticky w
>  
> @@ -11908,7 +11926,7 @@ proc doprefs {} {
>      global maxwidth maxgraphpct use_ttk NS
>      global oldprefs prefstop showneartags showlocalchanges
>      global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
> -    global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
> +    global tabstop limitdiffs autoselect extdifftool perfile_attrs
>      global hideremotes want_ttk have_ttk wrapcomment wrapdefault
>  
>      set top .gitkprefs
> @@ -12606,6 +12624,7 @@ set datetimeformat "%Y-%m-%d %H:%M:%S"
>  set autocopy 0
>  set autoselect 1
>  set autosellen 40
> +set autosellensha256 64
>  set perfile_attrs 0
>  set want_ttk 1
>  
> @@ -12702,7 +12721,7 @@ config_check_tmp_exists 50
>  set config_variables {
>      mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
>      cmitmode wrapcomment wrapdefault autocopy autoselect autosellen
> -    showneartags maxrefs visiblerefs
> +    autosellensha256 showneartags maxrefs visiblerefs
>      hideremotes showlocalchanges datetimeformat limitdiffs uicolor want_ttk
>      bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
>      markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor

