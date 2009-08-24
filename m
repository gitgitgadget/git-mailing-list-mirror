From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 2/4] fast-import: put marks reading in it's own function
Date: Mon, 24 Aug 2009 13:52:34 -0700
Message-ID: <1251147156-19279-3-git-send-email-srabbelier@gmail.com>
References: <1251147156-19279-1-git-send-email-srabbelier@gmail.com>
 <1251147156-19279-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 22:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfgXp-00068r-06
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 22:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbZHXUxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbZHXUw6
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 16:52:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:31568 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbZHXUwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 16:52:55 -0400
Received: by rv-out-0506.google.com with SMTP id f6so794188rvb.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ncl/ZKTJHlc6pGKBiSuSZtVctdTwIbkf8EzIOxkGEHM=;
        b=MpacV7GK8CSs2JIgo4fWBALPOP0HRFqD4DydOvnu59bAkqaz3awQMIZB6bkS8OKDQl
         LQGw+LBTbGfO2rWTcVrXBca3RtQgLznFfHMXO8d4fvSr1TzD/qjrFCiRa2F/PKxUT9Qs
         qlxduca++ijwmksRkbkqrHY1LqKdGHntHw6Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l6/PV+3SUp2Y00RS3yj2NqKBiZd02rSY0B6weoXzs0hnMmyr64ydyS4zkVOKw62teM
         0eJf91VmyUeSOu6/TJaEIrXIcDcqiy8JyYGIkudzL3hAj1CZpZEqZK2BeA4DQQ8WVjXy
         qnwYbXEEcUcJXsLrfgvgzOXONrNqKFbDlj3xI=
Received: by 10.140.202.9 with SMTP id z9mr2545271rvf.30.1251147177133;
        Mon, 24 Aug 2009 13:52:57 -0700 (PDT)
Received: from localhost.localdomain ([216.239.45.19])
        by mx.google.com with ESMTPS id 20sm1023981pzk.5.2009.08.24.13.52.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 13:52:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251147156-19279-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126968>

All options do nothing but set settings, with the exception of the
--input-marks option. Delay the reading of the marks file till after
all options have been parsed.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    New in the series, as requested by Shawn for easier review.

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
