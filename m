From: Johan Herland <johan@herland.net>
Subject: [PATCH 7/7] refs.c: Add rules for resolving refs using remote refspecs
Date: Sun,  5 May 2013 01:55:49 +0200
Message-ID: <1367711749-8812-8-git-send-email-johan@herland.net>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJM-0005n7-WB
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184Ab3EDX4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:56:10 -0400
Received: from mail-bk0-f53.google.com ([209.85.214.53]:52281 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3EDX4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:56:09 -0400
Received: by mail-bk0-f53.google.com with SMTP id i18so1135991bkv.40
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=vhO5bv2xOGOP787FS+Z+v4xlZfAk/fCB/WJpcrgefgM=;
        b=WOnSP1gmImC/SMnPADpnVvn4vz6jR8ZCGnSTRWmznMBr00UrLFrwYQ2h0UiQ25d2PY
         VSXsbmjKCL+LSERIkIhYnQUQl89f8tLKfW/z+zSyvJlvjMuyC7lTtf/+Zyr69GoHYY9C
         eyAHHPr51o85WA4letBOTfb9qXMzRnATG9UYpK2jgtpc6uPbO6Vt1qnPP0Wj+tVakjFO
         t0ucuYW5HRkycBk5PjetrzfX5MF8OHkuB0uDfkKh6Mnr+CaWKFOi5qoaUZO4hlEpO3fB
         YfN/N5C5+8hlj3lHZFN6MeJNXNJjdxr+yfkDOQVjLIj++NltiKjneHO2nae2MhmKwI3/
         H0xQ==
X-Received: by 10.205.42.194 with SMTP id tz2mr5891532bkb.129.1367711767508;
        Sat, 04 May 2013 16:56:07 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.56.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:56:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223385>

The "$remote/$branch" expression is often used as a shorthand with the
intention of referring to the remote-tracking branch corresponding to
the given $branch in the $remote repo.

Currently, Git resolves this by prepending "refs/remotes/" to the given
"$remote/$branch" expression, resulting in "refs/remotes/$remote/$branch",
which is equivalent to the above intention only when conventional
refspecs are being used (e.g. refs/heads/*:refs/remotes/origin/*).
Correspondingly, a full remote-tracking branch name, can only be
shortened to the "$remote/$branch" form if it textually matches the
"refs/remotes/$remote/$branch" format.

If unconventional refspecs (e.g. refs/heads/*:refs/remotes/origin/heads/*)
are being used, then the current expansion ("refs/remotes/$remote/$branch")
fails to match the remote-tracking branches from the configured remotes.
Ditto for the corresponding shortening.

Instead of doing pure textual expansion (from "$remote/$branch" to
"refs/remotes/$remote/$branch"), we should expand by finding all remotes
matching "$remote", look up their fetch refspecs, and map
"refs/heads/$branch" through them to find the appropriate remote-tracking
branch name corresponding to "$remote/$branch". This would yield the
correct remote-tracking branch in all cases, both for conventional and
unconventional refspecs.

Likewise, when shortening full refnames for remote-tracking branches into
their shorthand form ("$remote/$branch"), we should find the refspec with
the RHS that matches the full remote-tracking branch name, and map
through that refspec to produce the corresponding LHS (minus the leading
"refs/heads/" part), and from that construct the corresponding
"$remote/$branch" shorthand.

This patch adds a new expansion method - ref_expand_refspec() - and a
corresponding shortening method - ref_shorten_refspec() - that implements
the remote refspec traversal and expanding/shortening logic described
above. These expand/shorten methods complement the existing
ref_expand_txtly() and ref_shorten_txtly() methods that implement the
current textual expanding/shortening logic.

Implementing the proper expanding/shortening of "$remote/$branch" is now
a simple matter of adding another entry to the ref_expand_rules list,
using the new ref_expand_refspec() and ref_shorten_refspec() functions.

Note that the existing "refs/remotes/*" textual expansion/shortening rule
is kept to preserve backwards compatibility for refs under refs/remotes/*
that are not covered by any configured refspec.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c                                         | 98 +++++++++++++++++++++++++-
 t/t7900-working-with-namespaced-remote-refs.sh | 21 +++++-
 2 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 98997c4..18d7188 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,7 @@
 #include "tag.h"
 #include "dir.h"
 #include "string-list.h"
+#include "remote.h"
 
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
@@ -1758,12 +1759,102 @@ static char *ref_shorten_txtly(const struct ref_expand_rule *rule,
 	return xstrndup(refname + pre_len, match_len);
 }
 
+struct ref_expand_refspec_helper_data {
+	const struct ref_expand_rule *rule;
+	char *dst;
+	size_t dst_len;
+	const char *src;
+	size_t src_len;
+};
+
+static int ref_expand_refspec_helper(struct remote *remote, void *cb_data)
+{
+	struct ref_expand_refspec_helper_data *cb = cb_data;
+	struct refspec query;
+	char refspec_src[PATH_MAX];
+	size_t ref_start = strlen(remote->name) + 1;
+	if (prefixcmp(cb->src, remote->name) ||
+	    cb->src_len <= ref_start ||
+	    cb->src[ref_start - 1] != '/')
+		return 0;
+
+	mksnpath(refspec_src, sizeof(refspec_src), cb->rule->pattern,
+		 cb->src_len - ref_start, cb->src + ref_start);
+
+	memset(&query, 0, sizeof(struct refspec));
+	query.src = refspec_src;
+	if ((!remote_find_tracking(remote, &query)) &&
+	    strlen(query.dst) < cb->dst_len) {
+		strcpy(cb->dst, query.dst);
+		return 1;
+	}
+	return 0;
+}
+
+static void ref_expand_refspec(const struct ref_expand_rule *rule,
+			       char *dst, size_t dst_len,
+			       const char *shortname, size_t shortname_len)
+{
+	/*
+	 * Given shortname of the form "$remote/$ref", see if there is a
+	 * fetch refspec configured for $remote whose lhs matches
+	 * rule->pattern % $ref, and use the corresponding rhs of that
+	 * mapping as the expanded result of "$remote/$ref".
+	 */
+	const void *has_slash = memchr(shortname, '/', shortname_len);
+	struct ref_expand_refspec_helper_data cb = {
+		rule, dst, dst_len, shortname, shortname_len };
+	dst[0] = '\0';
+	if (has_slash)
+		for_each_remote(ref_expand_refspec_helper, &cb);
+}
+
+static int ref_shorten_refspec_helper(struct remote *remote, void *cb_data)
+{
+	struct ref_expand_refspec_helper_data *cb = cb_data;
+	struct refspec query;
+	char *lhs_ref;
+	int ret = 0;
+
+	memset(&query, 0, sizeof(struct refspec));
+	query.dst = (char *) cb->src;
+	if (!remote_find_tracking(remote, &query) &&
+	    (lhs_ref = ref_shorten_txtly(cb->rule, query.src))) {
+		/* refname matches rhs and rule->pattern matches lhs */
+		cb->dst_len = strlen(remote->name) + 1 + strlen(lhs_ref);
+		/* "$remote/$lhs_ref" should be shorter than src */
+		if (cb->dst_len < cb->src_len) {
+			cb->dst = xmalloc(cb->dst_len + 1);
+			snprintf(cb->dst, cb->dst_len + 1,
+				 "%s/%s", remote->name, lhs_ref);
+			ret = 1;
+		}
+		free(lhs_ref);
+	}
+	return ret;
+}
+
+static char *ref_shorten_refspec(const struct ref_expand_rule *rule,
+				 const char *refname)
+{
+	/*
+	 * See if there is a $remote with a fetch refspec that matches the
+	 * given refname on rhs, and will produce refs/heads/$ref on the
+	 * lhs. If so, construct "$remote/$ref" as the shorthand.
+	 */
+	struct ref_expand_refspec_helper_data cb = {
+		rule, NULL, 0, refname, strlen(refname) };
+	for_each_remote(ref_shorten_refspec_helper, &cb);
+	return cb.dst;
+}
+
 const struct ref_expand_rule ref_expand_rules_local[] = {
 	{ ref_expand_txtly, NULL, "%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/tags/%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/heads/%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s" },
+	{ ref_expand_refspec, ref_shorten_refspec, "refs/heads/%.*s" },
 	{ ref_expand_txtly, ref_shorten_txtly, "refs/remotes/%.*s/HEAD" },
 	{ NULL, NULL, NULL }
 };
@@ -3028,13 +3119,14 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 
 			/*
 			 * the short name is ambiguous, if it resolves
-			 * (with this previous rule) to a valid ref
-			 * read_ref() returns 0 on success
+			 * (with this previous rule) to a valid
+			 * (but different) ref
 			 */
 			if (q->expand) {
 				q->expand(q, resolved, sizeof(resolved),
 					  short_name, short_name_len);
-				if (ref_exists(resolved))
+				if (strcmp(refname, resolved) &&
+				    ref_exists(resolved))
 					break;
 			}
 		}
diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
index cc25e76..302083e 100755
--- a/t/t7900-working-with-namespaced-remote-refs.sh
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -89,7 +89,7 @@ test_expect_success 'enter client repo' '
 	cd client
 '
 
-test_expect_failure 'short-hand notation expands correctly for remote-tracking branches' '
+test_expect_success 'short-hand notation expands correctly for remote-tracking branches' '
 	echo refs/remotes/origin/heads/master > expect &&
 	git rev-parse --symbolic-full-name refs/remotes/origin/heads/master > actual &&
 	test_cmp expect actual &&
@@ -101,7 +101,7 @@ test_expect_failure 'short-hand notation expands correctly for remote-tracking b
 	test_cmp expect actual
 '
 
-test_expect_failure 'remote-tracking branches are shortened correctly' '
+test_expect_success 'remote-tracking branches are shortened correctly' '
 	echo origin/master > expect &&
 	git rev-parse --abbrev-ref refs/remotes/origin/heads/master > actual &&
 	test_cmp expect actual &&
@@ -113,4 +113,21 @@ test_expect_failure 'remote-tracking branches are shortened correctly' '
 	test_cmp expect actual
 '
 
+cat > expect.origin_master << EOF
+$server_master_b
+$server_master_a
+EOF
+
+cat > expect.origin_other << EOF
+$server_other_b
+$server_master_a
+EOF
+
+test_expect_success 'rev-list machinery should work with $remote/$branch' '
+	git rev-list origin/master > actual.origin_master &&
+	test_cmp expect.origin_master actual.origin_master &&
+	git rev-list origin/other > actual.origin_other &&
+	test_cmp expect.origin_other actual.origin_other
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f
