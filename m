From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 1/3] fast-import: do not write null_sha1 as a merge parent
Date: Wed, 27 Jun 2012 23:40:23 +0600
Message-ID: <1340818825-13754-2-git-send-email-divanorama@gmail.com>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 19:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjwDd-0000ud-A6
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 19:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619Ab2F0Rjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 13:39:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62882 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339Ab2F0Rjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 13:39:49 -0400
Received: by bkcji2 with SMTP id ji2so1242963bkc.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zBSXMWWud5+ZIRYVbDtSo7x7oyWzd/SO8Zdd8PWJb2M=;
        b=tt4ccVYmQH8PpQ7ocum74QItcvRIyeHB/T7lBOfeMbcBO2yyv5yDmeFL2hr5oMdARC
         v0VkC5WbeRg9D7atLvxTKmP4TqUUoZrE47S0ndX/6Hg9vrVMjbPirXuIiJgK6PwclGv/
         rQQ2v5ekD1CDLZhVXMl7NYCu2951Qtebtukwei1KBybCTQrZny/sR1Cmb2Y/BK6o/aE7
         FQDB985uPvWh/9xlJrAqeYzKySqBSKgvjTPHrMZikyCria5xB9ZvYhTmki9Iv7Aap0YH
         nAhd0/zbLAhfn/BLenDxPyEbLZp04qWp2yYM2xpl8Y2PS+eC21gML+cQIux4DcollBeF
         Gl8g==
Received: by 10.152.112.34 with SMTP id in2mr21453817lab.6.1340818787964;
        Wed, 27 Jun 2012 10:39:47 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id pp2sm84780930lab.3.2012.06.27.10.39.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:39:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200731>

null_sha1 is used in fast-import to indicate "empty" branches and
should never be actually written out as a commit parent. 'merge'
command lacks is_null_sha1 checks and must be fixed.

It looks like using null_sha1 or empty branches in 'from' command
is legal and/or an intended option (it has been here from the very
beginning and survived). So leave it allowed for 'merge' command too,
and just like with 'from' command silently skip null_sha1 parents.

Add a simple test for null_sha1 merge parents.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |    3 ++-
 t/t9300-fast-import.sh |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index eed97c8..419e435 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2734,7 +2734,8 @@ static void parse_new_commit(void)
 		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
 	while (merge_list) {
 		struct hash_list *next = merge_list->next;
-		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
+		if (!is_null_sha1(merge_list->sha1))
+			strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
 		free(merge_list);
 		merge_list = next;
 	}
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index c17f52e..5716420 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -850,6 +850,27 @@ INPUT_END
 test_expect_success \
 	'J: tag must fail on empty branch' \
 	'test_must_fail git fast-import <input'
+
+cat >input <<INPUT_END
+reset refs/heads/J3
+
+reset refs/heads/J4
+from 0000000000000000000000000000000000000000
+
+commit refs/heads/J5
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+Merge J3, J4 into fresh J5.
+COMMIT
+merge refs/heads/J3
+merge refs/heads/J4
+
+INPUT_END
+test_expect_success \
+	'J: allow merge with empty branch' \
+	'git fast-import <input &&
+	git rev-parse --verify J5 &&
+	test_must_fail git rev-parse --verify J5^'
 ###
 ### series K
 ###
-- 
1.7.3.4
