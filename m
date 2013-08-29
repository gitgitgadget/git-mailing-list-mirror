From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/9] fast-import: add support to delete refs
Date: Thu, 29 Aug 2013 10:23:25 -0500
Message-ID: <1377789808-2213-7-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF49h-0000Su-6F
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab3H2P27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:59 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35908 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab3H2P26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:58 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so628990obp.22
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GQ497KT6LL2kT7dqEkTm/fimDa1LZPr61XDRXfBXV4=;
        b=b/nJlsTYkFvOKC+JjgggD3o+wAxj3LJiPLN/epn+r5KDrYtnp+NeFVwHT9WjqjKqgb
         gkfl2AAFGZJd+otOd6G7fMxfcogckMQNtxD5YqKGwiZOa5OLYlR9cWUo6jcueB7tq/pe
         VNYnwx3DpjUU3Wi1SD9o0tyS3VewwiVlZy9UAf6f9a3hsqyCttMd54g5j9ZCTNX//suM
         s75g6enXtJNz2ttZb5dPPbEmjE+fkZqiUEhMlAe5+yvF2F5BmL4opTeUPZo1DXD4Uy36
         kzUK6VNFc+TvY/vG9tTK0FWC0Swnuy7J9wfVJVr5GJQdvpQqNkC30N2SKJfUXPIPaK0A
         jGhQ==
X-Received: by 10.60.45.196 with SMTP id p4mr785114oem.81.1377790137812;
        Thu, 29 Aug 2013 08:28:57 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm33021216oeb.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233273>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-import.txt |  3 +++
 fast-import.c                     | 13 ++++++++++---
 t/t9300-fast-import.sh            | 18 ++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bf1a02a..fe5c952 100644
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
index 23f625f..b6be7a7 100644
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
@@ -1674,10 +1675,13 @@ static int update_branch(struct branch *b)
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
 	lock = lock_any_ref_for_update(b->name, old_sha1, 0);
 	if (!lock)
 		return error("Unable to lock %s", b->name);
@@ -2604,8 +2608,11 @@ static int parse_from(struct branch *b)
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
index ac6f3b6..0150aa6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2934,4 +2934,22 @@ test_expect_success 'S: ls with garbage after sha1 must fail' '
 	test_i18ngrep "space after tree-ish" err
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
