From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 09/11] fast-import: add support to delete refs
Date: Tue, 12 Nov 2013 14:57:07 -0600
Message-ID: <1384289830-5471-15-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL9X-0000cy-4o
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab3KLVFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:05:21 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46461 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289Ab3KLVEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:44 -0500
Received: by mail-oa0-f47.google.com with SMTP id i7so2334040oag.6
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ryf9BefKMzvXiPY1HaMZsrMeRBIFG7IWdZJdgn7W9Dg=;
        b=f174vhrvOyAZpcQdrKceLz58gBSgHLqa609vWP+jsvv3x9jIWwywR8Ug6YgpMmyM03
         wX5l+MXxgkuAMYw1heNFNUGZhz+crEMr7agt4Kdi8L8q13XcgfyqFrC+8tcNsj5Mh6/U
         QACU6X9BarAXXXqtEvkOHnvvm69htPZDskAFlozowbQh+NCl+V1/fIxnwokvCqgliMSg
         CkfUFdUQbHxL2Uj5B3lX2aQcjmxGvHWNJKS+scQ8EzoFFiTKvEp3ESLuVVU8w1+A/deQ
         bU1TGzxuGntpiaiz5eKCvpuoFxfjfRJ0FrBNIzMQXU5Xeu8MIYP9g2ZylS62H0D+iPvS
         1zfA==
X-Received: by 10.60.45.65 with SMTP id k1mr13347345oem.48.1384290284317;
        Tue, 12 Nov 2013 13:04:44 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm35391796obc.12.2013.11.12.13.04.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:43 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237749>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-import.txt |  3 +++
 fast-import.c                     | 13 ++++++++++---
 t/t9300-fast-import.sh            | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 73f9806..2ffae42 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -483,6 +483,9 @@ Marks must be declared (via `mark`) before they can be used.
 * Any valid Git SHA-1 expression that resolves to a commit.  See
   ``SPECIFYING REVISIONS'' in linkgit:gitrevisions[7] for details.
 
+* The special null SHA-1 (40 zeros) specifies that the branch is to be
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
index 27263df..5fc9ef2 100755
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
1.8.4.2+fc1
