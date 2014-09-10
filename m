From: Jeff King <peff@peff.net>
Subject: [PATCH] refs: speed up is_refname_available
Date: Wed, 10 Sep 2014 06:17:31 -0400
Message-ID: <20140910101730.GA12399@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 12:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRey2-0003Wa-78
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 12:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbaIJKRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 06:17:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:46443 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750879AbaIJKRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 06:17:33 -0400
Received: (qmail 18311 invoked by uid 102); 10 Sep 2014 10:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 05:17:33 -0500
Received: (qmail 15384 invoked by uid 107); 10 Sep 2014 10:17:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 06:17:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 06:17:31 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256730>

Our filesystem ref storage does not allow D/F conflicts; so
if "refs/heads/a/b" exists, we do not allow "refs/heads/a"
to exist (and vice versa). This falls out naturally for
loose refs, where the filesystem enforces the condition. But
for packed-refs, we have to make the check ourselves.

We do so by iterating over the entire packed-refs namespace
and checking whether each name creates a conflict. If you
have a very large number of refs, this is quite inefficient,
as you end up doing a large number of comparisons with
uninteresting bits of the ref tree (e.g., we know that all
of "refs/tags" is uninteresting in the example above, yet we
check each entry in it).

Instead, let's take advantage of the fact that we have the
packed refs stored as a trie of ref_entry structs. We can
find each component of the proposed refname as we walk
through the trie, checking for D/F conflicts as we go. For a
refname of depth N (i.e., 4 in the above example), we only
have to visit N nodes. And at each visit, we can binary
search the M names at that level, for a total complexity of
O(N lg M). ("M" is different at each level, of course, but
we can take the worst-case "M" as a bound).

In a pathological case of fetching 30,000 fresh refs into a
repository with 8.5 million refs, this dropped the time to
run "git fetch" from tens of minutes to ~30s.

This may also help smaller cases in which we check against
loose refs (which we do when renaming a ref), as we may
avoid a disk access for unrelated loose directories.

Note that the tests we add appear at first glance to be
redundant with what is already in t3210. However, the early
tests are not robust; they are run with reflogs turned on,
meaning that we are not actually testing
is_refname_available at all! The operations will still fail
because the reflogs will hit D/F conflicts in the
filesystem. To get a true test, we must turn off reflogs
(but we don't want to do so for the entire script, because
the point of turning them on was to cover some other cases).

Signed-off-by: Jeff King <peff@peff.net>
---
The diff's a bit hard to read, because it keeps useless lines like "{"
as context. I thought histogram and patience were supposed to be more
readable there, but they seem to produce the same thing.

This has a fairly straightforward conflict with the ref-transaction
stuff in pu. The "oldrefname" parameter to is_refname_available became a
list of items; we resolve it by teaching entry_matches to do the same
here.  I pushed a proposed resolution up to:

  git://github.com/peff/git.git resolution-refname-available

 refs.c               | 123 +++++++++++++++++++++++++++++++++++++--------------
 t/t3210-pack-refs.sh |  31 ++++++++++++-
 2 files changed, 121 insertions(+), 33 deletions(-)

diff --git a/refs.c b/refs.c
index 27927f2..4e5639c 100644
--- a/refs.c
+++ b/refs.c
@@ -779,37 +779,32 @@ static void prime_ref_dir(struct ref_dir *dir)
 			prime_ref_dir(get_ref_dir(entry));
 	}
 }
-/*
- * Return true iff refname1 and refname2 conflict with each other.
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- */
-static int names_conflict(const char *refname1, const char *refname2)
+
+static int entry_matches(struct ref_entry *entry, const char *refname)
 {
-	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
-		;
-	return (*refname1 == '\0' && *refname2 == '/')
-		|| (*refname1 == '/' && *refname2 == '\0');
+	return refname && !strcmp(entry->name, refname);
 }
 
-struct name_conflict_cb {
-	const char *refname;
-	const char *oldrefname;
-	const char *conflicting_refname;
+struct nonmatching_ref_data {
+	const char *skip;
+	struct ref_entry *found;
 };
 
-static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
+static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 {
-	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
+	struct nonmatching_ref_data *data = vdata;
+
+	if (entry_matches(entry, data->skip))
 		return 0;
-	if (names_conflict(data->refname, entry->name)) {
-		data->conflicting_refname = entry->name;
-		return 1;
-	}
-	return 0;
+
+	data->found = entry;
+	return 1;
+}
+
+static void report_refname_conflict(struct ref_entry *entry,
+				    const char *refname)
+{
+	error("'%s' exists; cannot create '%s'", entry->name, refname);
 }
 
 /*
@@ -818,21 +813,85 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_dir *dir)
 {
-	struct name_conflict_cb data;
-	data.refname = refname;
-	data.oldrefname = oldrefname;
-	data.conflicting_refname = NULL;
+	const char *slash;
+	size_t len;
+	int pos;
+	char *dirname;
 
-	sort_ref_dir(dir);
-	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
-		error("'%s' exists; cannot create '%s'",
-		      data.conflicting_refname, refname);
+	for (slash = strchr(refname, '/'); slash; slash = strchr(slash, '/')) {
+		/*
+		 * We are still at a leading dir of the refname; we are
+		 * looking for a conflict with a leaf entry.
+		 *
+		 * If we find one, we still must make sure it is
+		 * not "oldrefname".
+		 */
+		pos = search_ref_dir(dir, refname, slash - refname);
+		if (pos >= 0) {
+			struct ref_entry *entry = dir->entries[pos];
+			if (entry_matches(entry, oldrefname))
+				return 1;
+			report_refname_conflict(entry, refname);
+			return 0;
+		}
+
+
+		/*
+		 * Otherwise, we can try to continue our search with
+		 * the next component; if we come up empty, we know
+		 * there is nothing under this whole prefix.
+		 */
+		slash++;
+		pos = search_ref_dir(dir, refname, slash - refname);
+		if (pos < 0)
+			return 1;
+
+		dir = get_ref_dir(dir->entries[pos]);
+	}
+
+	/*
+	 * We are at the leaf of our refname; we want to
+	 * make sure there are no directories which match it.
+	 */
+	len = strlen(refname);
+	dirname = xmallocz(len + 1);
+	sprintf(dirname, "%s/", refname);
+	pos = search_ref_dir(dir, dirname, len + 1);
+	free(dirname);
+
+	/*
+	 * If we did find a directory, it might be a conflict.
+	 * It is a problem if it has any ref that is not
+	 * "oldrefname".
+	 */
+	if (pos >= 0) {
+		struct ref_entry *entry = dir->entries[pos];
+		struct ref_dir *dir = get_ref_dir(entry);
+		struct nonmatching_ref_data data;
+
+		data.skip = oldrefname;
+		sort_ref_dir(dir);
+		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
+			return 1;
+
+		report_refname_conflict(data.found, refname);
 		return 0;
 	}
+
+	/*
+	 * There is no point in searching for another leaf
+	 * node which matches it; such an entry would be the
+	 * ref we are looking for, not a conflict.
+	 */
 	return 1;
 }
 
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 1a2080e..3d5cb4c 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -11,7 +11,9 @@ semantic is still the same.
 '
 . ./test-lib.sh
 
-echo '[core] logallrefupdates = true' >>.git/config
+test_expect_success 'enable reflogs' '
+	git config core.logallrefupdates true
+'
 
 test_expect_success \
     'prepare a trivial repository' \
@@ -151,4 +153,31 @@ test_expect_success 'delete ref while another dangling packed ref' '
 	test_cmp /dev/null result
 '
 
+test_expect_success 'disable reflogs' '
+	git config core.logallrefupdates false &&
+	rm -rf .git/logs
+'
+
+test_expect_success 'create packed foo/bar/baz branch' '
+	git branch foo/bar/baz &&
+	git pack-refs --all --prune &&
+	test_path_is_missing .git/refs/heads/foo/bar/baz &&
+	test_path_is_missing .git/logs/refs/heads/foo/bar/baz
+'
+
+test_expect_success 'notice d/f conflict with existing directory' '
+	test_must_fail git branch foo &&
+	test_must_fail git branch foo/bar
+'
+
+test_expect_success 'existing directory reports concrete ref' '
+	test_must_fail git branch foo 2>stderr &&
+	grep refs/heads/foo/bar/baz stderr
+'
+
+test_expect_success 'notice d/f conflict with existing ref' '
+	test_must_fail git branch foo/bar/baz/extra &&
+	test_must_fail git branch foo/bar/baz/lots/of/extra/components
+'
+
 test_done
-- 
2.1.0.373.g91ca799
