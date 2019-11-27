Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B95C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 21:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACFD21569
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 21:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfK0VzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:55:10 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45611 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfK0VzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 16:55:09 -0500
X-Originating-IP: 1.186.12.45
Received: from localhost (unknown [1.186.12.45])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A128EE0003;
        Wed, 27 Nov 2019 21:55:05 +0000 (UTC)
Date:   Thu, 28 Nov 2019 03:25:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Subject: Re: [PATCH v5 2/3] git-gui: update status bar to track operations
Message-ID: <20191127215503.x2lt2b3nce7q4yj2@yadavpratyush.com>
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
 <pull.436.v5.git.1574627876.gitgitgadget@gmail.com>
 <aa05a78d285dd9c5f4897b03467f1d43d7a5ad83.1574627876.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa05a78d285dd9c5f4897b03467f1d43d7a5ad83.1574627876.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for the re-roll.

On 24/11/19 08:37PM, Jonathan Gilbert via GitGitGadget wrote:
> From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> 
> Update the status bar to track updates as individual "operations" that
> can overlap. Update all call sites to interact with the new status bar
> mechanism. Update initialization to explicitly clear status text,
> since otherwise it may persist across future operations.
> 
> Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> ---
>  git-gui.sh          |   7 +-
>  lib/blame.tcl       |  22 +++--
>  lib/checkout_op.tcl |  15 +--
>  lib/index.tcl       |  31 +++---
>  lib/merge.tcl       |  14 ++-
>  lib/status_bar.tcl  | 228 +++++++++++++++++++++++++++++++++++++++-----
>  6 files changed, 260 insertions(+), 57 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 0d21f5688b..db02e399e7 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1797,10 +1797,10 @@ proc ui_status {msg} {
>  	}
>  }
>  
> -proc ui_ready {{test {}}} {
> +proc ui_ready {} {

This is not quite correct. There is one user of 'ui_ready' that uses 
'test'. It is in git-gui.sh:2211. It is used when starting gitk. This 
change breaks that call. 10 seconds after opening gitk via the 
"Visualise master's history" option, I get the following error:

  wrong # args: should be "ui_ready"
      while executing
  "ui_ready $starting_gitk_msg"
      ("after" script)
 
The code that calls it (git-gui.sh:2211) looks like:

  ui_status $::starting_gitk_msg
  after 10000 {
  	ui_ready $starting_gitk_msg
  }

I am not quite sure why this is done though. It was introduced in 
e210e67 (git-gui: Corrected keyboard bindings on Windows, improved state 
management., 2006-11-06) [0], but the commit message doesn't really 
explain why (probably because it is a small part of a larger change, 
though it doesn't really fit in with the topic of the change). I can't 
find a mailing list thread about the commit so I don't think we'll ever 
know for sure.

From looking at it, my guess is that it was added because gitk took a 
long time to start up (maybe it still does, but for me its almost 
instant). And so, this message was shown for 10 seconds, and then 
cleared because by then it probably would have started. But to avoid 
over-writing some other message, 'test' was used to make sure only the 
message intended to be cleared is cleared.

I'm not sure if this heuristic/hack is really needed, and that we need 
to keep the "Starting gitk..." message around for 10 seconds. The way I 
see it, it doesn't add too much value unless gitk takes a long time to 
start up on other platforms or repos. In that case an indication of 
"we're working on starting gitk" would be nice. Otherwise, I don't mind 
seeing this go. And even then, I think it is gitk's responsibility to 
give some sort of indication to the user that it is booting up, and not 
ours.

So, I vote for just getting rid of this hack.

>  	global main_status
>  	if {[info exists main_status]} {
> -		$main_status show [mc "Ready."] $test
> +		$main_status show [mc "Ready."]
>  	}
>  }
>  
> @@ -4159,6 +4159,9 @@ if {$picked && [is_config_true gui.autoexplore]} {
>  	do_explore
>  }
>  
> +# Clear "Initializing..." status
> +after 500 {$main_status show ""}
> +
>  # Local variables:
>  # mode: tcl
>  # indent-tabs-mode: t
> diff --git a/lib/blame.tcl b/lib/blame.tcl
> index a1aeb8b96e..888f98bab2 100644
> --- a/lib/blame.tcl
> +++ b/lib/blame.tcl
> @@ -24,6 +24,7 @@ field w_cviewer  ; # pane showing commit message
>  field finder     ; # find mini-dialog frame
>  field gotoline   ; # line goto mini-dialog frame
>  field status     ; # status mega-widget instance
> +field status_operation ; # status operation

Nitpick: The comment doesn't give any information the field name doesn't 
already give. Either remove it or replace it with something more 
descriptive.

>  field old_height ; # last known height of $w.file_pane
>  
>  
> @@ -274,6 +275,7 @@ constructor new {i_commit i_path i_jump} {
>  	pack $w_cviewer -expand 1 -fill both
>  
>  	set status [::status_bar::new $w.status]
> +	set status_operation {}
>  
>  	menu $w.ctxm -tearoff 0
>  	$w.ctxm add command \
> @@ -602,16 +604,21 @@ method _exec_blame {cur_w cur_d options cur_s} {
>  	} else {
>  		lappend options $commit
>  	}
> +
> +	# We may recurse in from another call to _exec_blame and already have
> +	# a status operation.

Thanks for being thorough enough to spot this :)

> +	if {$status_operation == {}} {
> +		set status_operation [$status start \
> +			$cur_s \
> +			[mc "lines annotated"]]

The call to this method from '_read_blame' specifies a different $cur_s. 
So shouldn't we be destroying $status_operation (after stopping it), and 
creating a new one?

> +	}
> +
>  	lappend options -- $path
>  	set fd [eval git_read --nice blame $options]
>  	fconfigure $fd -blocking 0 -translation lf -encoding utf-8
>  	fileevent $fd readable [cb _read_blame $fd $cur_w $cur_d]
>  	set current_fd $fd
>  	set blame_lines 0
> -
> -	$status start \
> -		$cur_s \
> -		[mc "lines annotated"]
>  }
>  
>  method _read_blame {fd cur_w cur_d} {

You did not update 'lib/choose_repository.tcl'. It still uses the old 
version of the status bar. Other than that, the rest of the patch looks 
good. Thanks.

[0]:
  Curiously, if I do 'git log -L 2208,+5:git-gui.sh' to find the origins 
  of the line, it leads me to the commit 25476c6. And looking at the 
  commit, it does indeed appear to be the origin of the line since the 
  line is in the post-image, and not the pre-image. But I accidentally 
  noticed the line in a parent of that commit. Looking further, it turns 
  out the line originated in e210e67. Probably a bug in some really old 
  versions of git. Interesting nonetheless.

-- 
Regards,
Pratyush Yadav
