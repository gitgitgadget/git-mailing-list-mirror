From: Junio C Hamano <junkio@cox.net>
Subject: [BROKEN NEXT] merge-recursive thinkofix
Date: Wed, 18 Apr 2007 19:32:16 -0700
Message-ID: <7vps61aybz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 04:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMRl-0005Rl-Vm
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 04:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993112AbXDSCcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 22:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993114AbXDSCcS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 22:32:18 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43004 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993112AbXDSCcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 22:32:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419023217.QFRM1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 22:32:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oqYG1W00w1kojtg0000000; Wed, 18 Apr 2007 22:32:17 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44978>

The version I pushed out on 'next' has a serious breakage that
would affect merges to anybody who has 'merge.summary' or
'merge.tool' set.

Sorry for the gotcha --- here is a quickfix.

I'll be pushing out an updated 'next', hopefully shortly.

---

 merge-recursive.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ec8438b..96e461c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -809,6 +809,9 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	int status, fd, i;
 	struct stat st;
 
+	if (fn->cmdline == NULL)
+		die("custom merge driver %s lacks command line.", fn->name);
+
 	result->ptr = NULL;
 	result->size = 0;
 	create_temp(orig, temp[0]);
@@ -879,7 +882,7 @@ static int read_merge_config(const char *var, const char *value)
 	 * especially, we do not want to look at variables such as
 	 * "merge.summary", "merge.tool", and "merge.verbosity".
 	 */
-	if (prefixcmp(var, "merge.") || (ep = strrchr(var, '.')) == var + 6)
+	if (prefixcmp(var, "merge.") || (ep = strrchr(var, '.')) == var + 5)
 		return 0;
 
 	/*
@@ -1021,13 +1024,8 @@ static int ll_merge(mmbuffer_t *result_buf,
 	ll_driver_name = git_path_check_merge(a->path);
 	driver = find_ll_merge_driver(ll_driver_name);
 
-	if (index_only && driver->recursive) {
-		void *merge_attr;
-
-		ll_driver_name = driver->recursive;
-		merge_attr = git_attr(ll_driver_name, strlen(ll_driver_name));
-		driver = find_ll_merge_driver(merge_attr);
-	}
+	if (index_only && driver->recursive)
+		driver = find_ll_merge_driver(driver->recursive);
 	merge_status = driver->fn(driver, a->path,
 				  &orig, &src1, name1, &src2, name2,
 				  result_buf);
