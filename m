From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 4/6] add ref_abbrev_matches_full_with_rules()
Date: Sun, 11 Nov 2007 15:01:46 +0100
Message-ID: <11947897083265-git-send-email-prohaska@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de>
 <11947897083381-git-send-email-prohaska@zib.de>
 <11947897081278-git-send-email-prohaska@zib.de>
 <11947897083159-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRe-0003eX-7x
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXKKOEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXKKOEv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:04:51 -0500
Received: from mailer.zib.de ([130.73.108.11]:57957 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbXKKOEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:04:45 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABE1nH8021599
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 15:04:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABE1mlY027967;
	Sun, 11 Nov 2007 15:01:49 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11947897083159-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64455>

We use at least two rulesets for matching abbreviated refnames with
full refnames (starting with 'refs/').  git-rev-parse and git-fetch
use slightly different rules.

This commit introduces a new function
ref_abbrev_matches_full_with_rules(
    const char *abbrev_name, const char *full_name, const char **rules).
abbrev_name is expanded using the rules and matched against full_name.
If a match is found the function returns true.  rules is a NULL-terminate
list of format patterns with "%.*s", for example

    const char *ref_rev_parse_rules[] = {
               "%.*s",
               "refs/%.*s",
               "refs/tags/%.*s",
               "refs/heads/%.*s",
               "refs/remotes/%.*s",
               "refs/remotes/%.*s/HEAD",
               NULL
    };

Asterisks are included in the format strings because this is the form
required in sha1_name.c.  Sharing the list with the functions there is
a good idea to avoid duplicating the rules.  Hopefully this
facilitates unified matching rules in the future.

This commit makes the rules used by rev-parse for resolving refs to
sha1s available for string comparison.  Before this change, the rules
were buried in get_sha1*() and dwim_ref().

A follow-up commit will refactor the rules used by fetch.

ref_abbrev_matches_full_with_rules() will be used for matching
refspecs in git-send-pack.

Thanks to Daniel Barkalow <barkalow@iabervon.org> for pointing
out that ref_matches_abbrev in remote.c solves a similar problem
and care should be taken to avoid confusion.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h     |    3 +++
 refs.c      |   24 ++++++++++++++++++++++++
 sha1_name.c |   14 ++------------
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index f0a25c7..d36b91d 100644
--- a/cache.h
+++ b/cache.h
@@ -409,6 +409,9 @@ extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
+extern int ref_abbrev_matches_full_with_rules(const char *abbrev_name, const char *full_name, const char **rules);
+extern const char *ref_rev_parse_rules[];
+
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
 
diff --git a/refs.c b/refs.c
index aff02cd..4bb16e5 100644
--- a/refs.c
+++ b/refs.c
@@ -655,6 +655,30 @@ int check_ref_format(const char *ref)
 	}
 }
 
+const char *ref_rev_parse_rules[] = {
+	"%.*s",
+	"refs/%.*s",
+	"refs/tags/%.*s",
+	"refs/heads/%.*s",
+	"refs/remotes/%.*s",
+	"refs/remotes/%.*s/HEAD",
+	NULL
+};
+
+int ref_abbrev_matches_full_with_rules(const char *abbrev_name, const char *full_name, const char **rules)
+{
+	const char **p;
+	const int abbrev_name_len = strlen(abbrev_name);
+
+	for (p = rules; *p; p++) {
+		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..d364244 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -239,23 +239,13 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static const char *ref_fmt[] = {
-	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
-};
-
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
 
 	*ref = NULL;
-	for (p = ref_fmt; *p; p++) {
+	for (p = ref_rev_parse_rules; *p; p++) {
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
 
@@ -277,7 +267,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	int logs_found = 0;
 
 	*log = NULL;
-	for (p = ref_fmt; *p; p++) {
+	for (p = ref_rev_parse_rules; *p; p++) {
 		struct stat st;
 		unsigned char hash[20];
 		char path[PATH_MAX];
-- 
1.5.3.5.578.g886d
