From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] fix git-archive with empty trees
Date: Mon, 11 Mar 2013 00:58:11 -0400
Message-ID: <20130311045811.GA13510@sigill.intra.peff.net>
References: <20130311013123.GA11692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 05:58:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEuor-0006e8-TB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 05:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002Ab3CKE6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 00:58:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45715 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3CKE6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 00:58:14 -0400
Received: (qmail 10544 invoked by uid 107); 11 Mar 2013 04:59:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Mar 2013 00:59:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2013 00:58:11 -0400
Content-Disposition: inline
In-Reply-To: <20130311013123.GA11692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217852>

On Sun, Mar 10, 2013 at 09:31:24PM -0400, Jeff King wrote:

> I noticed that "git archive" will barf when the root tree is empty.
> [...]
> I didn't bother even looking at empty subtrees. AFAIK, git should never
> produce them (it omits the tree entirely if there is no content in it).
> You would have to fake it using hash-object manually. I suspect it would
> work just fine, as we already exercise the empty-dir code paths in the
> tests I did add.

Curious, I went ahead and tested this. It does indeed work as expected.
The following tests can be squashed into patch 2/2 if we want:

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 395dd58..cdb7d7a 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -80,4 +80,23 @@ test_expect_success 'archive complains about pathspec on empty tree' '
 	test_must_fail git archive --format=tar HEAD -- foo >/dev/null
 '
 
+test_expect_success 'create a commit with an empty subtree' '
+	empty_tree=$(git hash-object -t tree /dev/null) &&
+	root_tree=$(printf "040000 tree $empty_tree\tsub\n" | git mktree)
+'
+
+test_expect_success 'archive empty subtree with no pathspec' '
+	git archive --format=tar $root_tree >subtree-all.tar &&
+	make_dir extract &&
+	"$TAR" xf subtree-all.tar -C extract &&
+	check_dir extract sub
+'
+
+test_expect_success 'archive empty subtree by direct pathspec' '
+	git archive --format=tar $root_tree -- sub >subtree-path.tar &&
+	make_dir extract &&
+	"$TAR" xf subtree-path.tar -C extract &&
+	check_dir extract sub
+'
+
 test_done
