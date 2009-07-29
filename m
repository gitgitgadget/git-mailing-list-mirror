From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Demonstrate merge failure when a directory is replaced
 with a symlink.
Date: Wed, 29 Jul 2009 10:29:32 +0200
Message-ID: <4A70086C.9070408@drmicha.warpmail.net>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com> <1248819198-13921-2-git-send-email-james.e.pickens@intel.com> <1248819198-13921-3-git-send-email-james.e.pickens@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, barvik@broadpark.no
To: James Pickens <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:30:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4Xt-0000Ez-KZ
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbZG2I3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbZG2I3t
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:29:49 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39145 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842AbZG2I3r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 04:29:47 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 08A493BA4D7;
	Wed, 29 Jul 2009 04:29:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 29 Jul 2009 04:29:48 -0400
X-Sasl-enc: A38WByB3HjzRMX4I2TG75fmtvpJ2KRLPFXa1ufEhtgKw 1248856178
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 137E247896;
	Wed, 29 Jul 2009 04:29:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <1248819198-13921-3-git-send-email-james.e.pickens@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124322>

James Pickens venit, vidit, dixit 29.07.2009 00:13:
> This test creates two directories, a/b and a/b-2, replaces a/b-2 with a
> symlink to a/b, then merges that change into another branch that
> contains unrelated changes.  Since the changes are unrelated, the merge
> should be free of conflicts, but 'git merge' gives a file/directory
> conflict.
> 
> Note that this test is almost identical to t6035, except that instead of
> replacing a/b with a symlink, it replaces a/b-2 with a symlink.  This
> test results in a merge conflict, whereas t6035 does not.

In fact they are identical: Exchange b for b-2 and vice versa everywhere
and you get the same test, except for the fact that in 1/2 you "test -f"
in the last step. But I'm sure that test fails at the merge step already
(because of a dirty worktree), doesn't it? You should see this when
running the test with -d/-v. (I'm guessing, I haven't run your test.)

> 
> Signed-off-by: James Pickens <james.e.pickens@intel.com>
> ---
>  t/t6036-merge-dir-to-symlink.sh |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>  create mode 100755 t/t6036-merge-dir-to-symlink.sh
> 
> diff --git a/t/t6036-merge-dir-to-symlink.sh b/t/t6036-merge-dir-to-symlink.sh
> new file mode 100755
> index 0000000..020db7c
> --- /dev/null
> +++ b/t/t6036-merge-dir-to-symlink.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +test_description='merging when a directory was replaced with a symlink'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	mkdir -p a/b/c a/b-2/c &&
> +	> a/b/c/d &&
> +	> a/b-2/c/d &&
> +	> a/x &&
> +	git add -A &&
> +	git commit -m base &&
> +	rm -rf a/b-2 &&
> +	ln -s b a/b-2 &&
> +	git add -A &&
> +	git commit -m "dir to symlink"
> +'
> +
> +test_expect_failure 'checkout should not delete a/b/c/d' '
> +	git checkout -b temp HEAD^ &&
> +	test -f a/b/c/d
> +'
> +
> +test_expect_failure 'merge should not have conflicts' '
> +	echo x > a/x &&
> +	git add a/x &&
> +	git commit -m x &&
> +	git merge master'
> +
> +test_done

As in 1/2, I think the first expect_failure leaves a dirty/unexpected
worktree (d missing) which causes the merge failure in the last step.

Michael
