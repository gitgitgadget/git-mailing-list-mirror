From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] contrib/subtree: fix "subtree split" skipped-merge bug.
Date: Tue, 8 Dec 2015 01:49:02 -0500
Message-ID: <CAPig+cR36772YDc5RQRwXP3+ucVWumim9HYTXVMuGXN2cnQ7Ow@mail.gmail.com>
References: <20151207045307.GA624@flurp.local>
	<1449521452-19043-1-git-send-email-davidw@realtimegenomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dave Ware <davidw@realtimegenomics.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:49:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6C5G-0000G8-1n
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 07:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbbLHGtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 01:49:05 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34195 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbbLHGtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 01:49:04 -0500
Received: by vkbs1 with SMTP id s1so6490852vkb.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 22:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=19c8jzBFilDExBEypg0LB8yyg5M7CnWPCzYHf0OaQp8=;
        b=VJfWiV32mDNmxUaQK+VvRXQuDD3ldaQ5w0qAg5+RV5GNBZGq+JEUkmTbvRzOhjNZVG
         FM36Gw84G/CsYttBCeDXSJbv5mUNki/Y3vyAipmmmqzdduy8GgWXRyrrOPEYH/G0+J6f
         29RnB/uW64O4BPFAI6QfnDr+T21PRtBaYKeI/QBL2OCundBhoKF2Tl4fQIVmvSdkM27v
         UTKHWAo1xbAMOzTSZBQStW3r+8iILAmOpPkfwktJgyhJXV+oAihxuAUu4Id8RFUJed3+
         qhOoFGEgsjIejuN12OPfDgSGY267ConHPbZOamqh1knnVIMEXJbJK+N7mzDSkWKIRoyW
         IvcA==
X-Received: by 10.31.182.129 with SMTP id g123mr1965539vkf.45.1449557342564;
 Mon, 07 Dec 2015 22:49:02 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 7 Dec 2015 22:49:02 -0800 (PST)
In-Reply-To: <1449521452-19043-1-git-send-email-davidw@realtimegenomics.com>
X-Google-Sender-Auth: sKNvULx08x0gM8I0lE2VyPdRhfU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282146>

On Mon, Dec 7, 2015 at 3:50 PM, Dave Ware <davidw@realtimegenomics.com> wrote:
> [PATCH] contrib/subtree: fix "subtree split" skipped-merge bug.

As an aid for reviewers, please indicate the version of this patch
submission. For instance, this is the second attempt, so the subject
would be decorated as [PATCH v2], and the next one (if submitted) will
be v3. The -v option of git-format-patch can help automate this.

Style: drop the full-stop (period) from the subject line

> A bug occurs in 'git-subtree split' where a merge is skipped even when
> both parents act on the subtree, provided the merge results in a tree
> identical to one of the parents. Fix by copying the merge if at least
> one parent is non-identical, and the non-identical parent is not an
> ancestor of the identical parent.
>
> Also adding a test case, this checks that a descendant can be pushed to

s/Also adding/Also, add/
s/, this/which/

> it's ancestor in this case.

s/it's/its/

> Signed-off-by: Dave Ware <davidw@realtimegenomics.com>
> ---

Right here below the "---" line is a good place to describe what
changed since the previous version. For instance, in v2, you made
minor improvements to the commit message, added your sign-off, folded
the new test into the existing t7900-subtree.sh, added a subshell
around 'cd', and assigned the output of git-rev-list to a shell
variable rather than dumping it to a file.

Including a link to the previous version, like this[1], is also
reviewer-friendly.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/282065

As before, I'm not a git-subtree user, so this review is superficial.
More below...

>  contrib/subtree/git-subtree.sh     | 12 +++++++--
>  contrib/subtree/t/t7900-subtree.sh | 52 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 9051982..ea991eb 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
>         ))
>  '
>
> +test_expect_success 'subtree descendent check' '
> +  mkdir git_subtree_split_check &&
> +  (
> +    cd git_subtree_split_check &&

Style: indent with tabs rather than spaces

> +    git init &&
> +
> +    mkdir folder &&
> +
> +    echo a >folder/a &&
> +    git add . &&
> +    git commit -m "first commit" &&
> +
> +    git branch branch &&
> +
> +    echo 0 >folder/0 &&
> +    git add . &&
> +    git commit -m "adding 0 to folder" &&
> +
> +    echo b >folder/b &&
> +    git add . &&
> +    git commit -m "adding b to folder" &&
> +    cherry=$(git rev-list HEAD -1) &&

git-rev-parse would probably be more idiomatic:

    cherry=$(git rev-parse HEAD)

> +    git checkout branch &&
> +    echo text >textBranch.txt &&
> +    git add . &&
> +    git commit -m "commit to fiddle with branch: branch" &&
> +
> +    git cherry-pick $cherry &&
> +    git checkout master &&
> +    git merge -m "merge" branch &&
> +
> +    git branch noop_branch &&
> +
> +    echo d >folder/d &&
> +    git add . &&
> +    git commit -m "adding d to folder" &&
> +
> +    git checkout noop_branch &&
> +    echo moreText >anotherText.txt &&
> +    git add . &&
> +    git commit -m "irrelevant" &&
> +
> +    git checkout master &&
> +    git merge -m "second merge" noop_branch &&
> +
> +    git subtree split --prefix folder/ --branch subtree_tip master &&
> +    git subtree split --prefix folder/ --branch subtree_branch branch &&
> +    git push . subtree_tip:subtree_branch
> +  )
> +  '
> +
>  test_done
> --
> 1.9.1
