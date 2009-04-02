From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] match_tree_entry(): a pathspec only matches at directory
 boundaries
Date: Wed, 01 Apr 2009 21:41:31 -0700
Message-ID: <7vwsa3llac.fsf_-_@gitster.siamese.dyndns.org>
References: <20090331094107.GC3307@atjola.homenet>
 <20090331150501.GA11446@atjola.homenet>
 <7vbprfn0ai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Anton Gyllenberg <anton@iki.fi>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 06:43:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpElm-0005tT-Go
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbZDBElm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 00:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbZDBElm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 00:41:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbZDBElm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 00:41:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ADA2BB3B5;
	Thu,  2 Apr 2009 00:41:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A4188B3AE; Thu, 
 2 Apr 2009 00:41:32 -0400 (EDT)
In-Reply-To: <7vbprfn0ai.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 01 Apr 2009 21:32:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DEA7CDA-1F40-11DE-965A-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115440>

Previously the code did a simple prefix match, which means that a path in
a directory "frotz/" would have matched with pathspec "f".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is a companion patch to fix ls-tree.  The test case uses a
   tree that has path3/1.txt and path3/2.txt in it.

   The bug Eric diagnosed and worked around in git-svn makes the current
   code show these two paths when pathspec "pa" and "path3/a" are given.
   The presense of "path3/a" makes the tree walker traverse down to path3
   subtree (in case something that matches "a" is in there---this is a
   correct behaviour), but then in that subtree, "pa" incorrectly matches
   "path3/1.txt".

   This logic dates back to 0ca14a5 (Start adding interfaces to read in
   partial trees, 2005-07-14).  I think it is just a simple oversight and
   we should fix it.

 t/t3101-ls-tree-dirname.sh |    6 ++++++
 tree.c                     |    8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 4dd7d12..51cb4a3 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -135,4 +135,10 @@ test_expect_success \
 EOF
      test_output'
 
+test_expect_success 'ls-tree filter is leading path match' '
+	git ls-tree $tree pa path3/a >current &&
+	>expected &&
+	test_output
+'
+
 test_done
diff --git a/tree.c b/tree.c
index 03e782a..d82a047 100644
--- a/tree.c
+++ b/tree.c
@@ -60,8 +60,12 @@ static int match_tree_entry(const char *base, int baselen, const char *path, uns
 			/* If it doesn't match, move along... */
 			if (strncmp(base, match, matchlen))
 				continue;
-			/* The base is a subdirectory of a path which was specified. */
-			return 1;
+			/* pathspecs match only at the directory boundaries */
+			if (!matchlen ||
+			    base[matchlen] == '/' ||
+			    match[matchlen - 1] == '/')
+				return 1;
+			continue;
 		}
 
 		/* Does the base match? */
-- 
1.6.2.1.483.gcc994
