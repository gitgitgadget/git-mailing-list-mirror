From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH 1/2] add_to_alternates_file: don't add duplicate paths
Date: Sun, 31 May 2015 11:15:22 -0700
Message-ID: <1433096123-14420-2-git-send-email-gjthill@gmail.com>
References: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 31 20:15:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7lv-0007Rz-Eh
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 20:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758432AbbEaSPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 14:15:36 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36071 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758372AbbEaSPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 14:15:33 -0400
Received: by pacux9 with SMTP id ux9so53358153pac.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffA4Jdt4rKomziO4UJTgM3IjPy9oFxGVUjbxmfxzZPA=;
        b=gkaT6Ikh1m7GKho9o5RdRxlNvllGxkTXwfC3k+3ObFdEp7qSKkHcuYwOjrvkPX7cOr
         x02TcjNIJSkSEOO+fguxdcAXaiXIScJMT6DczSO239kghgXYEHzOuXrQIAzUyYEAl56A
         1GP/ja36VLwpCS6DU053TZ3zmPJVfAa+03ZdSOGyXpsvoj27sxZicUa+i6VWVY7jzYM0
         6JN7f6O7bWdyRqzOISkwJu+1yJYAXPT5kfzz5nq6Lq3bXe3ZrbH1CvA5aVth5u+PdEER
         WpI985L39g8/0RFyLz4dZofmNK2q0Tf8/1TY8vwEyNYR2PqnRhrJzrS4P/tXtMwFC9XJ
         Idcg==
X-Received: by 10.68.197.161 with SMTP id iv1mr34040323pbc.0.1433096133358;
        Sun, 31 May 2015 11:15:33 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id l10sm11826347pbq.87.2015.05.31.11.15.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 11:15:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.gfc728c2
In-Reply-To: <1433096123-14420-1-git-send-email-gjthill@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270343>

Check for an existing match before appending a path to the alternates
file.  Beyond making git look smart to anyone checking the alternates
file, this removes the last use of hold_lock_file_for_append.

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
 sha1_file.c                | 29 +++++++++++++++++++++++++----
 t/t5700-clone-reference.sh |  4 ++--
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 47f56f2..43d9530 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -403,14 +403,35 @@ void read_info_alternates(const char * relative_base, int depth)
 
 void add_to_alternates_file(const char *reference)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
+	static struct lock_file lock = {0};
 	char *alt = mkpath("%s\n", reference);
+	char *alts = git_path("objects/info/alternates");
+	int fd = hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	struct strbuf altdata = STRBUF_INIT;
+	struct string_list lines = STRING_LIST_INIT_NODUP;
+
+	if (strbuf_read_file(&altdata, alts, 0) < 0)
+		if (errno != ENOENT)
+			die("alternates file unreadable");
+	strbuf_complete_line(&altdata);
+	write_or_die(fd, altdata.buf, altdata.len);
+
+	string_list_split_in_place(&lines, altdata.buf, '\n', -1);
+	lines.cmp = strcmp_icase;
+	if (unsorted_string_list_has_string(&lines, reference)) {
+		rollback_lock_file(&lock);
+		goto cleanup;
+	}
+
 	write_or_die(fd, alt, strlen(alt));
-	if (commit_lock_file(lock))
-		die("could not close alternates file");
+	if (commit_lock_file(&lock))
+		die("could not update alternates file");
 	if (alt_odb_tail)
 		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
+
+cleanup:
+	strbuf_reset(&altdata);
+	string_list_clear(&lines,0);
 }
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 3e783fc..cd9fa34 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -29,11 +29,11 @@ git prune'
 cd "$base_dir"
 
 test_expect_success 'cloning with reference (-l -s)' \
-'git clone -l -s --reference B A C'
+'git clone -l -s --reference B --reference A --reference B A C'
 
 cd "$base_dir"
 
-test_expect_success 'existence of info/alternates' \
+test_expect_success 'existence of info/alternates, no duplicates' \
 'test_line_count = 2 C/.git/objects/info/alternates'
 
 cd "$base_dir"
-- 
2.4.1.4.gfc728c2
