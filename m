From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] fast-{import,export}: use get_sha1_hex() directly
Date: Thu,  2 May 2013 23:31:39 -0500
Message-ID: <1367555502-4706-2-git-send-email-felipe.contreras@gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 06:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY7gK-0004gt-TB
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 06:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3ECEdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 00:33:09 -0400
Received: from mail-gg0-f177.google.com ([209.85.161.177]:64761 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3ECEdG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 00:33:06 -0400
Received: by mail-gg0-f177.google.com with SMTP id j5so218285ggn.36
        for <git@vger.kernel.org>; Thu, 02 May 2013 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OgiNKE3vDw/V6IZirp/acJeCLo52JKzdkOeIGLsZ3+s=;
        b=jQnuwkTZ8rEJJPB//tjTioPZ5IGDTouF7tz53dwLQ9L9MHqmikJZcqDUbx7nUs4QnF
         1PDtfFaoH9XW6U3kv2wpFhEvCQNPmOUWON9Shle/XQ8o7/pBdoDCLYusSgVqCMMvofyp
         gmLf1rCKQP5IN72033oJNXHBNJX9PT1OyhDUnl3vDvJcxj6EModebPQ8xU2pN7/YKZmQ
         jRqxYgwhxxF1mWwV0iaAD2F7Zoea9H+AoBhAUHSGLO0E/D4ZjQj04DU+oZMx0b43z2Wi
         1Yi4sxz8U2pE9PbcIOS/EbB4mav+9DiEKxPISdW/4dJZJg+s5XcbZAxqdEP4/BXCH8Mr
         AC5g==
X-Received: by 10.236.192.231 with SMTP id i67mr7761466yhn.23.1367555585827;
        Thu, 02 May 2013 21:33:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i44sm18193006yhk.17.2013.05.02.21.33.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 21:33:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223276>

There's no point in calling get_sha1() if we know they are SHA-1s.

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
