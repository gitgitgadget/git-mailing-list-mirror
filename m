From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH] Better errors when trying to merge a submodule
Date: Mon, 10 Dec 2007 13:44:35 +0100
Message-ID: <20071210124435.GA4788@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 10 13:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1i0K-00071v-0B
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 13:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbXLJMoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 07:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbXLJMoj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 07:44:39 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:33446 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbXLJMoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 07:44:38 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J1hzv-0002Sv-K6; Mon, 10 Dec 2007 13:44:35 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67707>


Instead of dying with weird errors when trying to merge submodules from a
supermodule, emit errors that show what the problem is.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---

If you try to merge a submodule from a supermodule, you get some very
strange error messages. With this patch you get a nice clean error
message indicating that this isn't supported instead.


 git-merge-one-file.sh |    7 +++++++
 merge-recursive.c     |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 1e7727d..7aee342 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -82,6 +82,13 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
+	case ",$6,$7," in
+	*,160000,*)
+		echo "ERROR: $4: Not merging submodule."
+		exit 1
+		;;
+	esac
+
 	src2=`git-unpack-file $3`
 	case "$1" in
 	'')
diff --git a/merge-recursive.c b/merge-recursive.c
index 9a1e2f2..ecae8ea 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1046,6 +1046,8 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
+                } else if (S_ISGITLINK(a->mode) || S_ISGITLINK(b->mode)) {
+                        die("cannot merge submodules!");
 		} else {
 			if (!(S_ISLNK(a->mode) || S_ISLNK(b->mode)))
 				die("cannot merge modes?");
-- 
1.5.3.7.1149.g591a-dirty
