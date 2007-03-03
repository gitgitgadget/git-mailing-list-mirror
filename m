From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2] Tell multi-parent diff about core.symlinks.
Date: Sat, 3 Mar 2007 20:38:00 +0100
Message-ID: <200703032038.00928.johannes.sixt@telecom.at>
References: <200703032032.47158.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 20:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNaCU-0008O7-KB
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 20:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbXCCTrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 14:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbXCCTrN
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 14:47:13 -0500
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:52516 "EHLO
	smtp1.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030410AbXCCTrM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 14:47:12 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP id AA8B336887
	for <git@vger.kernel.org>; Sat,  3 Mar 2007 20:38:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 359663B47A
	for <git@vger.kernel.org>; Sat,  3 Mar 2007 20:38:01 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <200703032032.47158.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41319>

When core.symlinks is false, and a merge of symbolic links had conflicts,
the merge result is left as a file in the working directory. A decision
must be made whether the file is treated as a regular file or as a
symbolic link. This patch treats the file as a symbolic link only if
all merge parents were also symbolic links.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

I'm not quite sure whether this patch is worth it. The only thing it seems
to do is to avoid the mode change line (this is after a merge where 'symlink'
had a conflict):

without the patch:

  $ git diff
  diff --cc symlink
  index 1a010b1,30d67d4..0000000
  mode 120000,120000..100644
  --- a/symlink
  +++ b/symlink

with the patch:

  $ git diff
  diff --cc symlink
  index 1a010b1,30d67d4..0000000
  --- a/symlink
  +++ b/symlink


 combine-diff.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 044633d..e6e3969 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -699,8 +699,18 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			 !fstat(fd, &st)) {
 			size_t len = st.st_size;
 			size_t sz = 0;
+			int is_file, i;
 
 			elem->mode = canon_mode(st.st_mode);
+			/* if symlinks don't work, assume symlink if all parents
+			 * are symlinks
+			 */
+			is_file = has_symlinks;
+			for (i = 0; !is_file && i < num_parent; i++)
+				is_file = !S_ISLNK(elem->parent[i].mode);
+			if (!is_file)
+				elem->mode = canon_mode(S_IFLNK);
+
 			result_size = len;
 			result = xmalloc(len + 1);
 			while (sz < len) {
-- 
1.5.0.2.4.gdd4e4-dirty
