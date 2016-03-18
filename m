From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] merge: refuse to create too cool a merge by default
Date: Fri, 18 Mar 2016 21:57:49 +0000
Message-ID: <56EC79DD.7010104@ramsayjones.plus.com>
References: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:57:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah2P8-0005M7-2I
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcCRV5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:57:54 -0400
Received: from avasout02.plus.net ([212.159.14.17]:59669 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbcCRV5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:57:52 -0400
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout02 with smtp
	id XZxo1s0041BQLD401ZxpLA; Fri, 18 Mar 2016 21:57:50 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=COHXJkfD c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=ybZZDoGAAAAA:8 a=4f6lCIiZe-8_1b55PRwA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqshznpmfe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289261>



On 18/03/16 20:21, Junio C Hamano wrote:
> While it makes sense to allow merging unrelated histories of two
> projects that started independently into one, in the way "gitk" was
> merged to "git" itself aka "the coolest merge ever", such a merge is
> still an unusual event.  Worse, if somebody creates an independent
> history by starting from a tarball of an established project and
> sends a pull request to the original project, "git merge" however
> happily creates such a merge without any sign of something unusual
> is happening.
> 
> Teach "git merge" to refuse to create such a merge by default,
> unless the user passes a new "--allow-unrelated-histories" option to
> tell it that the user is aware that two unrelated projects are
> merged.
> 
> Because such a "two project merge" is a rare event, a configuration
> option to always allow such a merge is not added.
> 
> We could add the same option to "git pull" and have it passed
> through to underlying "git merge".  I do not have a fundamental
> opposition against such a feature, but this commit does not do so
> and instead leaves it as low-hanging fruit for others, because such
> a "two project merge" would be done after fetching the other project
> into some location in the working tree of an existing project and
> making sure how well they fit together, it is sufficient to allow a
> local merge without such an option pass-through from "git pull" to
> "git merge".  Many tests that are updated by this patch does the
> pass-through manually by turning:
> 
> 	git pull something
> 
> into its equivalent:
> 
> 	git fetch something &&
>         git merge --allow-unrelated-histories FETCH_HEAD
> 
> If somebody is inclined to add such an option, updated tests in this
> change need to be adjusted back to:
> 
> 	git pull --allow-unrelated-histories something
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  builtin/merge.c                 | 12 +++++++++---
>  t/t3412-rebase-root.sh          |  2 +-
>  t/t5500-fetch-pack.sh           |  6 ++++--
>  t/t6009-rev-list-parent.sh      |  4 +++-
>  t/t6010-merge-base.sh           |  6 ++++--
>  t/t6012-rev-list-simplify.sh    |  2 +-
>  t/t6026-merge-attr.sh           |  3 ++-
>  t/t6029-merge-subtree.sh        |  2 +-
>  t/t6101-rev-parse-parents.sh    |  2 +-
>  t/t9400-git-cvsserver-server.sh |  3 ++-
>  10 files changed, 28 insertions(+), 14 deletions(-)
> 

[snip]

> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
> index 39b3238..e0c5f44 100755
> --- a/t/t6010-merge-base.sh
> +++ b/t/t6010-merge-base.sh
> @@ -215,11 +215,13 @@ test_expect_success 'criss-cross merge-base for octopus-step' '
>  	git reset --hard E &&
>  	test_commit CC2 &&
>  	test_tick &&
> -	git merge -s ours CC1 &&
> +	# E is a root commit unrelated to MMR root on which CC1 is based
> +	git merge -s ours --allow-unrelated-histories CC1 &&
>  	test_commit CC-o &&
>  	test_commit CCB &&
>  	git reset --hard CC1 &&
> -	git merge -s ours CC2 &&
> +	# E is a root commit unrelated to MMR root on which CC1 is based
> +	git merge -s ours --allow-unrelated-histories CC2 &&

I was only skimming this patch, but the above caught my eye - I assume
that the comment should reference CC2 not CC1. yes?

ATB,
Ramsay Jones
