Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8521F454
	for <e@80x24.org>; Mon, 11 Nov 2019 19:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKKTfv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 14:35:51 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34375 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfKKTfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 14:35:51 -0500
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D140D60008;
        Mon, 11 Nov 2019 19:35:48 +0000 (UTC)
Date:   Tue, 12 Nov 2019 01:05:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Subject: Re: [PATCH v2 0/2] git-gui: revert untracked files by deleting them
Message-ID: <20191111193546.lsx24e3w6fo336hu@yadavpratyush.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/19 07:05AM, Jonathan Gilbert via GitGitGadget wrote:
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
> This is the third revision of this change, which differs from the second
> version in the following ways:
> 
>  * A new construct called a "chord" is used to coordinate the completion of
>    multiple asynchronous operations that can be kicked off by revert_helper.
>    A chord is, conceptually, a procedure with multiple entrypoints whose
>    body only executes once all entrypoints have been activated. The 
>    chord.tcl file includes comprehensive documentation of how to use the
>    chord classes.
>    
>    
>  * Since we might not yet be ready to unlock the index when checkout_index 
>    returns, the _close_updateindex proc where it was ultimately unlocking
>    the index has been modified so that unlocking the index is the
>    responsibility of the caller. Since the $after functionality ran after 
>    unlock_index, that is also hoisted out. Nothing in _close_updateindex 
>    appears to be asynchronous, so the caller can simply make the calls
>    itself upon its return.

The cover letter is so much more descriptive than the commit message. It 
would be nice to have all this context and commentary in the commit 
message. Of course, you'd remove the "personal workflow" bit and some 
other stuff, but most of this can be copied verbatim.

Also, like I mentioned in the review of your second patch, 
`_close_updateindex` _does_ have an asynchronous component 
unfortunately.
    
>    
>  * lexists has been renamed to path_exists.
>    
>    
>  * Up to 10 deletion errors are now shown simultaneously. I also confirmed
>    that Tcl's file delete code will always return a nicely-formatted error
>    including the filename, and changed the message so that it isn't also 
>    injecting the filename.

-- 
Regards,
Pratyush Yadav
