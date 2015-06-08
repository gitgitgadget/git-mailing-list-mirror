From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] am --abort: support aborting to unborn branch
Date: Mon, 08 Jun 2015 13:10:41 -0700
Message-ID: <xmqq8ubu9d1a.fsf@gitster.dls.corp.google.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
	<1433591172-27077-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:10:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23Nf-0005RC-V1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbbFHUKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:10:44 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35592 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbbFHUKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:10:43 -0400
Received: by igbzc4 with SMTP id zc4so70701362igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1CsNQ+m0laneNLyBzhd686sJS/UzxHARygIoLJ3m7pk=;
        b=jBN05DNkxywAKKJZzBk7dPoQdANPJKNqngpqPzFodDmLQSwrG+/MebUC6TNnXnhLK+
         mQrLiE3QxveJrhpYxnyr1iEd1aYtCumwskxVtLNoUeUdC8Yj9IG8WkgWtOmWQM34F/4q
         EJU+HdxbmjrhO/DQozX/nBSaXJwhyM28y0u2n6AiXGTb+sOqIX8VfuH+f6RpaM2B052C
         M5DoE/sMpXK4LsASYyCadxET3cB7e33svn/1JoRdyLT5Psxduehu78JKFfU8zF7B2DXc
         UAhNFsnOyLdk7CfoZg+dKaetmMbQtQ6TMAfRKtUUiR42mecyRgeT4n7lUELrgDMONZFS
         3rkA==
X-Received: by 10.50.18.39 with SMTP id t7mr15657998igd.3.1433794242528;
        Mon, 08 Jun 2015 13:10:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id i185sm2429092ioi.24.2015.06.08.13.10.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 13:10:42 -0700 (PDT)
In-Reply-To: <1433591172-27077-6-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Sat, 6 Jun 2015 19:46:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271121>

Paul Tan <pyokagan@gmail.com> writes:

> When git-am is first run on an unborn branch, no ORIG_HEAD is created.
> As such, any applied commits will remain even after a git am --abort.

I think this answered my question on 4/6; that may indicate that
these two are either done in a wrong order or perhaps should be a
single change.



>
> To be consistent with the behavior of git am --abort when it is not run
> from an unborn branch, we empty the index, and then destroy the branch
> pointed to by HEAD if there is no ORIG_HEAD.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-am.sh           |  9 ++++++++-
>  t/t4151-am-abort.sh | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index e4fe3ed..95f90a0 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -524,7 +524,14 @@ then
>  			index_tree=$(git write-tree) &&
>  			orig_head=$(git rev-parse --verify -q ORIG_HEAD || echo $empty_tree) &&
>  			git read-tree -m -u $index_tree $orig_head
> -			git reset ORIG_HEAD
> +			if git rev-parse --verify -q ORIG_HEAD >/dev/null 2>&1
> +			then
> +				git reset ORIG_HEAD
> +			else
> +				git read-tree $empty_tree
> +				curr_branch=$(git symbolic-ref HEAD 2>/dev/null) &&
> +				git update-ref -d $curr_branch
> +			fi
>  		fi
>  		rm -fr "$dotest"
>  		exit ;;
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 2366042..b2a7fc5 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -14,6 +14,7 @@ test_expect_success setup '
>  	git add file-1 file-2 &&
>  	git commit -m initial &&
>  	git tag initial &&
> +	git format-patch --stdout --root initial >initial.patch &&
>  	for i in 2 3 4 5 6
>  	do
>  		echo $i >>file-1 &&
> @@ -125,4 +126,20 @@ test_expect_success 'am -3 --abort removes otherfile-4 on unborn branch' '
>  	test_path_is_missing otherfile-4
>  '
>  
> +test_expect_success 'am -3 --abort on unborn branch removes applied commits' '
> +	git checkout -f --orphan orphan &&
> +	git reset &&
> +	rm -f otherfile-4 otherfile-2 file-1 file-2 &&
> +	test_must_fail git am -3 initial.patch 0003-*.patch &&
> +	test 3 -eq $(git ls-files -u | wc -l) &&
> +	test 4 = "$(cat otherfile-4)" &&
> +	git am --abort &&
> +	test -z "$(git ls-files -u)" &&
> +	test_path_is_missing otherfile-4 &&
> +	test_path_is_missing file-1 &&
> +	test_path_is_missing file-2 &&
> +	test 0 -eq $(git log --oneline 2>/dev/null | wc -l) &&
> +	test refs/heads/orphan = "$(git symbolic-ref HEAD)"
> +'
> +
>  test_done
