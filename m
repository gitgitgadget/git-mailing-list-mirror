From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 3/4] t2027-worktree-list: add and adjust tests related to git-rev-parse
Date: Fri, 29 Apr 2016 16:22:48 +0200
Message-ID: <20160429142248.16496-1-szeder@ira.uka.de>
References: <1461361992-91918-4-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:23:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9K4-0003xC-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbcD2OXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:23:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57502 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752764AbcD2OXG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 10:23:06 -0400
Received: from x590cc487.dyn.telefonica.de ([89.12.196.135] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aw9Js-0001hs-7o; Fri, 29 Apr 2016 16:23:01 +0200
X-Mailer: git-send-email 2.8.1.404.g5513ce8
In-Reply-To: <1461361992-91918-4-git-send-email-rappazzo@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461939782.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293004>

[Resend to list, sorry for the duplicates...]

> Adjust the incorrect expectation for `rev-parse --git-common-dir`.
> 
> Add a test for `git rev-parse --git-path` executed from a linked
> worktree.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  t/t2027-worktree-list.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
> index 1b1b65a..16eec6e 100755
> --- a/t/t2027-worktree-list.sh
> +++ b/t/t2027-worktree-list.sh
> @@ -14,10 +14,18 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
>  	test_cmp expected actual &&
>  	mkdir sub &&
>  	git -C sub rev-parse --git-common-dir >actual2 &&
> -	echo sub/.git >expected2 &&
> +	echo ../.git >expected2 &&
>  	test_cmp expected2 actual2
>  '

This hunk must go into patch 1/4.

The full test suite should pass after every single commit.  As patch
1/4 fixes things, the changing behavior makes this test case fail,
resulting in two commits in which 'make test' would fail.

> +test_expect_success 'rev-parse --git-path objects linked worktree' '
> +	echo "$(git rev-parse --show-toplevel)/.git/worktrees/linked-tree/objects" >expect &&
> +	test_when_finished "rm -rf linked-tree && git worktree prune" &&
> +	git worktree add --detach linked-tree master &&
> +	git -C linked-tree rev-parse --git-path objects >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success '"list" all worktrees from main' '
>  	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
>  	test_when_finished "rm -rf here && git worktree prune" &&
> -- 
> 2.8.0
