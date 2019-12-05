Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41AFC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C932464F
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 18:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfLESyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:54:31 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36181 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLESy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 13:54:27 -0500
X-Originating-IP: 157.36.228.144
Received: from localhost (unknown [157.36.228.144])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9FAD81C0003;
        Thu,  5 Dec 2019 18:54:24 +0000 (UTC)
Date:   Fri, 6 Dec 2019 00:24:20 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Subject: Re: [PATCH v7 0/3] git-gui: revert untracked files by deleting them
Message-ID: <20191205185420.laivdwmmwuukptxu@yadavpratyush.com>
References: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
 <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On 01/12/19 02:28AM, Jonathan Gilbert via GitGitGadget wrote:
> My development environment sometimes makes automatic changes that I don't
> want to keep. In some cases, this involves new files being added that I
> don't want to commit or keep (but I also don't want to outright .gitignore 
> forever). I have typically had to explicitly delete those files externally
> to Git Gui, which is a context switch to a manual operation, and I want to
> be able to just select those newly-created untracked files in the UI and
> "revert" them into oblivion.
> 
> This change updates the revert_helper proc to check for untracked files as
> well as changes, and then changes to be reverted and untracked files are
> handled by independent blocks of code. The user is prompted independently
> for untracked files, since the underlying action is fundamentally different
> (rm -f). If after deleting untracked files, the directory containing them
> becomes empty, then the directory is removed as well. A new proc 
> delete_files takes care of actually deleting the files, using the Tcler's
> Wiki recommended approach for keeping the UI responsive.
> 
> Since the checkout_index and delete_files calls are both asynchronous and
> could potentially complete in any order, a "chord" is used to coordinate
> unlocking the index and returning the UI to a usable state only after both
> operations are complete.
> 
> Since the checkout_index and delete_files calls are both asynchronous and
> overlap, they clash in wanting to update the status bar. To address this,
> the status bar is reworked so that when an operation wants to display
> ongoing updates/progress, it explicitly starts an "operation", which is
> tracked by its own object, and the status bar handles multiple concurrent
> operations by merging their progress and concatenating their text. This is
> captured in a separate commit, since it touches a variety of files.
> 
> The _close_updateindex proc contains error handling (added in d4e890e5) that
> has the potential to interact badly with unlock_index running at the
> completion of an async operation. I have refactored the procedure into
> separate procs _close_updateindex and rescan_on_error. Call sites that
> exercised the combined functionality also unlocked the index, so a combined
> proc close_and_unlock_index calls _close_updateindex and then either 
> rescan_on_error or unlock_index as appropriate. Call sites have been updated
> appropriately.
> 
> The revert_helper proc, with its overlapping operations, is an example of a
> call site that does not combine the close and unlock/rescan operations. The 
> checkout_index proc has been reworked to only call _close_updateindex, and
> to call a functor supplied by the caller to captures any errors that occur. 
> revert_helper uses this to supply a lambda function that stashes the error
> within the chord's body namespace, so that it can then separately call 
> rescan_on_error when the chord is completed (or unlock_index, if no error
> was captured), which might be substantially after checkout_index encounters
> its error. If it turns out that a rescan is called for, it is done once the
> deletion is complete.
> 
> This is the eighth revision of this change, which differs from the seventh
> version in the following ways (most of which are in the second of the three
> commits, to do with the status bar rework):
> 
>  * The bump of the Tcl/Tk dependency from 8.4 to 8.6 now takes place in the
>    third commit, where it is needed and whose commit message actually calls
>    it out.
>    
>    
>  * The show method in status_bar_operation has been renamed to restart, and
>    the meter is cleared. Also, the supplied message is set as the prefix for
>    future update calls.
>    
>    
>  * The call site for $status_operation show in blame.tcl has been
>    corresponding changed to $status_operation restart.
>    
>    
>  * A typo has been corrected in a comment. :-)

Thanks for the quality contribution. Merged to 'master'. Will push it 
out soon.

-- 
Regards,
Pratyush Yadav
