From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 12/12] refs.c: fix handling of badly named refs
Date: Wed, 16 Jul 2014 15:23:12 -0700
Message-ID: <1405549392-27306-13-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:24:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XcS-0004X5-L2
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbaGPWXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:45 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:58605 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbaGPWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:17 -0400
Received: by mail-ig0-f201.google.com with SMTP id h3so174579igd.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8z/Mq60mEZtWGr+4A/T5PJNKyhnrEQxqurDGm08yJF0=;
        b=aW1wtFolwvtwBNnoJkcOfkrZryHyVli03o0jwadP9XCAu2pb5PZ2r4puIFDVbzmkK3
         DfGiJnEFDeY+mC6Lhpv9CvwDzFpK9q/EfR1zkX04RNgKgW270eX+5DT/dlLfML3Tt3/p
         zI/AJHDC8BdDk/rgBt7pGzv8/cGVuaLoX1aT0aLj7CdzrA1rZrFpuQqBpGys/9K5HIpx
         TcgJ8CHs/02xZQ16AjaWBx7drzAH+UPNYJLoGu/O84nYoSgIJ1aNNKUyf7n4JRrqgPmF
         eC+QDSCWxW89zWs9nhhtV6B+nPRD1I/jhdxFltbUMAwAVG/sq0LfuJ6REjBx/Oc4s51x
         nKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8z/Mq60mEZtWGr+4A/T5PJNKyhnrEQxqurDGm08yJF0=;
        b=ewCqerolT+T7iykSQy2AzyPkDQx0RA9bQkljXeOmoYclEqB+Acpmys7hvwjx8EaK0u
         IkJ1ziMc8BJcdM6KjEyk346x/R9NGN7ySzubMfX4kPmaBQ1P3V7dt5WZCIX8m0Firxgh
         ssjVIqDM/5bw9DWE7dJY23wFFQeIphstp2m8gCDsD95/SMtYz/HgXDD1Bdj0L93ryLis
         UY+aLsDv9krFaG552HZ83bTk1hjF2sqWAksrBWnITEl094NLCjSshdg+0pFosz5i93Fm
         Pew3TDIhzZ3LVV4w7Q6hfYeRr8Y4zm0E5X3TQZGs06AjmKgpujgGg1W5f0zrm8pVimbb
         gTnQ==
X-Gm-Message-State: ALoCoQka0RpS2C9aoEbQkasyMR/swFaEbjIrIQJLsjvYAKgnc1ejtJkaBZuNylxK8YnTAMlx6Ni9
X-Received: by 10.42.123.148 with SMTP id s20mr15772314icr.8.1405549396357;
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si73327yhh.5.2014.07.16.15.23.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1540C31C307;
	Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B8CC7E0F80; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253710>

We currently do not handle badly named refs well :
$ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
$ git branch
   fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
$ git branch -D master.....@\*@\\.
  error: branch 'master.....@*@\.' not found.

But we can not really recover from a badly named ref with less than
manually deleting the .git/refs/heads/<refname> file.

Change resolve_ref_unsafe to take a flags field instead of a 'reading'
boolean and update all callers that used a non-zero value for reading
to pass the flag RESOLVE_REF_READING instead.
Add another flag RESOLVE_REF_ALLOW_BAD_NAME that will make
resolve_ref_unsafe skip checking the refname for sanity and use this
from branch.c so that we will be able to call resolve_ref_unsafe on such
refs when trying to delete it.
Add checks for refname sanity when updating (not deleting) a ref in
ref_transaction_update and in ref_transaction_create to make the transaction
fail if an attempt is made to create/update a badly named ref.
Since all ref changes will later go through the transaction layer this means
we no longer need to check for and fail for bad refnames in
lock_ref_sha1_basic.

Change lock_ref_sha1_basic to not fail for bad refnames. Just check the
refname, and print an error, and remember that the refname is bad so that
we can skip calling verify_lock().

Allow reading refs with bad names from loose refs and packed refs
but flag them as broken. This means that the refs will at least show up in
git branch even if their name is invalid/broken.

Since we now do the refname checks, when we need to, before the call
to create_ref_entry we can remove the check_name argument to the function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/blame.c         |   2 +-
 builtin/branch.c        |   6 ++-
 builtin/clone.c         |   2 +-
 builtin/fmt-merge-msg.c |   2 +-
 builtin/for-each-ref.c  |   6 ++-
 builtin/log.c           |   3 +-
 builtin/remote.c        |   5 +-
 builtin/show-branch.c   |   6 ++-
 bundle.c                |   2 +-
 cache.h                 |  18 ++++---
 http-backend.c          |   3 +-
 reflog-walk.c           |   3 +-
 refs.c                  | 126 ++++++++++++++++++++++++++++++------------------
 remote.c                |   6 ++-
 sequencer.c             |   2 +-
 transport-helper.c      |   2 +-
 transport.c             |   5 +-
 17 files changed, 123 insertions(+), 76 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 662e3fe..76340e2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2278,7 +2278,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->object.type = OBJ_COMMIT;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+	if (!resolve_ref_unsafe("HEAD", head_sha1, RESOLVE_REF_READING, NULL))
 		die("no such ref: HEAD");
 
 	parent_tail = append_parent(parent_tail, head_sha1);
diff --git a/builtin/branch.c b/builtin/branch.c
index 652b1d2..5c95656 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -129,7 +129,8 @@ static int branch_merged(int kind, const char *name,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name = reference_name_to_free =
-		     resolve_refdup(branch->merge[0]->dst, sha1, 1, NULL)) != NULL)
+		     resolve_refdup(branch->merge[0]->dst, sha1,
+				    RESOLVE_REF_READING, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -233,7 +234,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, sha1, 0, &flags);
+		target = resolve_ref_unsafe(name, sha1,
+					    RESOLVE_REF_ALLOW_BAD_NAME, &flags);
 		if (!target ||
 		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
 			error(remote_branch
diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..f7307e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -622,7 +622,7 @@ static int checkout(void)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", sha1, 1, NULL);
+	head = resolve_refdup("HEAD", sha1, RESOLVE_REF_READING, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..d8ab177 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -602,7 +602,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", head_sha1, 1, NULL);
+		resolve_refdup("HEAD", head_sha1, RESOLVE_REF_READING, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4135980..a5833fd 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -649,7 +649,8 @@ static void populate_value(struct refinfo *ref)
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		ref->symref = resolve_refdup(ref->refname, unused1, 1, NULL);
+		ref->symref = resolve_refdup(ref->refname, unused1,
+					     RESOLVE_REF_READING, NULL);
 		if (!ref->symref)
 			ref->symref = "";
 	}
@@ -707,7 +708,8 @@ static void populate_value(struct refinfo *ref)
 			const char *head;
 			unsigned char sha1[20];
 
-			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			head = resolve_ref_unsafe("HEAD", sha1,
+						  RESOLVE_REF_READING, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
 			else
diff --git a/builtin/log.c b/builtin/log.c
index a7ba211..92db809 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1395,7 +1395,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (check_head) {
 			unsigned char sha1[20];
 			const char *ref;
-			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			ref = resolve_ref_unsafe("HEAD", sha1,
+						 RESOLVE_REF_READING, NULL);
 			if (ref && starts_with(ref, "refs/heads/"))
 				branch_name = xstrdup(ref + strlen("refs/heads/"));
 			else
diff --git a/builtin/remote.c b/builtin/remote.c
index 401feb3..be8ebac 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -568,7 +568,8 @@ static int read_remote_branches(const char *refname,
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
-		symref = resolve_ref_unsafe(refname, orig_sha1, 1, &flag);
+		symref = resolve_ref_unsafe(refname, orig_sha1,
+					    RESOLVE_REF_READING, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
@@ -704,7 +705,7 @@ static int mv(int argc, const char **argv)
 		int flag = 0;
 		unsigned char sha1[20];
 
-		read_ref_full(item->string, sha1, 1, &flag);
+		read_ref_full(item->string, sha1, RESOLVE_REF_READING, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d873172..a9a5eb3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -727,7 +727,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (ac == 0) {
 			static const char *fake_av[2];
 
-			fake_av[0] = resolve_refdup("HEAD", sha1, 1, NULL);
+			fake_av[0] = resolve_refdup("HEAD", sha1,
+						    RESOLVE_REF_READING, NULL);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -789,7 +790,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	head_p = resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
+	head_p = resolve_ref_unsafe("HEAD", head_sha1,
+				    RESOLVE_REF_READING, NULL);
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
diff --git a/bundle.c b/bundle.c
index 1222952..8aaf5f8 100644
--- a/bundle.c
+++ b/bundle.c
@@ -311,7 +311,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 			continue;
-		if (read_ref_full(e->name, sha1, 1, &flag))
+		if (read_ref_full(e->name, sha1, RESOLVE_REF_READING, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
diff --git a/cache.h b/cache.h
index 4ca4583..aab246d 100644
--- a/cache.h
+++ b/cache.h
@@ -948,7 +948,7 @@ extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref_full(const char *refname, unsigned char *sha1,
-			 int reading, int *flags);
+			 int flags, int *ref_flag);
 extern int read_ref(const char *refname, unsigned char *sha1);
 
 /*
@@ -960,17 +960,17 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * or the input ref.
  *
  * If the reference cannot be resolved to an object, the behavior
- * depends on the "reading" argument:
+ * depends on the RESOLVE_REF_READING flag:
  *
- * - If reading is set, return NULL.
+ * - If RESOLVE_REF_READING is set, return NULL.
  *
- * - If reading is not set, clear sha1 and return the name of the last
- *   reference name in the chain, which will either be a non-symbolic
+ * - If RESOLVE_REF_READING is not set, clear sha1 and return the name of
+ *   the last reference name in the chain, which will either be a non-symbolic
  *   reference or an undefined reference.  If this is a prelude to
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
- * If flag is non-NULL, set the value that it points to the
+ * If ref_flag is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
  * packed references) and REF_ISSYMREF (if the initial reference was a
  * symbolic reference).
@@ -981,8 +981,10 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  *
  * errno is set to something meaningful on error.
  */
-extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int reading, int *flag);
-extern char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag);
+#define RESOLVE_REF_READING        0x01
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x02
+extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int flags, int *ref_flag);
+extern char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag);
 
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
diff --git a/http-backend.c b/http-backend.c
index d2c0a62..059f790 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -417,7 +417,8 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 
 	if (flag & REF_ISSYMREF) {
 		unsigned char unused[20];
-		const char *target = resolve_ref_unsafe(refname, unused, 1, NULL);
+		const char *target = resolve_ref_unsafe(refname, unused,
+						RESOLVE_REF_READING, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
diff --git a/reflog-walk.c b/reflog-walk.c
index 9ce8b53..d80a42a 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -48,7 +48,8 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 		unsigned char sha1[20];
 		const char *name;
 		void *name_to_free;
-		name = name_to_free = resolve_refdup(ref, sha1, 1, NULL);
+		name = name_to_free = resolve_refdup(ref, sha1,
+						     RESOLVE_REF_READING, NULL);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
diff --git a/refs.c b/refs.c
index 6c7a9d2..6dcb920 100644
--- a/refs.c
+++ b/refs.c
@@ -281,15 +281,11 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 static struct ref_entry *create_ref_entry(const char *refname,
-					  const unsigned char *sha1, int flag,
-					  int check_name)
+					  const unsigned char *sha1, int flag)
 {
 	int len;
 	struct ref_entry *ref;
 
-	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -1062,7 +1058,12 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, REF_ISPACKED, 1);
+			int flag = REF_ISPACKED;
+
+			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT)) {
+				flag |= REF_ISBROKEN;
+			}
+			last = create_ref_entry(refname, sha1, flag);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -1135,8 +1136,10 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+		die("Reference has invalid format: '%s'", refname);
 	add_ref(get_packed_ref_dir(packed_ref_cache),
-		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+		create_ref_entry(refname, sha1, REF_ISPACKED));
 }
 
 /*
@@ -1194,12 +1197,17 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			} else if (read_ref_full(refname.buf, sha1, 1, &flag)) {
+			} else if (read_ref_full(refname.buf, sha1,
+						 RESOLVE_REF_READING, &flag)) {
+				hashclr(sha1);
+				flag |= REF_ISBROKEN;
+			}
+			if (check_refname_format(refname.buf, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag, 1));
+					 create_ref_entry(refname.buf, sha1, flag));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
@@ -1346,21 +1354,21 @@ static const char *handle_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
+const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
 
-	if (flag)
-		*flag = 0;
+	if (ref_flag)
+		*ref_flag = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+	if (!(flags & RESOLVE_REF_ALLOW_BAD_NAME) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		errno = EINVAL;
 		return NULL;
 	}
-
 	for (;;) {
 		char path[PATH_MAX];
 		struct stat st;
@@ -1387,7 +1395,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		if (lstat(path, &st) < 0) {
 			if (errno == ENOENT)
 				return handle_missing_loose_ref(refname, sha1,
-								reading, flag);
+						flags & RESOLVE_REF_READING,
+						ref_flag);
 			else
 				return NULL;
 		}
@@ -1407,8 +1416,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 					!check_refname_format(buffer, 0)) {
 				strcpy(refname_buffer, buffer);
 				refname = refname_buffer;
-				if (flag)
-					*flag |= REF_ISSYMREF;
+				if (ref_flag)
+					*ref_flag |= REF_ISSYMREF;
 				continue;
 			}
 		}
@@ -1453,21 +1462,21 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			 */
 			if (get_sha1_hex(buffer, sha1) ||
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
-				if (flag)
-					*flag |= REF_ISBROKEN;
+				if (ref_flag)
+					*ref_flag |= REF_ISBROKEN;
 				errno = EINVAL;
 				return NULL;
 			}
 			return refname;
 		}
-		if (flag)
-			*flag |= REF_ISSYMREF;
+		if (ref_flag)
+			*ref_flag |= REF_ISSYMREF;
 		buf = buffer + 4;
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flag)
-				*flag |= REF_ISBROKEN;
+			if (ref_flag)
+				*ref_flag |= REF_ISBROKEN;
 			errno = EINVAL;
 			return NULL;
 		}
@@ -1475,9 +1484,9 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	}
 }
 
-char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag)
+char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
 {
-	const char *ret = resolve_ref_unsafe(ref, sha1, reading, flag);
+	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
 	return ret ? xstrdup(ret) : NULL;
 }
 
@@ -1488,22 +1497,22 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, unsigned char *sha1, int reading, int *flags)
+int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
 {
-	if (resolve_ref_unsafe(refname, sha1, reading, flags))
+	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
 		return 0;
 	return -1;
 }
 
 int read_ref(const char *refname, unsigned char *sha1)
 {
-	return read_ref_full(refname, sha1, 1, NULL);
+	return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
 }
 
 int ref_exists(const char *refname)
 {
 	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, 1, NULL);
+	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
 }
 
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
@@ -1617,7 +1626,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return 0;
 	}
 
-	if (read_ref_full(refname, base, 1, &flag))
+	if (read_ref_full(refname, base, RESOLVE_REF_READING, &flag))
 		return -1;
 
 	/*
@@ -1783,7 +1792,7 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", sha1, 1, &flag))
+	if (!read_ref_full("HEAD", sha1, RESOLVE_REF_READING, &flag))
 		return fn("HEAD", sha1, flag, cb_data);
 
 	return 0;
@@ -1863,7 +1872,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, sha1, 1, &flag))
+	if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
 		ret = fn(buf.buf, sha1, flag, cb_data);
 	strbuf_release(&buf);
 
@@ -1958,7 +1967,8 @@ int refname_match(const char *abbrev_name, const char *full_name)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+	if (read_ref_full(lock->ref_name, lock->old_sha1,
+			  mustexist ? RESOLVE_REF_READING : 0, NULL)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
@@ -2031,7 +2041,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, this_result, 1, &flag);
+		r = resolve_ref_unsafe(fullref, this_result,
+				       RESOLVE_REF_READING, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -2060,7 +2071,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		const char *ref, *it;
 
 		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, hash, 1, NULL);
+		ref = resolve_ref_unsafe(path, hash, RESOLVE_REF_READING, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path))
@@ -2092,18 +2103,22 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int last_errno = 0;
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
+	int resolve_flags;
 	int missing = 0;
 	int attempts_remaining = 3;
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		errno = EINVAL;
-		return NULL;
-	}
+	int bad_refname;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	refname = resolve_ref_unsafe(refname, lock->old_sha1, mustexist, &type);
+	bad_refname = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
+
+	resolve_flags = RESOLVE_REF_ALLOW_BAD_NAME;
+	if (mustexist)
+		resolve_flags |= RESOLVE_REF_READING;
+
+	refname = resolve_ref_unsafe(refname, lock->old_sha1, resolve_flags,
+				     &type);
 	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -2116,7 +2131,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			error("there are still refs under '%s'", orig_refname);
 			goto error_return;
 		}
-		refname = resolve_ref_unsafe(orig_refname, lock->old_sha1, mustexist, &type);
+		refname = resolve_ref_unsafe(orig_refname, lock->old_sha1,
+					     resolve_flags, &type);
 	}
 	if (type_p)
 	    *type_p = type;
@@ -2180,6 +2196,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		else
 			unable_to_lock_index_die(ref_file, errno);
 	}
+	if (bad_refname)
+		return lock;
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
  error_return:
@@ -2343,8 +2361,9 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
 		hashcpy(packed_entry->u.value.sha1, entry->u.value.sha1);
 	} else {
-		packed_entry = create_ref_entry(entry->name, entry->u.value.sha1,
-						REF_ISPACKED | REF_KNOWS_PEELED, 0);
+		packed_entry = create_ref_entry(entry->name,
+					entry->u.value.sha1,
+					REF_ISPACKED | REF_KNOWS_PEELED);
 		add_ref(cb->packed_refs, packed_entry);
 	}
 	hashcpy(packed_entry->u.value.peeled, entry->u.value.peeled);
@@ -2658,7 +2677,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, orig_sha1,
+				    RESOLVE_REF_READING, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2682,7 +2702,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
+	if (!read_ref_full(newrefname, sha1, RESOLVE_REF_READING, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
@@ -2960,7 +2980,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
-		head_ref = resolve_ref_unsafe("HEAD", head_sha1, 1, &head_flag);
+		head_ref = resolve_ref_unsafe("HEAD", head_sha1,
+					      RESOLVE_REF_READING, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -3446,6 +3467,12 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (!is_null_sha1(new_sha1) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(err, "Bad refname: %s", refname);
+		return -1;
+	}
+
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
@@ -3471,6 +3498,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(err, "Bad refname: %s", refname);
+		return -1;
+	}
+
 	update = add_update(transaction, refname);
 
 	hashcpy(update->new_sha1, new_sha1);
diff --git a/remote.c b/remote.c
index ae04043..de84ac3 100644
--- a/remote.c
+++ b/remote.c
@@ -1121,7 +1121,8 @@ static char *guess_ref(const char *name, struct ref *peer)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	const char *r = resolve_ref_unsafe(peer->name, sha1, 1, NULL);
+	const char *r = resolve_ref_unsafe(peer->name, sha1,
+					   RESOLVE_REF_READING, NULL);
 	if (!r)
 		return NULL;
 
@@ -1182,7 +1183,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		unsigned char sha1[20];
 		int flag;
 
-		dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
+		dst_value = resolve_ref_unsafe(matched_src->name, sha1,
+					       RESOLVE_REF_READING, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
diff --git a/sequencer.c b/sequencer.c
index 284059b..e1419bf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -365,7 +365,7 @@ static int is_index_unchanged(void)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+	if (!resolve_ref_unsafe("HEAD", head_sha1, RESOLVE_REF_READING, NULL))
 		return error(_("Could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(head_sha1);
diff --git a/transport-helper.c b/transport-helper.c
index 84c616f..270ae28 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -889,7 +889,7 @@ static int push_refs_with_export(struct transport *transport,
 					int flag;
 
 					/* Follow symbolic refs (mainly for HEAD). */
-					name = resolve_ref_unsafe(ref->peer_ref->name, sha1, 1, &flag);
+					name = resolve_ref_unsafe(ref->peer_ref->name, sha1, RESOLVE_REF_READING, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
diff --git a/transport.c b/transport.c
index 325f03e..f40e950 100644
--- a/transport.c
+++ b/transport.c
@@ -168,7 +168,8 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
-		tmp = resolve_ref_unsafe(localname, sha, 1, &flag);
+		tmp = resolve_ref_unsafe(localname, sha,
+					 RESOLVE_REF_READING, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
 			localname = tmp;
@@ -753,7 +754,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	unsigned char head_sha1[20];
 	char *head;
 
-	head = resolve_refdup("HEAD", head_sha1, 1, NULL);
+	head = resolve_refdup("HEAD", head_sha1, RESOLVE_REF_READING, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
-- 
2.0.1.527.gc6b782e
