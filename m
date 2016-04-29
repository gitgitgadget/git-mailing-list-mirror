From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 2/4] t1500-rev-parse: add tests executed from sub path of the main worktree
Date: Fri, 29 Apr 2016 16:22:06 +0200
Message-ID: <20160429142206.16397-1-szeder@ira.uka.de>
References: <1461361992-91918-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:22:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9JH-0003LY-Ae
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbcD2OWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:22:19 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57469 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753022AbcD2OWT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 10:22:19 -0400
Received: from x590cc487.dyn.telefonica.de ([89.12.196.135] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aw9J8-0001eu-2x; Fri, 29 Apr 2016 16:22:15 +0200
X-Mailer: git-send-email 2.8.1.404.g5513ce8
In-Reply-To: <1461361992-91918-3-git-send-email-rappazzo@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461939735.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293003>

[Resend to list, sorry for the duplicates.]

> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  t/t1500-rev-parse.sh | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 48ee077..1e220f7 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -36,6 +36,7 @@ test_rev_parse() {
>  # label is-bare is-inside-git is-inside-work prefix git-dir
>  
>  ROOT=$(pwd)
> +original_core_bare=$(git config core.bare)
>  
>  test_rev_parse toplevel false false true '' .git
>  
> @@ -84,4 +85,40 @@ test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
>  git config --unset core.bare
>  test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
>  
> +#cleanup from the above
> +cd ..
> +rm -r work
> +mv repo.git .git || exit 1

You can't just 'exit 1' mid-script, because terminating the test script
abruptly makes the test harness unhappy.

> +unset GIT_DIR
> +unset GIT_CONFIG

Both variables are set at this point, so calling plain 'unset' is OK.
Still, I would suggest using 'sane_unset' instead, so the next person
looking at this test doesn't have to spend brain cycles on figuring
out whether plain 'unset' is indeed safe or not.

> +git config core.bare $original_core_bare

This whole '#cleanup from the above' block is just ugly.  Not your
fault, of course, but the consequence of how the preceeding tests were
written in the past.  I think it would be best if this series were
scheduled on top of the 't1500 cleanup & modernization' patch I saw a
few days ago, then this block wouldn't be necessary at all.

> +test_expect_success 'git-common-dir from worktree root' '
> +	echo .git >expect &&
> +	git rev-parse --git-common-dir >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git-common-dir inside sub-dir' '
> +	mkdir -p path/to/child &&
> +	test_when_finished "rm -rf path" &&
> +	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
> +	git -C path/to/child rev-parse --git-common-dir >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git-path from worktree root' '
> +	echo .git/objects >expect &&
> +	git rev-parse --git-path objects >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git-path inside sub-dir' '
> +	mkdir -p path/to/child &&
> +	test_when_finished "rm -rf path" &&
> +	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
> +	git -C path/to/child rev-parse --git-path objects >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 2.8.0
