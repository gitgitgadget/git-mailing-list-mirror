From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] use xstrdup_or_null to replace ternary conditionals
Date: Mon, 12 Jan 2015 20:59:09 -0500
Message-ID: <20150113015909.GD18986@peff.net>
References: <20150113015427.GA5497@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqlG-0005RH-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbbAMB7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:59:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:33610 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752158AbbAMB7K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:59:10 -0500
Received: (qmail 19267 invoked by uid 102); 13 Jan 2015 01:59:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 19:59:10 -0600
Received: (qmail 22724 invoked by uid 107); 13 Jan 2015 01:59:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:59:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 20:59:09 -0500
Content-Disposition: inline
In-Reply-To: <20150113015427.GA5497@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262319>

This replaces "x ? xstrdup(x) : NULL" with xstrdup_or_null(x).
The change is fairly mechanical, with the exception of
resolve_refdup, which can eliminate a temporary variable.

There are still a few hits grepping for "?.*xstrdup", but
these are of slightly different forms and cannot be
converted (e.g., "x ? xstrdup(x->foo) : NULL").

Signed-off-by: Jeff King <peff@peff.net>
---
resolve_refdup is the interesting one to look at for readability here.

 config.c  | 2 +-
 grep.c    | 4 ++--
 notes.c   | 2 +-
 refs.c    | 3 +--
 remote.c  | 4 ++--
 shallow.c | 2 +-
 walker.c  | 2 +-
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index 752e2e2..e5e64dc 100644
--- a/config.c
+++ b/config.c
@@ -1340,7 +1340,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		string_list_init(&e->value_list, 1);
 		hashmap_add(&cs->config_hash, e);
 	}
-	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
+	si = string_list_append_nodup(&e->value_list, xstrdup_or_null(value));
 
 	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
 	l_item = &cs->list.items[cs->list.nr++];
diff --git a/grep.c b/grep.c
index 6e085f8..b58c7c6 100644
--- a/grep.c
+++ b/grep.c
@@ -1661,8 +1661,8 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		      const void *identifier)
 {
 	gs->type = type;
-	gs->name = name ? xstrdup(name) : NULL;
-	gs->path = path ? xstrdup(path) : NULL;
+	gs->name = xstrdup_or_null(name);
+	gs->path = xstrdup_or_null(path);
 	gs->buf = NULL;
 	gs->size = 0;
 	gs->driver = NULL;
diff --git a/notes.c b/notes.c
index c763a21..2be4d7f 100644
--- a/notes.c
+++ b/notes.c
@@ -1006,7 +1006,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
 	t->prev_non_note = NULL;
-	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
+	t->ref = xstrdup_or_null(notes_ref);
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
 	t->dirty = 0;
diff --git a/refs.c b/refs.c
index 5fcacc6..78fec5c 100644
--- a/refs.c
+++ b/refs.c
@@ -1618,8 +1618,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 
 char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags)
 {
-	const char *ret = resolve_ref_unsafe(ref, resolve_flags, sha1, flags);
-	return ret ? xstrdup(ret) : NULL;
+	return xstrdup_or_null(resolve_ref_unsafe(ref, resolve_flags, sha1, flags));
 }
 
 /* The argument to filter_refs */
diff --git a/remote.c b/remote.c
index 5b9c693..7b71ebf 100644
--- a/remote.c
+++ b/remote.c
@@ -975,8 +975,8 @@ struct ref *copy_ref(const struct ref *ref)
 	cpy = xmalloc(sizeof(struct ref) + len + 1);
 	memcpy(cpy, ref, sizeof(struct ref) + len + 1);
 	cpy->next = NULL;
-	cpy->symref = ref->symref ? xstrdup(ref->symref) : NULL;
-	cpy->remote_status = ref->remote_status ? xstrdup(ref->remote_status) : NULL;
+	cpy->symref = xstrdup_or_null(ref->symref);
+	cpy->remote_status = xstrdup_or_null(ref->remote_status);
 	cpy->peer_ref = copy_ref(ref->peer_ref);
 	return cpy;
 }
diff --git a/shallow.c b/shallow.c
index cdd0775..f5e6720 100644
--- a/shallow.c
+++ b/shallow.c
@@ -22,7 +22,7 @@ void set_alternate_shallow_file(const char *path, int override)
 	if (alternate_shallow_file && !override)
 		return;
 	free(alternate_shallow_file);
-	alternate_shallow_file = path ? xstrdup(path) : NULL;
+	alternate_shallow_file = xstrdup_or_null(path);
 }
 
 int register_shallow(const unsigned char *sha1)
diff --git a/walker.c b/walker.c
index f149371..483da4e 100644
--- a/walker.c
+++ b/walker.c
@@ -232,7 +232,7 @@ int walker_targets_stdin(char ***target, const char ***write_ref)
 			REALLOC_ARRAY(*write_ref, targets_alloc);
 		}
 		(*target)[targets] = xstrdup(tg_one);
-		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
+		(*write_ref)[targets] = xstrdup_or_null(rf_one);
 		targets++;
 	}
 	strbuf_release(&buf);
-- 
2.2.1.425.g441bb3c
