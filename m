From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v2] add tests for 'git rebase --keep-empty'
Date: Fri, 10 Aug 2012 09:26:08 -0400
Message-ID: <20120810132608.GA29609@hmsreliant.think-freely.org>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 15:26:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzpEX-0007P5-ME
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 15:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab2HJN01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 09:26:27 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41085 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab2HJN00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 09:26:26 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SzpEA-0005P0-2d; Fri, 10 Aug 2012 09:26:23 -0400
Content-Disposition: inline
In-Reply-To: <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203216>

On Thu, Aug 09, 2012 at 08:39:51AM -0700, Martin von Zweigbergk wrote:
> Add test cases for 'git rebase --keep-empty' with and without an
> "empty" commit already in upstream. The empty commit that is about to
> be rebased should be kept in both cases.
> 
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>

> ---
> 
> Added another test for when the upstream already has an empty
> commit. The test case protects the current behavior; I just assume the
> current behavior is what we want.
> 
> While writing the test case, I also noticed that an interrupted 'git
> rebase --keep-empty' can not be continued 'git rebase --continue', but
> instead needs 'git cherry-pick --continue'. I guess this shouldn't
> really be surprising given that it's implemented in terms of
> cherry-pick. This should be fixed once all the different kinds of
> rebase use the same way of finding the commits to rebase, so I
> wouldn't worry about fixing this specific problem right now.
> 
>  t/t3401-rebase-partial.sh | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
> index 7f8693b..58f4823 100755
> --- a/t/t3401-rebase-partial.sh
> +++ b/t/t3401-rebase-partial.sh
> @@ -47,7 +47,23 @@ test_expect_success 'rebase ignores empty commit' '
>  	git commit --allow-empty -m empty &&
>  	test_commit D &&
>  	git rebase C &&
> -	test $(git log --format=%s C..) = "D"
> +	test "$(git log --format=%s C..)" = "D"
> +'
> +
> +test_expect_success 'rebase --keep-empty' '
> +	git reset --hard D &&
> +	git rebase --keep-empty C &&
> +	test "$(git log --format=%s C..)" = "D
> +empty"
> +'
> +
> +test_expect_success 'rebase --keep-empty keeps empty even if already in upstream' '
> +	git reset --hard A &&
> +	git commit --allow-empty -m also-empty &&
> +	git rebase --keep-empty D &&
> +	test "$(git log --format=%s A..)" = "also-empty
> +D
> +empty"
>  '
>  
>  test_done
> -- 
> 1.7.11.1.104.ge7b44f1
> 
> 
