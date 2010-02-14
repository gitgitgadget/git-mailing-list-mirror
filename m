From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] for-each-ref --format='%(symref) %(symref:short)'
Date: Sun, 14 Feb 2010 01:32:43 -0500
Message-ID: <20100214063243.GA20630@coredump.intra.peff.net>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
 <1266093033-9526-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 07:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgY2G-0006XJ-K1
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 07:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab0BNGcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 01:32:46 -0500
Received: from peff.net ([208.65.91.99]:58981 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab0BNGcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 01:32:45 -0500
Received: (qmail 31138 invoked by uid 107); 14 Feb 2010 06:32:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 01:32:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 01:32:43 -0500
Content-Disposition: inline
In-Reply-To: <1266093033-9526-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139887>

On Sat, Feb 13, 2010 at 12:30:32PM -0800, Junio C Hamano wrote:

> New %(symref) output atom expands to the name of the ref a symbolic ref
> points at, or an empty string if the ref being shown is not a symref.

I think this is reasonable, but:

> +	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
> +		unsigned char unused1[20];
> +		const char *symref;
> +		symref = resolve_ref(ref->refname, unused1, 1, NULL);
> +		if (symref)
> +			ref->symref = xstrdup(symref);
> +		else
> +			ref->symref = "";
> +	}

It feels ugly that we need to re-resolve the ref when we simply threw
that information away earlier from when we called resolve_ref in
get_ref_dir (which covers the loose case; for the packed case, I don't
believe we have actual symbolic refs in the packed list).

Unfortunately, passing that information up the callchain changes the
signature of each_ref_fn, which has a pretty big fallout. The patch is
below (it does not replace your 3/4; it merely gets the information up
to grab_single_ref).

The patch below is to show the extent of the change. The changes were
mostly mechanical, and I haven't extensively tested. However, it
_should_ be a no-op, as most callbacks just ignore the new information.
The exception is read_remote_branches, which was re-resolving just to
find symref information.

If we were going to do this for real, I would be tempted to actually
change the signature of each_ref_fn to take a struct so this doesn't
come up again, and do three patches:

  1/3: pass "struct reflist" to each_ref_fn
  2/3: add symref to "struct reflist"
  3/3: use added symref information in read_remote_branches

---
 bisect.c               |    2 +-
 builtin-branch.c       |    2 +-
 builtin-checkout.c     |    2 +-
 builtin-describe.c     |    2 +-
 builtin-fetch-pack.c   |    6 +++---
 builtin-fetch.c        |    2 +-
 builtin-for-each-ref.c |    2 +-
 builtin-fsck.c         |    6 +++---
 builtin-name-rev.c     |    2 +-
 builtin-pack-objects.c |    2 +-
 builtin-receive-pack.c |    4 ++--
 builtin-reflog.c       |    2 +-
 builtin-remote.c       |   15 ++++-----------
 builtin-replace.c      |    2 +-
 builtin-rev-parse.c    |    4 ++--
 builtin-show-branch.c  |   12 ++++++------
 builtin-show-ref.c     |    4 ++--
 builtin-tag.c          |    2 +-
 http-backend.c         |    2 +-
 log-tree.c             |    2 +-
 pack-refs.c            |    2 +-
 reachable.c            |    4 ++--
 refs.c                 |   32 ++++++++++++++++++++------------
 refs.h                 |    2 +-
 remote.c               |    4 ++--
 replace_object.c       |    3 ++-
 revision.c             |    4 ++--
 server-info.c          |    2 +-
 sha1_name.c            |    3 ++-
 transport.c            |    4 ++--
 upload-pack.c          |    4 ++--
 walker.c               |    2 +-
 32 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6dc27ee..e45f345 100644
--- a/bisect.c
+++ b/bisect.c
@@ -436,7 +436,7 @@ static void sha1_array_push(struct sha1_array *array,
 }
 
 static int register_ref(const char *refname, const unsigned char *sha1,
-			int flags, void *cb_data)
+			int flags, const char *symref, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
 		current_bad_sha1 = sha1;
diff --git a/builtin-branch.c b/builtin-branch.c
index a28a139..8d43fb4 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -257,7 +257,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 	return xstrdup(dst);
 }
 
-static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int append_ref(const char *refname, const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..6e31bc6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -592,7 +592,7 @@ struct tracking_name_data {
 };
 
 static int check_tracking_name(const char *refname, const unsigned char *sha1,
-			       int flags, void *cb_data)
+			       int flags, const char *symref, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
 	const char *slash;
diff --git a/builtin-describe.c b/builtin-describe.c
index 71be2a9..5297a6f 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -62,7 +62,7 @@ static void add_to_known_names(const char *path,
 	found_names = 1;
 }
 
-static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int get_name(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	int might_be_tag = !prefixcmp(path, "refs/tags/");
 	struct commit *commit;
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 8ed4a6f..dfab784 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -54,7 +54,7 @@ static void rev_list_push(struct commit *commit, int mark)
 	}
 }
 
-static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
@@ -64,7 +64,7 @@ static int rev_list_insert_ref(const char *path, const unsigned char *sha1, int
 	return 0;
 }
 
-static int clear_marks(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int clear_marks(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *o = deref_tag(parse_object(sha1), path, 0);
 
@@ -422,7 +422,7 @@ done:
 
 static struct commit_list *complete;
 
-static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_complete(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 55c7d94..cbbf46a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -533,7 +533,7 @@ static int prune_refs(struct transport *transport, struct ref *ref_map)
 }
 
 static int add_existing(const char *refname, const unsigned char *sha1,
-			int flag, void *cbdata)
+			int flag, const char *symref, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	struct string_list_item *item = string_list_insert(refname, list);
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index a5a83f1..de43c09 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -685,7 +685,7 @@ struct grab_ref_cbdata {
  * need to use global variables to pass extra information to this
  * function.
  */
-static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 0929c7f..55f4996 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -444,7 +444,7 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, int flag, void *cb_data)
+static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	for_each_reflog_ent(logname, fsck_handle_reflog_ent, NULL);
 	return 0;
@@ -455,7 +455,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
 }
 
-static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *obj;
 
@@ -477,7 +477,7 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 static void get_default_heads(void)
 {
 	if (head_points_at && !is_null_sha1(head_sha1))
-		fsck_handle_ref("HEAD", head_sha1, 0, NULL);
+		fsck_handle_ref("HEAD", head_sha1, 0, NULL, NULL);
 	for_each_ref(fsck_handle_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 06a38ac..8b7ffb6 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -88,7 +88,7 @@ struct name_ref_data {
 	const char *ref_filter;
 };
 
-static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)
+static int name_ref(const char *path, const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 	struct name_ref_data *data = cb_data;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e1d3adf..acc24fc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1766,7 +1766,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 #define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
 #endif
 
-static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	unsigned char peeled[20];
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 4320c93..1f22379 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -103,7 +103,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int show_ref(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	if (!capabilities_to_send)
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
@@ -118,7 +118,7 @@ static void write_head_info(void)
 {
 	for_each_ref(show_ref, NULL);
 	if (capabilities_to_send)
-		show_ref("capabilities^{}", null_sha1, 0, NULL);
+		show_ref("capabilities^{}", null_sha1, 0, NULL, NULL);
 
 }
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 7498210..5e13334 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -383,7 +383,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	return status;
 }
 
-static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, const char *symref, void *cb_data)
 {
 	struct collected_reflog *e;
 	struct collect_reflog_cb *cb = cb_data;
diff --git a/builtin-remote.c b/builtin-remote.c
index 277765b..4cbd6fa 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -456,7 +456,7 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec refspec;
@@ -504,23 +504,16 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
-	int flag;
-	unsigned char orig_sha1[20];
-	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
 	if (!prefixcmp(refname, buf.buf)) {
 		item = string_list_append(xstrdup(refname), rename->remote_branches);
-		symref = resolve_ref(refname, orig_sha1, 1, &flag);
-		if (flag & REF_ISSYMREF)
-			item->util = xstrdup(symref);
-		else
-			item->util = NULL;
+		item->util = symref ? xstrdup(symref) : NULL;
 	}
 
 	return 0;
@@ -787,7 +780,7 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct ref_states *states = cb_data;
 	struct refspec refspec;
diff --git a/builtin-replace.c b/builtin-replace.c
index fe3a647..dc626d4 100644
--- a/builtin-replace.c
+++ b/builtin-replace.c
@@ -21,7 +21,7 @@ static const char * const git_replace_usage[] = {
 };
 
 static int show_reference(const char *refname, const unsigned char *sha1,
-			  int flag, void *cb_data)
+			  int flag, const char *symref, void *cb_data)
 {
 	const char *pattern = cb_data;
 
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a8c5043..7705b76 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -178,13 +178,13 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int show_reference(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	show_rev(NORMAL, sha1, refname);
 	return 0;
 }
 
-static int anti_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int anti_reference(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	show_rev(REVERSED, sha1, refname);
 	return 0;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 9f13caa..08fbff6 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -403,7 +403,7 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	unsigned char tmp[20];
 	int ofs = 11;
@@ -417,7 +417,7 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 	return append_ref(refname + ofs, sha1, 0);
 }
 
-static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	unsigned char tmp[20];
 	int ofs = 13;
@@ -431,7 +431,7 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 	return append_ref(refname + ofs, sha1, 0);
 }
 
-static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	if (prefixcmp(refname, "refs/tags/"))
 		return 0;
@@ -449,7 +449,7 @@ static int count_slash(const char *s)
 	return cnt;
 }
 
-static int append_matching_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_matching_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
@@ -465,9 +465,9 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
 	if (!prefixcmp(refname, "refs/heads/"))
-		return append_head_ref(refname, sha1, flag, cb_data);
+		return append_head_ref(refname, sha1, flag, symref, cb_data);
 	if (!prefixcmp(refname, "refs/tags/"))
-		return append_tag_ref(refname, sha1, flag, cb_data);
+		return append_tag_ref(refname, sha1, flag, symref, cb_data);
 	return append_ref(refname, sha1, 0);
 }
 
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 17ada88..5961f7f 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -26,7 +26,7 @@ static void show_one(const char *refname, const unsigned char *sha1)
 		printf("%s %s\n", hex, refname);
 }
 
-static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+static int show_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cbdata)
 {
 	struct object *obj;
 	const char *hex;
@@ -102,7 +102,7 @@ match:
 	return 0;
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+static int add_existing(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(refname, list);
diff --git a/builtin-tag.c b/builtin-tag.c
index 4ef1c4f..ae9b78b 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -32,7 +32,7 @@ struct tag_filter {
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
 static int show_reference(const char *refname, const unsigned char *sha1,
-			  int flag, void *cb_data)
+			  int flag, const char *symref, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
 
diff --git a/http-backend.c b/http-backend.c
index 345c12b..bd14606 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -419,7 +419,7 @@ static void run_service(const char **argv)
 }
 
 static int show_text_ref(const char *name, const unsigned char *sha1,
-	int flag, void *cb_data)
+	int flag, const char *symref, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 	struct object *o = parse_object(sha1);
diff --git a/log-tree.c b/log-tree.c
index 27afcf6..58a4ee8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -20,7 +20,7 @@ static void add_name_decoration(const char *prefix, const char *name, struct obj
 	res->next = add_decoration(&name_decoration, obj, res);
 }
 
-static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct object *obj = parse_object(sha1);
 	if (!obj)
diff --git a/pack-refs.c b/pack-refs.c
index 7f43f8a..f1f3e73 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -24,7 +24,7 @@ static int do_not_prune(int flags)
 }
 
 static int handle_one_ref(const char *path, const unsigned char *sha1,
-			  int flags, void *cb_data)
+			  int flags, const char *symref, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
 	int is_tag_ref;
diff --git a/reachable.c b/reachable.c
index b515fa2..2a07135 100644
--- a/reachable.c
+++ b/reachable.c
@@ -133,7 +133,7 @@ static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_one_ref(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *object = parse_object(sha1);
 	struct rev_info *revs = (struct rev_info *)cb_data;
@@ -145,7 +145,7 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static int add_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_one_reflog(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	for_each_reflog_ent(path, add_one_reflog_ent, cb_data);
 	return 0;
diff --git a/refs.c b/refs.c
index 503a8c2..986c8e2 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,7 @@
 struct ref_list {
 	struct ref_list *next;
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
+	char *symref;
 	unsigned char sha1[20];
 	unsigned char peeled[20];
 	char name[FLEX_ARRAY];
@@ -44,7 +45,8 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 }
 
 static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
-				int flag, struct ref_list *list,
+				int flag, const char *real_ref,
+				struct ref_list *list,
 				struct ref_list **new_entry)
 {
 	int len;
@@ -57,6 +59,7 @@ static struct ref_list *add_ref(const char *name, const unsigned char *sha1,
 	hashclr(entry->peeled);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
+	entry->symref = (flag & REF_ISSYMREF) ? xstrdup(real_ref) : NULL;
 	entry->next = list;
 	if (new_entry)
 		*new_entry = entry;
@@ -204,7 +207,7 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 
 		name = parse_ref_line(refline, sha1);
 		if (name) {
-			list = add_ref(name, sha1, flag, list, &last);
+			list = add_ref(name, sha1, flag, NULL, list, &last);
 			continue;
 		}
 		if (last &&
@@ -219,7 +222,7 @@ static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
 
 void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
 {
-	extra_refs = add_ref(name, sha1, flag, extra_refs, NULL);
+	extra_refs = add_ref(name, sha1, flag, NULL, extra_refs, NULL);
 }
 
 void clear_extra_refs(void)
@@ -260,6 +263,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			struct stat st;
 			int flag;
 			int namelen;
+			const char *real_ref;
 
 			if (de->d_name[0] == '.')
 				continue;
@@ -275,9 +279,10 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 				list = get_ref_dir(ref, list);
 				continue;
 			}
-			if (!resolve_ref(ref, sha1, 1, &flag))
+			real_ref = resolve_ref(ref, sha1, 1, &flag);
+			if (!real_ref)
 				hashclr(sha1);
-			list = add_ref(ref, sha1, flag, list, NULL);
+			list = add_ref(ref, sha1, flag, real_ref, list, NULL);
 		}
 		free(ref);
 		closedir(dir);
@@ -292,7 +297,7 @@ struct warn_if_dangling_data {
 };
 
 static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
-				   int flags, void *cb_data)
+				   int flags, const char *symref, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
 	const char *resolves_to;
@@ -549,16 +554,17 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		}
 	}
 	current_ref = entry;
-	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+	return fn(entry->name + trim, entry->sha1, entry->flag, entry->symref,
+			cb_data);
 }
 
 static int filter_refs(const char *ref, const unsigned char *sha, int flags,
-	void *data)
+		const char *symref, void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 	if (fnmatch(filter->pattern, ref, 0))
 		return 0;
-	return filter->fn(ref, sha, flags, filter->cb_data);
+	return filter->fn(ref, sha, flags, symref, filter->cb_data);
 }
 
 int peel_ref(const char *ref, unsigned char *sha1)
@@ -654,9 +660,11 @@ int head_ref(each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
 	int flag;
+	const char *real_ref;
 
-	if (resolve_ref("HEAD", sha1, 1, &flag))
-		return fn("HEAD", sha1, flag, cb_data);
+	real_ref = resolve_ref("HEAD", sha1, 1, &flag);
+	if (real_ref)
+		return fn("HEAD", sha1, flag, real_ref, cb_data);
 	return 0;
 }
 
@@ -1666,7 +1674,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 				if (!resolve_ref(log, sha1, 0, NULL))
 					retval = error("bad ref for %s", log);
 				else
-					retval = fn(log, sha1, 0, cb_data);
+					retval = fn(log, sha1, 0, NULL, cb_data);
 			}
 			if (retval)
 				break;
diff --git a/refs.h b/refs.h
index f7648b9..300ffb3 100644
--- a/refs.h
+++ b/refs.h
@@ -17,7 +17,7 @@ struct ref_lock {
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
  */
-typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
+typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, const char *symref, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn, void *);
diff --git a/remote.c b/remote.c
index c70181c..b78805a 100644
--- a/remote.c
+++ b/remote.c
@@ -1612,7 +1612,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	return 1;
 }
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
@@ -1684,7 +1684,7 @@ struct stale_heads_info {
 };
 
 static int get_stale_heads_cb(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const unsigned char *sha1, int flags, const char *symref, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct refspec refspec;
diff --git a/replace_object.c b/replace_object.c
index eb59604..1dd6965 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -52,7 +52,8 @@ static int register_replace_object(struct replace_object *replace,
 
 static int register_replace_ref(const char *refname,
 				const unsigned char *sha1,
-				int flag, void *cb_data)
+				int flag, const char *symref,
+				void *cb_data)
 {
 	/* Get sha1 from refname */
 	const char *slash = strrchr(refname, '/');
diff --git a/revision.c b/revision.c
index 3ba6d99..65cec90 100644
--- a/revision.c
+++ b/revision.c
@@ -701,7 +701,7 @@ struct all_refs_cb {
 	const char *name_for_errormsg;
 };
 
-static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object = get_reference(cb->all_revs, path, sha1,
@@ -751,7 +751,7 @@ static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int handle_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int handle_one_reflog(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
diff --git a/server-info.c b/server-info.c
index 4098ca2..f617f3f 100644
--- a/server-info.c
+++ b/server-info.c
@@ -7,7 +7,7 @@
 /* refs */
 static FILE *info_ref_fp;
 
-static int add_info_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_info_ref(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 	if (!o)
diff --git a/sha1_name.c b/sha1_name.c
index 7729925..aba8bf3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -661,7 +661,8 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 }
 
 static int handle_one_ref(const char *path,
-		const unsigned char *sha1, int flag, void *cb_data)
+		const unsigned char *sha1, int flag, const char *symref,
+		void *cb_data)
 {
 	struct commit_list **list = cb_data;
 	struct object *object = parse_object(sha1);
diff --git a/transport.c b/transport.c
index 3846aac..039ccef 100644
--- a/transport.c
+++ b/transport.c
@@ -283,7 +283,7 @@ static int fetch_objs_via_rsync(struct transport *transport,
 }
 
 static int write_one_ref(const char *name, const unsigned char *sha1,
-		int flags, void *data)
+		int flags, const char *symref, void *data)
 {
 	struct strbuf *buf = data;
 	int len = buf->len;
@@ -316,7 +316,7 @@ static int write_refs_to_temp_dir(struct strbuf *temp_dir,
 		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) != 1)
 			return error("Could not get ref %s", refspec[i]);
 
-		if (write_one_ref(ref, sha1, 0, temp_dir)) {
+		if (write_one_ref(ref, sha1, 0, NULL, temp_dir)) {
 			free(ref);
 			return -1;
 		}
diff --git a/upload-pack.c b/upload-pack.c
index df15181..8f3c730 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -618,7 +618,7 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
-static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int send_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
@@ -646,7 +646,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
 	if (!o)
diff --git a/walker.c b/walker.c
index 11d9052..0b2aaf6 100644
--- a/walker.c
+++ b/walker.c
@@ -202,7 +202,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	return -1;
 }
 
-static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_complete(const char *path, const unsigned char *sha1, int flag, const char *symref, void *cb_data)
 {
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
