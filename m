From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v5 2/6] fast-import: put marks reading in it's own function
Date: Thu, 27 Aug 2009 11:12:12 -0700
Message-ID: <1251396736-928-2-git-send-email-srabbelier@gmail.com>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Thu Aug 27 20:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgjSm-00077M-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbZH0SMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbZH0SMf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:12:35 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:39583 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZH0SMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:12:33 -0400
Received: by ewy2 with SMTP id 2so1461383ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zREsoLCH86wCHWD1QVpAXhyIrObMCbMoXqrbNxilBf8=;
        b=I7xWqin5N5V2Fi8z939+UY2MVWVxD/6P3dDsVogzPjmST3EDa9LK8P+qOZ5oyGEmSt
         nWiR6PgLH2KdmQMrVwyBkTc6vjdMxt24gGAlcUgS+mfNd/aMLNWQ7KfSlgPDRzvY7qQm
         p/FhWPXyY3lVMcxn93spS1QLsv9z6y0y52OMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jlretxRJTA6wsFxb/KoV05vv8E66zcr3K7Aa/yY84Hgaa0M2dHQ2XtZHx/Hg+nKU7y
         iDVNLgN0NvvQM8XFtYBSnZpIbkcD0XWJpliEBq/7aA9791e7w+4jYsV8Dtx5DiIj0QvE
         ItxHSKIAxBhtgamv09wJRFhTsucQtkFJNkt4c=
Received: by 10.211.132.36 with SMTP id j36mr600100ebn.51.1251396753800;
        Thu, 27 Aug 2009 11:12:33 -0700 (PDT)
Received: from localhost.localdomain (kaayla.mtv.corp.google.com [172.22.72.177])
        by mx.google.com with ESMTPS id 10sm62710eyz.25.2009.08.27.11.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 11:12:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.122.g6ffd7
In-Reply-To: <1251396736-928-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127183>

All options do nothing but set settings, with the exception of the
--input-marks option. Delay the reading of the marks file till after
all options have been parsed.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Unchanged from v4.

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
1.6.4.122.g6ffd7
