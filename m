Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D46720A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdJAWJC (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54144 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751980AbdJAWI4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:08:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 383F160DAE;
        Sun,  1 Oct 2017 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895734;
        bh=zOUYm7sBS+ixVdeFUN8phQ0uJZMn17egG7TGjeW44WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4PnWODwu4mDwF3s5kCajopbiHL73dLwQQJ9N8oJFYID/Thk+SXce7ZWa3xyihVxS
         Ed7lledvg2PVqvnJ8wAmiL2RF/+js5bLTaMVcRRp2GgsCatd3sKJWFkEFEs2y5kkme
         UFsbeQ60s/bzp/RFbhzJm3iFeF4kLo8USfoomrB0EKF3o3Ss402Idhm5A0oxnTPPcG
         0lLk+4NkE8MnRo1stch46Z3By/NSb4ka1DJm71r/Z0/q+QeIZIeHDt0sKQS+EPHtbS
         dxhchfXPi2e0M3mF8KrmGPmDXytKu3Z3FQWFjzS+U6eqVXaOqyRDEvSpOrWqU7Vf1M
         aY0E1I4xiKumMzjSa9D+UonirFWcipYokA/xv2Htp4mv3voIzL81R00+9/4Gx17t0+
         FmCapbnHB0mlDCCgOToLQiE6DZlmxnEaPE/99/Tbau6uYF/CHi0BX2Fq9mNvu5pUqK
         9AyIHj5mNeT4fJdFQphvm2g6vMV8F1Bg3qmACRJorlGJBa851CY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 09/24] refs: convert dwim_ref and expand_ref to struct object_id
Date:   Sun,  1 Oct 2017 22:08:16 +0000
Message-Id: <20171001220831.214705-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All of the callers of these functions just pass the hash member of a
struct object_id, so convert them to use a pointer to struct object_id
directly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c             |  2 +-
 branch.c              |  2 +-
 builtin/fast-export.c |  2 +-
 builtin/log.c         |  2 +-
 builtin/merge-base.c  |  2 +-
 builtin/merge.c       |  2 +-
 builtin/rev-parse.c   |  2 +-
 builtin/show-branch.c |  2 +-
 bundle.c              |  2 +-
 refs.c                | 14 +++++++-------
 refs.h                |  4 ++--
 remote.c              |  3 +--
 sha1_name.c           |  6 +++---
 upload-pack.c         |  2 +-
 wt-status.c           |  2 +-
 15 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/archive.c b/archive.c
index 1e41f4bbeb..0b7b62af0c 100644
--- a/archive.c
+++ b/archive.c
@@ -371,7 +371,7 @@ static void parse_treeish_arg(const char **argv,
 		const char *colon = strchrnul(name, ':');
 		int refnamelen = colon - name;
 
-		if (!dwim_ref(name, refnamelen, oid.hash, &ref))
+		if (!dwim_ref(name, refnamelen, &oid, &ref))
 			die("no such ref: %.*s", refnamelen, name);
 		free(ref);
 	}
diff --git a/branch.c b/branch.c
index 45029ea142..62f7b0d8c2 100644
--- a/branch.c
+++ b/branch.c
@@ -264,7 +264,7 @@ void create_branch(const char *name, const char *start_name,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), oid.hash, &real_ref)) {
+	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2fb60d6d48..d74c73f777 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -823,7 +823,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (e->flags & UNINTERESTING)
 			continue;
 
-		if (dwim_ref(e->name, strlen(e->name), oid.hash, &full_name) != 1)
+		if (dwim_ref(e->name, strlen(e->name), &oid, &full_name) != 1)
 			continue;
 
 		if (refspecs) {
diff --git a/builtin/log.c b/builtin/log.c
index d81a09051e..ba9d4cd786 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -975,7 +975,7 @@ static char *find_branch_name(struct rev_info *rev)
 		return NULL;
 	ref = rev->cmdline.rev[positive].name;
 	tip_oid = &rev->cmdline.rev[positive].item->oid;
-	if (dwim_ref(ref, strlen(ref), branch_oid.hash, &full_ref) &&
+	if (dwim_ref(ref, strlen(ref), &branch_oid, &full_ref) &&
 	    skip_prefix(full_ref, "refs/heads/", &v) &&
 	    !oidcmp(tip_oid, &branch_oid))
 		branch = xstrdup(v);
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6dbd167d3b..e99f5405ce 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -156,7 +156,7 @@ static int handle_fork_point(int argc, const char **argv)
 	struct commit_list *bases;
 	int i, ret = 0;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), oid.hash, &refname)) {
+	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
 	case 0:
 		die("No such ref: '%s'", argv[0]);
 	case 1:
diff --git a/builtin/merge.c b/builtin/merge.c
index 99d2df965f..6071dbfe34 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -454,7 +454,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die(_("'%s' does not point to a commit"), remote);
 
-	if (dwim_ref(remote, strlen(remote), branch_head.hash, &found_ref) > 0) {
+	if (dwim_ref(remote, strlen(remote), &branch_head, &found_ref) > 0) {
 		if (starts_with(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 				    oid_to_hex(&branch_head), remote);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index b9c13d3d9d..ad20a948f0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -133,7 +133,7 @@ static void show_rev(int type, const struct object_id *oid, const char *name)
 			struct object_id discard;
 			char *full;
 
-			switch (dwim_ref(name, strlen(name), discard.hash, &full)) {
+			switch (dwim_ref(name, strlen(name), &discard, &full)) {
 			case 0:
 				/*
 				 * Not found -- not a ref.  We could
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 0237be4975..722a7f4bec 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -720,7 +720,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			die(Q_("only %d entry can be shown at one time.",
 			       "only %d entries can be shown at one time.",
 			       MAX_REVS), MAX_REVS);
-		if (!dwim_ref(*av, strlen(*av), oid.hash, &ref))
+		if (!dwim_ref(*av, strlen(*av), &oid, &ref))
 			die(_("no such ref %s"), *av);
 
 		/* Has the base been specified? */
diff --git a/bundle.c b/bundle.c
index 12658c5c9f..93290962c9 100644
--- a/bundle.c
+++ b/bundle.c
@@ -338,7 +338,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), oid.hash, &ref) != 1)
+		if (dwim_ref(e->name, strlen(e->name), &oid, &ref) != 1)
 			goto skip_write_ref;
 		if (read_ref_full(e->name, RESOLVE_REF_READING, &oid, &flag))
 			flag = 0;
diff --git a/refs.c b/refs.c
index d6f8587b57..db683248c7 100644
--- a/refs.c
+++ b/refs.c
@@ -456,15 +456,15 @@ static char *substitute_branch_name(const char **string, int *len)
 	return NULL;
 }
 
-int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
+int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	int   refs_found  = expand_ref(str, len, sha1, ref);
+	int   refs_found  = expand_ref(str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
-int expand_ref(const char *str, int len, unsigned char *sha1, char **ref)
+int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
@@ -472,15 +472,15 @@ int expand_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 	*ref = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char sha1_from_ref[20];
-		unsigned char *this_result;
+		struct object_id oid_from_ref;
+		struct object_id *this_result;
 		int flag;
 
-		this_result = refs_found ? sha1_from_ref : sha1;
+		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
 		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
-				       this_result, &flag);
+				       this_result->hash, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
diff --git a/refs.h b/refs.h
index a2032b8397..832a77183c 100644
--- a/refs.h
+++ b/refs.h
@@ -139,8 +139,8 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
  */
 int refname_match(const char *abbrev_name, const char *full_name);
 
-int expand_ref(const char *str, int len, unsigned char *sha1, char **ref);
-int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
+int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
+int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 
 /*
diff --git a/remote.c b/remote.c
index 698a890a83..439d3b32f2 100644
--- a/remote.c
+++ b/remote.c
@@ -1628,8 +1628,7 @@ static void set_merge(struct branch *ret)
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
-			     oid.hash, &ref) == 1)
+		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]), &oid, &ref) == 1)
 			ret->merge[i]->dst = ref;
 		else
 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
diff --git a/sha1_name.c b/sha1_name.c
index 134ac9742f..28bad3e74b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -603,7 +603,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (len == GIT_SHA1_HEXSZ && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
-			refs_found = dwim_ref(str, len, tmp_oid.hash, &real_ref);
+			refs_found = dwim_ref(str, len, &tmp_oid, &real_ref);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
@@ -654,11 +654,11 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
-		refs_found = dwim_ref("HEAD", 4, oid->hash, &real_ref);
+		refs_found = dwim_ref("HEAD", 4, oid, &real_ref);
 	else if (reflog_len)
 		refs_found = dwim_log(str, len, oid->hash, &real_ref);
 	else
-		refs_found = dwim_ref(str, len, oid->hash, &real_ref);
+		refs_found = dwim_ref(str, len, oid, &real_ref);
 
 	if (!refs_found)
 		return -1;
diff --git a/upload-pack.c b/upload-pack.c
index e25f725c0f..030eba5a0c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -787,7 +787,7 @@ static void receive_needs(void)
 		if (skip_prefix(line, "deepen-not ", &arg)) {
 			char *ref = NULL;
 			struct object_id oid;
-			if (expand_ref(arg, strlen(arg), oid.hash, &ref) != 1)
+			if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
 				die("git upload-pack: ambiguous deepen-not: %s", line);
 			string_list_append(&deepen_not, ref);
 			free(ref);
diff --git a/wt-status.c b/wt-status.c
index 6d7d675a5b..280518a89b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1451,7 +1451,7 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 		return;
 	}
 
-	if (dwim_ref(cb.buf.buf, cb.buf.len, oid.hash, &ref) == 1 &&
+	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
 	    /* sha1 is a commit? match without further lookup */
 	    (!oidcmp(&cb.noid, &oid) ||
 	     /* perhaps sha1 is a tag, try to dereference to a commit */
-- 
2.14.2.822.g60be5d43e6

