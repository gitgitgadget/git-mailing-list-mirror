From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 18/37] merge-recursive: Move delete/modify handling into dedicated function
Date: Mon, 20 Sep 2010 02:28:51 -0600
Message-ID: <1284971350-30590-19-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjU-0005rH-Rm
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab0ITI2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab0ITI2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:08 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EmHGhfbq2UMU8YgRulgfkSeyVC9Gv/xJADn7AL3pBvM=;
        b=cypX0v7WkN7AINM4AkimJhJ1mnWmCIpECZOF0GkyP2BpCEEIAb8bCAYcp5ChVu5I4z
         0uUDpaLJguvNpsrm8pNT4op6IqgiNrdAQ7rsZKBAZaLdeF386qyQn4w7scgbd0OGHEAp
         MCdXFMRQ/DCZ89HGD1ff1AswCsNlwRL3nv4jM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m5wOdjjswjKDf5py+xVcRD5giCX+MRMATcNAGgjnymz+wIS6Zk+xmVBPKZjbCpcOQH
         ImmI/fcwW/x62SQmKjIKp707n9fcH5t0URvH4LHkHx5EkDtYkKyTnloWZwsUyQ5Qr+Bq
         8GMkdPnJXdnl2pt1JesAm0amIRJdJ3dDzUc4A=
Received: by 10.142.192.14 with SMTP id p14mr7335969wff.303.1284971288706;
        Mon, 20 Sep 2010 01:28:08 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156572>

This move is in preparation for the function being called from multiple
places in order to handle D/F conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 87be24c..a6da2cc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1119,6 +1119,26 @@ error_return:
 	return ret;
 }
 
+static void handle_delete_modify(struct merge_options *o,
+				 const char *path,
+				 unsigned char *a_sha, int a_mode,
+				 unsigned char *b_sha, int b_mode)
+{
+	if (!a_sha) {
+		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
+		       "and modified in %s. Version %s of %s left in tree.",
+		       path, o->branch1,
+		       o->branch2, o->branch2, path);
+		update_file(o, 0, b_sha, b_mode, path);
+	} else {
+		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
+		       "and modified in %s. Version %s of %s left in tree.",
+		       path, o->branch2,
+		       o->branch1, o->branch1, path);
+		update_file(o, 0, a_sha, a_mode, path);
+	}
+}
+
 /* Per entry merge function */
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
@@ -1151,19 +1171,8 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
-			if (!a_sha) {
-				output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-				       "and modified in %s. Version %s of %s left in tree.",
-				       path, o->branch1,
-				       o->branch2, o->branch2, path);
-				update_file(o, 0, b_sha, b_mode, path);
-			} else {
-				output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-				       "and modified in %s. Version %s of %s left in tree.",
-				       path, o->branch2,
-				       o->branch1, o->branch1, path);
-				update_file(o, 0, a_sha, a_mode, path);
-			}
+			handle_delete_modify(o, path,
+					     a_sha, a_mode, b_sha, b_mode);
 		}
 
 	} else if ((!o_sha && a_sha && !b_sha) ||
-- 
1.7.3.271.g16009
