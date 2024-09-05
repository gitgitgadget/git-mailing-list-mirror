Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615E194C92
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526313; cv=none; b=DMtYxAAfQ3oa85jAIq0RSTuMUo80VMhz3qUcDpx5Auq+VBV+z9lA+/+YupxhNmbWcKCtxkrgwq8zcn31CzAbYXtsZnq4iYT2VHJdQRWVQWlh1vqa3P189N7X2R90MtEvMdDHEX2hfZm0L/moGnG68oT9G3V3SzvyiVfKjns2LCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526313; c=relaxed/simple;
	bh=g6JWnAmqEi5IspBlA9QKi8piq+IpFB2d96ejJqwae8k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Em5OBdR4PewsWbUPApJTpq8a2Jjk7a8mELaA7fZrq6GxTXO41AmBFksUlzK/OKrdpZUCTonpmDqY4N0Yjg/YHOSUvbAriZpqDJDXEWYpw0p8uN5tL0QiF+Z+unhAgckT/aICLASGUwRx5vlH9trKLFDAxGt1rw7N+SX0iJ5GYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5765 invoked by uid 109); 5 Sep 2024 08:51:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 08:51:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7069 invoked by uid 111); 5 Sep 2024 08:51:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 04:51:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 04:51:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] drop trailing newline from warning/error/die messages
Message-ID: <20240905085149.GA2340826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Our error reporting routines append a trailing newline, and the strings
we pass to them should not include them (otherwise we get an extra blank
line after the message).

These cases were all found by looking at the results of:

  git grep -P '[^_](error|error_errno|warning|die|die_errno)\(.*\\n"[,)]' '*.c'

Note that we _do_ sometimes include a newline in the middle of such
messages, to create multiline output (hence our grep matching "," or ")"
after we see the newline, so we know we're at the end of the string).

It's possible that one or more of these cases could intentionally be
including a blank line at the end, but having looked at them all
manually, I think these are all just mistakes.

Signed-off-by: Jeff King <peff@peff.net>
---
I just happened to notice one of these, so I grepped for more.

 builtin/bisect.c            |  4 ++--
 builtin/fetch.c             |  4 ++--
 builtin/stash.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 fetch-pack.c                |  2 +-
 loose.c                     |  4 ++--
 negotiator/skipping.c       |  2 +-
 send-pack.c                 |  2 +-
 serve.c                     |  2 +-
 t/helper/test-path-utils.c  |  6 +++---
 t/helper/test-progress.c    | 10 +++++-----
 t/helper/test-reach.c       |  4 ++--
 12 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 453a6cccd7..c8aa92b19d 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -583,7 +583,7 @@ static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 	refs_for_each_glob_ref_in(get_main_ref_store(the_repository),
 				  add_bisect_ref, good, "refs/bisect/", &cb);
 	if (prepare_revision_walk(revs))
-		res = error(_("revision walk setup failed\n"));
+		res = error(_("revision walk setup failed"));
 
 	free(good);
 	free(bad);
@@ -1108,7 +1108,7 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
 			setup_revisions(2, argv + i - 1, &revs, NULL);
 
 			if (prepare_revision_walk(&revs))
-				die(_("revision walk setup failed\n"));
+				die(_("revision walk setup failed"));
 			while ((commit = get_revision(&revs)) != NULL)
 				strvec_push(&argv_state,
 						oid_to_hex(&commit->object.oid));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2b5aee5bf..55f97134aa 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1161,7 +1161,7 @@ static int store_updated_refs(struct display_state *display_state,
 		opt.exclude_hidden_refs_section = "fetch";
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
-			rc = error(_("%s did not send all necessary objects\n"),
+			rc = error(_("%s did not send all necessary objects"),
 				   display_state->url);
 			goto abort;
 		}
@@ -1458,7 +1458,7 @@ static void set_option(struct transport *transport, const char *name, const char
 		die(_("option \"%s\" value \"%s\" is not valid for %s"),
 		    name, value, transport->url);
 	if (r > 0)
-		warning(_("option \"%s\" is ignored for %s\n"),
+		warning(_("option \"%s\" is ignored for %s"),
 			name, transport->url);
 }
 
diff --git a/builtin/stash.c b/builtin/stash.c
index fcfd97972a..be842258d0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -484,7 +484,7 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 					 "         to make room.\n"),
 				       ce->name, new_path.buf);
 				if (rename(ce->name, new_path.buf))
-					die("Failed to move %s to %s\n",
+					die("Failed to move %s to %s",
 					    ce->name, new_path.buf);
 				strbuf_release(&new_path);
 			}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85fb23dee8..a46ffd49b3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -917,7 +917,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 		} else {
 			/* for a submodule removal (mode:0000000), don't warn */
 			if (p->mod_dst)
-				warning(_("unexpected mode %o\n"), p->mod_dst);
+				warning(_("unexpected mode %o"), p->mod_dst);
 		}
 	}
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 58b4581ad8..983c560785 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1614,7 +1614,7 @@ static void receive_packfile_uris(struct packet_reader *reader,
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		if (reader->pktlen < the_hash_algo->hexsz ||
 		    reader->line[the_hash_algo->hexsz] != ' ')
-			die("expected '<hash> <uri>', got: %s\n", reader->line);
+			die("expected '<hash> <uri>', got: %s", reader->line);
 
 		string_list_append(uris, reader->line);
 	}
diff --git a/loose.c b/loose.c
index a8bf772172..6d6a41b7e5 100644
--- a/loose.c
+++ b/loose.c
@@ -162,7 +162,7 @@ int repo_write_loose_object_map(struct repository *repo)
 errout:
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
-	error_errno(_("failed to write loose object index %s\n"), path.buf);
+	error_errno(_("failed to write loose object index %s"), path.buf);
 	strbuf_release(&path);
 	return -1;
 }
@@ -197,7 +197,7 @@ static int write_one_object(struct repository *repo, const struct object_id *oid
 	strbuf_release(&path);
 	return 0;
 errout:
-	error_errno(_("failed to write loose object index %s\n"), path.buf);
+	error_errno(_("failed to write loose object index %s"), path.buf);
 	close(fd);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index f65d47858b..6e61b3c5f1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -239,7 +239,7 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 {
 	int known_to_be_common = !!(c->object.flags & COMMON);
 	if (!(c->object.flags & SEEN))
-		die("received ack for commit %s not sent as 'have'\n",
+		die("received ack for commit %s not sent as 'have'",
 		    oid_to_hex(&c->object.oid));
 	mark_common(n->data, c);
 	return known_to_be_common;
diff --git a/send-pack.c b/send-pack.c
index 9666b2c995..5d0c23772a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -626,7 +626,7 @@ int send_pack(struct send_pack_args *args,
 				strbuf_release(&req_buf);
 				strbuf_release(&cap_buf);
 				reject_atomic_push(remote_refs, args->send_mirror);
-				error("atomic push failed for ref %s. status: %d\n",
+				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
 				return args->porcelain ? 0 : -1;
 			}
diff --git a/serve.c b/serve.c
index 884cd84ca8..d674764a25 100644
--- a/serve.c
+++ b/serve.c
@@ -323,7 +323,7 @@ static int process_request(void)
 		die("no command requested");
 
 	if (client_hash_algo != hash_algo_by_ptr(the_repository->hash_algo))
-		die("mismatched object format: server %s; client %s\n",
+		die("mismatched object format: server %s; client %s",
 		    the_repository->hash_algo->name,
 		    hash_algos[client_hash_algo].name);
 
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index bf0e23ed50..fd6e6cc4a5 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -38,7 +38,7 @@ static void normalize_argv_string(const char **var, const char *input)
 		*var = input;
 
 	if (*var && (**var == '<' || **var == '('))
-		die("Bad value: %s\n", input);
+		die("Bad value: %s", input);
 }
 
 struct test_data {
@@ -78,12 +78,12 @@ static int test_function(struct test_data *data, char *(*func)(char *input),
 		if (!strcmp(to, data[i].to))
 			continue;
 		if (!data[i].alternative)
-			error("FAIL: %s(%s) => '%s' != '%s'\n",
+			error("FAIL: %s(%s) => '%s' != '%s'",
 				funcname, data[i].from, to, data[i].to);
 		else if (!strcmp(to, data[i].alternative))
 			continue;
 		else
-			error("FAIL: %s(%s) => '%s' != '%s', '%s'\n",
+			error("FAIL: %s(%s) => '%s' != '%s', '%s'",
 				funcname, data[i].from, to, data[i].to,
 				data[i].alternative);
 		failed = 1;
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 66acb6a06c..44be2645e9 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -62,32 +62,32 @@ int cmd__progress(int argc, const char **argv)
 			else if (*end == ' ')
 				title = string_list_insert(&titles, end + 1)->string;
 			else
-				die("invalid input: '%s'\n", line.buf);
+				die("invalid input: '%s'", line.buf);
 
 			progress = start_progress(title, total);
 		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
 			uint64_t item_count = strtoull(end, &end, 10);
 			if (*end != '\0')
-				die("invalid input: '%s'\n", line.buf);
+				die("invalid input: '%s'", line.buf);
 			display_progress(progress, item_count);
 		} else if (skip_prefix(line.buf, "throughput ",
 				       (const char **) &end)) {
 			uint64_t byte_count, test_ms;
 
 			byte_count = strtoull(end, &end, 10);
 			if (*end != ' ')
-				die("invalid input: '%s'\n", line.buf);
+				die("invalid input: '%s'", line.buf);
 			test_ms = strtoull(end + 1, &end, 10);
 			if (*end != '\0')
-				die("invalid input: '%s'\n", line.buf);
+				die("invalid input: '%s'", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
 		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
 		} else if (!strcmp(line.buf, "stop")) {
 			stop_progress(&progress);
 		} else {
-			die("invalid input: '%s'\n", line.buf);
+			die("invalid input: '%s'", line.buf);
 		}
 	}
 	strbuf_release(&line);
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 7314f6c0d8..995e382863 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -67,13 +67,13 @@ int cmd__reach(int ac, const char **av)
 		peeled = deref_tag_noverify(the_repository, orig);
 
 		if (!peeled)
-			die("failed to load commit for input %s resulting in oid %s\n",
+			die("failed to load commit for input %s resulting in oid %s",
 			    buf.buf, oid_to_hex(&oid));
 
 		c = object_as_type(peeled, OBJ_COMMIT, 0);
 
 		if (!c)
-			die("failed to load commit for input %s resulting in oid %s\n",
+			die("failed to load commit for input %s resulting in oid %s",
 			    buf.buf, oid_to_hex(&oid));
 
 		switch (buf.buf[0]) {
-- 
2.46.0.802.g13da1a47c4
