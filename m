From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/3] prepare_packed_git(): refactor garbage reporting in pack directory
Date: Tue,  3 Nov 2015 21:05:06 -0600
Message-ID: <1446606308-1668-1-git-send-email-dougk.ff7@gmail.com>
References: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 04:05:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtoO3-0001XI-RR
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 04:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbbKDDFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 22:05:18 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36195 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbKDDFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 22:05:16 -0500
Received: by igdg1 with SMTP id g1so95588387igd.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71gSMym30+mkjoQNNsybR8YKVLaiMlEAoGGB+F0zTSs=;
        b=BKSczrWhMyZ39YWpKmRA6J25Dy/JJ3L1rvlrW8HNoj0Q8nQo3LGTuZGXvU/O0w1eG/
         5gKChr/KeWgz/zD5eOZPaeRi4zRr4EcZ4737oNW4AgRuaLlm7mn7ki3vIP0hL7xX22/p
         2L71xjh8nu3NT83p05H5KpHuw8xABRaYr/bqCcIvF07BDbYkeiUX2lIqltd+vh21SQY1
         yXISVbBzUM7WAcUDxPJ1mJFoB0QoR28vSqTzJCfqBcfnWoc6auprna7Da2Xrq8k6ZxuO
         Ir0kHJNL/5wVlchSPUuQjfXSLSTWgyiSEaIasrfVZblfAqG2gUXcgqIWatK0j6GiQOSt
         Qygg==
X-Received: by 10.50.72.51 with SMTP id a19mr578374igv.21.1446606315347;
        Tue, 03 Nov 2015 19:05:15 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by smtp.gmail.com with ESMTPSA id c23sm292311iod.0.2015.11.03.19.05.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Nov 2015 19:05:14 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280844>

From: Junio C Hamano <gitster@pobox.com>

The hook to report "garbage" files in $GIT_OBJECT_DIRECTORY/pack/
could be generic but is too specific to count-object's needs.

Move the part to produce human-readable messages to count-objects,
and refine the interface to callback with the "bits" with values
defined in the cache.h header file, so that other callers (e.g.
prune) can later use the same mechanism to enumerate different
kinds of garbage files and do something intelligent about them,
other than reporting in textual messages.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 builtin/count-objects.c | 26 ++++++++++++++++++++++++--
 cache.h                 |  7 +++++--
 path.c                  |  2 +-
 sha1_file.c             | 23 ++++++-----------------
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ad0c799..ba92919 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -15,9 +15,31 @@ static int verbose;
 static unsigned long loose, packed, packed_loose;
 static off_t loose_size;
 
-static void real_report_garbage(const char *desc, const char *path)
+static const char *bits_to_msg(unsigned seen_bits)
+{
+	switch (seen_bits) {
+	case 0:
+		return "no corresponding .idx or .pack";
+	case PACKDIR_FILE_GARBAGE:
+		return "garbage found";
+	case PACKDIR_FILE_PACK:
+		return "no corresponding .idx";
+	case PACKDIR_FILE_IDX:
+		return "no corresponding .pack";
+	case PACKDIR_FILE_PACK|PACKDIR_FILE_IDX:
+	default:
+		return NULL;
+	}
+}
+
+static void real_report_garbage(unsigned seen_bits, const char *path)
 {
 	struct stat st;
+	const char *desc = bits_to_msg(seen_bits);
+
+	if (!desc)
+		return;
+
 	if (!stat(path, &st))
 		size_garbage += st.st_size;
 	warning("%s: %s", desc, path);
@@ -27,7 +49,7 @@ static void real_report_garbage(const char *desc, const char *path)
 static void loose_garbage(const char *path)
 {
 	if (verbose)
-		report_garbage("garbage found", path);
+		report_garbage(PACKDIR_FILE_GARBAGE, path);
 }
 
 static int count_loose(const unsigned char *sha1, const char *path, void *data)
diff --git a/cache.h b/cache.h
index 3ba0b8f..736abc0 100644
--- a/cache.h
+++ b/cache.h
@@ -1289,8 +1289,11 @@ struct pack_entry {
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
-/* A hook for count-objects to report invalid files in pack directory */
-extern void (*report_garbage)(const char *desc, const char *path);
+/* A hook to report invalid files in pack directory */
+#define PACKDIR_FILE_PACK 1
+#define PACKDIR_FILE_IDX 2
+#define PACKDIR_FILE_GARBAGE 4
+extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
diff --git a/path.c b/path.c
index c740c4f..f28ace2 100644
--- a/path.c
+++ b/path.c
@@ -363,7 +363,7 @@ void report_linked_checkout_garbage(void)
 		strbuf_setlen(&sb, len);
 		strbuf_addstr(&sb, path);
 		if (file_exists(sb.buf))
-			report_garbage("unused in linked checkout", sb.buf);
+			report_garbage(PACKDIR_FILE_GARBAGE, sb.buf);
 	}
 	strbuf_release(&sb);
 }
diff --git a/sha1_file.c b/sha1_file.c
index c5b31de..3d56746 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1217,27 +1217,16 @@ void install_packed_git(struct packed_git *pack)
 	packed_git = pack;
 }
 
-void (*report_garbage)(const char *desc, const char *path);
+void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
 			  int seen_bits, int first, int last)
 {
-	const char *msg;
-	switch (seen_bits) {
-	case 0:
-		msg = "no corresponding .idx or .pack";
-		break;
-	case 1:
-		msg = "no corresponding .idx";
-		break;
-	case 2:
-		msg = "no corresponding .pack";
-		break;
-	default:
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
 		return;
-	}
+
 	for (; first < last; first++)
-		report_garbage(msg, list->items[first].string);
+		report_garbage(seen_bits, list->items[first].string);
 }
 
 static void report_pack_garbage(struct string_list *list)
@@ -1260,7 +1249,7 @@ static void report_pack_garbage(struct string_list *list)
 		if (baselen == -1) {
 			const char *dot = strrchr(path, '.');
 			if (!dot) {
-				report_garbage("garbage found", path);
+				report_garbage(PACKDIR_FILE_GARBAGE, path);
 				continue;
 			}
 			baselen = dot - path + 1;
@@ -1332,7 +1321,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		    ends_with(de->d_name, ".keep"))
 			string_list_append(&garbage, path.buf);
 		else
-			report_garbage("garbage found", path.buf);
+			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
 	}
 	closedir(dir);
 	report_pack_garbage(&garbage);
-- 
2.5.1
