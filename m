Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA653201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 12:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbdB1MQ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 07:16:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:35533 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752160AbdB1MQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 07:16:26 -0500
Received: (qmail 22536 invoked by uid 109); 28 Feb 2017 12:14:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:14:37 +0000
Received: (qmail 25372 invoked by uid 111); 28 Feb 2017 12:14:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:14:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:14:35 -0500
Date:   Tue, 28 Feb 2017 07:14:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH 4/8] interpret_branch_name: allow callers to restrict
 expansions
Message-ID: <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net>
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original purpose of interpret_branch_name() was to be
used by get_sha1() in resolving refs. As such, some of its
expansions may point to refs outside of the local
"refs/heads" namespace.

Over time, the function has been picked up by other callers
who want to use the ref-expansion to give the user access to
the same shortcuts (e.g., allowing "git branch" to delete
via "@{-1}" or "@{upstream}").  These uses have confusing
corner cases when the expansion isn't in refs/heads/ (for
instance, deleting "@" tries to delete refs/heads/HEAD,
which is nonsense).

Callers can't know from the returned string how the
expansion happened (e.g., did the user really ask for a
branch named "HEAD", or did we do a bogus expansion?). One
fix would be to return some out-parameters describing the
types of expansion that occurred. This has the benefit that
the caller can generate precise error messages ("I
understood @{upstream} to mean origin/master, but that is a
remote tracking branch, so you cannot create it as a local
name").

However, out-parameters make calling interface somewhat
cumbersome. Instead, let's do the opposite: let the caller
tell us which elements to expand. That's easier to pass in,
and none of the callers give more precise error messages
than "@{upstream} isn't a valid branch name" anyway (which
should be sufficient).

The strbuf_branchname() function needs a similar parameter,
as most of the callers access interpret_branch_name()
through it. For now, we'll pass "0" for "no restrictions" in
each caller, and update them individually in subsequent
patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c   |  2 +-
 builtin/checkout.c |  2 +-
 builtin/merge.c    |  2 +-
 cache.h            | 13 +++++++++++--
 refs.c             |  2 +-
 revision.c         |  2 +-
 sha1_name.c        | 52 +++++++++++++++++++++++++++++++++++++++-------------
 strbuf.h           |  6 +++++-
 8 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 94f7de7fa..cf0ece55d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -216,7 +216,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		char *target = NULL;
 		int flags = 0;
 
-		strbuf_branchname(&bname, argv[i]);
+		strbuf_branchname(&bname, argv[i], 0);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f174f5030..05eefd994 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -452,7 +452,7 @@ static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_branchname(&buf, branch->name);
+	strbuf_branchname(&buf, branch->name, 0);
 	if (strcmp(buf.buf, branch->name))
 		branch->name = xstrdup(buf.buf);
 	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
diff --git a/builtin/merge.c b/builtin/merge.c
index a96d4fb50..848a29855 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -438,7 +438,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	char *found_ref;
 	int len, early;
 
-	strbuf_branchname(&bname, remote);
+	strbuf_branchname(&bname, remote, 0);
 	remote = bname.buf;
 
 	memset(branch_head, 0, sizeof(branch_head));
diff --git a/cache.h b/cache.h
index c67995caa..a8816c914 100644
--- a/cache.h
+++ b/cache.h
@@ -1383,8 +1383,17 @@ extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as s
  *
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
- */
-extern int interpret_branch_name(const char *str, int len, struct strbuf *);
+ *
+ * If "allowed" is non-zero, it is a treated as a bitfield of allowable
+ * expansions: local branches ("refs/heads/"), remote branches
+ * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
+ * allowed, even ones to refs outside of those namespaces.
+ */
+#define INTERPRET_BRANCH_LOCAL (1<<0)
+#define INTERPRET_BRANCH_REMOTE (1<<1)
+#define INTERPRET_BRANCH_HEAD (1<<2)
+extern int interpret_branch_name(const char *str, int len, struct strbuf *,
+				 unsigned allowed);
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index 6d0961921..da62119c2 100644
--- a/refs.c
+++ b/refs.c
@@ -405,7 +405,7 @@ int refname_match(const char *abbrev_name, const char *full_name)
 static char *substitute_branch_name(const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, *len, &buf);
+	int ret = interpret_branch_name(*string, *len, &buf, 0);
 
 	if (ret == *len) {
 		size_t size;
diff --git a/revision.c b/revision.c
index b37dbec37..771d079f6 100644
--- a/revision.c
+++ b/revision.c
@@ -147,7 +147,7 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
-		int len = interpret_branch_name(name, 0, &buf);
+		int len = interpret_branch_name(name, 0, &buf, 0);
 		int st;
 
 		if (0 < len && name[len] && buf.len)
diff --git a/sha1_name.c b/sha1_name.c
index 4c1e91184..b21997c29 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1176,7 +1176,8 @@ static int interpret_empty_at(const char *name, int namelen, int len, struct str
 	return 1;
 }
 
-static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
+static int reinterpret(const char *name, int namelen, int len,
+		       struct strbuf *buf, unsigned allowed)
 {
 	/* we have extra data, which might need further processing */
 	struct strbuf tmp = STRBUF_INIT;
@@ -1184,7 +1185,7 @@ static int reinterpret(const char *name, int namelen, int len, struct strbuf *bu
 	int ret;
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = interpret_branch_name(buf->buf, buf->len, &tmp);
+	ret = interpret_branch_name(buf->buf, buf->len, &tmp, allowed);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1205,11 +1206,27 @@ static void set_shortened_ref(struct strbuf *buf, const char *ref)
 	free(s);
 }
 
+static int branch_interpret_allowed(const char *refname, unsigned allowed)
+{
+	if (!allowed)
+		return 1;
+
+	if ((allowed & INTERPRET_BRANCH_LOCAL) &&
+	    starts_with(refname, "refs/heads/"))
+		return 1;
+	if ((allowed & INTERPRET_BRANCH_REMOTE) &&
+	    starts_with(refname, "refs/remotes/"))
+		return 1;
+
+	return 0;
+}
+
 static int interpret_branch_mark(const char *name, int namelen,
 				 int at, struct strbuf *buf,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
-							 struct strbuf *))
+							 struct strbuf *),
+				 unsigned allowed)
 {
 	int len;
 	struct branch *branch;
@@ -1234,11 +1251,15 @@ static int interpret_branch_mark(const char *name, int namelen,
 	if (!value)
 		die("%s", err.buf);
 
+	if (!branch_interpret_allowed(value, allowed))
+		return -1;
+
 	set_shortened_ref(buf, value);
 	return len + at;
 }
 
-int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
+int interpret_branch_name(const char *name, int namelen, struct strbuf *buf,
+			  unsigned allowed)
 {
 	char *at;
 	const char *start;
@@ -1254,24 +1275,29 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 		if (len == namelen)
 			return len; /* consumed all */
 		else
-			return reinterpret(name, namelen, len, buf);
+			return reinterpret(name, namelen, len, buf, allowed);
 	}
 
 	for (start = name;
 	     (at = memchr(start, '@', namelen - (start - name)));
 	     start = at + 1) {
 
-		len = interpret_empty_at(name, namelen, at - name, buf);
-		if (len > 0)
-			return reinterpret(name, namelen, len, buf);
+		if (!allowed || (allowed & INTERPRET_BRANCH_HEAD)) {
+			len = interpret_empty_at(name, namelen, at - name, buf);
+			if (len > 0)
+				return reinterpret(name, namelen, len, buf,
+						   allowed);
+		}
 
 		len = interpret_branch_mark(name, namelen, at - name, buf,
-					    upstream_mark, branch_get_upstream);
+					    upstream_mark, branch_get_upstream,
+					    allowed);
 		if (len > 0)
 			return len;
 
 		len = interpret_branch_mark(name, namelen, at - name, buf,
-					    push_mark, branch_get_push);
+					    push_mark, branch_get_push,
+					    allowed);
 		if (len > 0)
 			return len;
 	}
@@ -1279,10 +1305,10 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 	return -1;
 }
 
-void strbuf_branchname(struct strbuf *sb, const char *name)
+void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 {
 	int len = strlen(name);
-	int used = interpret_branch_name(name, len, sb);
+	int used = interpret_branch_name(name, len, sb, allowed);
 
 	if (used < 0)
 		used = 0;
@@ -1291,7 +1317,7 @@ void strbuf_branchname(struct strbuf *sb, const char *name)
 
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
-	strbuf_branchname(sb, name);
+	strbuf_branchname(sb, name, 0);
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
diff --git a/strbuf.h b/strbuf.h
index 6b51b2604..17e5f29a5 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -567,8 +567,12 @@ static inline void strbuf_complete_line(struct strbuf *sb)
  * "refs/remotes/origin/master").
  *
  * Note that the resulting name may not be a syntactically valid refname.
+ *
+ * If "allowed" is non-zero, restrict the set of allowed expansions. See
+ * interpret_branch_name() for details.
  */
-extern void strbuf_branchname(struct strbuf *sb, const char *name);
+extern void strbuf_branchname(struct strbuf *sb, const char *name,
+			      unsigned allowed);
 
 /*
  * Like strbuf_branchname() above, but confirm that the result is
-- 
2.12.0.359.gd4c8c42e9

