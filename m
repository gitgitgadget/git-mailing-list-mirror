From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/6] refactor fetch's ref matching to use ref_abbrev_matches_full_with_rules()
Date: Sun, 11 Nov 2007 15:01:48 +0100
Message-ID: <11947897092576-git-send-email-prohaska@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de>
 <11947897083381-git-send-email-prohaska@zib.de>
 <11947897081278-git-send-email-prohaska@zib.de>
 <11947897083159-git-send-email-prohaska@zib.de>
 <11947897083265-git-send-email-prohaska@zib.de>
 <1194789709671-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRc-0003eX-Pz
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbXKKOEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752319AbXKKOEr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:04:47 -0500
Received: from mailer.zib.de ([130.73.108.11]:57954 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbXKKOEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:04:45 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABE1nOI021601
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 15:04:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABE1mla027967;
	Sun, 11 Nov 2007 15:01:49 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1194789709671-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64457>

The old rules used by fetch were coded as a series of ifs.  The old
rules are:
1) match full refname if it starts with "refs/" or matches "HEAD"
2) verify that full refname starts with "refs/"
3) match abbreviated name in "refs/" if it starts with "heads/",
    "tags/", or "remotes/".
4) match abbreviated name in "refs/heads/"

This is replaced by the new rules
a) match full refname
b) match abbreviated name prefixed with "refs/"
c) match abbreviated name prefixed with "refs/heads/"

The details of the new rules are different from the old rules.  We no
longer verify that the full refname starts with "refs/".  The new rule
(a) matches any full string.  The old rules (1) and (2) were stricter.
Now, the caller is responsible for using sensible full refnames.  This
should be the case for the current code.  The new rule (b) is less
strict than old rule (3).  The new rule accepts abbreviated names that
start with a non-standard prefix below "refs/".

Despite this modifications the new rules should handle all cases as
expected.  Two tests are added to verify that fetch does not resolve
short tags or HEAD in remotes.

We may even think about loosening the rules a bit more and unify them
with the rev-parse rules.  This would be done by replacing
ref_ref_fetch_rules with ref_ref_parse_rules.  Note, the two new test
would break.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h          |    1 +
 refs.c           |    7 +++++++
 remote.c         |   23 ++---------------------
 t/t5510-fetch.sh |   25 +++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index d36b91d..1313378 100644
--- a/cache.h
+++ b/cache.h
@@ -411,6 +411,7 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
 extern int ref_abbrev_matches_full_with_rules(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
+extern const char *ref_fetch_rules[];
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index 4bb16e5..7db2146 100644
--- a/refs.c
+++ b/refs.c
@@ -665,6 +665,13 @@ const char *ref_rev_parse_rules[] = {
 	NULL
 };
 
+const char *ref_fetch_rules[] = {
+	"%.*s",
+	"refs/%.*s",
+	"refs/heads/%.*s",
+	NULL
+};
+
 int ref_abbrev_matches_full_with_rules(const char *abbrev_name, const char *full_name, const char **rules)
 {
 	const char **p;
diff --git a/remote.c b/remote.c
index 28d8eb7..2dfce70 100644
--- a/remote.c
+++ b/remote.c
@@ -417,25 +417,6 @@ int remote_has_url(struct remote *remote, const char *url)
 	return 0;
 }
 
-/*
- * Returns true if, under the matching rules for fetching, name is the
- * same as the given full name.
- */
-static int ref_matches_abbrev(const char *name, const char *full)
-{
-	if (!prefixcmp(name, "refs/") || !strcmp(name, "HEAD"))
-		return !strcmp(name, full);
-	if (prefixcmp(full, "refs/"))
-		return 0;
-	if (!prefixcmp(name, "heads/") ||
-	    !prefixcmp(name, "tags/") ||
-	    !prefixcmp(name, "remotes/"))
-		return !strcmp(name, full + 5);
-	if (prefixcmp(full + 5, "heads/"))
-		return 0;
-	return !strcmp(full + 11, name);
-}
-
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
 	int find_src = refspec->src == NULL;
@@ -804,7 +785,7 @@ int branch_merge_matches(struct branch *branch,
 {
 	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	return ref_matches_abbrev(branch->merge[i]->src, refname);
+	return ref_abbrev_matches_full_with_rules(branch->merge[i]->src, refname, ref_fetch_rules);
 }
 
 static struct ref *get_expanded_map(struct ref *remote_refs,
@@ -843,7 +824,7 @@ static struct ref *find_ref_by_name_abbrev(struct ref *refs, const char *name)
 {
 	struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (ref_matches_abbrev(name, ref->name))
+		if (ref_abbrev_matches_full_with_rules(name, ref->name, ref_fetch_rules))
 			return ref;
 	}
 	return NULL;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index aad863d..2025742 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -95,6 +95,31 @@ test_expect_success 'fetch following tags' '
 
 '
 
+test_expect_failure 'fetch must not resolve short tag name' '
+
+	cd "$D" &&
+
+	mkdir five &&
+	cd five &&
+	git init &&
+
+	git fetch .. anno:five
+
+'
+
+test_expect_failure 'fetch must not resolve short remote name' '
+
+	cd "$D" &&
+	git-update-ref refs/remotes/six/HEAD HEAD
+
+	mkdir six &&
+	cd six &&
+	git init &&
+
+	git fetch .. six:six
+
+'
+
 test_expect_success 'create bundle 1' '
 	cd "$D" &&
 	echo >file updated again by origin &&
-- 
1.5.3.5.578.g886d
