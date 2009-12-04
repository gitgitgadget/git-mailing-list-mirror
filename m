From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v8 2/7] fast-import: put marks reading in it's own function
Date: Fri,  4 Dec 2009 18:06:55 +0100
Message-ID: <1259946420-8845-3-git-send-email-srabbelier@gmail.com>
References: <1259946420-8845-1-git-send-email-srabbelier@gmail.com>
 <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	<vcs-fast-import-devs@l
X-From: git-owner@vger.kernel.org Fri Dec 04 18:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbdE-000621-8Q
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbZLDRHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbZLDRHS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:07:18 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58084 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbZLDRHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:07:12 -0500
Received: by ewy19 with SMTP id 19so3051396ewy.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 09:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ehKGRVsk/NxchwYawtwD636Th+eFUU7qIHLkJXDoVHE=;
        b=Hq1Cw7IEbipMo5EVFQJzTqYZEAQOBRsz1BIl4L/ge12pPvcRS6B0/XvZpy5BIc3lhh
         QOtUt9NyyfpDMxJ88rN3RqPVWUPBYM4qlXiocg3L8OIIDRx4OTqDUCVo/BwfXhZxBMrR
         2afVb+RyJBBiNHrpYEwM0dzoGQBqHRJzjveHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ISPyTpn7ejyIBm9/LjHFpbmkE/B4dKYHKriVw6FVMM9oNkkLG2NSSud5egISpMlFEW
         14skf93kG2848vvubj1VmOriHM85D/O7TNAJFQQUEdGo1v5zh9yrH0kPd6e/HLcjE1O5
         sla9OONZ77N1yUI2srON8GrS3jQhLTm+2iYkI=
Received: by 10.213.15.19 with SMTP id i19mr2886513eba.65.1259946437618;
        Fri, 04 Dec 2009 09:07:17 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1980184ewy.14.2009.12.04.09.07.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 09:07:16 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1259946420-8845-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134545>

All options do nothing but set settings, with the exception of the
--input-marks option. Delay the reading of the marks file till after
all options have been parsed.

Also, rename mark_file to export_marks_file as it is now ambiguous.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Renamed mark_fiel to export_marks_file and added import_marks_file as
	per Shawn's comments.

 fast-import.c |   93 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fcd9e1e..0458b03 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -318,7 +318,8 @@ static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
-static const char *mark_file;
+static const char *export_marks_file;
+static const char *import_marks_file;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -455,8 +456,8 @@ static void write_crash_report(const char *err)
 	fputc('\n', rpt);
 	fputs("Marks\n", rpt);
 	fputs("-----\n", rpt);
-	if (mark_file)
-		fprintf(rpt, "  exported to %s\n", mark_file);
+	if (export_marks_file)
+		fprintf(rpt, "  exported to %s\n", export_marks_file);
 	else
 		dump_marks_helper(rpt, 0, marks);
 
@@ -1603,13 +1604,13 @@ static void dump_marks(void)
 	int mark_fd;
 	FILE *f;
 
-	if (!mark_file)
+	if (!export_marks_file)
 		return;
 
-	mark_fd = hold_lock_file_for_update(&mark_lock, mark_file, 0);
+	mark_fd = hold_lock_file_for_update(&mark_lock, export_marks_file, 0);
 	if (mark_fd < 0) {
 		failure |= error("Unable to write marks file %s: %s",
-			mark_file, strerror(errno));
+			export_marks_file, strerror(errno));
 		return;
 	}
 
@@ -1618,7 +1619,7 @@ static void dump_marks(void)
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to write marks file %s: %s",
-			mark_file, strerror(saved_errno));
+			export_marks_file, strerror(saved_errno));
 		return;
 	}
 
@@ -1634,7 +1635,7 @@ static void dump_marks(void)
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to write marks file %s: %s",
-			mark_file, strerror(saved_errno));
+			export_marks_file, strerror(saved_errno));
 		return;
 	}
 
@@ -1642,11 +1643,47 @@ static void dump_marks(void)
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to commit marks file %s: %s",
-			mark_file, strerror(saved_errno));
+			export_marks_file, strerror(saved_errno));
 		return;
 	}
 }
 
+static void read_marks(void)
+{
+	char line[512];
+	FILE *f = fopen(import_marks_file, "r");
+	if (!f)
+		die_errno("cannot read '%s'", import_marks_file);
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
@@ -2421,39 +2458,9 @@ static void parse_progress(void)
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
+	import_marks_file = xstrdup(marks);
 }
 
 static void option_date_format(const char *fmt)
@@ -2487,7 +2494,7 @@ static void option_active_branches(const char *branches)
 
 static void option_export_marks(const char *marks)
 {
-	mark_file = xstrdup(marks);
+	export_marks_file = xstrdup(marks);
 }
 
 static void option_export_pack_edges(const char *edges)
@@ -2581,6 +2588,8 @@ int main(int argc, const char **argv)
 	}
 	if (i != argc)
 		usage(fast_import_usage);
+	if (import_marks_file)
+		read_marks();
 
 	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
-- 
1.6.5.3.164.g07b0c
