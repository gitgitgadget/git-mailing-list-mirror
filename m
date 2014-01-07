From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] get_sha1: speed up ambiguous 40-hex test
Date: Tue, 7 Jan 2014 18:59:53 -0500
Message-ID: <20140107235953.GD10657@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 01:00:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gZ1-0002Sf-P0
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 01:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbaAGX77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 18:59:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:56848 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754829AbaAGX7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 18:59:55 -0500
Received: (qmail 1826 invoked by uid 102); 7 Jan 2014 23:59:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 17:59:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 18:59:53 -0500
Content-Disposition: inline
In-Reply-To: <20140107235631.GA10503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240186>

Since 798c35f (get_sha1: warn about full or short object
names that look like refs, 2013-05-29), a 40-hex sha1 causes
us to call dwim_ref on the result, on the off chance that we
have a matching ref. This can cause a noticeable slow-down
when there are a large number of objects.  E.g., on
linux.git:

  [baseline timing]
  $ best-of-five git rev-list --all --pretty=raw
  real    0m3.996s
  user    0m3.900s
  sys     0m0.100s

  [same thing, but calling get_sha1 on each commit from stdin]
  $ git rev-list --all >commits
  $ best-of-five -i commits git rev-list --stdin --pretty=raw
  real    0m7.862s
  user    0m6.108s
  sys     0m1.760s

The problem is that each call to dwim_ref individually stats
the possible refs in refs/heads, refs/tags, etc. In the
common case, there are no refs that look like sha1s at all.
We can therefore do the same check much faster by loading
all ambiguous-looking candidates once, and then checking our
index for each object.

This is technically more racy (somebody might create such a
ref after we build our index), but that's OK, as it's just a
warning (and we provide no guarantees about whether a
simultaneous process ran before or after the ref was created
anyway).

Here is the time after this patch, which implements the
strategy described above:

  $ best-of-five -i commits git rev-list --stdin --pretty=raw
  real    0m4.966s
  user    0m4.776s
  sys     0m0.192s

We still pay some price to read the commits from stdin, but
notice the system time is much lower, as we are avoiding
hundreds of thousands of stat() calls.

Signed-off-by: Jeff King <peff@peff.net>
---
I wanted to make the ref traversal as cheap as possible, hence the
NO_RECURSE flag I added. I thought INCLUDE_BROKEN used to not open up
the refs at all, but it looks like it does these days. I wonder if that
is worth changing or not.

 refs.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 refs.h      |  2 ++
 sha1_name.c |  4 +---
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index ca854d6..cddd871 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,7 @@
 #include "tag.h"
 #include "dir.h"
 #include "string-list.h"
+#include "sha1-array.h"
 
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
@@ -2042,6 +2043,52 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+static int check_ambiguous_sha1_ref(const char *refname,
+				    const unsigned char *sha1,
+				    int flags,
+				    void *data)
+{
+	unsigned char tmp_sha1[20];
+	if (strlen(refname) == 40 && !get_sha1_hex(refname, tmp_sha1))
+		sha1_array_append(data, tmp_sha1);
+	return 0;
+}
+
+static void build_ambiguous_sha1_ref_index(struct sha1_array *idx)
+{
+	const char **rule;
+
+	for (rule = ref_rev_parse_rules; *rule; rule++) {
+		const char *prefix = *rule;
+		const char *end = strstr(prefix, "%.*s");
+		char *buf;
+
+		if (!end)
+			continue;
+
+		buf = xmemdupz(prefix, end - prefix);
+		do_for_each_ref(&ref_cache, buf, check_ambiguous_sha1_ref,
+				end - prefix,
+				DO_FOR_EACH_INCLUDE_BROKEN |
+				DO_FOR_EACH_NO_RECURSE,
+				idx);
+		free(buf);
+	}
+}
+
+int sha1_is_ambiguous_with_ref(const unsigned char *sha1)
+{
+	struct sha1_array idx = SHA1_ARRAY_INIT;
+	static int loaded;
+
+	if (!loaded) {
+		build_ambiguous_sha1_ref_index(&idx);
+		loaded = 1;
+	}
+
+	return sha1_array_lookup(&idx, sha1) >= 0;
+}
+
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
diff --git a/refs.h b/refs.h
index 87a1a79..c7d5f89 100644
--- a/refs.h
+++ b/refs.h
@@ -229,4 +229,6 @@ int update_refs(const char *action, const struct ref_update **updates,
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 extern int ref_is_hidden(const char *);
 
+int sha1_is_ambiguous_with_ref(const unsigned char *sha1);
+
 #endif /* REFS_H */
diff --git a/sha1_name.c b/sha1_name.c
index a5578f7..f83ecb7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -452,13 +452,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 
 	if (len == 40 && !get_sha1_hex(str, sha1)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
-			if (refs_found > 0) {
+			if (sha1_is_ambiguous_with_ref(sha1)) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
 					fprintf(stderr, "%s\n", _(object_name_msg));
 			}
-			free(real_ref);
 		}
 		return 0;
 	}
-- 
1.8.5.2.500.g8060133
