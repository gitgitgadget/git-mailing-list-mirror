Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DE21F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 18:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503999AbfJXSHM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 14:07:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2503966AbfJXSHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 14:07:12 -0400
Received: (qmail 17591 invoked by uid 109); 24 Oct 2019 18:07:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 18:07:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3444 invoked by uid 111); 24 Oct 2019 18:10:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 14:10:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 14:07:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/23] fsck: unify object-name code
Message-ID: <20191024180710.GC12892@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
 <20191018045613.GI17879@sigill.intra.peff.net>
 <xmqq8spafzjt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8spafzjt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 03:05:58PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +/*
> > + * Subsystem for storing human-readable names for each object.
> > + *
> > + * If fsck_enable_object_names() has not been called, all other functions are
> > + * noops.
> 
> I think it is clear from the context that put_ and get_ we see below
> refer to functions whose true names have fsck_ prefix, but the fact
> that this one has fsck_ spelled out disrupts that context.
> 
> IOW, s/fsck_// for consistency, perhaps.

Heh. I originally wrote just "put" and "get" for brevity, but then
worried that wasn't clear enough. Let's just use the full names. We can
afford the extra few bytes, and it makes it easier if we later need to
grep for them or whatever. Here's a replacement patch (I won't send the
whole series just yet, as it seems it hasn't gotten a whole lot of
review so far).

-- >8 --
Subject: [PATCH] fsck: unify object-name code

Commit 90cf590f53 (fsck: optionally show more helpful info for broken
links, 2016-07-17) added a system for decorating objects with names. The
code is split across builtin/fsck.c (which gives the initial names) and
fsck.c (which adds to the names as it traverses the object graph). This
leads to some duplication, where both sites have near-identical
describe_object() functions (the difference being that the one in
builtin/fsck.c uses a circular array of buffers to allow multiple calls
in a single printf).

Let's provide a unified object_name API for fsck. That lets us drop the
duplication, as well as making the interface boundaries more clear
(which will let us refactor the implementation more in a future patch).

We'll leave describe_object() in builtin/fsck.c as a thin wrapper around
the new API, as it relies on a static global to make its many callers a
bit shorter.

We'll also convert the bare add_decoration() calls in builtin/fsck.c to
put_object_name(). This fixes two minor bugs:

  1. We leak many small strings. add_decoration() has a last-one-wins
     approach: it updates the decoration to the new string and returns
     the old one. But we ignore the return value, leaking the old
     string. This is quite common to trigger, since we look at reflogs:
     the tip of any ref will be described both by looking at the actual
     ref, as well as the latest reflog entry. So we'd always end up
     leaking one of those strings.

  2. The last-one-wins approach gives us lousy names. For instance, we
     first look at all of the refs, and then all of the reflogs. So
     rather than seeing "refs/heads/master", we're likely to overwrite
     it with "HEAD@{12345678}". We're generally better off using the
     first name we find.

     And indeed, the test in t1450 expects this ugly HEAD@{} name. After
     this patch, we've switched to using fsck_put_object_name()'s
     first-one-wins semantics, and we output the more human-friendly
     "refs/tags/julius" (and the test is updated accordingly).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  | 50 ++++++++----------------------
 fsck.c          | 82 ++++++++++++++++++++++++++++++-------------------
 fsck.h          | 24 +++++++++++++++
 t/t1450-fsck.sh |  2 +-
 4 files changed, 89 insertions(+), 69 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 18403a94fa..237643cc1d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -52,24 +52,7 @@ static int name_objects;
 
 static const char *describe_object(struct object *obj)
 {
-	static struct strbuf bufs[] = {
-		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
-	};
-	static int b = 0;
-	struct strbuf *buf;
-	char *name = NULL;
-
-	if (name_objects)
-		name = lookup_decoration(fsck_walk_options.object_names, obj);
-
-	buf = bufs + b;
-	b = (b + 1) % ARRAY_SIZE(bufs);
-	strbuf_reset(buf);
-	strbuf_addstr(buf, oid_to_hex(&obj->oid));
-	if (name)
-		strbuf_addf(buf, " (%s)", name);
-
-	return buf->buf;
+	return fsck_describe_object(&fsck_walk_options, obj);
 }
 
 static const char *printable_type(struct object *obj)
@@ -499,10 +482,10 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 	if (!is_null_oid(oid)) {
 		obj = lookup_object(the_repository, oid);
 		if (obj && (obj->flags & HAS_OBJ)) {
-			if (timestamp && name_objects)
-				add_decoration(fsck_walk_options.object_names,
-					obj,
-					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
+			if (timestamp)
+				fsck_put_object_name(&fsck_walk_options, obj,
+						     "%s@{%"PRItime"}",
+						     refname, timestamp);
 			obj->flags |= USED;
 			mark_object_reachable(obj);
 		} else if (!is_promisor_object(oid)) {
@@ -566,9 +549,8 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	}
 	default_refs++;
 	obj->flags |= USED;
-	if (name_objects)
-		add_decoration(fsck_walk_options.object_names,
-			obj, xstrdup(refname));
+	fsck_put_object_name(&fsck_walk_options,
+			     obj, "%s", refname);
 	mark_object_reachable(obj);
 
 	return 0;
@@ -742,9 +724,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 			return 1;
 		}
 		obj->flags |= USED;
-		if (name_objects)
-			add_decoration(fsck_walk_options.object_names,
-				obj, xstrdup(":"));
+		fsck_put_object_name(&fsck_walk_options, obj, ":");
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
 			err |= objerror(obj, _("non-tree in cache-tree"));
@@ -830,8 +810,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	if (name_objects)
-		fsck_walk_options.object_names =
-			xcalloc(1, sizeof(struct decoration));
+		fsck_enable_object_names(&fsck_walk_options);
 
 	git_config(fsck_config, NULL);
 
@@ -890,9 +869,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			}
 
 			obj->flags |= USED;
-			if (name_objects)
-				add_decoration(fsck_walk_options.object_names,
-					obj, xstrdup(arg));
+			fsck_put_object_name(&fsck_walk_options, obj,
+					     "%s", arg);
 			mark_object_reachable(obj);
 			continue;
 		}
@@ -928,10 +906,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				continue;
 			obj = &blob->object;
 			obj->flags |= USED;
-			if (name_objects)
-				add_decoration(fsck_walk_options.object_names,
-					obj,
-					xstrfmt(":%s", active_cache[i]->name));
+			fsck_put_object_name(&fsck_walk_options, obj,
+					     ":%s", active_cache[i]->name);
 			mark_object_reachable(obj);
 		}
 		if (active_cache_tree)
diff --git a/fsck.c b/fsck.c
index 347a0ef5c9..ecd5957362 100644
--- a/fsck.c
+++ b/fsck.c
@@ -312,15 +312,21 @@ static int report(struct fsck_options *options, struct object *object,
 	return result;
 }
 
-static char *get_object_name(struct fsck_options *options, struct object *obj)
+void fsck_enable_object_names(struct fsck_options *options)
+{
+	if (!options->object_names)
+		options->object_names = xcalloc(1, sizeof(struct decoration));
+}
+
+const char *fsck_get_object_name(struct fsck_options *options, struct object *obj)
 {
 	if (!options->object_names)
 		return NULL;
 	return lookup_decoration(options->object_names, obj);
 }
 
-static void put_object_name(struct fsck_options *options, struct object *obj,
-	const char *fmt, ...)
+void fsck_put_object_name(struct fsck_options *options, struct object *obj,
+			  const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf buf = STRBUF_INIT;
@@ -337,17 +343,27 @@ static void put_object_name(struct fsck_options *options, struct object *obj,
 	va_end(ap);
 }
 
-static const char *describe_object(struct fsck_options *o, struct object *obj)
+const char *fsck_describe_object(struct fsck_options *options,
+				 struct object *obj)
 {
-	static struct strbuf buf = STRBUF_INIT;
-	char *name;
-
-	strbuf_reset(&buf);
-	strbuf_addstr(&buf, oid_to_hex(&obj->oid));
-	if (o->object_names && (name = lookup_decoration(o->object_names, obj)))
-		strbuf_addf(&buf, " (%s)", name);
+	static struct strbuf bufs[] = {
+		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
+	};
+	static int b = 0;
+	struct strbuf *buf;
+	char *name = NULL;
+
+	if (options->object_names)
+		name = lookup_decoration(options->object_names, obj);
+
+	buf = bufs + b;
+	b = (b + 1) % ARRAY_SIZE(bufs);
+	strbuf_reset(buf);
+	strbuf_addstr(buf, oid_to_hex(&obj->oid));
+	if (name)
+		strbuf_addf(buf, " (%s)", name);
 
-	return buf.buf;
+	return buf->buf;
 }
 
 static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
@@ -360,7 +376,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 	if (parse_tree(tree))
 		return -1;
 
-	name = get_object_name(options, &tree->object);
+	name = fsck_get_object_name(options, &tree->object);
 	if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
 		return -1;
 	while (tree_entry_gently(&desc, &entry)) {
@@ -373,20 +389,21 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		if (S_ISDIR(entry.mode)) {
 			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
 			if (name && obj)
-				put_object_name(options, obj, "%s%s/", name,
-					entry.path);
+				fsck_put_object_name(options, obj, "%s%s/",
+						     name, entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
 			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
-				put_object_name(options, obj, "%s%s", name,
-					entry.path);
+				fsck_put_object_name(options, obj, "%s%s",
+						     name, entry.path);
 			result = options->walk(obj, OBJ_BLOB, data, options);
 		}
 		else {
 			result = error("in tree %s: entry %s has bad mode %.6o",
-					describe_object(options, &tree->object), entry.path, entry.mode);
+				       fsck_describe_object(options, &tree->object),
+				       entry.path, entry.mode);
 		}
 		if (result < 0)
 			return result;
@@ -407,10 +424,10 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	if (parse_commit(commit))
 		return -1;
 
-	name = get_object_name(options, &commit->object);
+	name = fsck_get_object_name(options, &commit->object);
 	if (name)
-		put_object_name(options, &get_commit_tree(commit)->object,
-				"%s:", name);
+		fsck_put_object_name(options, &get_commit_tree(commit)->object,
+				     "%s:", name);
 
 	result = options->walk((struct object *)get_commit_tree(commit),
 			       OBJ_TREE, data, options);
@@ -441,13 +458,15 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 			struct object *obj = &parents->item->object;
 
 			if (counter++)
-				put_object_name(options, obj, "%s^%d",
-					name, counter);
+				fsck_put_object_name(options, obj, "%s^%d",
+						     name, counter);
 			else if (generation > 0)
-				put_object_name(options, obj, "%.*s~%d",
-					name_prefix_len, name, generation + 1);
+				fsck_put_object_name(options, obj, "%.*s~%d",
+						     name_prefix_len, name,
+						     generation + 1);
 			else
-				put_object_name(options, obj, "%s^", name);
+				fsck_put_object_name(options, obj, "%s^",
+						     name);
 		}
 		result = options->walk((struct object *)parents->item, OBJ_COMMIT, data, options);
 		if (result < 0)
@@ -461,12 +480,12 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 
 static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *options)
 {
-	char *name = get_object_name(options, &tag->object);
+	const char *name = fsck_get_object_name(options, &tag->object);
 
 	if (parse_tag(tag))
 		return -1;
 	if (name)
-		put_object_name(options, tag->tagged, "%s", name);
+		fsck_put_object_name(options, tag->tagged, "%s", name);
 	return options->walk(tag->tagged, OBJ_ANY, data, options);
 }
 
@@ -488,7 +507,8 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 	case OBJ_TAG:
 		return fsck_walk_tag((struct tag *)obj, data, options);
 	default:
-		error("Unknown object type for %s", describe_object(options, obj));
+		error("Unknown object type for %s",
+		      fsck_describe_object(options, obj));
 		return -1;
 	}
 }
@@ -962,10 +982,10 @@ int fsck_error_function(struct fsck_options *o,
 	struct object *obj, int msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", describe_object(o, obj), message);
+		warning("object %s: %s", fsck_describe_object(o, obj), message);
 		return 0;
 	}
-	error("object %s: %s", describe_object(o, obj), message);
+	error("object %s: %s", fsck_describe_object(o, obj), message);
 	return 1;
 }
 
diff --git a/fsck.h b/fsck.h
index e479461075..f6f0c40060 100644
--- a/fsck.h
+++ b/fsck.h
@@ -67,4 +67,28 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Subsystem for storing human-readable names for each object.
+ *
+ * If fsck_enable_object_names() has not been called, all other functions are
+ * noops.
+ *
+ * Use put_object_name() to seed initial names (e.g. from refnames); the fsck
+ * code will extend that while walking trees, etc.
+ *
+ * Use get_object_name() to get a single name (or NULL if none). Or the more
+ * convenient describe_object(), which always produces an output string with
+ * the oid combined with the name (if any). Note that the return value points
+ * to a rotating array of static buffers, and may be invalidated by a
+ * subsequent call.
+ */
+void fsck_enable_object_names(struct fsck_options *options);
+const char *fsck_get_object_name(struct fsck_options *options,
+				 struct object *obj);
+__attribute__((format (printf,3,4)))
+void fsck_put_object_name(struct fsck_options *options, struct object *obj,
+			  const char *fmt, ...);
+const char *fsck_describe_object(struct fsck_options *options,
+				 struct object *obj);
+
 #endif
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 50d28e6fdb..7c7ff7e961 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -616,7 +616,7 @@ test_expect_success 'fsck --name-objects' '
 		remove_object $(git rev-parse julius:caesar.t) &&
 		test_must_fail git fsck --name-objects >out &&
 		tree=$(git rev-parse --verify julius:) &&
-		test_i18ngrep -E "$tree \((refs/heads/master|HEAD)@\{[0-9]*\}:" out
+		test_i18ngrep "$tree (refs/tags/julius:" out
 	)
 '
 
-- 
2.24.0.rc1.670.g28e7e9fef7

