Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2334CD342E
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 01:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjISBE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 21:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 21:04:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C5107
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 18:04:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CF4428C91;
        Mon, 18 Sep 2023 21:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=M4ym6F/lS977oqXyY0tv+dzRqaPRkzLIZ7HQn3
        sW/y0=; b=Tlwr9YC2U3tlNz2BobSjsD7yjQEH26DBl6tgGcusUESzKdgJWQpK33
        1MSWOaA/z0iahFPDihG/jbZkUWCAYffE8Hft08C1aKOk0L6I+2CiP46por41Xysp
        dzSwpklLFv+pA51v9qq/jIqw+7XdelvW9viEl+mxfx8warluFwWJg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46CD228C90;
        Mon, 18 Sep 2023 21:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C24DD28C8E;
        Mon, 18 Sep 2023 21:04:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Zach FettersMoore <zach.fetters@apollographql.com>
Subject: Re: [PATCH] subtree: fix split processing with multiple subtrees
 present
In-Reply-To: <pull.1587.git.1695067516192.gitgitgadget@gmail.com> (Zach
        FettersMoore via GitGitGadget's message of "Mon, 18 Sep 2023 20:05:16
        +0000")
References: <pull.1587.git.1695067516192.gitgitgadget@gmail.com>
Date:   Mon, 18 Sep 2023 18:04:06 -0700
Message-ID: <xmqqpm2fht2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F4FF1F8-5688-11EE-9D4C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In the diagram below, 'M' represents the mainline repo branch, 'A'
> represents one subtree, and 'B' represents another. M3 and B1 represent
> a split commit for subtree B that was created from commit M4. M2 and A1
> represent a split commit made from subtree A that was also created
> based on changes back to and including M4. M1 represents new changes to
> the repo, in this scenario if you try to run a 'git subtree split
> --rejoin' for subtree B, commits M1, M2, and A1, will be included in
> the processing of changes for the new split commit since the last
> split/rejoin for subtree B was at M3. The issue is that by having A1
> included in this processing the command ends up needing to processing
> every commit down tree A even though none of that is needed or relevant
> to the current command and result.
>
> M1
>  |      \       \
> M2       |       |
>  |      A1       |
> M3       |       |
>  |       |      B1
> M4       |       |

The above paragraph explains which different things you drew in the
diagram are representing, but it is not clear how they relate to
each other.  Do they for example depict parent-child commit
relationship?  What are the wide gaps between these three tracks and
what are the short angled lines leaning to the left near the tip?
Is the time/topology flowing from bottom to top?

> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index e0c5d3b0de6..e9250dfb019 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -778,12 +778,29 @@ ensure_valid_ref_format () {
>  		die "fatal: '$1' does not look like a ref"
>  }
>  
> +# Usage: check if a commit from another subtree should be ignored from processing for splits

Way overlong line.  Please split them accordingly.  I won't comment
on what CodingGuidelines tells us already, in this review, but have
a few comments here:

> +should_ignore_subtree_commit () {
> +  if [ "$(git log -1 --grep="git-subtree-dir:" $1)" ]
> +  then
> +    if [[ -z "$(git log -1 --grep="git-subtree-mainline:" $1)" && -z "$(git log -1 --grep="git-subtree-dir: $dir$" $1)" ]]

Here $dir is a free variable that comes from outside.  The caller
does not supply it as a parameter to this function (and the caller
does not receive it as its parameter from its caller).  Yet the file
as a whole seems to liberally make assignments to it ("git grep dir="
on the file counts 7 assignments).  Are we sure we are looking for
the right $dir in this particular grep?

	Side note: I am not familiar with this part of the code at
	all, so do not take it as "here is a bug", but more as "this
	smells error prone."

Also can $dir have regular expressions special characters?  "The
existing code and new code alike, git-subtree is not prepared to 
handle directory names with RE special characters well at all, so
do not use them if you do not want your history broken" is an
acceptable answer.

The caller of this function process_split_commit is cmd_split and
process_split_commit (hence this function) is called repeatedly
inside a loop.  This function makes a traversal over the entire
history for each and every iteration in "good" cases where there is
no 'mainline' or 'subtree-dir' commits for the given $dir.

I wonder if it is more efficient to enumerate all commits that hits
these grep criteria in the cmd_split before it starts to call
process_split_commit repeatedly.  If it knows which commit can be
ignored beforehand, it can skip and not call process_split_commit,
no?

> +    then
> +      return 0
> +    fi
> +  fi
> +  return 1
> +}
> +
>  # Usage: process_split_commit REV PARENTS
>  process_split_commit () {
>  	assert test $# = 2
>  	local rev="$1"
>  	local parents="$2"

These seem to assume that $1 and $2 can have $IFS in them, so
shouldn't ...

> +    if should_ignore_subtree_commit $rev

... this call too enclose $rev inside a pair of double-quotes for
consistency?  We know the loop in the cmd_split that calls this
function is reading from "rev-list --parents" and $rev is a 40-hex
commit object name (and $parents can have more than one 40-hex
commit object names separated with SP), so it is safe to leave $rev
unquoted, but it pays to be consistent to help make the code more
readable.

> +    then
> +	    return
> +    fi
> +
>  	if test $indent -eq 0
>  	then
>  		revcount=$(($revcount + 1))
>
> base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
