From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff: release blobs after generating textual diff.
Date: Sun, 06 May 2007 01:47:25 -0700
Message-ID: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 10:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkcP4-00014G-56
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXEFIr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 04:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXEFIr2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:47:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:32846 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXEFIr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 04:47:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506084726.CRZE1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 04:47:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vknS1W0071kojtg0000000; Sun, 06 May 2007 04:47:26 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46317>

This reduces the memory pressure when dealing with many paths.

An unscientific test of running "diff-tree --stat --summary -M"
between v2.6.19 and v2.6.20-rc1 in the linux kernel repository
indicates that the number of minor faults are reduced by 2/3
(153k vs 49k).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is still a WIP, not in the sense that it breaks anything
   (it doesn't seem to), but in the sense that it is not known
   if it is useful in general and would make that much of a
   difference with a project much larger than the kernel.

diff --git a/diff.c b/diff.c
index 7bbe759..9de053c 100644
--- a/diff.c
+++ b/diff.c
@@ -1236,6 +1236,8 @@ static void builtin_diff(const char *name_a,
 	}
 
  free_ab_and_return:
+	diff_free_filespec_data(one);
+	diff_free_filespec_data(two);
 	free(a_one);
 	free(b_two);
 	return;
@@ -1262,7 +1264,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		diff_populate_filespec(two, 0);
 		data->deleted = count_lines(one->data, one->size);
 		data->added = count_lines(two->data, two->size);
-		return;
+		goto free_and_return;
 	}
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
@@ -1284,6 +1286,10 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		ecb.priv = diffstat;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
+
+ free_and_return:
+	diff_free_filespec_data(one);
+	diff_free_filespec_data(two);
 }
 
 static void builtin_checkdiff(const char *name_a, const char *name_b,
@@ -1306,7 +1312,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		die("unable to read files to diff");
 
 	if (file_is_binary(two))
-		return;
+		goto free_and_return;
 	else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
@@ -1320,6 +1326,9 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		ecb.priv = &data;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
+ free_and_return:
+	diff_free_filespec_data(one);
+	diff_free_filespec_data(two);
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
