From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] sha1_name: Suggest commit:./file for path in subdir
Date: Thu, 31 Mar 2011 11:17:34 +0200
Message-ID: <4ff35194dc52fa969049f555f8d9358cb7ba0c1a.1301562935.git.git@drmicha.warpmail.net>
References: <4D94322A.8030409@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 11:21:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5E4G-00039P-3Z
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 11:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259Ab1CaJVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 05:21:20 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:53919 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933189Ab1CaJVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 05:21:09 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3379C20A4B;
	Thu, 31 Mar 2011 05:21:09 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 31 Mar 2011 05:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=wUibRfqqCQypndLZ9Hv7lZrW55g=; b=K+flYafH/t++PWx9HeEgr7O8ou3eNaJzC69u/NQhjn4fmgfJodl9st/k80s9Im//fTTOGnQNAQ/VkX3BBxf0nEvhsdhA2Slwf2EdCsBVC5uNG/MNlkC4KQ6haWBaG7Kf8KbhfwnbqfXrggLZIjAldWkJxHdPrJ5odJBUfI6O21c=
X-Sasl-enc: 8dydq5l02bpP8+u/KfQ0BliBWZDxvh4WAnF8Jk6/56oR 1301563268
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BEA2E4433A0;
	Thu, 31 Mar 2011 05:21:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <4D94322A.8030409@drmicha.warpmail.net>
In-Reply-To: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170462>

Currently, the "Did you mean..." message suggests "commit:fullpath"
only. Extend this to show the more convenient "commit:./file" form also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 sha1_name.c                    |   11 +++++++----
 t/t1506-rev-parse-diagnosis.sh |    2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index faea58d..69cd6c8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1012,11 +1012,13 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 		if (!get_tree_entry(tree_sha1, fullname,
 				    sha1, &mode)) {
 			die("Path '%s' exists, but not '%s'.\n"
-			    "Did you mean '%s:%s'?",
+			    "Did you mean '%s:%s' aka '%s:./%s'?",
 			    fullname,
 			    filename,
 			    object_name,
-			    fullname);
+			    fullname,
+			    object_name,
+			    filename);
 		}
 		die("Path '%s' does not exist in '%s'",
 		    filename, object_name);
@@ -1065,9 +1067,10 @@ static void diagnose_invalid_index_path(int stage,
 		if (ce_namelen(ce) == fullnamelen &&
 		    !memcmp(ce->name, fullname, fullnamelen))
 			die("Path '%s' is in the index, but not '%s'.\n"
-			    "Did you mean ':%d:%s'?",
+			    "Did you mean ':%d:%s' aka ':%d:./%s'?",
 			    fullname, filename,
-			    ce_stage(ce), fullname);
+			    ce_stage(ce), fullname,
+			    ce_stage(ce), filename);
 	}
 
 	if (!lstat(filename, &st))
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index f9cb202..4a6396f 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -9,7 +9,7 @@ exec </dev/null
 test_did_you_mean ()
 {
 	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
-	printf "Did you mean '$1:$2$3'?\n" >>expected &&
+	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
 	test_cmp expected error
 }
 
-- 
1.7.4.2.668.gba03a4
