From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Thu, 24 Jun 2010 09:23:04 -0500
Message-ID: <oyrgMnuxMzyEmKMa6Bb_rvLb_zp8WscXW73T03xzJ5_bpheAt9Hpcw@cipher.nrlssc.navy.mil>
References: <4C0E7037.8080403@web.de> <4C0E7077.9090509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 24 16:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORnLR-0003Zv-2i
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 16:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab0FXOXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 10:23:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38837 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab0FXOXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 10:23:51 -0400
Received: by mail.nrlssc.navy.mil id o5OEN5Jg030292; Thu, 24 Jun 2010 09:23:05 -0500
In-Reply-To: <4C0E7077.9090509@web.de>
X-OriginalArrivalTime: 24 Jun 2010 14:23:04.0830 (UTC) FILETIME=[C27879E0:01CB13A8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149597>

On 06/08/2010 11:31 AM, Jens Lehmann wrote:

Two things...

> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index 83c1914..559b41e 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -103,9 +103,17 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
>  	git diff HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
> -	test_cmp expect.body actual.body
> +	test_cmp expect.body actual.body &&
> +	git diff --ignore-submodules HEAD >actual2 &&
> +	echo -n "" | test_cmp - actual2 &&

'echo -n' is not portable (here, and below).  Please use printf
instead.  Ditto for t4041

> +	git diff --ignore-submodules=untracked HEAD >actual3 &&
> +	sed -e "1,/^@@/d" actual3 >actual3.body &&
> +	expect_from_to >expect.body $subprev $subprev-dirty &&
> +	test_cmp expect.body actual3.body &&
> +	git diff --ignore-submodules=dirty HEAD >actual4 &&
> +	echo -n "" | test_cmp - actual4
>  '
> -
> +test_done
   ^^^^^^^^^

Why is this test_done here?  There are additional tests after this point,
and an additional call to test_done.


>  test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
>  	(
>  		cd sub &&
> @@ -129,7 +137,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>  	git diff HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
> -	test_cmp expect.body actual.body
> +	test_cmp expect.body actual.body &&
> +	git diff --ignore-submodules=all HEAD >actual2 &&
> +	echo -n "" | test_cmp - actual2 &&
> +	git diff --ignore-submodules=untracked HEAD >actual3 &&
> +	echo -n "" | test_cmp - actual3 &&
> +	git diff --ignore-submodules=dirty HEAD >actual4 &&
> +	echo -n "" | test_cmp - actual4
>  '
> 
>  test_expect_success 'git diff (empty submodule dir)' '
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 019acb9..f44b906 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
