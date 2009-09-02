From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v6 2/6] fast-import: put marks reading in it's own function
Date: Wed,  2 Sep 2009 19:56:59 +0200
Message-ID: <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.cla
X-From: git-owner@vger.kernel.org Wed Sep 02 19:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu6C-0007Zr-Mb
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZIBR5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZIBR5g
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:57:36 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57092 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZIBR5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:57:34 -0400
Received: by bwz19 with SMTP id 19so909406bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+0cIgwQS6GzuVt6tHeqp/d9pCixwMSAIPWJaKwGX4pM=;
        b=OLm74q2z6cP9juMqeX5EQl5nHJa9Qj5MiiMkwZt1hm+CBy3d/E600kIMgmk7yT0rGw
         LqG3twBHJR7OlGn1ttWO+q5H6qFOPao8HNBFukdqUuvHF20hmJb07oU9SM0OIpZZ5FOC
         3uo7mmfrzsUIi6WEqMHgZuIREHZgB/xrRZzco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UaozUQ6tHoCkjcy7NCDUnkrxjrUn7JzVNzO9GRSTeiCF5VIllXn4ckCDl/djo71UeX
         8N9QAxhJK81KtSeEuQWZtMyB1jBSzDGVaADAfmjbqOCBH2d4B/bOsX0PpAb7MLPYVNUq
         N95ZF9dAmYMCQ6yoaBRP42tVgHbgs3N2UGfFM=
Received: by 10.204.151.209 with SMTP id d17mr6950960bkw.120.1251914254815;
        Wed, 02 Sep 2009 10:57:34 -0700 (PDT)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 21sm325505fks.9.2009.09.02.10.57.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:57:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127619>

All options do nothing but set settings, with the exception of the
--input-marks option. Delay the reading of the marks file till after
all options have been parsed.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  No change since v5.

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
