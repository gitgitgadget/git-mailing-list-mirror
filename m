From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] Demonstrate bugs when a directory is replaced with
 a symlink.
Date: Wed, 29 Jul 2009 10:19:54 +0200
Message-ID: <4A70062A.4040008@drmicha.warpmail.net>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com> <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, barvik@broadpark.no
To: James Pickens <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:20:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4Od-0004kG-2i
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbZG2IUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbZG2IUM
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:20:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38528 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307AbZG2IUK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 04:20:10 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 75F633B088F;
	Wed, 29 Jul 2009 04:20:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 29 Jul 2009 04:20:10 -0400
X-Sasl-enc: 5dUiaaoF+j6MT16RSigoGBZxD3MINhFpHEo2CncLtozL 1248855610
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 99897D591;
	Wed, 29 Jul 2009 04:20:09 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124319>

James Pickens venit, vidit, dixit 29.07.2009 00:13:
> This test creates two directories, a/b and a/b-2, then replaces a/b with
> a symlink to a/b-2, then merges that change into another branch that
> contains an unrelated change.
> 
> There are two bugs:
> 1. 'git checkout' wrongly deletes work tree file a/b-2/d.
> 2. 'git merge' wrongly deletes work tree file a/b-2/d.
> 
> Signed-off-by: James Pickens <james.e.pickens@intel.com>
> ---
>  t/t6035-merge-dir-to-symlink.sh |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
>  create mode 100755 t/t6035-merge-dir-to-symlink.sh
> 
> diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
> new file mode 100755
> index 0000000..926c8ed
> --- /dev/null
> +++ b/t/t6035-merge-dir-to-symlink.sh
> @@ -0,0 +1,32 @@
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
> +	rm -rf a/b &&
> +	ln -s b-2 a/b &&
> +	git add -A &&
> +	git commit -m "dir to symlink"
> +'
> +
> +test_expect_failure 'checkout should not delete a/b-2/c/d' '
> +	git checkout -b temp HEAD^ &&
> +	test -f a/b-2/c/d
> +'
> +
> +test_expect_failure 'merge should not delete a/b-2/c/d' '
> +	echo x > a/x &&
> +	git add a/x &&
> +	git commit -m x &&
> +	git merge master &&
> +	test -f a/b-2/c/d
> +'
> +
> +test_done

Isn't the failure of the second test caused by that of the first one?
a/b-2/c/d is gone from the worktree, and master does not touch it, so
the merge leaves the worktree version (non-existent) as is.

Michael
