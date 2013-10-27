From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/10] fast-import: add support to delete refs
Date: Sun, 27 Oct 2013 01:05:20 -0600
Message-ID: <1382857521-7005-10-git-send-email-felipe.contreras@gmail.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 08:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaKWc-0006wv-JF
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 08:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab3J0HM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 03:12:29 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35053 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3J0HMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 03:12:23 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so2446554obc.41
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oV3O714r5e1sPfZ2AIqxWbrWnRxT3I9/VyYCbEcyJ04=;
        b=xhuQRl0MvsbN/gToLNQ9/IjbAhEHqHH+4Z4mgkruaWqryn8F8hOsKncs0+zNns75GD
         Bcl6Pk2rkS7huoRc2ByU9XaOBYnI7PfA5JLm+Kr1a7LCE6imaV9n5rCRIWOWLpGfBzbK
         BvyNSJkOZzORCWtLKGa8/3teBNov3Cg0ThA69/9T/v7AbjX76liveyGEizdcJlLKN+vI
         70+s0j6UzWwO3zYTKOm6CVJaBSWxQ5F5Y0ZJH+KdubjDQsu5W9XHCkPVmutnKinddTlo
         XN98BTFRCWjiVZ45hmFJ7P02B7wT4OJ4X3tCR9BeKPzSGD/T2V9hIT6j3fTrK/EBmTLF
         liHg==
X-Received: by 10.182.219.138 with SMTP id po10mr285209obc.58.1382857942128;
        Sun, 27 Oct 2013 00:12:22 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm18014978obi.14.2013.10.27.00.12.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2013 00:12:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236787>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-import.txt |  3 +++
 fast-import.c                     | 13 ++++++++++---
 t/t9300-fast-import.sh            | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 73f9806..c49ede4 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -483,6 +483,9 @@ Marks must be declared (via `mark`) before they can be used.
 * Any valid Git SHA-1 expression that resolves to a commit.  See
   ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
 
+* The special null SHA-1 (40 zeros) specifices that the branch is to be
+  removed.
+
 The special case of restarting an incremental import from the
 current branch value should be written as:
 ----
diff --git a/fast-import.c b/fast-import.c
index f4d9969..fdce0b7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -248,6 +248,7 @@ struct branch {
 	uintmax_t last_commit;
 	uintmax_t num_notes;
 	unsigned active : 1;
+	unsigned delete : 1;
 	unsigned pack_id : PACK_ID_BITS;
 	unsigned char sha1[20];
 };
@@ -1690,10 +1691,13 @@ static int update_branch(struct branch *b)
 	struct ref_lock *lock;
 	unsigned char old_sha1[20];
 
-	if (is_null_sha1(b->sha1))
-		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
+	if (is_null_sha1(b->sha1)) {
+		if (b->delete)
+			delete_ref(b->name, old_sha1, 0);
+		return 0;
+	}
 	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
 	if (!lock)
 		return error("Unable to lock %s", b->name);
@@ -2620,8 +2624,11 @@ static int parse_from(struct branch *b)
 			free(buf);
 		} else
 			parse_from_existing(b);
-	} else if (!get_sha1(from, b->sha1))
+	} else if (!get_sha1(from, b->sha1)) {
 		parse_from_existing(b);
+		if (is_null_sha1(b->sha1))
+			b->delete = 1;
+	}
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 88fc407..f453388 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2999,4 +2999,22 @@ test_expect_success 'T: ls root tree' '
 	test_cmp expect actual
 '
 
+test_expect_success 'T: delete branch' '
+	git branch to-delete &&
+	git fast-import <<-EOF &&
+	reset refs/heads/to-delete
+	from 0000000000000000000000000000000000000000
+	EOF
+	test_must_fail git rev-parse --verify refs/heads/to-delete
+'
+
+test_expect_success 'T: empty reset doesnt delete branch' '
+	git branch not-to-delete &&
+	git fast-import <<-EOF &&
+	reset refs/heads/not-to-delete
+	EOF
+	git show-ref &&
+	git rev-parse --verify refs/heads/not-to-delete
+'
+
 test_done
-- 
1.8.4-fc
