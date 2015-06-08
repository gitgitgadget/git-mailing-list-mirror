From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] am --abort: revert changes introduced by failed 3way merge
Date: Mon, 08 Jun 2015 13:09:13 -0700
Message-ID: <xmqqd2169d3q.fsf@gitster.dls.corp.google.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
	<1433591172-27077-5-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 22:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z23MI-0004B3-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 22:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbbFHUJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 16:09:16 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38495 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbbFHUJP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 16:09:15 -0400
Received: by igblz2 with SMTP id lz2so960762igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YuJRHj5YktdzORM6yW28HXTMjcr1Wp1R5g5+XNw/aUc=;
        b=iS/p0dnu+iRVHIcF0/A+VSh4uIoyrbuKI1YjBPz/qCP6E6vJgMLpQu73i8nWJnXpge
         J6N5lMiQxko5Z3ZXiCRbGuLZxFqnZkDykI2vGBUPuQFw1DcKemt2XRESc2YIWutZL1/R
         TWIJdypftEPhVsmUWjUHSl1rs8zvxv05h1+liRINKTMjeQODaIgyadv0rSCsdCNYN/hb
         uL4moC374Z8XFWzeGB+R/4IcUXZlDkf0VHubCjq7QSxNIxJL+MiJ87FT5dpRDOpSqAZP
         U/2Q92/NkRC/wZZzo/1idS6z03TZ0Kql3DIR5YpezTPXMBs99n0HbF1VY3Cei+iDxA0e
         INvA==
X-Received: by 10.43.178.195 with SMTP id ox3mr26123178icc.10.1433794154997;
        Mon, 08 Jun 2015 13:09:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id k16sm1042378igf.19.2015.06.08.13.09.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 13:09:14 -0700 (PDT)
In-Reply-To: <1433591172-27077-5-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Sat, 6 Jun 2015 19:46:10 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271120>

Paul Tan <pyokagan@gmail.com> writes:

> Even when a merge conflict occurs with am --3way, the index will be
> modified with the results of any successfully merged files. These
> changes to the index will not be reverted with a
> "git read-tree --reset -u HEAD ORIG_HEAD", as git read-tree will not be
> aware of how the current index differs from HEAD or ORIG_HEAD.
>
> To fix this, we first reset any conflicting entries in the index. The
> resulting index will contain the results of successfully merged files
> introduced by the failed merge. We write this index to a tree, and then
> use git read-tree to fast-forward this "index tree" back to ORIG_HEAD,
> thus undoing all the changes from the failed merge.
>
> When we are on an unborn branch, HEAD and ORIG_HEAD will not point to
> valid trees. In this case, use an empty tree.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-am.sh           |  6 +++++-
>  t/t4151-am-abort.sh | 23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 67f4f25..e4fe3ed 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -519,7 +519,11 @@ then
>  		git rerere clear
>  		if safe_to_abort
>  		then
> -			git read-tree --reset -u HEAD ORIG_HEAD
> +			head_tree=$(git rev-parse --verify -q HEAD || echo $empty_tree) &&
> +			git read-tree --reset -u $head_tree $head_tree &&
> +			index_tree=$(git write-tree) &&
> +			orig_head=$(git rev-parse --verify -q ORIG_HEAD || echo $empty_tree) &&
> +			git read-tree -m -u $index_tree $orig_head
>  			git reset ORIG_HEAD

What would the last "reset" do when ORIG_HEAD is invalid?  In other
words, does it make sense to worry about the case where ORIG_HEAD
does not exist?  At which point in the flow does it get written using
what information?

>  		fi
>  		rm -fr "$dotest"
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index ea4a49e..2366042 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -70,6 +70,17 @@ test_expect_success 'am -3 --skip removes otherfile-4' '
>  	test 4 = "$(cat otherfile-4)" &&
>  	git am --skip &&
>  	test_cmp_rev initial HEAD &&
> +	test -z "$(git ls-files -u)" &&
> +	test_path_is_missing otherfile-4
> +'
> +
> +test_expect_success 'am -3 --abort removes otherfile-4' '
> +	git reset --hard initial &&
> +	test_must_fail git am -3 0003-*.patch &&
> +	test 3 -eq $(git ls-files -u | wc -l) &&
> +	test 4 = "$(cat otherfile-4)" &&
> +	git am --abort &&
> +	test_cmp_rev initial HEAD &&
>  	test -z $(git ls-files -u) &&
>  	test_path_is_missing otherfile-4
>  '
> @@ -102,4 +113,16 @@ test_expect_success 'am -3 --skip clears index on unborn branch' '
>  	test_path_is_missing tmpfile
>  '
>  
> +test_expect_success 'am -3 --abort removes otherfile-4 on unborn branch' '
> +	git checkout -f --orphan orphan &&
> +	git reset &&
> +	rm -f otherfile-4 file-1 &&
> +	test_must_fail git am -3 0003-*.patch &&
> +	test 2 -eq $(git ls-files -u | wc -l) &&
> +	test 4 = "$(cat otherfile-4)" &&
> +	git am --abort &&
> +	test -z "$(git ls-files -u)" &&
> +	test_path_is_missing otherfile-4
> +'
> +
>  test_done
