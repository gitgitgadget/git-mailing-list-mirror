From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] remote prune: warn dangling symrefs
Date: Mon,  9 Feb 2009 01:09:23 -0800
Message-ID: <1234170565-6740-5-git-send-email-gitster@pobox.com>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com>
 <1234170565-6740-2-git-send-email-gitster@pobox.com>
 <1234170565-6740-3-git-send-email-gitster@pobox.com>
 <1234170565-6740-4-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 10:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSAu-0004Zb-H4
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbZBIJJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbZBIJJm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:09:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60486 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbZBIJJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:09:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E25092ABFD
	for <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB89E2ABE6 for
 <git@vger.kernel.org>; Mon,  9 Feb 2009 04:09:36 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc0.28.g2593d
In-Reply-To: <1234170565-6740-4-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 60643DA8-F689-11DD-830D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109054>

If you prune from the remote "frotz" that deleted the ref your tracking
branch remotes/frotz/HEAD points at, the symbolic ref will become
dangling.  We used to detect this as an error condition and issued a
message every time refs are enumerated.

This stops the error message, but moves the warning to "remote prune".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-remote.c |    6 ++++
 refs.c           |   72 ++++++++++++++++++++++++++++++++++++++++-------------
 refs.h           |    5 +++
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index db18bcf..ac69d37 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -756,12 +756,17 @@ static int prune(int argc, const char **argv)
 		OPT_END()
 	};
 	struct ref_states states;
+	const char *dangling_msg;
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
 	if (argc < 1)
 		usage_with_options(builtin_remote_usage, options);
 
+	dangling_msg = (dry_run
+			? " %s will become dangling!\n"
+			: " %s has become dangling!\n");
+
 	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
 		int i;
@@ -784,6 +789,7 @@ static int prune(int argc, const char **argv)
 
 			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
 			       abbrev_ref(refname, "refs/remotes/"));
+			warn_dangling_symref(dangling_msg, refname);
 		}
 
 		/* NEEDSWORK: free remote */
diff --git a/refs.c b/refs.c
index 024211d..6eb5f53 100644
--- a/refs.c
+++ b/refs.c
@@ -275,10 +275,8 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 				list = get_ref_dir(ref, list);
 				continue;
 			}
-			if (!resolve_ref(ref, sha1, 1, &flag)) {
-				error("%s points nowhere!", ref);
-				continue;
-			}
+			if (!resolve_ref(ref, sha1, 1, &flag))
+				hashclr(sha1);
 			list = add_ref(ref, sha1, flag, list, NULL);
 		}
 		free(ref);
@@ -287,6 +285,35 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 	return sort_ref_list(list);
 }
 
+struct warn_if_dangling_data {
+	const char *refname;
+	const char *msg_fmt;
+};
+
+static int warn_if_dangling_symref(const char *refname, const unsigned char *sha1,
+				   int flags, void *cb_data)
+{
+	struct warn_if_dangling_data *d = cb_data;
+	const char *resolves_to;
+	unsigned char junk[20];
+
+	if (!(flags & REF_ISSYMREF))
+		return 0;
+
+	resolves_to = resolve_ref(refname, junk, 0, NULL);
+	if (!resolves_to || strcmp(resolves_to, d->refname))
+		return 0;
+
+	printf(d->msg_fmt, refname);
+	return 0;
+}
+
+void warn_dangling_symref(const char *msg_fmt, const char *refname)
+{
+	struct warn_if_dangling_data data = { refname, msg_fmt };
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
+
 static struct ref_list *get_loose_refs(void)
 {
 	if (!cached_refs.did_loose) {
@@ -498,16 +525,19 @@ int read_ref(const char *ref, unsigned char *sha1)
 	return -1;
 }
 
+#define DO_FOR_EACH_INCLUDE_BROKEN 01
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
-		      void *cb_data, struct ref_list *entry)
+		      int flags, void *cb_data, struct ref_list *entry)
 {
 	if (strncmp(base, entry->name, trim))
 		return 0;
-	if (is_null_sha1(entry->sha1))
-		return 0;
-	if (!has_sha1_file(entry->sha1)) {
-		error("%s does not point to a valid object!", entry->name);
-		return 0;
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
+		if (is_null_sha1(entry->sha1))
+			return 0;
+		if (!has_sha1_file(entry->sha1)) {
+			error("%s does not point to a valid object!", entry->name);
+			return 0;
+		}
 	}
 	current_ref = entry;
 	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
@@ -561,7 +591,7 @@ fallback:
 }
 
 static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
-			   void *cb_data)
+			   int flags, void *cb_data)
 {
 	int retval = 0;
 	struct ref_list *packed = get_packed_refs();
@@ -570,7 +600,7 @@ static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 	struct ref_list *extra;
 
 	for (extra = extra_refs; extra; extra = extra->next)
-		retval = do_one_ref(base, fn, trim, cb_data, extra);
+		retval = do_one_ref(base, fn, trim, flags, cb_data, extra);
 
 	while (packed && loose) {
 		struct ref_list *entry;
@@ -586,13 +616,13 @@ static int do_for_each_ref(const char *base, each_ref_fn fn, int trim,
 			entry = packed;
 			packed = packed->next;
 		}
-		retval = do_one_ref(base, fn, trim, cb_data, entry);
+		retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
 		if (retval)
 			goto end_each;
 	}
 
 	for (packed = packed ? packed : loose; packed; packed = packed->next) {
-		retval = do_one_ref(base, fn, trim, cb_data, packed);
+		retval = do_one_ref(base, fn, trim, flags, cb_data, packed);
 		if (retval)
 			goto end_each;
 	}
@@ -614,22 +644,28 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0, cb_data);
+	return do_for_each_ref("refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
+	return do_for_each_ref("refs/tags/", fn, 10, 0, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
+	return do_for_each_ref("refs/heads/", fn, 11, 0, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
+	return do_for_each_ref("refs/remotes/", fn, 13, 0, cb_data);
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/", fn, 0,
+			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
 /*
diff --git a/refs.h b/refs.h
index 3bb529d..29bdcec 100644
--- a/refs.h
+++ b/refs.h
@@ -24,6 +24,11 @@ extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
 
+/* can be used to learn about broken ref and symref */
+extern int for_each_rawref(each_ref_fn, void *);
+
+extern void warn_dangling_symref(const char *msg_fmt, const char *refname);
+
 /*
  * Extra refs will be listed by for_each_ref() before any actual refs
  * for the duration of this process or until clear_extra_refs() is
-- 
1.6.2.rc0.28.g2593d
