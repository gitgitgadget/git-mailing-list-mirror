Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF40C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6196206EB
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgHZLal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:30:41 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45565 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgHZLai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 07:30:38 -0400
X-Originating-IP: 103.82.80.123
Received: from localhost (unknown [103.82.80.123])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C259FFF809;
        Wed, 26 Aug 2020 11:30:32 +0000 (UTC)
Date:   Wed, 26 Aug 2020 17:00:30 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: accommodate for intent-to-add files
Message-ID: <20200826113030.xnutfxxfmdhgoq5o@yadavpratyush.com>
References: <pull.699.git.1597244777943.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.699.git.1597244777943.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the patch.

On 12/08/20 03:06PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As of Git v2.28.0, the diff for files staged via `git add -N` marks them
> as new files. Git GUI was ill-prepared for that, and this patch teaches
> Git GUI about them.
> 
> Please note that this will not even fix things with v2.28.0, as the
> `rp/apply-cached-with-i-t-a` patches are required on Git's side, too.
> 
> This fixes https://github.com/git-for-windows/git/issues/2779
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     git-gui: accommodate for intent-to-add files
>     
>     This fixes the intent-to-add bug reported in 
>     https://github.com/git-for-windows/git/issues/2779: after a file was
>     staged with git add -N, staging hunks/lines would fail silently.
>     
>     On its own, this patch is not enough, as it requires the patches
>     provided in rp/apply-cached-with-i-t-a to be applied on Git's side.
>     
>     Please note that this patch might need a bit more help, as I do not
>     really know whether showing "new file mode 100644" in the diff view is
>     desirable, or whether we should somehow try to retain the
>     "intent-to-add" state so that unstaging all hunks would return the file
>     to "intent-to-add" state.

I built latest Git master (e9b77c84a0) which has 
`rp/apply-cached-with-i-t-a` and tested this patch. It works... for the 
most part.

I can select a line set of lines and they get staged/unstaged, which is 
good. The part that is not good though is that a lot of common 
operations still don't work as they should:

- I can't click on the icon in the "Unstaged Changes" pane to stage the 
  whole file. Nothing happens when I do that.

- The file that is marked as intent-to-add shows up in both the "Staged 
  Changes" and "Unstaged Changes" panes, with the "Staged Changes" part 
  being empty. Ideally it should only show up in the "Unstaged Changes" 
  pane.

- Selecting the whole file and choosing "Stage Lines for Commit" works 
  well. But choosing "Stage Hunk for Commit" does not. While the changes 
  do get staged, the UI is not properly updated and the file is still 
  listed in the "Unstaged Changes" pane.

  I think the difference here is because for 
  `apply_or_revert_range_or_line`, we call `do_rescan` after it to 
  update the UI, but for `apply_or_revert_hunk` we update the UI 
  "manually" in the function after we are done applying or reverting the 
  changes. So the logic to update the UI needs to be updated to account 
  for this change. Or we can get rid of all that logic and just run a 
  rescan.

And also, like you mentioned, we don't retain the i-t-a state when 
unstaging. But with some quick testing, I see that Git command line 
doesn't either (I tried a plain `git restore --staged`). So IMO we 
should mimic what the command line UI does and not retain the i-t-a 
state when unstaging.

>     
>     Thoughts?

IMO this is a good start but more work needs to be done before we can 
call this feature finished.
 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-699%2Fdscho%2Fgit-gui-stage-ita-hunks-and-lines-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-699/dscho/git-gui-stage-ita-hunks-and-lines-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/699
> 
>  git-gui.sh   |  2 ++
>  lib/diff.tcl | 12 ++++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 49bd86e635..e08cb17395 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2080,6 +2080,7 @@ set all_icons(U$ui_index)   file_merge
>  set all_icons(T$ui_index)   file_statechange
>  
>  set all_icons(_$ui_workdir) file_plain
> +set all_icons(A$ui_workdir) file_plain
>  set all_icons(M$ui_workdir) file_mod
>  set all_icons(D$ui_workdir) file_question
>  set all_icons(U$ui_workdir) file_merge
> @@ -2106,6 +2107,7 @@ foreach i {
>  		{A_ {mc "Staged for commit"}}
>  		{AM {mc "Portions staged for commit"}}
>  		{AD {mc "Staged for commit, missing"}}
> +		{AA {mc "Intended to be added"}}
>  
>  		{_D {mc "Missing"}}
>  		{D_ {mc "Staged for removal"}}
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 871ad488c2..36d3715f7b 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -582,7 +582,8 @@ proc apply_or_revert_hunk {x y revert} {
>  	if {$current_diff_side eq $ui_index} {
>  		set failed_msg [mc "Failed to unstage selected hunk."]
>  		lappend apply_cmd --reverse --cached
> -		if {[string index $mi 0] ne {M}} {
> +		set file_state [string index $mi 0]
> +		if {$file_state ne {M} && $file_state ne {A}} {
>  			unlock_index
>  			return
>  		}
> @@ -595,7 +596,8 @@ proc apply_or_revert_hunk {x y revert} {
>  			lappend apply_cmd --cached
>  		}
>  
> -		if {[string index $mi 1] ne {M}} {
> +		set file_state [string index $mi 1]
> +		if {$file_state ne {M} && $file_state ne {A}} {
>  			unlock_index
>  			return
>  		}
> @@ -687,7 +689,8 @@ proc apply_or_revert_range_or_line {x y revert} {
>  		set failed_msg [mc "Failed to unstage selected line."]
>  		set to_context {+}
>  		lappend apply_cmd --reverse --cached
> -		if {[string index $mi 0] ne {M}} {
> +		set file_state [string index $mi 0]
> +		if {$file_state ne {M} && $file_state ne {A}} {
>  			unlock_index
>  			return
>  		}
> @@ -702,7 +705,8 @@ proc apply_or_revert_range_or_line {x y revert} {
>  			lappend apply_cmd --cached
>  		}
>  
> -		if {[string index $mi 1] ne {M}} {
> +		set file_state [string index $mi 1]
> +		if {$file_state ne {M} && $file_state ne {A}} {
>  			unlock_index
>  			return
>  		}
> 

These changes look good to me to set up basic functionality. We just 
need to iron out the rough edges.

> base-commit: 469725c1a3d44f7e1475f1d37cd13e0824d4ea41
> -- 
> gitgitgadget

-- 
Regards,
Pratyush Yadav
