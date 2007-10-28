From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 06/10] add ref_abbrev_matches_full_with_rev_parse_rules() comparing abbrev with full ref name
Date: Sun, 28 Oct 2007 18:46:17 +0100
Message-ID: <11935935821136-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de>
 <11935935822846-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCI8-0000ou-DG
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbXJ1RuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbXJ1RuG
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:50:06 -0400
Received: from mailer.zib.de ([130.73.108.11]:63844 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkM66016198
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsa019730;
	Sun, 28 Oct 2007 18:46:22 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935822846-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62581>

ref_abbrev_matches_full_with_rev_parse_rules(abbrev_name, full_name)
expands abbrev_name according to the rules documented in
git-rev-parse and compares the expanded name with full_name. It
reports a match by returning 0.

This function makes the rules for resolving refs to sha1s available
for string comparison. Before this change, the rules were buried in
get_sha1*() and dwim_ref().

The function name is very long to make the rule set used
explicit. We have a different set of rules for matching refspecs.
It would be a good thing to unify all different rule sets. But
this commit doesn't address this challenge. It only makes the
git-rev-parse rules available for string comparison.

ref_abbrev_matches_full_with_rev_parse_rules() will be used for
matching refspecs in git-send-pack.

Thanks to Daniel Barkalow <barkalow@iabervon.org> for pointing
out that ref_matches_abbrev in remote.c solves a similar problem
and care should be take to avoid confusion.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h     |    1 +
 sha1_name.c |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 27485d3..bb10ade 100644
--- a/cache.h
+++ b/cache.h
@@ -405,6 +405,7 @@ extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
+extern int ref_abbrev_matches_full_with_rev_parse_rules(const char *abbrev_name, const char *full_name);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..944e318 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -249,6 +249,20 @@ static const char *ref_fmt[] = {
 	NULL
 };
 
+int ref_abbrev_matches_full_with_rev_parse_rules(const char *abbrev_name, const char *full_name)
+{
+	const char **p;
+	const int abbrev_name_len = strlen(abbrev_name);
+
+	for (p = ref_fmt; *p; p++) {
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
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
1.5.3.4.439.ge8b49
