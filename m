From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 15:15:09 +0000
Message-ID: <200702281515.10016.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0702281535070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 16:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQX8-0002cJ-HJ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933068AbXB1PPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933070AbXB1PPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:15:16 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:8032 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933068AbXB1PPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:15:15 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 28 Feb 2007 15:17:18 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HMQWN-0001G7-00
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 15:15:11 +0000
In-Reply-To: <Pine.LNX.4.63.0702281535070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-TUID: 436a2060afaa68d3
X-UID: 270
X-Length: 2640
Content-Disposition: inline
X-OriginalArrivalTime: 28 Feb 2007 15:17:18.0531 (UTC) FILETIME=[892AD930:01C75B4B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40935>

Previously, a binary file in the diffstat would show as:

 some-binary-file.bin       |  Bin

The space after the "Bin" was never used.  This patch changes binary
lines in the diffstat to be:

 some-binary-file.bin       |  Bin 123456 -> 12345 bytes

The very nice "->" notation was suggested by Johannes Schindelin, and
shows the before and after sizes more clearly than "+" and "-" would.
If a size is 0 it's not shown (although it would probably be better to
treat no-file differently from zero-byte-file).

The user can see what changed in the binary file, and how big the new
file is.  This is in keeping with the information in the rest of the
diffstat.

The diffstat_t members "added" and "deleted" were unused when the file
was binary, so this patch loads them with the file sizes in
builtin_diffstat().  These figures are then read in show_stats() when
the file is marked binary.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

Good call.

I like it.  "->" is much better than "+" and "-"; they would
imply that a set of bytes had been removed and another set added to
replace them - obviously nonsense.

 diff.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d1eae72..ea322e2 100644
--- a/diff.c
+++ b/diff.c
@@ -808,7 +808,16 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 
 		if (data->files[i]->is_binary) {
 			show_name(prefix, name, len, reset, set);
-			printf("  Bin\n");
+			printf("  Bin ");
+			if (added != 0)
+				printf("%s%i%s", add_c, added, reset);
+			if (added != 0 && deleted != 0 )
+				printf(" -> ");
+			if (deleted != 0)
+				printf("%s%i%s", del_c, deleted, reset);
+			if (added != 0 || deleted != 0 )
+				printf(" bytes");
+			printf("\n");
 			goto free_diffstat_file;
 		}
 		else if (data->files[i]->is_unmerged) {
@@ -1179,9 +1188,11 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2))
+	if (mmfile_is_binary(&mf1) || mmfile_is_binary(&mf2)) {
 		data->is_binary = 1;
-	else {
+		data->added = mf2.size;
+		data->deleted = mf1.size;
+	} else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-- 
1.5.0.2.205.gea888-dirty
