From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH 2/2] blame: introduce -u/--unique option
Date: Tue,  8 Mar 2011 19:59:11 +0900
Message-ID: <1299581951-4670-2-git-send-email-namhyung@gmail.com>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 11:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwudT-0003HE-MF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 11:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab1CHK7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 05:59:25 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56701 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab1CHK7X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 05:59:23 -0500
Received: by mail-yi0-f46.google.com with SMTP id 27so1948163yia.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=+8ikb7U1Gte86xaHu3BNEDHlQoycZ263bUROtSlrQvA=;
        b=L9FII9RUOnfiPJhTKpnF0U6PTLnfBEXxK7WM6R4QpOWWVEOtUs+gkM7ozov0O8orWp
         wNfrY+1wF774el1tOwRpHTm9cIRjeYXgXPqoxkOQacaq/HpqET6NJFlTyLWG2uCXm65S
         j/nd8jUewwu6Ca/xlKq/9JsUCKud8v7GHpWS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CSGpSBk9+p7CI8nDGopSDBvusqi+q991Aoua3AUVK0lweRqnQFkJQGpGh4Zu/nICII
         8YU7ipQxRP2WGR7hxcreAUvBg+dewy9yAJ2H4ZRAOZvAqxDWU3eYTtjhtKmzwkBA0XXk
         dbIXmcyf20PZfKVvbpGk9jATUuEbZHKp1FcWw=
Received: by 10.150.161.5 with SMTP id j5mr5730925ybe.378.1299581963115;
        Tue, 08 Mar 2011 02:59:23 -0800 (PST)
Received: from localhost.localdomain ([118.176.73.109])
        by mx.google.com with ESMTPS id l2sm589368ybn.15.2011.03.08.02.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 02:59:22 -0800 (PST)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168656>

-u/--unique option will find and use minimum length of unique
SHA-1 name. If -l option is specified also, it will have higher
priority, IOW git blame will use full 40-length SHA-1 name.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 builtin/blame.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec5..9ea41bc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -41,6 +41,7 @@ static int reverse;
 static int blank_boundary;
 static int incremental;
 static int xdl_opts;
+static int longest_uniq_sha1;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
@@ -1618,6 +1619,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_SHOW_SCORE      0100
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
+#define OUTPUT_UNIQ_OBJECT_NAME	01000
 
 static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 {
@@ -1664,14 +1666,22 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	struct commit_info ci;
 	char hex[41];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int sha1_len;
 
 	get_commit_info(suspect->commit, &ci, 1);
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 
+	if (opt & OUTPUT_LONG_OBJECT_NAME)
+		sha1_len = 40;
+	else if (opt & OUTPUT_UNIQ_OBJECT_NAME)
+		sha1_len = longest_uniq_sha1;
+	else
+		sha1_len = 8;
+
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
+		int length = sha1_len;
 
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
@@ -1842,6 +1852,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	for (e = sb->ent; e; e = e->next) {
 		struct origin *suspect = e->suspect;
 		struct commit_info ci;
+		const char *sha1;
 		int num;
 
 		if (strcmp(suspect->path, sb->path))
@@ -1867,6 +1878,10 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			longest_dst_lines = num;
 		if (largest_score < ent_score(sb, e))
 			largest_score = ent_score(sb, e);
+		sha1 = find_unique_abbrev(suspect->commit->object.sha1,
+					  MINIMUM_ABBREV);
+		if (longest_uniq_sha1 < strlen(sha1))
+			longest_uniq_sha1 = strlen(sha1);
 	}
 	max_orig_digits = lineno_width(longest_src_lines);
 	max_digits = lineno_width(longest_dst_lines);
@@ -2306,6 +2321,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('s', NULL, &output_option, "Suppress author name and timestamp (Default: off)", OUTPUT_NO_AUTHOR),
 		OPT_BIT('e', "show-email", &output_option, "Show author email instead of name (Default: off)", OUTPUT_SHOW_EMAIL),
 		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_IGNORE_WHITESPACE),
+		OPT_BIT('u', "unique", &output_option, "Show minimum unique SHA-1 (Default: off)", OUTPUT_UNIQ_OBJECT_NAME),
 		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file> instead of calling git-rev-list"),
 		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s contents as the final image"),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies within and across files", PARSE_OPT_OPTARG, blame_copy_callback },
-- 
1.7.4
