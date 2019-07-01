Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D2E1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGANRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:17:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727049AbfGANRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:17:42 -0400
Received: (qmail 26101 invoked by uid 109); 1 Jul 2019 13:17:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Jul 2019 13:17:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4553 invoked by uid 111); 1 Jul 2019 13:18:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Jul 2019 09:18:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jul 2019 09:17:40 -0400
Date:   Mon, 1 Jul 2019 09:17:40 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/2] object-store.h: move for_each_alternate_ref() from
 transport.h
Message-ID: <20190701131740.GA2584@sigill.intra.peff.net>
References: <20190701131713.GA25349@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701131713.GA25349@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's nothing inherently transport-related about enumerating the
alternate ref tips. The code has lived in transport.[ch] because the
only use so far had been advertising available tips during transport.
But it could be used for more, and a future patch will teach rev-list to
access these refs.

Let's move it alongside the other alt-odb code, declaring it in
object-store.h with the implementation in sha1-file.c.

This lets us drop the inclusion of transport.h from receive-pack, which
perhaps shows how it was misplaced (though receive-pack is about
transporting objects, transport.h is mostly about the client side).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c |  1 -
 object-store.h         |  2 +
 sha1-file.c            | 97 ++++++++++++++++++++++++++++++++++++++++++
 transport.c            | 97 ------------------------------------------
 transport.h            |  2 -
 5 files changed, 99 insertions(+), 100 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 77b7122456..557e686d5d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -12,7 +12,6 @@
 #include "object.h"
 #include "remote.h"
 #include "connect.h"
-#include "transport.h"
 #include "string-list.h"
 #include "sha1-array.h"
 #include "connected.h"
diff --git a/object-store.h b/object-store.h
index 49f56ab8d9..7f7b3cdd80 100644
--- a/object-store.h
+++ b/object-store.h
@@ -33,6 +33,8 @@ void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct object_directory *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
+typedef void alternate_ref_fn(const struct object_id *oid, void *);
+void for_each_alternate_ref(alternate_ref_fn, void *);
 
 /*
  * Add the directory to the on-disk alternates file; the new entry will also
diff --git a/sha1-file.c b/sha1-file.c
index 888b6024d5..3c273c076a 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -743,6 +743,103 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 	return ref_git;
 }
 
+static void fill_alternate_refs_command(struct child_process *cmd,
+					const char *repo_path)
+{
+	const char *value;
+
+	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
+		cmd->use_shell = 1;
+
+		argv_array_push(&cmd->args, value);
+		argv_array_push(&cmd->args, repo_path);
+	} else {
+		cmd->git_cmd = 1;
+
+		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
+		argv_array_push(&cmd->args, "for-each-ref");
+		argv_array_push(&cmd->args, "--format=%(objectname)");
+
+		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
+			argv_array_push(&cmd->args, "--");
+			argv_array_split(&cmd->args, value);
+		}
+	}
+
+	cmd->env = local_repo_env;
+	cmd->out = -1;
+}
+
+static void read_alternate_refs(const char *path,
+				alternate_ref_fn *cb,
+				void *data)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf line = STRBUF_INIT;
+	FILE *fh;
+
+	fill_alternate_refs_command(&cmd, path);
+
+	if (start_command(&cmd))
+		return;
+
+	fh = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, fh) != EOF) {
+		struct object_id oid;
+		const char *p;
+
+		if (parse_oid_hex(line.buf, &oid, &p) || *p) {
+			warning(_("invalid line while parsing alternate refs: %s"),
+				line.buf);
+			break;
+		}
+
+		cb(&oid, data);
+	}
+
+	fclose(fh);
+	finish_command(&cmd);
+}
+
+struct alternate_refs_data {
+	alternate_ref_fn *fn;
+	void *data;
+};
+
+static int refs_from_alternate_cb(struct object_directory *e,
+				  void *data)
+{
+	struct strbuf path = STRBUF_INIT;
+	size_t base_len;
+	struct alternate_refs_data *cb = data;
+
+	if (!strbuf_realpath(&path, e->path, 0))
+		goto out;
+	if (!strbuf_strip_suffix(&path, "/objects"))
+		goto out;
+	base_len = path.len;
+
+	/* Is this a git repository with refs? */
+	strbuf_addstr(&path, "/refs");
+	if (!is_directory(path.buf))
+		goto out;
+	strbuf_setlen(&path, base_len);
+
+	read_alternate_refs(path.buf, cb->fn, cb->data);
+
+out:
+	strbuf_release(&path);
+	return 0;
+}
+
+void for_each_alternate_ref(alternate_ref_fn fn, void *data)
+{
+	struct alternate_refs_data cb;
+	cb.fn = fn;
+	cb.data = data;
+	foreach_alt_odb(refs_from_alternate_cb, &cb);
+}
+
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
 	struct object_directory *ent;
diff --git a/transport.c b/transport.c
index f1fcd2c4b0..2def5a0c35 100644
--- a/transport.c
+++ b/transport.c
@@ -1380,100 +1380,3 @@ char *transport_anonymize_url(const char *url)
 literal_copy:
 	return xstrdup(url);
 }
-
-static void fill_alternate_refs_command(struct child_process *cmd,
-					const char *repo_path)
-{
-	const char *value;
-
-	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
-		cmd->use_shell = 1;
-
-		argv_array_push(&cmd->args, value);
-		argv_array_push(&cmd->args, repo_path);
-	} else {
-		cmd->git_cmd = 1;
-
-		argv_array_pushf(&cmd->args, "--git-dir=%s", repo_path);
-		argv_array_push(&cmd->args, "for-each-ref");
-		argv_array_push(&cmd->args, "--format=%(objectname)");
-
-		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
-			argv_array_push(&cmd->args, "--");
-			argv_array_split(&cmd->args, value);
-		}
-	}
-
-	cmd->env = local_repo_env;
-	cmd->out = -1;
-}
-
-static void read_alternate_refs(const char *path,
-				alternate_ref_fn *cb,
-				void *data)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct strbuf line = STRBUF_INIT;
-	FILE *fh;
-
-	fill_alternate_refs_command(&cmd, path);
-
-	if (start_command(&cmd))
-		return;
-
-	fh = xfdopen(cmd.out, "r");
-	while (strbuf_getline_lf(&line, fh) != EOF) {
-		struct object_id oid;
-		const char *p;
-
-		if (parse_oid_hex(line.buf, &oid, &p) || *p) {
-			warning(_("invalid line while parsing alternate refs: %s"),
-				line.buf);
-			break;
-		}
-
-		cb(&oid, data);
-	}
-
-	fclose(fh);
-	finish_command(&cmd);
-}
-
-struct alternate_refs_data {
-	alternate_ref_fn *fn;
-	void *data;
-};
-
-static int refs_from_alternate_cb(struct object_directory *e,
-				  void *data)
-{
-	struct strbuf path = STRBUF_INIT;
-	size_t base_len;
-	struct alternate_refs_data *cb = data;
-
-	if (!strbuf_realpath(&path, e->path, 0))
-		goto out;
-	if (!strbuf_strip_suffix(&path, "/objects"))
-		goto out;
-	base_len = path.len;
-
-	/* Is this a git repository with refs? */
-	strbuf_addstr(&path, "/refs");
-	if (!is_directory(path.buf))
-		goto out;
-	strbuf_setlen(&path, base_len);
-
-	read_alternate_refs(path.buf, cb->fn, cb->data);
-
-out:
-	strbuf_release(&path);
-	return 0;
-}
-
-void for_each_alternate_ref(alternate_ref_fn fn, void *data)
-{
-	struct alternate_refs_data cb;
-	cb.fn = fn;
-	cb.data = data;
-	foreach_alt_odb(refs_from_alternate_cb, &cb);
-}
diff --git a/transport.h b/transport.h
index 06e06d3d89..0b5f7806f6 100644
--- a/transport.h
+++ b/transport.h
@@ -262,6 +262,4 @@ int transport_refs_pushed(struct ref *ref);
 void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
 #endif
-- 
2.22.0.776.g16867c022c

