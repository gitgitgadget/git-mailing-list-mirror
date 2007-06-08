From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 06/10] Sparse: fix "'add_head' not declared" warning
Date: Fri, 08 Jun 2007 23:16:31 +0100
Message-ID: <4669D53F.5020206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 05:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwrnX-0003Au-4Z
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 05:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbXFIDj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 23:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbXFIDjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 23:39:25 -0400
Received: from anchor-fallback-94.mail.demon.net ([194.217.242.94]:51598 "EHLO
	anchor-fallback-94.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752771AbXFIDjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 23:39:25 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1542 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-94.mail.demon.net
	with ESMTP id S2739335AbXFHWcf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 23:32:35 +0100
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmy3-0005oD-1s; Fri, 08 Jun 2007 22:30:04 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49555>


This function was defined in builtin-diff.c and also used in
builtin-log.c. Since it has demonstrated its utility, move the
function definition to revision.c, which is a more logical place
for it, and add a declaration to revision.h.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-diff.c |   12 ------------
 builtin-log.c  |    3 ---
 revision.c     |   12 ++++++++++++
 revision.h     |    1 +
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 7f367b6..e00a212 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -176,18 +176,6 @@ static int builtin_diff_combined(struct rev_info *revs,
 	return 0;
 }
 
-void add_head(struct rev_info *revs)
-{
-	unsigned char sha1[20];
-	struct object *obj;
-	if (get_sha1("HEAD", sha1))
-		return;
-	obj = parse_object(sha1);
-	if (!obj)
-		return;
-	add_pending_object(revs, obj, "HEAD");
-}
-
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
diff --git a/builtin-log.c b/builtin-log.c
index 3744712..d40a0fc 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -17,9 +17,6 @@
 
 static int default_show_root = 1;
 
-/* this is in builtin-diff.c */
-void add_head(struct rev_info *revs);
-
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
 	int plen = strlen(prefix);
diff --git a/revision.c b/revision.c
index 0125d41..1bfe80c 100644
--- a/revision.c
+++ b/revision.c
@@ -129,6 +129,18 @@ void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, con
 				(struct commit *)obj, name);
 }
 
+void add_head(struct rev_info *revs)
+{
+	unsigned char sha1[20];
+	struct object *obj;
+	if (get_sha1("HEAD", sha1))
+		return;
+	obj = parse_object(sha1);
+	if (!obj)
+		return;
+	add_pending_object(revs, obj, "HEAD");
+}
+
 static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
 {
 	struct object *object;
diff --git a/revision.h b/revision.h
index 2845167..2fa6286 100644
--- a/revision.h
+++ b/revision.h
@@ -132,5 +132,6 @@ extern void add_object(struct object *obj,
 
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
 extern void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode);
+extern void add_head(struct rev_info *revs);
 
 #endif
-- 
1.5.2
