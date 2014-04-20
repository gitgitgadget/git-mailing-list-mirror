From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/8] fast-import: add support to delete refs
Date: Sun, 20 Apr 2014 13:59:27 -0500
Message-ID: <1398020370-11406-6-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8Q-0005mr-0t
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbaDTTKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:30 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:38344 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427AbaDTTKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:10:08 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so2903458yhz.22
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X9oSSmlQ/6vTEEcI6kmk7eI9jkF5cQX2Jj15M4bk9zw=;
        b=yk8HWT41dpxcRbyd0nq+RM6lNhQ+ElUcvmEgPWypKvOpVzFaiZb8UmLAG24BgvQJkP
         l/mX0r/kDFylYdbpvcR2/fiYi1p/sACaRgQ3+XDPyjAioOnqgAu7B131WSlu/jxNdxbL
         cKioPGvW/mcb39LQOHsl9oKlELs/Lk4czX22zDVrcNl28w0TAOkPOxDX5qd5YuDVkL0N
         Z8+pUhR5dbf7ecy+uutHGophaDqjsnNLSkIrjQUI3NaN3us0VzwAyKPAUhRcbRdS0HD0
         7BUS+PGejbqE6wL0dkyhFTUKPzt/yySHzq9GszeetM2L3dQBAQhNtzpHzonh2w+R1xW0
         0/zQ==
X-Received: by 10.236.110.77 with SMTP id t53mr11767634yhg.78.1398021007981;
        Sun, 20 Apr 2014 12:10:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z4sm19202429yhc.11.2014.04.20.12.10.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:10:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246563>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-fast-import.txt |  3 +++
 fast-import.c                     | 13 ++++++++++---
 t/t9300-fast-import.sh            | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index fd22a9a..c32a9a5 100644
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
index fb4738d..6707a66 100644
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
@@ -1681,10 +1682,13 @@ static int update_branch(struct branch *b)
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
@@ -2611,8 +2615,11 @@ static int parse_from(struct branch *b)
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
1.9.1+fc3.9.gc73078e
