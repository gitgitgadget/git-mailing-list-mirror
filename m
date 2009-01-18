From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] sha1_file: add function to insert alternate object db
Date: Sun, 18 Jan 2009 16:55:30 +0100
Message-ID: <1232294130-11409-1-git-send-email-hjemli@gmail.com>
References: <alpine.DEB.1.00.0901181629590.3586@pacific.mpi-cbg.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:57:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOa1G-00041a-In
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658AbZARPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933622AbZARPzj
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:55:39 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:50635 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933517AbZARPzi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:55:38 -0500
Received: from localhost.localdomain (ti0025a380-2706.bb.online.no [83.108.109.152])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id n0IFtUIZ004347;
	Sun, 18 Jan 2009 16:55:30 +0100 (MET)
X-Mailer: git-send-email 1.6.1.150.g5e733b
In-Reply-To: <alpine.DEB.1.00.0901181629590.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106232>

This function will be used when implementing traversal into submodules.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On Sun, Jan 18, 2009 at 16:32, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> On Sun, 18 Jan 2009, Lars Hjemli wrote:
>> +int add_alt_odb(const char *path)
>> +{
>> +     return link_alt_odb_entry(path, strlen(path), NULL, 0);
>
> This function can return the error message "object directory %s does not
> exist; check .git/objects/info/alternates."  Maybe you want to change
> that, even if the user you are introducing might not hit that code path.

Something like this, maybe?


 cache.h     |    1 +
 sha1_file.c |   17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 8e1af26..0dbe2a6 100644
--- a/cache.h
+++ b/cache.h
@@ -724,6 +724,7 @@ extern struct alternate_object_database {
 	char base[FLEX_ARRAY]; /* more */
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
+extern int add_alt_odb(const char *path, int quiet);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern void foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index f08493f..4b7e691 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -252,7 +252,8 @@ static void read_info_alternates(const char * alternates, int depth);
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
+static int link_alt_odb_entry(const char * entry, int len,
+			      const char * relative_base, int depth, int quiet)
 {
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
@@ -285,9 +286,10 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(ent->base)) {
-		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
-		      ent->base);
+		if (!quiet)
+			error("object directory %s does not exist; "
+			      "check .git/objects/info/alternates.",
+			      ent->base);
 		free(ent);
 		return -1;
 	}
@@ -347,7 +349,7 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 						relative_base, last);
 			} else {
 				link_alt_odb_entry(last, cp - last,
-						relative_base, depth);
+						relative_base, depth, 0);
 			}
 		}
 		while (cp < ep && *cp == sep)
@@ -356,6 +358,11 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 	}
 }
 
+int add_alt_odb(const char *path, int quiet)
+{
+	return link_alt_odb_entry(path, strlen(path), NULL, 0, quiet);
+}
+
 static void read_info_alternates(const char * relative_base, int depth)
 {
 	char *map;
-- 
1.6.1.150.g5e733b
