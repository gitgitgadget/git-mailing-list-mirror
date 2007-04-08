From: Dana How <danahow@gmail.com>
Subject: [PATCH 2/8] git-repack --max-pack-size: minor code restructuring
Date: Sun, 08 Apr 2007 16:20:29 -0700
Message-ID: <461978BD.4080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaggV-0006zW-JN
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXDHXUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbXDHXUd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:20:33 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:63717 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXDHXUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:20:32 -0400
Received: by py-out-1112.google.com with SMTP id a29so896710pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:20:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=aBKbCag7tnumYhWOGObLxzHEtkS7nsZz9hCc3PgVUJ5q1YbxWo4DjeWSmDe2VJbjkcFVphz68e71DNsbvS3XIa3i3nULEoF+4H+i9+eqJCP8u7j8MBXF0XzmQVNxsbGswcaIFn7Bm4djZFYTDG2VL6Kb+i2dbg8CPUzywNd+5Eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=COA6iQMHtEoVI4cYoZqG0Npbar4dqWF7SO1N57ne2erggYq6KW9VAYLXtGhLswxR5obgUSoF0J70aYQwrNFzAvtDUiYNy2ziNMvtDtmbuSrLIiqyx7kEs+9k04MGueDAccMmKv+owCVeHJucY035H3HZ8gTUEzG0EnIfLPw17LQ=
Received: by 10.65.151.6 with SMTP id d6mr10530028qbo.1176074431799;
        Sun, 08 Apr 2007 16:20:31 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id e1sm8757395nzd.2007.04.08.16.20.30;
        Sun, 08 Apr 2007 16:20:31 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44011>


Move the call to write_index_file() from cmd_pack_objects()
to write_pack_file() (since only the latter will know how
many times to call write_index_file()),  and move or add
forward declarations for later changes.

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 builtin-pack-objects.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 64318b3..8415549 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -518,6 +518,16 @@ static off_t write_one(struct sha1file *f,
 	return offset + write_object(f, e);
 }
 
+typedef int (*entry_sort_t)(const struct object_entry *, const struct object_entry *);
+
+static entry_sort_t current_sort;
+
+/* forward declarations for write_pack_file */
+/* (probably should move sorting stuff up here) */
+static int sort_comparator(const void *_a, const void *_b);
+static int sha1_sort(const struct object_entry *a, const struct object_entry *b);
+static void write_index_file(void);
+
 static void write_pack_file(void)
 {
 	uint32_t i;
@@ -562,6 +572,10 @@ static void write_pack_file(void)
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
+	if (!pack_to_stdout) {
+		write_index_file();
+		puts(sha1_to_hex(object_list_sha1));
+	}
 }
 
 static void write_index_file(void)
@@ -1106,10 +1120,6 @@ static void get_object_details(void)
 	}
 }
 
-typedef int (*entry_sort_t)(const struct object_entry *, const struct object_entry *);
-
-static entry_sort_t current_sort;
-
 static int sort_comparator(const void *_a, const void *_b)
 {
 	struct object_entry *a = *(struct object_entry **)_a;
@@ -1698,10 +1708,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			progress_update = 0;
 		}
 		write_pack_file();
-		if (!pack_to_stdout) {
-			write_index_file();
-			puts(sha1_to_hex(object_list_sha1));
-		}
 	}
 	if (progress)
 		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
-- 
1.5.1.89.g8abf0
