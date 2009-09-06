From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v7 2/6] fast-import: put marks reading in it's own function
Date: Sun,  6 Sep 2009 16:35:44 +0200
Message-ID: <1252247748-14507-3-git-send-email-srabbelier@gmail.com>
References: <1252247748-14507-1-git-send-email-srabbelier@gmail.com>
 <1252247748-14507-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Sun Sep 06 16:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkIrA-00078l-0K
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 16:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757974AbZIFOgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 10:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757968AbZIFOgN
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 10:36:13 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55913 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757964AbZIFOgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 10:36:11 -0400
Received: by mail-ew0-f206.google.com with SMTP id 2so1511761ewy.17
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bYl/vhsJW6oBYmLh+uU+WDuwtro9KT+T2e35bxnv07M=;
        b=K0cExOLtPF9a7gwXY3o4/N1Uv2bJQ5vnOpfc/yhxmJjdXRENAuxI6fkL8GEgDei19z
         7U4IJCfjMj2wnA1ach4eyOTa30kzjJ1tZNIBf3R7z6xOBDbaZz0lS7TJrFRA1j9p/iGu
         x8E2MUaVLFIydlrQ4PAKNDOXpgvBtsKyUrbf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yo+oN4VkD3/TL+zzk9oofZR+ijJLPIJsv7FnAMYklcKFDgfTPAccpocJfRouAxQunS
         Hvlc4AjNe8JWNqcYgIBlFGxPS8QfZf0u+yXDDws85Xx0YjMyrGjXAmtbmCAXve3DHfIx
         xQQqd3pVUZTOVHRIdFuV3mIZbY0nvazytXoBk=
Received: by 10.216.70.204 with SMTP id p54mr2651781wed.87.1252247773778;
        Sun, 06 Sep 2009 07:36:13 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id q9sm8759493gve.6.2009.09.06.07.36.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 07:36:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1252247748-14507-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127856>

All options do nothing but set settings, with the exception of the
--input-marks option. Delay the reading of the marks file till after
all options have been parsed.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged again.

 fast-import.c |   73 ++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b904f20..812fcf0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -315,6 +315,7 @@ static struct object_entry_pool *blocks;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
 static const char *mark_file;
+static const char *input_file;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -1643,6 +1644,42 @@ static void dump_marks(void)
 	}
 }
 
+static void read_marks(void)
+{
+	char line[512];
+	FILE *f = fopen(input_file, "r");
+	if (!f)
+		die_errno("cannot read '%s'", input_file);
+	while (fgets(line, sizeof(line), f)) {
+		uintmax_t mark;
+		char *end;
+		unsigned char sha1[20];
+		struct object_entry *e;
+
+		end = strchr(line, '\n');
+		if (line[0] != ':' || !end)
+			die("corrupt mark line: %s", line);
+		*end = 0;
+		mark = strtoumax(line + 1, &end, 10);
+		if (!mark || end == line + 1
+			|| *end != ' ' || get_sha1(end + 1, sha1))
+			die("corrupt mark line: %s", line);
+		e = find_object(sha1);
+		if (!e) {
+			enum object_type type = sha1_object_info(sha1, NULL);
+			if (type < 0)
+				die("object not found: %s", sha1_to_hex(sha1));
+			e = insert_object(sha1);
+			e->type = type;
+			e->pack_id = MAX_PACK_ID;
+			e->offset = 1; /* just not zero! */
+		}
+		insert_mark(mark, e);
+	}
+	fclose(f);
+}
+
+
 static int read_next_command(void)
 {
 	static int stdin_eof = 0;
@@ -2338,39 +2375,9 @@ static void parse_progress(void)
 	skip_optional_lf();
 }
 
-static void option_import_marks(const char *input_file)
+static void option_import_marks(const char *marks)
 {
-	char line[512];
-	FILE *f = fopen(input_file, "r");
-	if (!f)
-		die_errno("cannot read '%s'", input_file);
-	while (fgets(line, sizeof(line), f)) {
-		uintmax_t mark;
-		char *end;
-		unsigned char sha1[20];
-		struct object_entry *e;
-
-		end = strchr(line, '\n');
-		if (line[0] != ':' || !end)
-			die("corrupt mark line: %s", line);
-		*end = 0;
-		mark = strtoumax(line + 1, &end, 10);
-		if (!mark || end == line + 1
-			|| *end != ' ' || get_sha1(end + 1, sha1))
-			die("corrupt mark line: %s", line);
-		e = find_object(sha1);
-		if (!e) {
-			enum object_type type = sha1_object_info(sha1, NULL);
-			if (type < 0)
-				die("object not found: %s", sha1_to_hex(sha1));
-			e = insert_object(sha1);
-			e->type = type;
-			e->pack_id = MAX_PACK_ID;
-			e->offset = 1; /* just not zero! */
-		}
-		insert_mark(mark, e);
-	}
-	fclose(f);
+	input_file = xstrdup(marks);
 }
 
 static void option_date_format(const char *fmt)
@@ -2495,6 +2502,8 @@ int main(int argc, const char **argv)
 	}
 	if (i != argc)
 		usage(fast_import_usage);
+	if (input_file)
+		read_marks();
 
 	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
-- 
1.6.4.16.g72c66.dirty
