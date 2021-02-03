Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F5C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280E264F84
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhBCRd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:33:58 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:12230 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbhBCRdx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:33:53 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4DW80R4tVdz5tlB;
        Wed,  3 Feb 2021 18:33:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3FDED49F0;
        Wed,  3 Feb 2021 18:33:11 +0100 (CET)
Subject: Re: [PATCH] git-gui: remove lines starting with the comment character
To:     Pratyush Yadav <me@yadavpratyush.com>
References: <20210202200301.44282-1-me@yadavpratyush.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fdfe1661-463b-fc18-02cc-4c6e22ce0463@kdbg.org>
Date:   Wed, 3 Feb 2021 18:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202200301.44282-1-me@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.21 um 21:03 schrieb Pratyush Yadav:
> The comment character is specified by the config variable
> 'core.commentchar'. Any lines starting with this character is considered
> a comment and should not be included in the final commit message.
> 
> Teach git-gui to filter out lines in the commit message that start with
> the comment character. If the config is not set, '#' is taken as the
> default.

This is WRONG. Git GUI is that: a GUI, it's all about WYSIWYG. If you do
not give sufficient unambiguous visual clue to the user that certain
lines will be ignored, you cannot ignore them.

You cannot just throw away what the user has typed into the edit box
without warning. How would you make it possible to insert text that
happens to begin with the comment character of the day?

Perhaps what you are really only interested in is to remove the list of
conflicted files after a merge conflict? Then the correct way to proceed
would be to sanitize the contents of .git/MERGE_MSG before it is
inserted into the edit box.

> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
>  lib/commit.tcl | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> index 11379f8..3c3035f 100644
> --- a/lib/commit.tcl
> +++ b/lib/commit.tcl
> @@ -209,6 +209,28 @@ You must stage at least 1 file before you can commit.
>  	#
>  	set msg [string trim [$ui_comm get 1.0 end]]
>  	regsub -all -line {[ \t\r]+$} $msg {} msg
> +
> +	# Remove lines starting with the comment character.
> +	set comment_char [get_config core.commentchar]
> +	if {[string length $comment_char] > 1} {
> +		error_popup [mc "core.commitchar should only be one character."]
> +		unlock_index
> +		return
> +	}
> +
> +	if {$comment_char eq {}} {
> +		set comment_char "#"
> +	}
> +
> +	# If the comment character is not alphabetical, then we need to escape it
> +	# with a backslash to make sure it is not interpreted as a special character
> +	# in the regex.
> +	if {![string is alpha $comment_char]} {
> +		set comment_char "\\$comment_char"
> +	}
> +
> +	regsub -all -line "$comment_char.*(\\n|\\Z)" $msg {} msg
> +
>  	if {$msg eq {}} {
>  		error_popup [mc "Please supply a commit message.
> 

-- Hannes
