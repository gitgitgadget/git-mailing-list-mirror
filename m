Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4335253920
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510505; cv=none; b=Q3zof/YN2HMOKAPLqeaaGPeGeqjGPKtmWWewxOfl5XAATXecGSWmzb6fWecA04UkLxB/fCN4rMneJoSj/hf7RJKgA1ljKPRkzwabBg0w0mHngjwf5hrpt7hUFS9bWTWYe4rPx+jeRRRqgThfZpRJHzrB7QbW+kcQXpJnQBu9vD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510505; c=relaxed/simple;
	bh=bk5VBuhl+4WCjw7AkW+npUWO5TNXejNRFn4PyCNVZNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=slW7bS9QL68tmTvvAlZkcQXX53k6TEajgHzAuVclpl3bt8N9eqRmUIc1KINnxPBe9W9rPwddxpdhrt4ga4DBRV/1ugmzW4qIm3zM+CZmRRAQZpsyCitrQ4D+Gfyvrq1QFh4FC31Jm0vSejyAdBemwX/jD/0lJSkH5PuIdhfnC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4bgnmt2GHXzRpLD;
	Mon, 14 Jul 2025 18:28:14 +0200 (CEST)
Message-ID: <b78bad36-d4ae-4d91-a72a-c3446e10d34b@kdbg.org>
Date: Mon, 14 Jul 2025 18:28:13 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] git-gui: Add support of SHA256 repo
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20250703120430.17240-1-tiwai@suse.de>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250703120430.17240-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.07.25 um 14:04 schrieb Takashi Iwai:
> This patch adds the basic support of SHA256 Git repositories.
> The needed changes were mostly about adjusting the fixed ID length of
> SHA1 (40) to be variable depending on the repo type.

Thank you. Being precise in the commit message would be very
appreciated. You say "mostly", which makes me wonder what the cases are
that fall not under "mostly". How about:

   Determine the hash length on startup, then replace the hard-coded
   "40" by the variable value. Also fix <foo> to do <bar> so as to
   account for <baz>.

Or make a bullet list if there is more to enumerate. Or make a
multi-patch series where each patch has its own topic if this is warranted.

Now reading on...

> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: Fix the handling in commit_committree, too
> 
>  git-gui/git-gui.sh                   | 13 ++++++++++++-
>  git-gui/lib/blame.tcl                | 12 ++++++++----
>  git-gui/lib/choose_repository.tcl    |  8 ++++++--
>  git-gui/lib/commit.tcl               |  3 ++-
>  git-gui/lib/remote_branch_delete.tcl |  4 +++-
>  5 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 28572c889c0e..206981190535 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1275,6 +1275,17 @@ if {[catch {
>  	set picked 1
>  }
>  
> +# Use object format as hash algorightm (either "sha1" or "sha256")
> +set hashalgorithm [exec git rev-parse --show-object-format]

Mental note: This raises the minimal requirement to Git 2.25.0.

> +if {$hashalgorithm eq "sha1"} {
> +	set hashlength 40
> +} elseif {$hashalgorithm eq "sha256"} {
> +	set hashlength 64
> +} else {
> +	puts stderr "Unknown hash algorithm: $hashalgorithm"
> +	exit 1
> +}
> +
>  # we expand the _gitdir when it's just a single dot (i.e. when we're being
>  # run from the .git dir itself) lest the routines to find the worktree
>  # get confused
> @@ -1822,7 +1833,7 @@ proc short_path {path} {
>  }
>  
>  set next_icon_id 0
> -set null_sha1 [string repeat 0 40]
> +set null_sha1 [string repeat 0 $hashlength]
>  
>  proc merge_state {path new_state {head_info {}} {index_info {}}} {
>  	global file_states next_icon_id null_sha1

BTW, there is a case

      if {[regexp {^[0-9a-f]{1,39}$} $head]}

around line 3217 in git-gui.sh.

> diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
> index 8441e109be32..1f0b8ea28504 100644
> --- a/git-gui/lib/blame.tcl
> +++ b/git-gui/lib/blame.tcl
> @@ -426,6 +426,7 @@ method _kill {} {
>  
>  method _load {jump} {
>  	variable group_colors
> +	global hashlength
>  
>  	_hide_tooltip $this
>  
> @@ -436,7 +437,7 @@ method _load {jump} {
>  			$i conf -state normal
>  			$i delete 0.0 end
>  			foreach g [$i tag names] {
> -				if {[regexp {^g[0-9a-f]{40}$} $g]} {
> +				if {[regexp [string map "@@ $hashlength" {^g[0-9a-f]{@@}$}] $g]} {

Github copilot insist that using 'string map' to replace parts of a
regular expression is idiomatic. However, I could not find a single
reference that it cited. Tsk, tsk, AI, what were you smoking today?

The alternatives that I tried could come up with were not any better, so
this is good.

>  					$i tag delete $g
>  				}
>  			}
> @@ -500,6 +501,8 @@ method _load {jump} {
>  }
>  
>  method _history_menu {} {
> +	global hashlength
> +
>  	set m $w.backmenu
>  	if {[winfo exists $m]} {
>  		$m delete 0 end
> @@ -513,7 +516,7 @@ method _history_menu {} {
>  		set c [lindex $e 0]
>  		set f [lindex $e 1]
>  
> -		if {[regexp {^[0-9a-f]{40}$} $c]} {
> +		if {[regexp [string map "@@ $hashlength" {^[0-9a-f]{@@}$}] $c]} {
>  			set t [string range $c 0 8]...
>  		} elseif {$c eq {}} {
>  			set t {Working Directory}
> @@ -627,6 +630,7 @@ method _exec_blame {cur_w cur_d options cur_s} {
>  method _read_blame {fd cur_w cur_d} {
>  	upvar #0 $cur_d line_data
>  	variable group_colors
> +	global hashlength
>  
>  	if {$fd ne $current_fd} {
>  		catch {close $fd}
> @@ -635,7 +639,7 @@ method _read_blame {fd cur_w cur_d} {
>  
>  	$cur_w conf -state normal
>  	while {[gets $fd line] >= 0} {
> -		if {[regexp {^([a-z0-9]{40}) (\d+) (\d+) (\d+)$} $line line \
> +		if {[regexp [string map "@@ $hashlength" {^([a-z0-9]{@@}) (\d+) (\d+) (\d+)$}] $line line \
>  			cmit original_line final_line line_count]} {
>  			set r_commit     $cmit
>  			set r_orig_line  $original_line
> @@ -648,7 +652,7 @@ method _read_blame {fd cur_w cur_d} {
>  			set oln  $r_orig_line
>  			set cmit $r_commit
>  
> -			if {[regexp {^0{40}$} $cmit]} {
> +			if {[regexp [string map "@@ $hashlength" {^0{@@}$}] $cmit]} {

This is a roundabout way to say 'if {$cmit eq $nullid}'.

>  				set commit_abbr work
>  				set commit_type curr_commit
>  			} elseif {$cmit eq $commit} {
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index d23abedcb36f..6078b1c7e2c4 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -870,6 +870,8 @@ method _do_clone_HEAD {ok} {
>  }
>  
>  method _do_clone_full_end {ok} {
> +	global hashlength
> +
>  	$o_cons done $ok
>  
>  	if {$ok} {
> @@ -879,7 +881,7 @@ method _do_clone_full_end {ok} {
>  		if {[file exists [gitdir FETCH_HEAD]]} {
>  			set fd [open [gitdir FETCH_HEAD] r]
>  			while {[gets $fd line] >= 0} {
> -				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
> +				if {[regexp [string map "@@ $hashlength" "^(.{@@})\t\t"] $line line HEAD]} {
>  					break
>  				}
>  			}

The repository picker dialog runs before $hashlength is set. Therefore,
at the time that this function is executed, $hashlength is not available.

This procedure can depend on the file format, which is to have \t\t
after the hash regardless of its length.

> @@ -965,6 +967,8 @@ method _do_clone_checkout {HEAD} {
>  }
>  
>  method _readtree_wait {fd} {
> +	global hashlength
> +
>  	set buf [read $fd]
>  	$o_status_op update_meter $buf
>  	append readtree_err $buf
> @@ -986,7 +990,7 @@ method _readtree_wait {fd} {
>  
>  	# -- Run the post-checkout hook.
>  	#
> -	set fd_ph [githook_read post-checkout [string repeat 0 40] \
> +	set fd_ph [githook_read post-checkout [string repeat 0 $hashlength] \

Yet another case where $nullid can be used.

>  		[git rev-parse HEAD] 1]
>  	if {$fd_ph ne {}} {
>  		global pch_error
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index a570f9cdc6a4..7a7394a5c89c 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -348,6 +348,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>  	global file_states selected_paths rescan_active
>  	global repo_config
>  	global env
> +	global hashlength
>  
>  	gets $fd_wt tree_id
>  	if {[catch {close $fd_wt} err]} {
> @@ -367,7 +368,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
>  		close $fd_ot
>  
>  		if {[string equal -length 5 {tree } $old_tree]
> -			&& [string length $old_tree] == 45} {
> +			&& [string length $old_tree] == [expr {$hashlength + 5}]} {

Good find!

>  			set old_tree [string range $old_tree 5 end]
>  		} else {
>  			error [mc "Commit %s appears to be corrupt" $PARENT]
> diff --git a/git-gui/lib/remote_branch_delete.tcl b/git-gui/lib/remote_branch_delete.tcl
> index 5ba9fcadd17f..8ea672479306 100644
> --- a/git-gui/lib/remote_branch_delete.tcl
> +++ b/git-gui/lib/remote_branch_delete.tcl
> @@ -323,6 +323,8 @@ method _load {cache uri} {
>  }
>  
>  method _read {cache fd} {
> +	global hashlength
> +
>  	if {$fd ne $active_ls} {
>  		catch {close $fd}
>  		return
> @@ -330,7 +332,7 @@ method _read {cache fd} {
>  
>  	while {[gets $fd line] >= 0} {
>  		if {[string match {*^{}} $line]} continue
> -		if {[regexp {^([0-9a-f]{40})	(.*)$} $line _junk obj ref]} {
> +		if {[regexp [string map "@@ $hashlength" {^([0-9a-f]{@@})	(.*)$}] $line _junk obj ref]} {
>  			if {[regsub ^refs/heads/ $ref {} abr]} {
>  				lappend head_list $abr
>  				lappend head_cache($cache) $abr

-- Hannes

