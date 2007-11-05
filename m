From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH 1/2] git-svn: fix dcommit clobbering when committing a
	series of diffs
Date: Mon, 5 Nov 2007 15:22:54 +0100
Message-ID: <20071105142254.GA20277@xp.machine.xx>
References: <1194261708-32256-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 15:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip2rC-0005r0-7e
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 15:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbXKEOW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 09:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbXKEOW7
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 09:22:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:42839 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754365AbXKEOW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 09:22:58 -0500
Received: (qmail invoked by alias); 05 Nov 2007 14:22:56 -0000
Received: from p54AAB8C3.dip0.t-ipconnect.de (EHLO localhost) [84.170.184.195]
  by mail.gmx.net (mp017) with SMTP; 05 Nov 2007 15:22:56 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19tPpkIH+htxmH/uIA+Q8xH1MLsDqn4i9ZlmopTrh
	TXAcu8nROVobeI
Content-Disposition: inline
In-Reply-To: <1194261708-32256-1-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63520>

On Mon, Nov 05, 2007 at 03:21:47AM -0800, Eric Wong wrote:
> Our revision number sent to SVN is set to the last revision we
> committed if we've made any previous commits in a dcommit
> invocation.
> 
> Although our SVN Editor code uses the delta of two (old) trees
> to generate information to send upstream, it'll still send
> complete resultant files upstream; even if the tree they're
> based against is out-of-date.
> 
> The combination of sending a file that does not include the
> latest changes, but set with a revision number of a commit we
> just made will cause SVN to accept the resultant file even if it
> was generated against an old tree.
> 
> More trouble was caused when fixing this because we were
> rebasing uncessarily at times.  We used git-diff-tree to check
> the imported SVN revision against our HEAD, not the last tree we
> committed to SVN.  The unnecessary rebasing caused merge commits
> upstream to SVN to fail.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> 

[...]

> diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
> new file mode 100755
> index 0000000..4216a88
> --- /dev/null
> +++ b/t/t9106-git-svn-dcommit-clobber-series.sh
> @@ -0,0 +1,56 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Eric Wong
> +test_description='git-svn dcommit clobber series'
> +. ./lib-git-svn.sh
> +
> +test_expect_success 'initialize repo' "
> +	mkdir import &&
> +	cd import &&
> +	awk 'BEGIN { for (i = 1; i < 64; i++) { print i } }' > file
> +	svn import -m 'initial' . $svnrepo &&
> +	cd .. &&
> +	git svn init $svnrepo &&
> +	git svn fetch &&
> +	test -e file
> +	"
> +
> +test_expect_success '(supposedly) non-conflicting change from SVN' "
> +	test x\"\`sed -n -e 58p < file\`\" = x58 &&
> +	test x\"\`sed -n -e 61p < file\`\" = x61 &&
> +	svn co $svnrepo tmp &&
> +	cd tmp &&
> +		perl -i -p -e 's/^58\$/5588/' file &&
> +		perl -i -p -e 's/^61\$/6611/' file &&
> +		test x\"\`sed -n -e 58p < file\`\" = x5588 &&
> +		test x\"\`sed -n -e 61p < file\`\" = x6611 &&
> +		svn commit -m '58 => 5588, 61 => 6611' &&
> +		cd ..
> +	"
> +
> +test_expect_success 'unrelated some unrelated changes to git' "

The first unrelated seems odd here.

-Peter

> +	echo hi > life &&
> +	git update-index --add life &&
> +	git commit -m hi-life &&
> +	echo bye >> life &&
> +	git commit -m bye-life life
> +	"
> +
[...] 
