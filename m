Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC333C43217
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEB461168
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhKMIFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 03:05:53 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:56173 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMIFw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 03:05:52 -0500
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id DDFC2CAFF5
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 07:55:45 +0000 (UTC)
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9FBC3C0005;
        Sat, 13 Nov 2021 07:55:23 +0000 (UTC)
Date:   Sat, 13 Nov 2021 13:25:20 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com
Subject: Re: [RFC PATCH 3/4] expand regexp matching an oid to be hash agnostic
Message-ID: <20211113075520.vzy23i6b5kinaeob@yadavpratyush.com>
References: <20211011121757.627-1-carenas@gmail.com>
 <20211011121757.627-4-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011121757.627-4-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/21 05:17AM, Carlo Marcelo Arenas Belón wrote:
> Before this change, listing or blame will fail as it couldn't find the
> OID in an SHA-256 repository.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  lib/blame.tcl                | 8 ++++----
>  lib/choose_repository.tcl    | 2 +-
>  lib/remote_branch_delete.tcl | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/blame.tcl b/lib/blame.tcl
> index e6d4302..ee7db9d 100644
> --- a/lib/blame.tcl
> +++ b/lib/blame.tcl
> @@ -436,7 +436,7 @@ method _load {jump} {
>  			$i conf -state normal
>  			$i delete 0.0 end
>  			foreach g [$i tag names] {
> -				if {[regexp {^g[0-9a-f]{40}$} $g]} {
> +				if {[regexp {^g[0-9a-f]{40}(?:[0-9a-f]{24})?$} $g]} {
>  					$i tag delete $g
>  				}
>  			}
> @@ -513,7 +513,7 @@ method _history_menu {} {
>  		set c [lindex $e 0]
>  		set f [lindex $e 1]
>  
> -		if {[regexp {^[0-9a-f]{40}$} $c]} {
> +		if {[regexp {^[0-9a-f]{40}(?:[0-9a-f]{24})?$} $c]} {
>  			set t [string range $c 0 8]...
>  		} elseif {$c eq {}} {
>  			set t {Working Directory}
> @@ -635,7 +635,7 @@ method _read_blame {fd cur_w cur_d} {
>  
>  	$cur_w conf -state normal
>  	while {[gets $fd line] >= 0} {
> -		if {[regexp {^([a-z0-9]{40}) (\d+) (\d+) (\d+)$} $line line \
> +		if {[regexp {^([a-z0-9]{40}(?:[0-9a-f]{24})?) (\d+) (\d+) (\d+)$} $line line \

Since we already have oid_size, why not use that to generate the regular 
expression? That would make it much easier to add another hash of a 
different length, and make the regex easier to understand.

You can replace this with:

	regexp "^(\[a-z0-9\]{$oid_size}) (\\d+) (\\d+) (\\d+)$"

And since backslashes for escaping special string characters like '[', 
which can make the regex harder to read, you can use

	set exp [subst -nocommands -nobackslashes \
		{^([a-z0-9]{$oid_size}) (\d+) (\d+) (\d+)$}]

>  			cmit original_line final_line line_count]} {
>  			set r_commit     $cmit
>  			set r_orig_line  $original_line
> @@ -648,7 +648,7 @@ method _read_blame {fd cur_w cur_d} {
>  			set oln  $r_orig_line
>  			set cmit $r_commit
>  
> -			if {[regexp {^0{40}$} $cmit]} {
> +			if {[regexp {^0{40}(?:0{24})?$} $cmit]} {
>  				set commit_abbr work
>  				set commit_type curr_commit
>  			} elseif {$cmit eq $commit} {
> diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
> index af1fee7..e864f38 100644
> --- a/lib/choose_repository.tcl
> +++ b/lib/choose_repository.tcl
> @@ -904,7 +904,7 @@ method _do_clone_full_end {ok} {
>  		if {[file exists [gitdir FETCH_HEAD]]} {
>  			set fd [open [gitdir FETCH_HEAD] r]
>  			while {[gets $fd line] >= 0} {
> -				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
> +				if {[regexp "^([0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)\t\t" $line line HEAD]} {
>  					break
>  				}
>  			}
> diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
> index 5ba9fca..57bae9c 100644
> --- a/lib/remote_branch_delete.tcl
> +++ b/lib/remote_branch_delete.tcl
> @@ -330,7 +330,7 @@ method _read {cache fd} {
>  
>  	while {[gets $fd line] >= 0} {
>  		if {[string match {*^{}} $line]} continue
> -		if {[regexp {^([0-9a-f]{40})	(.*)$} $line _junk obj ref]} {
> +		if {[regexp {^([0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)	(.*)$} $line _junk obj ref]} {
>  			if {[regsub ^refs/heads/ $ref {} abr]} {
>  				lappend head_list $abr
>  				lappend head_cache($cache) $abr
> -- 
> 2.33.0.1081.g099423f5b7
> 

-- 
Regards,
Pratyush Yadav
