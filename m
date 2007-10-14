From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/6] add get_sha1_with_real_ref() returning full name of ref on demand
Date: Sun, 14 Oct 2007 10:54:41 +0200
Message-ID: <11923520852991-git-send-email-prohaska@zib.de>
References: <11923520851713-git-send-email-prohaska@zib.de>
 <1192352085653-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 10:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzFU-0006lW-Lo
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbXJNIyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbXJNIyt
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:54:49 -0400
Received: from mailer.zib.de ([130.73.108.11]:58224 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163AbXJNIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:54:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E8sjF8025866
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 10:54:45 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E8sjYt021275;
	Sun, 14 Oct 2007 10:54:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1192352085653-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60809>

Deep inside get_sha1() the name of the requested ref is matched
according to the rules documented in git-rev-parse. This patch
introduces a function that returns the full name of the matched
ref to the outside.

For example 'master' is typically returned as 'refs/heads/master'.

The new function can be used by "git rev-parse" to print the full
name of the matched ref and can be used by "git send-pack" to expand
a local ref to its full name.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h     |    1 +
 sha1_name.c |   38 +++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index e0abcd6..f98d57a 100644
--- a/cache.h
+++ b/cache.h
@@ -401,6 +401,7 @@ static inline unsigned int hexval(unsigned char c)
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
+extern int get_sha1_with_real_ref(const char *str, unsigned char *sha1, char **real_ref);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..b820909 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -306,7 +306,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+static int get_sha1_basic(const char *str, int len, unsigned char *sha1, char **real_ref_out)
 {
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
 	char *real_ref = NULL;
@@ -378,17 +378,21 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		}
 	}
 
-	free(real_ref);
+	if (real_ref_out) {
+		*real_ref_out = real_ref;
+	} else {
+		free(real_ref);
+	}
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1);
+static int get_sha1_1(const char *name, int len, unsigned char *sha1, char **real_ref);
 
 static int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1);
+	int ret = get_sha1_1(name, len, sha1, /*real_ref=*/ 0);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -418,7 +422,7 @@ static int get_nth_ancestor(const char *name, int len,
 			    unsigned char *result, int generation)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1);
+	int ret = get_sha1_1(name, len, sha1, /*real_ref=*/ 0);
 	if (ret)
 		return ret;
 
@@ -471,7 +475,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	else
 		return -1;
 
-	if (get_sha1_1(name, sp - name - 2, outer))
+	if (get_sha1_1(name, sp - name - 2, outer, /*real_ref=*/ 0))
 		return -1;
 
 	o = parse_object(outer);
@@ -531,7 +535,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+static int get_sha1_1(const char *name, int len, unsigned char *sha1, char **real_ref)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -569,7 +573,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 	if (!ret)
 		return 0;
 
-	ret = get_sha1_basic(name, len, sha1);
+	ret = get_sha1_basic(name, len, sha1, real_ref);
 	if (!ret)
 		return 0;
 
@@ -651,14 +655,14 @@ int get_sha1(const char *name, unsigned char *sha1)
 	return get_sha1_with_mode(name, sha1, &unused);
 }
 
-int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
+int get_sha1_with_mode_real_ref(const char *name, unsigned char *sha1, unsigned *mode, char** real_ref)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
 
 	*mode = S_IFINVALID;
-	ret = get_sha1_1(name, namelen, sha1);
+	ret = get_sha1_1(name, namelen, sha1, real_ref);
 	if (!ret)
 		return ret;
 	/* sha1:path --> object name of path in ent sha1
@@ -709,9 +713,21 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
+		if (!get_sha1_1(name, cp-name, tree_sha1, real_ref))
 			return get_tree_entry(tree_sha1, cp+1, sha1,
 					      mode);
 	}
 	return ret;
 }
+
+int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
+{
+	return get_sha1_with_mode_real_ref(name, sha1, mode, 0);
+}
+
+int get_sha1_with_real_ref(const char *name, unsigned char *sha1, char **real_ref)
+{
+	unsigned unused;
+	return get_sha1_with_mode_real_ref(name, sha1, &unused, real_ref);
+}
+
-- 
1.5.3.4.224.gc6b84
