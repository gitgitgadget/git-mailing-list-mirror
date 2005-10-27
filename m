From: Pavel Roskin <proski@gnu.org>
Subject: gitk shows an empty line between "Comments" and changed files
Date: Thu, 27 Oct 2005 13:30:30 -0400
Message-ID: <1130434230.19641.21.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 27 19:32:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVBaQ-00031j-95
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 19:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJ0Ran (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 13:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVJ0Ran
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 13:30:43 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:28862 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751309AbVJ0Ram
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 13:30:42 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EVBaC-000098-Mk
	for git@vger.kernel.org; Thu, 27 Oct 2005 13:30:38 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EVBaA-0002SC-Ar
	for git@vger.kernel.org; Thu, 27 Oct 2005 13:30:30 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10717>

Hello!

gitk is now showing an empty line between "Comments" and changes files.
This change was caused by 8b7e5d76e836396a097bb6f61cf930ea872a7bd3 (Make
"gitk" work better with dense revlists).

git-diff-tree outputs some SHA1 as the first line if only one tree-ish
argument is provided.  I don't see any way to suppress that output (see
diff-tree.c, line 114).

One solution would be to add an option to git-diff-tree to suppress all
headers (let's call it --no-headers).

Or maybe the SHA1 header should never be printed at all?  It looks like
it's not documented anywhere.  It doesn't break the tests.

While debugging the patch, I have found that the p variable is unused in
both functions that stopped passing it to git-diff-tree.

Also, gettreediffs function in gitk could use --names-only for
git-diff-tree, because it only needs names.

Maybe --names-only and --name-status should suppress the SHA1 header to
match their descriptions?  Unfortunately, they don't suppress the patch
is -p is specified, so "matching the descriptions" would have to take
care of it.

P.S. I consider printing the SHA1 header in git-diff-tree an
undocumented feature (in other words, a bug).

Proposed patch:

Don't print the SHA1 when only one tree-ish is given to git-diff-tree.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/diff-tree.c b/diff-tree.c
index 382011a..ac53f48 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -111,7 +111,6 @@ static int diff_tree_commit(const unsign
 		unsigned char parent[20];
 		if (get_sha1_hex(buf + offset + 7, parent))
 			return -1;
-		header = generate_header(name, sha1_to_hex(parent), buf, size);
 		diff_tree_sha1_top(parent, commit, "");
 		if (!header && verbose_header) {
 			header_prefix = "\ndiff-tree ";


-- 
Regards,
Pavel Roskin
