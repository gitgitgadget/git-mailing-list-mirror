From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/8] add ref_cmp_full_short() comparing full ref name with a short name
Date: Sat, 27 Oct 2007 18:50:05 +0200
Message-ID: <11935038084130-git-send-email-prohaska@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de>
 <11935038081650-git-send-email-prohaska@zib.de>
 <1193503808519-git-send-email-prohaska@zib.de>
 <11935038083369-git-send-email-prohaska@zib.de>
 <11935038084055-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 18:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlosM-0004eP-AJ
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 18:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbXJ0Qu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 12:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbXJ0Qu0
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 12:50:26 -0400
Received: from mailer.zib.de ([130.73.108.11]:49610 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbXJ0QuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 12:50:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9RGo86L023480
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 18:50:08 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9RGo7oM028374;
	Sat, 27 Oct 2007 18:50:08 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935038084055-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62501>

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
 sha1_name.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 726948b..e1385ac 100644
--- a/cache.h
+++ b/cache.h
@@ -406,6 +406,7 @@ extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
+extern int ref_cmp_full_short(const char *full_name, const char *short_name);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
diff --git a/sha1_name.c b/sha1_name.c
index b820909..2a1e093 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -249,6 +249,20 @@ static const char *ref_fmt[] = {
 	NULL
 };
 
+int ref_cmp_full_short(const char *full_name, const char *short_name)
+{
+	const char **p;
+	const int short_name_len = strlen(short_name);
+
+	for (p = ref_fmt; *p; p++) {
+		if (strcmp(full_name, mkpath(*p, short_name_len, short_name)) == 0) {
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	const char **p, *r;
-- 
1.5.3.4.1261.g626eb
