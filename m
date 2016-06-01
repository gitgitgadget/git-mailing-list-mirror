From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git gc and worktrees
Date: Wed, 1 Jun 2016 09:00:49 +0200
Message-ID: <574E8821.3070502@kdbg.org>
References: <574D382A.8030809@kdbg.org>
 <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
 <20160531221415.GA3824@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 09:01:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b809B-0005Wt-8q
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 09:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbcFAHAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 03:00:54 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:36954 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757441AbcFAHAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 03:00:53 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rKLq63c71z5tlH;
	Wed,  1 Jun 2016 09:00:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 2D01A5247;
	Wed,  1 Jun 2016 09:00:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160531221415.GA3824@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296058>

Am 01.06.2016 um 00:14 schrieb Jeff King:
> Right, we use the index for reachability checks (both in "prune", but
> also during a "repack -a", which uses the revision parser's
> '--indexed-objects" option). That obviously should handle per-worktree
> index files, but I don't know whether it currently does.

Thanks. Here's a test case to make sure that --indexed-objects looks at
the indexes of separate worktrees. I'm not submitting a proper patch
because I don't feel like being able to fix the problem and I'm not
sure what the expected order of the listed objects is.

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 3e752ce..dbd3679 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -96,6 +96,34 @@ test_expect_success 'rev-list can show index objects' '
 	test_cmp expect actual
 '
 
+test_expect_success '--indexed-objects in the index of a separate worktrees' '
+	# see also the comments in the previous case
+	cat >expect <<-\EOF &&
+	8e4020bb5a8d8c873b25de15933e75cc0fc275df one
+	d9d3a7417b9605cfd88ee6306b28dadc29e6ab08 only-in-index
+	2043d83f5a374f119437856d2f1773c936938876 only-in-wt-index
+	9200b628cf9dc883a85a7abc8d6e6730baee589c two
+	EOF
+	echo only-in-index >only-in-index &&
+	git add only-in-index &&
+
+	git worktree add -b side wt &&
+	test_when_finished "rm -r wt; git worktree prune" &&
+	(
+		cd wt &&
+		echo only-in-wt-index >only-in-wt-index &&
+		git add only-in-wt-index &&
+
+		# this must also include the objects of the main worktree
+		git rev-list --objects --indexed-objects >../actual
+	) &&
+	test_cmp expect actual &&
+
+	# same result when invoked from the main worktree
+	git rev-list --objects --indexed-objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--bisect and --first-parent can not be combined' '
 	test_must_fail git rev-list --bisect --first-parent HEAD
 '
