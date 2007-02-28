From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 13:03:11 +0000
Message-ID: <200702281303.11951.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 14:03:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMOSr-0001Vz-1l
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 14:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbXB1NDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 08:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbXB1NDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 08:03:16 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:4670 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932201AbXB1NDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 08:03:15 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 28 Feb 2007 13:05:19 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HMOSe-0007Tg-00
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 13:03:12 +0000
X-TUID: 99b3adb3ae5db45e
X-UID: 269
X-Length: 2464
Content-Disposition: inline
X-OriginalArrivalTime: 28 Feb 2007 13:05:19.0281 (UTC) FILETIME=[18ED3210:01C75B39]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40920>

Previously, a binary file in the diffstat would show as:

 some-binary-file.bin       |  Bin

The space after the "Bin" was never used.  This patch changes binary
lines in the diffstat to be:

 some-binary-file.bin       |  Bin +123456B -12345B

The "+" item is the size of the new version, the "-" item is the size of
the old version.  If a size is 0 it's not shown (although it would
probably be better to treat no-file differently from zero-byte-file).

The "B" (for bytes) is shown to highlight the fact that these numbers
are not "number of lines", but actual bytes.

The user can see what changed in the binary file, and how big the new
file is.  This is in keeping with the information in the rest of the
diffstat.

The diffstat_t members "added" and "deleted" were unused when the file
was binary, so this patch loads them with the file sizes in
builtin_diffstat().  These figures are then read in show_stats() when
the file is marked binary.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 diff.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d1eae72..174b84e 100644
--- a/diff.c
+++ b/diff.c
@@ -808,7 +808,14 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 
 		if (data->files[i]->is_binary) {
 			show_name(prefix, name, len, reset, set);
-			printf("  Bin\n");
+			printf("  Bin ");
+			if (added != 0)
+				printf("%s+%iB%s", add_c, added, reset);
+			if (added != 0 && deleted != 0 )
+				printf(" ");
+			if (deleted != 0)
+				printf("%s-%iB%s", del_c, deleted, reset);
+			printf("\n");
 			goto free_diffstat_file;
 		}
 		else if (data->files[i]->is_unmerged) {
@@ -1179,9 +1186,11 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
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
1.5.0.2.778.gdcb06
