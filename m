From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 05/10] refs.c: Add support for expanding/shortening refs in refs/peers/*
Date: Sat, 11 May 2013 18:21:15 +0200
Message-ID: <1368289280-30337-6-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:22:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYc-0007jj-LP
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab3EKQVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:53 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43164 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3EKQVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn3so1576990wib.0
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uJW01ej3FnywO0nTmkAPM/E905cMKe3viabsRucDPjI=;
        b=cF4+GVvyoshd9fN3nEsUD9BkuTXnrxL2bOJE7wR9pA3vA851Skw791BirHhbM6tbjE
         FN6puhHc6kOCYfbg+NsrFbilK1WhWJyYinmTduSkkHxNsweJrQvahAAFMOrapk1CMgUt
         LMwm6IRkYF4/B9aGF0+Qx8/0/vjKsGKPkqrBFG7QSrmtCXIVUb3Xw/8Ei/4G9g/JAAcY
         d2yIoj1L009L7a6PJ0fEY0UdYLfP/QDTPE7JTYHsXNZf6QoBr+kGNfR4PGbUTix15TFr
         by7ogIVQ1z+05pQleGmNuT8q/dMRDAdqvILYf2PFM8SNm3YpdoehMptGW//w9OUuYjSD
         TIcg==
X-Received: by 10.180.183.139 with SMTP id em11mr9840855wic.16.1368289294100;
        Sat, 11 May 2013 09:21:34 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223990>

This patch adds the following patterns for expanding/shortening refs:

  "refs/peers/%*"
  "refs/peers/%1/tags/%*"
  "refs/peers/%1/heads/%*"

These allow shorthand names like "origin/master" to expand to refs in
the refs/peers/* hierarchy (in this case, the likely expansion would be
by the middle rule above, resulting in "refs/peers/origin/heads/master").

To accomplish this, we have added the new "%1" wildcard which shall
expand into the first component (i.e. up to the first '/') of the given
shorthand. The other wildcard ("%*") shall then expand into the remainder
of the shorthand (i.e. following the first '/').

Correspondingly, when shortening according to a pattern with "%1", a
single component (not including any '/' character) shall be extracted
from that point in the given refname, and shall be added to the resulting
shorthand, with a trailing '/'. Then, when hitting the "%*", the
remainder of the given refname (modulo a trailing match in the pattern)
shall be extracted and appended to the portion previously extracted by
the "%1" wildcard.

The need to split the "$remote/$ref" into its $remote and $ref parts is
the reason why multi-level remote names will no longer work (and hence
were disallowed in the previous patch). A testcase demonstrating how
multi-level remote names fail is therefore included in this patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 refs.c                                         | 101 +++++++++++++++++++++----
 t/t7900-working-with-namespaced-remote-refs.sh |   4 +-
 t/t7901-multi-level-remote-name-failure.sh     |  20 +++++
 3 files changed, 107 insertions(+), 18 deletions(-)
 create mode 100755 t/t7901-multi-level-remote-name-failure.sh

diff --git a/refs.c b/refs.c
index ab5e120..188a9eb 100644
--- a/refs.c
+++ b/refs.c
@@ -1789,7 +1789,10 @@ static const char *refname_patterns[] = {
 	"refs/tags/%*",
 	"refs/heads/%*",
 	"refs/remotes/%*",
-	"refs/remotes/%*/HEAD"
+	"refs/remotes/%*/HEAD",
+	"refs/peers/%*",
+	"refs/peers/%1/tags/%*",
+	"refs/peers/%1/heads/%*"
 };
 
 struct wildcard_data {
@@ -1806,6 +1809,15 @@ static size_t refname_expand_helper(struct strbuf *sb, const char *placeholder,
 		strbuf_add(sb, cb->s, cb->len);
 		cb->done = 1;
 		return 1;
+	} else if (*placeholder == '1' && !cb->done) {
+		const char *p = memchr(cb->s, '/', cb->len);
+		size_t copy_len = p ? p - cb->s : cb->len;
+		strbuf_add(sb, cb->s, copy_len);
+		if (copy_len < cb->len && cb->s[copy_len] == '/')
+			copy_len++;
+		cb->s += copy_len;
+		cb->len -= copy_len;
+		return 1;
 	}
 	return 0;
 }
@@ -1821,6 +1833,46 @@ static int refname_expand(struct strbuf *dst, const char *pattern,
 	return !cbdata.done;
 }
 
+static int handle_fragment(struct strbuf *dst, struct strbuf *fragment,
+			   int first, int last,
+			   const char *refname, size_t refname_len)
+{
+	const char *ref = refname, *p;
+	size_t ref_len = refname_len, trail_len;
+	if (!first) {
+		/* extract wildcard according to wildcard char */
+		switch (fragment->buf[0]) {
+		case '1':
+			/* extract up to next '/' from refname */
+			p = memchr(ref, '/', ref_len);
+			if (!p)
+				return -1;
+			strbuf_add(dst, ref, p - ref);
+			strbuf_addch(dst, '/');
+			ref_len -= p - ref;
+			ref += p - ref;
+			break;
+		case '*':
+			/* extract all up to matching trailer */
+			assert(last);
+			trail_len = fragment->len - 1;
+			if (trail_len > ref_len)
+				return -1;
+			strbuf_add(dst, ref, ref_len - trail_len);
+			ref += ref_len - trail_len;
+			ref_len -= ref_len - trail_len;
+			break;
+		}
+	}
+
+	/* match rest of fragment verbatim */
+	p = fragment->buf + (first ? 0 : 1); /* skip wildcard character */
+	trail_len = fragment->len - ((first ? 0 : 1) + (last ? 0 : 1));
+	if (trail_len > ref_len || memcmp(ref, p, trail_len))
+		return -1;
+	return (ref - refname) + trail_len;
+}
+
 static int refname_shorten(struct strbuf *dst, const char *pattern,
 			   const char *refname, size_t refname_len)
 {
@@ -1830,26 +1882,43 @@ static int refname_shorten(struct strbuf *dst, const char *pattern,
 	 * Return 0 on success (positive match, wildcard-matching portion
 	 * copied into dst), and non-zero on failure (no match, dst empty).
 	 */
-	const char *match_end;
-	struct strbuf **fragments = strbuf_split_str(pattern, '%', 2);
-	struct strbuf *prefix = fragments[0], *suffix = fragments[1];
-	assert(!fragments[2]);
-	assert(prefix->len && prefix->buf[prefix->len - 1] == '%');
-	assert(suffix->len && suffix->buf[0] == '*');
+	struct strbuf **fragments = strbuf_split_str(pattern, '%', 0);
+	struct strbuf **it;
+	int first = 1, last, ret = 1;
 
 	strbuf_reset(dst);
-	match_end = refname + refname_len - (suffix->len - 1);
-	if (refname_len <= (prefix->len - 1) + (suffix->len - 1) ||
-	    memcmp(prefix->buf, refname, prefix->len - 1) ||
-	    memcmp(suffix->buf + 1, match_end, suffix->len - 1)) {
-		strbuf_list_free(fragments);
-		return 1; /* refname does not match pattern */
+	for (it = fragments; *it; it++) {
+		int consumed;
+		struct strbuf *cur = *it;
+		last = *(it + 1) == NULL;
+
+		/* all but last ends with '%' */
+		assert(last || cur->buf[cur->len - 1] == '%');
+		/* all but first starts with '*' or '1' */
+		assert(first || cur->buf[0] == '*' || cur->buf[0] == '1');
+		/* only last starts with '*' */
+		assert((cur->buf[0] == '*' && last) ||
+		       (cur->buf[0] != '*' && !last));
+
+		consumed = handle_fragment(dst, cur, first, last,
+					   refname, refname_len);
+		if (consumed < 0)
+			goto cleanup;
+		else {
+			refname += consumed;
+			refname_len -= consumed;
+		}
+
+		first = 0;
 	}
+	if (refname_len == 0)
+		ret = 0;
 
-	refname += prefix->len - 1;
-	strbuf_add(dst, refname, match_end - refname);
+cleanup:
+	if (ret)
+		strbuf_reset(dst);
 	strbuf_list_free(fragments);
-	return 0;
+	return ret;
 }
 
 int refname_match(const char *abbrev_name, const char *full_name)
diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
index 109e9b8..33266e0 100755
--- a/t/t7900-working-with-namespaced-remote-refs.sh
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -83,7 +83,7 @@ test_expect_success 'enter client repo' '
 	cd client
 '
 
-test_expect_failure 'short-hand notation expands correctly for remote-tracking branches' '
+test_expect_success 'short-hand notation expands correctly for remote-tracking branches' '
 	echo refs/peers/origin/heads/master >expect &&
 	git rev-parse --symbolic-full-name refs/peers/origin/heads/master >actual &&
 	test_cmp expect actual &&
@@ -95,7 +95,7 @@ test_expect_failure 'short-hand notation expands correctly for remote-tracking b
 	test_cmp expect actual
 '
 
-test_expect_failure 'remote-tracking branches are shortened correctly' '
+test_expect_success 'remote-tracking branches are shortened correctly' '
 	echo origin/master >expect &&
 	git rev-parse --abbrev-ref refs/peers/origin/heads/master >actual &&
 	test_cmp expect actual &&
diff --git a/t/t7901-multi-level-remote-name-failure.sh b/t/t7901-multi-level-remote-name-failure.sh
new file mode 100755
index 0000000..8d2a617
--- /dev/null
+++ b/t/t7901-multi-level-remote-name-failure.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='Show why multi-level remote names can no longer be used'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit a &&
+	git config remote.multi/level.url . &&
+	git config remote.multi/level.fetch "+refs/heads/*:refs/peers/multi/level/heads/*" &&
+	git fetch multi/level
+'
+
+test_expect_failure 'Fail to use shorthand notation: "$remote/$branch"' '
+	git rev-parse --verify a >expect &&
+	git rev-parse --verify multi/level/master >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.1.3.704.g33f7d4f
