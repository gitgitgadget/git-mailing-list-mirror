From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] fast-{import,export}: use get_sha1_hex() directly
Date: Sun,  5 May 2013 17:38:52 -0500
Message-ID: <1367793534-8401-2-git-send-email-felipe.contreras@gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 06 00:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ7bd-0006pc-4u
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 00:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab3EEWkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 18:40:23 -0400
Received: from mail-gh0-f182.google.com ([209.85.160.182]:57402 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3EEWkV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 18:40:21 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so608112ghb.13
        for <git@vger.kernel.org>; Sun, 05 May 2013 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=HtLSaDsQuoJTSZja8d7pWYe8BvfDNQG2YW2FngHE6dM=;
        b=OGLErMhgADl9ZBHU8eAF40Gj61t8ZuknvnWMbvy30ejT8aPOd9sd9fK9O2cpT8S8Sn
         9JrQhTM1sZLaNvZvsuN0zzONs2oZ9zvRZr4ae1AO+khgXRCEffkiSF4UtD6/qxI2vxsZ
         ZJfKiZFWSQ3avs3MfZofLXoJnjoeQdnrM17udwx4bsUrKUTeVr/+GaQiaOMkitAPE8KG
         6jWEcWd5rhNMwA9Pv7bknYLFL3DaOs7yC0FO+fEPN4pxYcPneqMTmLiA1njmqujuv0IH
         AsEL/SFesELscuSaaPNzOPrKzr5Kv/ctvM2OVXvglQKmesOoKW4K5m3KVkhAPVR1YqLj
         gAkA==
X-Received: by 10.236.1.233 with SMTP id 69mr16520902yhd.127.1367793620897;
        Sun, 05 May 2013 15:40:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id g24sm42444574yhm.0.2013.05.05.15.40.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 05 May 2013 15:40:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223422>

It's wrong to call get_sha1() if they should be SHA-1s, plus
inefficient.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c |  2 +-
 fast-import.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d60d675..a4dee14 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -621,7 +621,7 @@ static void import_marks(char *input_file)
 
 		mark = strtoumax(line + 1, &mark_end, 10);
 		if (!mark || mark_end == line + 1
-			|| *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
+			|| *mark_end != ' ' || get_sha1_hex(mark_end + 1, sha1))
 			die("corrupt mark line: %s", line);
 
 		if (last_idnum < mark)
diff --git a/fast-import.c b/fast-import.c
index 5f539d7..e02f212 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1822,7 +1822,7 @@ static void read_marks(void)
 		*end = 0;
 		mark = strtoumax(line + 1, &end, 10);
 		if (!mark || end == line + 1
-			|| *end != ' ' || get_sha1(end + 1, sha1))
+			|| *end != ' ' || get_sha1_hex(end + 1, sha1))
 			die("corrupt mark line: %s", line);
 		e = find_object(sha1);
 		if (!e) {
@@ -2490,7 +2490,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 		if (commit_oe->type != OBJ_COMMIT)
 			die("Mark :%" PRIuMAX " not a commit", commit_mark);
 		hashcpy(commit_sha1, commit_oe->idx.sha1);
-	} else if (!get_sha1(p, commit_sha1)) {
+	} else if (!get_sha1_hex(p, commit_sha1)) {
 		unsigned long size;
 		char *buf = read_object_with_reference(commit_sha1,
 			commit_type, &size, commit_sha1);
@@ -2604,7 +2604,7 @@ static int parse_from(struct branch *b)
 			free(buf);
 		} else
 			parse_from_existing(b);
-	} else if (!get_sha1(from, b->sha1))
+	} else if (!get_sha1_hex(from, b->sha1))
 		parse_from_existing(b);
 	else
 		die("Invalid ref name or SHA1 expression: %s", from);
@@ -2632,7 +2632,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			if (oe->type != OBJ_COMMIT)
 				die("Mark :%" PRIuMAX " not a commit", idnum);
 			hashcpy(n->sha1, oe->idx.sha1);
-		} else if (!get_sha1(from, n->sha1)) {
+		} else if (!get_sha1_hex(from, n->sha1)) {
 			unsigned long size;
 			char *buf = read_object_with_reference(n->sha1,
 				commit_type, &size, n->sha1);
@@ -2792,7 +2792,7 @@ static void parse_new_tag(void)
 		oe = find_mark(from_mark);
 		type = oe->type;
 		hashcpy(sha1, oe->idx.sha1);
-	} else if (!get_sha1(from, sha1)) {
+	} else if (!get_sha1_hex(from, sha1)) {
 		struct object_entry *oe = find_object(sha1);
 		if (!oe) {
 			type = sha1_object_info(sha1, NULL);
-- 
1.8.3.rc0.401.g45bba44
