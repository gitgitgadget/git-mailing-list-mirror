From: Jakob Pfender <jpfender@elegosoft.com>
Subject: Re: [PATCH] diff --quiet: disable optimization when --diff-filter=X
 is used
Date: Thu, 17 Mar 2011 12:15:07 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D81ED3B.3000500@elegosoft.com>
References: <4D80EBC1.7010105@elegosoft.com> <7v62ri7oqm.fsf@alter.siamese.dyndns.org> <7vwrjy670r.fsf_-_@alter.siamese.dyndns.org> <7vmxku64sh.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 12:15:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0BAu-0006Kt-CX
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 12:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847Ab1CQLPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 07:15:17 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:56114 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab1CQLPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 07:15:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 309CF1B4B6A;
	Thu, 17 Mar 2011 12:15:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8x9say-yswb8; Thu, 17 Mar 2011 12:15:08 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 996B61B4B67;
	Thu, 17 Mar 2011 12:15:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vmxku64sh.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169235>



On 03/17/2011 12:09 AM, Junio C Hamano wrote:
> The code notices that the caller does not want any detail of the changes
> and only wants to know if there is a change or not by specifying --quiet.
> And it breaks out of the loop when it knows it already found any change.
>
> When you have a post-process filter (e.g. --diff-filter), however, the
> path we found to be different in the previous round and set HAS_CHANGES
> bit may end up being uninteresting, and there may be no output at the end.
> The optimization needs to be disabled for such case.
>
> Note that the f245194 (diff: change semantics of "ignore whitespace"
> options, 2009-05-22) already disables this optimization by refraining
> from setting HAS_CHANGES when post-process filters that need to inspect
> the contents of the files (e.g. -S, -w) in diff_change() function.

That fixes it nicely, thank you.

>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>
>   * This time with tests, on top of 90b1994 (diff: Rename QUIET internal
>     option to QUICK, 2009-05-23), which was the last commit in the series
>     that introduced the incorrect optimization in the first place.
>
>     Note that the test script was renamed to t/t4040 in today's codebase,
>     but it merges cleanly.
>
>   diff-lib.c                   |    3 ++-
>   t/t4037-whitespace-status.sh |    7 +++++++
>   2 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index b7813af..bfa6503 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -74,7 +74,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>   		int changed;
>
>   		if (DIFF_OPT_TST(&revs->diffopt, QUICK)&&
> -			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
> +		    !revs->diffopt.filter&&
> +		    DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
>   			break;
>
>   		if (!ce_path_match(ce, revs->prune_data))
> diff --git a/t/t4037-whitespace-status.sh b/t/t4037-whitespace-status.sh
> index a30b03b..abc4934 100755
> --- a/t/t4037-whitespace-status.sh
> +++ b/t/t4037-whitespace-status.sh
> @@ -60,4 +60,11 @@ test_expect_success 'diff-files -b -p --exit-code' '
>   	git diff-files -b -p --exit-code
>   '
>
> +test_expect_success 'diff-files --diff-filter --quiet' '
> +	git reset --hard&&
> +	rm a/d&&
> +	echo x>>b/e&&
> +	test_must_fail git diff-files --diff-filter=M --quiet
> +'
> +
>   test_done
