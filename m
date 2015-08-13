From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in pack directory
Date: Thu, 13 Aug 2015 13:02:52 -0500
Message-ID: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
Cc: peff@peff.net, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 20:03:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPwr6-0001fI-0I
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 20:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbbHMSDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 14:03:49 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35402 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbbHMSDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 14:03:48 -0400
Received: by iodt126 with SMTP id t126so60653789iod.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPJXFOurpNAy43cexpG9296GBaDvzn4/1BILSpi3Hr8=;
        b=mIO+v4bR33SFW4+pT//grvLv17+VDHzpSvYwTXTyK2PNRCIeQAqAbitaWHeaauWmEm
         3olly5jQSV0+rkIZC4co0A3RCAX/dat5Gw9JAxdXzvsIlgM6tZ9kmhf6RhTNu0XmRoNh
         2f8ACXt9YughDGlX/CCTK124v+dyFZeWPo9d5wlWYdWFz16pYBuHCcjW8oGPcm59OPn/
         U2TMJ7WSBugS6nNyvzk9T/58FBnf+Og4YfLEgLQzGLk8dRkTnVwo2peoPHmd8AcrFZ2D
         4n72s+uFs6bfiTShYz8JqbbJgBODgHJ4nQ45ByGIwtSXWn6MxS0e2WmXOdP9O9pkFNz8
         jcdQ==
X-Received: by 10.107.135.140 with SMTP id r12mr39991301ioi.153.1439489027342;
        Thu, 13 Aug 2015 11:03:47 -0700 (PDT)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by smtp.gmail.com with ESMTPSA id b78sm2006376ioe.2.2015.08.13.11.03.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Aug 2015 11:03:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275867>

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
---
 builtin/count-objects.c | 26 ++++++++++++++++++++++++--
 cache.h                 |  7 +++++--
 path.c                  |  2 +-
 sha1_file.c             | 23 ++++++-----------------
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index ad0c799..4c3198e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -15,9 +15,31 @@ static int verbose;
 static unsigned long loose, packed, packed_loose;
 static off_t loose_size;
 
-static void real_report_garbage(const char *desc, const char *path)
+const char *bits_to_msg(unsigned seen_bits)
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
index 6bb7119..2d4dedc 100644
--- a/cache.h
+++ b/cache.h
@@ -1212,8 +1212,11 @@ struct pack_entry {
 
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
index 10f4cbf..75ec236 100644
--- a/path.c
+++ b/path.c
@@ -143,7 +143,7 @@ void report_linked_checkout_garbage(void)
 		strbuf_setlen(&sb, len);
 		strbuf_addstr(&sb, path);
 		if (file_exists(sb.buf))
-			report_garbage("unused in linked checkout", sb.buf);
+			report_garbage(PACKDIR_FILE_GARBAGE, sb.buf);
 	}
 	strbuf_release(&sb);
 }
diff --git a/sha1_file.c b/sha1_file.c
index 1cee438..0c0b652 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1183,27 +1183,16 @@ void install_packed_git(struct packed_git *pack)
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
@@ -1226,7 +1215,7 @@ static void report_pack_garbage(struct string_list *list)
 		if (baselen == -1) {
 			const char *dot = strrchr(path, '.');
 			if (!dot) {
-				report_garbage("garbage found", path);
+				report_garbage(PACKDIR_FILE_GARBAGE, path);
 				continue;
 			}
 			baselen = dot - path + 1;
@@ -1298,7 +1287,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		    ends_with(de->d_name, ".keep"))
 			string_list_append(&garbage, path.buf);
 		else
-			report_garbage("garbage found", path.buf);
+			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
 	}
 	closedir(dir);
 	report_pack_garbage(&garbage);
-- 
2.0.5
