From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Show binary file size change in diff --stat
Date: Wed, 4 Apr 2007 13:14:14 +0000
Message-ID: <200704041414.14797.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 15:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ5Jn-0001Hj-O1
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 15:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992908AbXDDNO1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 09:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992910AbXDDNO1
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 09:14:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:35317 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992908AbXDDNO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 09:14:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so656341uga
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 06:14:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=kU8v9NT7XuR63l2iYamSKYxYUaU2mP77dJjQqzXAXDmNFwhmYcnyGXuLZukTZI9dTnrEukaDDzZQH13qaICsyVgjS4CQZX4dIC9XrDE2zIgKc+nnRbmyEin8aiv8ycdhHpv9tKsvbD8wjAdVrD9xbMAyeH7MBtcwk4h9M9lD+ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=k4jNEgXPj/x0D+KucEZkp+ntOSzOcP/dRIT0At7dM8g52FV4rp4JPJc1QOVDH7cQp6TYcA1yW/wUwXWsoTIklzsuwyFPUjQvd/nqtIvGRoM13pohjwaucozfwpdf85x6JriiT8/+oj8CZEGCN67cFaWh7CuENWQuIBGUNRJ56v4=
Received: by 10.67.89.5 with SMTP id r5mr140490ugl.1175692461045;
        Wed, 04 Apr 2007 06:14:21 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z37sm1218288ikz.2007.04.04.06.14.19;
        Wed, 04 Apr 2007 06:14:20 -0700 (PDT)
X-TUID: af7935fa35eb9b1a
X-UID: 300
X-Length: 2342
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43735>

Previously, a binary file in the diffstat would show as:

 some-binary-file.bin       |  Bin

The space after the "Bin" was never used.  This patch changes binary
lines in the diffstat to be:

 some-binary-file.bin       |  Bin 12345 -> 123456 bytes

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
This is a resend; I still wish for it every time I see a --stat with
binary files changed.

Is there any objection to it that I can address?


 diff.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d8f9242..1a527e9 100644
--- a/diff.c
+++ b/diff.c
@@ -811,7 +811,12 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 
 		if (data->files[i]->is_binary) {
 			show_name(prefix, name, len, reset, set);
-			printf("  Bin\n");
+			printf("  Bin ");
+			printf("%s%i%s", del_c, deleted, reset);
+			printf(" -> ");
+			printf("%s%i%s", add_c, added, reset);
+			printf(" bytes");
+			printf("\n");
 			goto free_diffstat_file;
 		}
 		else if (data->files[i]->is_unmerged) {
@@ -1185,9 +1190,11 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
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
1.5.1.rc3.703.g5709-dirty
