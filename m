From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH] fast-import: always save out branches, tags and marks on checkpoint
Date: Wed,  2 Oct 2013 18:24:57 +0600
Message-ID: <1380716697-7560-1-git-send-email-divanorama@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 14:23:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRLT1-0006uc-7j
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 14:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab3JBMXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 08:23:44 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:58889 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab3JBMXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 08:23:41 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so552250lab.34
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zDHy8zYUI87q927yy63P3WaWxpRQsTm/u2D5DSvhbTg=;
        b=qMvka7RZ8/Qp+OzP9a6WR5LcvDHFyzHimHWXbXb6lbiHxUqpdZeEXnc+HTS3NZRHm9
         bUSVeM04Imtm4MAejHS+scb82Ss7atGYwq7Q3LxSju1+E4fG3nPNrk571Qg6PY4G9mTG
         esoIZamyHbsH7Coi9Pzz7XF2TeM2SGHAYyXuCpfPYnw1+B3FtJufu3LI9iKunesoaw/T
         vaC5ykF3VsWZQrYggczJRDqS97G+6rVY4WaGSrSePthGocWSqiF9BRyYSuawErhjORLg
         Gql7nc1V7cpOFeR+HpzcHtlrMjQzY9929m7bGpb3h5I6ysC0HWzH/l2uSjH8ehaPMfAf
         ipIQ==
X-Received: by 10.152.243.42 with SMTP id wv10mr1285095lac.39.1380716620561;
        Wed, 02 Oct 2013 05:23:40 -0700 (PDT)
Received: from woot.lan (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPSA id u20sm1545703lbh.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 05:23:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235668>

checkpoint command causes fast-import to finish the current pack and
start a new one. If there are no (newly imported) objects in the pack
fast-import does nothing with the pack AND doesn't save out branches,
tags and marks.

Fix it by always saving out branches, tags and marks on a checkpoint.

Simple test case where no new objects are created is
$ fast-export $somebranch | sed $somebranch to $newbranch | fast-import
While it's running send checkpoint signals to fast-import to avoid
parsing the import stream. Non-fast-forward updates may happen if there
are merges in $somebranch history. The fast-import may fail on
checkpoints now. Not a regression as it'd fail the same way before if
import is to a new/empty repository - the intermediate packs won't be
empty and so a real checkpoint happens anyway.

Whether fast-export really should reuse $somebranch name for all commits
in it's history graph and so cause intermediate non-fast-forwads is a
separate topic to be discussed.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |  9 ++++-----
 t/t9300-fast-import.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f4d9969..4a3b93f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3101,12 +3101,11 @@ static void parse_ls(struct branch *b)
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
-	if (object_count) {
+	if (object_count)
 		cycle_packfile();
-		dump_branches();
-		dump_tags();
-		dump_marks();
-	}
+	dump_branches();
+	dump_tags();
+	dump_marks();
 }
 
 static void parse_checkpoint(void)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 88fc407..03bfdef 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -693,6 +693,32 @@ test_expect_success \
 	'git cat-file commit other >actual &&
 	test_cmp expect actual'
 
+cat >input2 <<INPUT_END
+reset refs/heads/branch2
+from refs/heads/other
+
+reset refs/heads/branch2
+from refs/heads/branch
+INPUT_END
+
+cat >input3 <<INPUT_END
+reset refs/heads/branch3
+from refs/heads/other
+
+checkpoint
+
+reset refs/heads/branch3
+from refs/heads/branch
+INPUT_END
+
+test_expect_success \
+	'F: intermediate non-fast-forward' \
+	'git fast-import <input2'
+
+test_expect_success \
+	'F: intermediate non-fast-forward with zero objects checkpoint should fail' \
+	'test_must_fail git fast-import <input3'
+
 ###
 ### series G
 ###
-- 
1.8.1.5
