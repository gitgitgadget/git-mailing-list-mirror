From: Johan Herland <johan@herland.net>
Subject: [PATCH 6/7] refname_match(): Caller must declare if we're matching local or remote refs
Date: Sun,  5 May 2013 01:55:48 +0200
Message-ID: <1367711749-8812-7-git-send-email-johan@herland.net>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJY-0005xP-Lg
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab3EDX4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:56:14 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:50848 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3EDX4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:56:07 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so1164326bkc.35
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=crxHs/f696bED9VLpAi0R5969M3jCHAyabJzTX4I4Ro=;
        b=Q0IijDKHVP975bo1ak5loMV51ovdpEs5zpqaIPdD1pNfF1hLUzb5pARPwjFxJkxQyj
         Yh3hVtxCIGy7iNewGxtsyaTFF8gAtjey5DNljDkdLI0gZVMLpqutazZdL7CpeywqWzCc
         t+FudyvcreIn643BWEeE+le+Gbuq7PwZ8Mrzx3Rxvgvq9G36VTzHCmak+ImQjwaRvA0E
         WpA9igNjYDdojZv3o3B7Ra/tLK7J2Ty7LyzNzH2wnBvS0XxqAwEPQROakPyKNfiSLjLC
         Qg2KzKlppcaTFSyjEvZc2xewpb6fjyE2G1jeJeVk1dadfND1OkkUSE94Y9vi/oqT/TH0
         5N+g==
X-Received: by 10.204.165.15 with SMTP id g15mr5903733bky.140.1367711765619;
        Sat, 04 May 2013 16:56:05 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:56:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223389>

refname_match() is used to check whether a given shorthand name matches a
given full refname, but that full refname does not always belong in the
local repo, rather it is sometimes taken from list of refs sent over from
a remote repo.

In preparation for adding alternative ways of expanding refspecs, we
need to take into account that such alternative ways may depend on
local repo configuration, and it would therefore be wrong to use them
when expanding refnames for a remote repo.

To resolve this, we split the ref_expand_rules list into a local and a
remote variant, and teach the callers of refname_match() to pass the
correct list as third argument to refname_match().

For now, the remote and local lists are identical, but this will change
in a subsequent patch.

The other functions that use ref_expand_rules, all use it in a local
context, so they hardcode the use of the local variant.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c   | 24 +++++++++++++++++-------
 refs.h   |  3 ++-
 remote.c | 15 +++++++++------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index a866489..98997c4 100644
--- a/refs.c
+++ b/refs.c
@@ -1758,7 +1758,17 @@ static char *ref_shorten_txtly(const struct ref_expand_rule *rule,
 	return xstrndup(refname + pre_len, match_len);
 }
 
-const struct ref_expand_rule ref_expand_rules[] = {
+const struct ref_expand_rule ref_expand_rules_local[] = {
+	{ ref_expand_txtly, NULL, "%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/tags/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/heads/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s" },
+	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s/HEAD" },
+	{ NULL, NULL, NULL }
+};
+
+const struct ref_expand_rule ref_expand_rules_remote[] = {
 	{ ref_expand_txtly, NULL, "%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/tags/%.*s" },
@@ -1848,7 +1858,7 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 	int refs_found = 0;
 
 	*ref = NULL;
-	for (p = ref_expand_rules; p->expand; p++) {
+	for (p = ref_expand_rules_local; p->expand; p++) {
 		char fullref[PATH_MAX];
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
@@ -1879,7 +1889,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	int logs_found = 0;
 
 	*log = NULL;
-	for (p = ref_expand_rules; p->expand; p++) {
+	for (p = ref_expand_rules_local; p->expand; p++) {
 		struct stat st;
 		unsigned char hash[20];
 		char path[PATH_MAX];
@@ -2987,11 +2997,11 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	int i;
 	char *short_name;
 
-	for (i = ARRAY_SIZE(ref_expand_rules) - 1; i >= 0 ; --i) {
+	for (i = ARRAY_SIZE(ref_expand_rules_local) - 1; i >= 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
 		int short_name_len;
-		const struct ref_expand_rule *p = ref_expand_rules + i;
+		const struct ref_expand_rule *p = ref_expand_rules_local + i;
 
 		if (!p->shorten || !(short_name = p->shorten(p, refname)))
 			continue;
@@ -3002,14 +3012,14 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		 * must fail to resolve to a valid non-ambiguous ref
 		 */
 		if (strict)
-			rules_to_fail = ARRAY_SIZE(ref_expand_rules);
+			rules_to_fail = ARRAY_SIZE(ref_expand_rules_local);
 
 		/*
 		 * check if the short name resolves to a valid ref,
 		 * but use only rules prior to the matched one
 		 */
 		for (j = 0; j < rules_to_fail; j++) {
-			const struct ref_expand_rule *q = ref_expand_rules + j;
+			const struct ref_expand_rule *q = ref_expand_rules_local + j;
 			char resolved[PATH_MAX];
 
 			/* skip matched rule */
diff --git a/refs.h b/refs.h
index 245af6f..15b5ec2 100644
--- a/refs.h
+++ b/refs.h
@@ -173,7 +173,8 @@ struct ref_expand_rule {
 			 const char *refname);
 	const char *pattern;
 };
-extern const struct ref_expand_rule ref_expand_rules[];
+extern const struct ref_expand_rule ref_expand_rules_local[];
+extern const struct ref_expand_rule ref_expand_rules_remote[];
 extern int refname_match(const char *abbrev_name, const char *full_name,
 			 const struct ref_expand_rule *rules);
 
diff --git a/remote.c b/remote.c
index 5ef34c9..379577c 100644
--- a/remote.c
+++ b/remote.c
@@ -969,7 +969,8 @@ void sort_ref_list(struct ref **l, int (*cmp)(const void *, const void *))
 
 static int count_refspec_match(const char *pattern,
 			       struct ref *refs,
-			       struct ref **matched_ref)
+			       struct ref **matched_ref,
+			       int refs_from_remote)
 {
 	int patlen = strlen(pattern);
 	struct ref *matched_weak = NULL;
@@ -981,7 +982,9 @@ static int count_refspec_match(const char *pattern,
 		char *name = refs->name;
 		int namelen = strlen(name);
 
-		if (!refname_match(pattern, name, ref_expand_rules))
+		if (!refname_match(pattern, name, refs_from_remote ?
+				   ref_expand_rules_remote :
+				   ref_expand_rules_local))
 			continue;
 
 		/* A match is "weak" if it is with refs outside
@@ -1091,7 +1094,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return 0;
 
 	matched_src = matched_dst = NULL;
-	switch (count_refspec_match(rs->src, src, &matched_src)) {
+	switch (count_refspec_match(rs->src, src, &matched_src, 0)) {
 	case 1:
 		copy_src = 1;
 		break;
@@ -1121,7 +1124,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			    matched_src->name);
 	}
 
-	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
+	switch (count_refspec_match(dst_value, dst, &matched_dst, 1)) {
 	case 1:
 		break;
 	case 0:
@@ -1499,7 +1502,7 @@ int branch_merge_matches(struct branch *branch,
 {
 	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	return refname_match(branch->merge[i]->src, refname, ref_expand_rules);
+	return refname_match(branch->merge[i]->src, refname, ref_expand_rules_local);
 }
 
 static int ignore_symref_update(const char *refname)
@@ -1545,7 +1548,7 @@ static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const c
 {
 	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name, ref_expand_rules))
+		if (refname_match(name, ref->name, ref_expand_rules_remote))
 			return ref;
 	}
 	return NULL;
-- 
1.8.1.3.704.g33f7d4f
