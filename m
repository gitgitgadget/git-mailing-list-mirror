From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] dwim_ref(): Separate name-to-ref DWIM code out.
Date: Fri, 19 Jan 2007 15:51:05 -0800
Message-ID: <7vtzymd192.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 20 00:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H83Vu-00040z-Ov
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 00:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbXASXvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 18:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXASXvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 18:51:09 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49955 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872AbXASXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 18:51:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119235106.PDLA19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 18:51:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DBrP1W00Y1kojtg0000000; Fri, 19 Jan 2007 18:51:24 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37221>

I'll be using this in another function to figure out what to
pass to resolve_ref().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 cache.h     |    2 ++
 sha1_name.c |   38 ++++++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index e6e19bd..a218db3 100644
--- a/cache.h
+++ b/cache.h
@@ -299,6 +299,8 @@ extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
+extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
+
 extern int create_symref(const char *ref, const char *refs_heads_master);
 extern int validate_headref(const char *ref);
 
diff --git a/sha1_name.c b/sha1_name.c
index 6d7cd78..ae31851 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -235,7 +235,7 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	static const char *fmt[] = {
 		"%.*s",
@@ -246,13 +246,32 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		"refs/remotes/%.*s/HEAD",
 		NULL
 	};
+	const char **p, *r;
+	int refs_found = 0;
+
+	*ref = NULL;
+	for (p = fmt; *p; p++) {
+		unsigned char sha1_from_ref[20];
+		unsigned char *this_result;
+
+		this_result = refs_found ? sha1_from_ref : sha1;
+		r = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
+		if (r) {
+			if (!refs_found++)
+				*ref = xstrdup(r);
+			if (!warn_ambiguous_refs)
+				break;
+		}
+	}
+	return refs_found;
+}
+
+static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+{
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
-	const char **p, *ref;
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
-	unsigned char *this_result;
-	unsigned char sha1_from_ref[20];
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
@@ -273,16 +292,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (ambiguous_path(str, len))
 		return -1;
 
-	for (p = fmt; *p; p++) {
-		this_result = refs_found ? sha1_from_ref : sha1;
-		ref = resolve_ref(mkpath(*p, len, str), this_result, 1, NULL);
-		if (ref) {
-			if (!refs_found++)
-				real_ref = xstrdup(ref);
-			if (!warn_ambiguous_refs)
-				break;
-		}
-	}
+	refs_found = dwim_ref(str, len, sha1, &real_ref);
 
 	if (!refs_found)
 		return -1;
-- 
1.5.0.rc1.gcb48c
