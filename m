From: drafnel@gmail.com
Subject: [PATCH 2/3] sha1_file.c: split has_loose_object() into local and non-local counterparts
Date: Sun,  9 Nov 2008 23:59:57 -0600
Message-ID: <5374142.1226296710939.JavaMail.teamon@b307.teamon.com>
References: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
 <1226296798-31522-1-git-send-email-foo@foo.com>
 <1226296798-31522-2-git-send-email-foo@foo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, nico@cam.org, ae@op5.se,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Mon Nov 10 07:00:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzPpN-0001FU-KA
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 07:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYKJF72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 00:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYKJF71
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 00:59:27 -0500
Received: from www.teamon.com ([216.34.91.250]:6691 "EHLO b307.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753350AbYKJF70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 00:59:26 -0500
Received: from b307.teamon.com (localhost [127.0.0.1])
	by b307.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mAA5wUo28432;
	Mon, 10 Nov 2008 05:58:30 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <1226296798-31522-2-git-send-email-foo@foo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100493>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 cache.h     |    1 +
 sha1_file.c |   19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 37ab457..1ec90f1 100644
--- a/cache.h
+++ b/cache.h
@@ -578,6 +578,7 @@ extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1, const char **ignore);
 extern int has_sha1_file(const unsigned char *sha1);
+extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
 extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index f2b25bd..4912205 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -423,23 +423,30 @@ void prepare_alt_odb(void)
 	read_info_alternates(get_object_directory(), 0);
 }
 
-static int has_loose_object(const unsigned char *sha1)
+static int has_loose_object_local(const unsigned char *sha1)
 {
 	char *name = sha1_file_name(sha1);
-	struct alternate_object_database *alt;
+	return !access(name, F_OK);
+}
 
-	if (!access(name, F_OK))
-		return 1;
+int has_loose_object_nonlocal(const unsigned char *sha1)
+{
+	struct alternate_object_database *alt;
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		name = alt->name;
-		fill_sha1_path(name, sha1);
+		fill_sha1_path(alt->name, sha1);
 		if (!access(alt->base, F_OK))
 			return 1;
 	}
 	return 0;
 }
 
+static int has_loose_object(const unsigned char *sha1)
+{
+	return has_loose_object_local(sha1) ||
+	       has_loose_object_nonlocal(sha1);
+}
+
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
-- 
1.6.0.2.588.g3102
