From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 5/6] add ref_cmp_full_short() comparing full ref name with a short name
Date: Sun, 14 Oct 2007 10:54:44 +0200
Message-ID: <11923520853014-git-send-email-prohaska@zib.de>
References: <11923520851713-git-send-email-prohaska@zib.de>
 <1192352085653-git-send-email-prohaska@zib.de>
 <11923520852991-git-send-email-prohaska@zib.de>
 <11923520853189-git-send-email-prohaska@zib.de>
 <11923520851656-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 10:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzFz-0006qF-Tx
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbXJNIzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbXJNIy7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:54:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:58232 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754259AbXJNIyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:54:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E8skMV025873
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 10:54:46 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E8sjYw021275;
	Sun, 14 Oct 2007 10:54:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11923520851656-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60812>

ref_cmp_full_short(full_name, short_name) expands short_name according
to the rules documented in git-rev-parse and compares the expanded
name with full_name. It reports a match by returning 0.

This function makes the rules for resolving refs to sha1s available
for string comparison. Before this change, the rules were buried in
get_sha1*() and dwim_ref().

ref_cmp_full_short() will be used for matching refspecs in git-send-pack.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h     |    1 +
 sha1_name.c |   13 +++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index f98d57a..59345b5 100644
--- a/cache.h
+++ b/cache.h
@@ -406,6 +406,7 @@ extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
+extern int ref_cmp_full_short(const char *full_name, const char* short_name);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
diff --git a/sha1_name.c b/sha1_name.c
index b820909..ae235be 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -249,6 +249,19 @@ static const char *ref_fmt[] = {
 	NULL
 };
 
+int ref_cmp_full_short(const char* full_name, const char* short_name)
+{
+	const char **p;
+    const int short_name_len = strlen(short_name);
+
+	for (p = ref_fmt; *p; p++) {
+		if (strcmp(full_name, mkpath(*p, short_name_len, short_name)) == 0) {
+            return 0;
+        }
+    }
+    return -1;
+}
+
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	const char **p, *r;
-- 
1.5.3.4.224.gc6b84
