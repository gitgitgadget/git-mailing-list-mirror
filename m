From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] rebase -i: do not leave a CHERRY_PICK_HEAD file
 behind
Date: Wed, 17 Jun 2015 14:58:14 +0200
Message-ID: <20150617145814.Horde.VFmyWwlQfspzMMXX3ZuSlQ4@webmail.informatik.kit.edu>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
 <cover.1434528725.git.johannes.schindelin@gmx.de>
 <2751d249ba6315f0139ba8fd6aa6ff23c32c9e69.1434528725.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 14:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5CvA-0003T4-Ix
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 14:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbbFQM6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 08:58:20 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60997 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753116AbbFQM6S (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 08:58:18 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Z5Cv1-00044Z-T8; Wed, 17 Jun 2015 14:58:15 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Z5Cv0-00072N-LF; Wed, 17 Jun 2015 14:58:14 +0200
Received: from x590d2ef6.dyn.telefonica.de (x590d2ef6.dyn.telefonica.de
 [89.13.46.246]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 17 Jun 2015 14:58:14 +0200
In-Reply-To: <2751d249ba6315f0139ba8fd6aa6ff23c32c9e69.1434528725.git.johannes.schindelin@gmx.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1434545895.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271837>

Hi,

Quoting Johannes Schindelin <johannes.schindelin@gmx.de>:
> When skipping commits whose changes were already applied via `git rebase
> --continue`, we need to clean up said file explicitly.
>
> The same is not true for `git rebase --skip` because that will execute
> `git reset --hard` as part of the "skip" handling in git-rebase.sh, even
> before git-rebase--interactive.sh is called.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Nice quick turnaround, thanks.

So, with this change the 'git reset' won't be necessary at all, right?

> ---
>  git-rebase--interactive.sh    | 6 +++++-
>  t/t3404-rebase-interactive.sh | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..16e0a82 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -849,7 +849,11 @@ continue)
>  	# do we have anything to commit?
>  	if git diff-index --cached --quiet HEAD --
>  	then
> -		: Nothing to commit -- skip this
> +		: Nothing to commit -- skip this commit

"While at it", perhaps you could turn this into a proper comment with '#".
Now that this if-branch starts to actually do something, there's no  
reason to continue (ab)using the null command.

> +
> +		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
> +		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
> +		die "Could not remove CHERRY_PICK_HEAD"
>  	else
>  		if ! test -f "$author_script"
>  		then
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 5d52775..241d4d1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1102,7 +1102,7 @@ test_expect_success 'rebase -i commits that  
> overwrite untracked files (no ff)' '
>  	test $(git cat-file commit HEAD | sed -ne \$p) = I
>  '
>
> -test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
> +test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
>  	git checkout -b commit-to-skip &&
>  	for double in X 3 1
>  	do
> --
> 2.3.1.windows.1.9.g8c01ab4
