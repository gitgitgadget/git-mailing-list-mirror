Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE0E20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbdLEQ77 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:59:59 -0500
Received: from siwi.pair.com ([209.68.5.199]:45215 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbdLEQ7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:59:16 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 068AB844E4;
        Tue,  5 Dec 2017 11:59:16 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6FE3D844DE;
        Tue,  5 Dec 2017 11:59:15 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com
Subject: [PATCH v6 07/12] introduce fetch-object: fetch one promisor object
Date:   Tue,  5 Dec 2017 16:58:49 +0000
Message-Id: <20171205165854.64979-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165854.64979-1-git@jeffhostetler.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Introduce fetch-object, providing the ability to fetch one object from a
promisor remote.

This uses fetch-pack. To do this, the transport mechanism has been
updated with 2 flags, "from-promisor" to indicate that the resulting
pack comes from a promisor remote (and thus should be annotated as such
by index-pack), and "no-dependents" to indicate that only the objects
themselves need to be fetched (but fetching additional objects is
nevertheless safe).

Whenever "no-dependents" is used, fetch-pack will refrain from using any
object flags, because it is most likely invoked as part of a dynamic
object fetch by another Git command (which may itself use object flags).
An alternative to this is to leave fetch-pack alone, and instead update
the allocation of flags so that fetch-pack's flags never overlap with
any others, but this will end up shrinking the number of flags available
to nearly every other Git command (that is, every Git command that
accesses objects), so the approach in this commit was used instead.

This will be tested in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/gitremote-helpers.txt |  7 ++++++
 Makefile                            |  1 +
 builtin/fetch-pack.c                |  8 +++++++
 builtin/index-pack.c                | 16 ++++++++++---
 fetch-object.c                      | 24 +++++++++++++++++++
 fetch-object.h                      |  6 +++++
 fetch-pack.c                        | 48 +++++++++++++++++++++----------------
 fetch-pack.h                        |  8 +++++++
 remote-curl.c                       | 14 ++++++++++-
 transport.c                         |  8 +++++++
 transport.h                         | 11 +++++++++
 11 files changed, 126 insertions(+), 25 deletions(-)
 create mode 100644 fetch-object.c
 create mode 100644 fetch-object.h

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 4a584f3..4b8c93e 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -466,6 +466,13 @@ set by Git if the remote helper has the 'option' capability.
 	Transmit <string> as a push option. As the push option
 	must not contain LF or NUL characters, the string is not encoded.
 
+'option from-promisor' {'true'|'false'}::
+	Indicate that these objects are being fetched from a promisor.
+
+'option no-dependents' {'true'|'false'}::
+	Indicate that only the objects wanted need to be fetched, not
+	their dependents.
+
 SEE ALSO
 --------
 linkgit:git-remote[1]
diff --git a/Makefile b/Makefile
index ca378a4..795e0c7 100644
--- a/Makefile
+++ b/Makefile
@@ -792,6 +792,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += gettext.o
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d1..02abe72 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -143,6 +143,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!strcmp("--from-promisor", arg)) {
+			args.from_promisor = 1;
+			continue;
+		}
+		if (!strcmp("--no-dependents", arg)) {
+			args.no_dependents = 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4f305a7..24c2f05 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1429,14 +1429,16 @@ static void write_special_file(const char *suffix, const char *msg,
 		if (close(fd) != 0)
 			die_errno(_("cannot close written %s file '%s'"),
 				  suffix, filename);
-		*report = suffix;
+		if (report)
+			*report = suffix;
 	}
 	strbuf_release(&name_buf);
 }
 
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
-		  const char *keep_msg, unsigned char *sha1)
+		  const char *keep_msg, const char *promisor_msg,
+		  unsigned char *sha1)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
@@ -1455,6 +1457,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (keep_msg)
 		write_special_file("keep", keep_msg, final_pack_name, sha1,
 				   &report);
+	if (promisor_msg)
+		write_special_file("promisor", promisor_msg, final_pack_name,
+				   sha1, NULL);
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
@@ -1644,6 +1649,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_msg = NULL;
+	const char *promisor_msg = NULL;
 	struct strbuf index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
@@ -1693,6 +1699,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				keep_msg = "";
 			} else if (starts_with(arg, "--keep=")) {
 				keep_msg = arg + 7;
+			} else if (!strcmp(arg, "--promisor")) {
+				promisor_msg = "";
+			} else if (starts_with(arg, "--promisor=")) {
+				promisor_msg = arg + strlen("--promisor=");
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
@@ -1803,7 +1813,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
-		      keep_msg,
+		      keep_msg, promisor_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
diff --git a/fetch-object.c b/fetch-object.c
new file mode 100644
index 0000000..08e91ce
--- /dev/null
+++ b/fetch-object.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+#include "packfile.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+#include "transport.h"
+#include "fetch-object.h"
+
+void fetch_object(const char *remote_name, const unsigned char *sha1)
+{
+	struct remote *remote;
+	struct transport *transport;
+	struct ref *ref;
+
+	remote = remote_get(remote_name);
+	if (!remote->url[0])
+		die(_("Remote with no URL"));
+	transport = transport_get(remote, remote->url[0]);
+
+	ref = alloc_ref(sha1_to_hex(sha1));
+	hashcpy(ref->old_oid.hash, sha1);
+	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
+	transport_fetch_refs(transport, ref);
+}
diff --git a/fetch-object.h b/fetch-object.h
new file mode 100644
index 0000000..f371300
--- /dev/null
+++ b/fetch-object.h
@@ -0,0 +1,6 @@
+#ifndef FETCH_OBJECT_H
+#define FETCH_OBJECT_H
+
+extern void fetch_object(const char *remote_name, const unsigned char *sha1);
+
+#endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 008b25d..0798e0b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -450,6 +450,8 @@ static int find_common(struct fetch_pack_args *args,
 
 	flushes = 0;
 	retval = -1;
+	if (args->no_dependents)
+		goto done;
 	while ((oid = get_rev())) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
@@ -734,29 +736,31 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
-	if (!args->deepen) {
-		for_each_ref(mark_complete_oid, NULL);
-		for_each_cached_alternate(mark_alternate_complete);
-		commit_list_sort_by_date(&complete);
-		if (cutoff)
-			mark_recent_complete_commits(args, cutoff);
-	}
+	if (!args->no_dependents) {
+		if (!args->deepen) {
+			for_each_ref(mark_complete_oid, NULL);
+			for_each_cached_alternate(mark_alternate_complete);
+			commit_list_sort_by_date(&complete);
+			if (cutoff)
+				mark_recent_complete_commits(args, cutoff);
+		}
 
-	/*
-	 * Mark all complete remote refs as common refs.
-	 * Don't mark them common yet; the server has to be told so first.
-	 */
-	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
-					     NULL, 0);
+		/*
+		 * Mark all complete remote refs as common refs.
+		 * Don't mark them common yet; the server has to be told so first.
+		 */
+		for (ref = *refs; ref; ref = ref->next) {
+			struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
+						     NULL, 0);
 
-		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
-			continue;
+			if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
+				continue;
 
-		if (!(o->flags & SEEN)) {
-			rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+			if (!(o->flags & SEEN)) {
+				rev_list_push((struct commit *)o, COMMON_REF | SEEN);
 
-			mark_common((struct commit *)o, 1, 1);
+				mark_common((struct commit *)o, 1, 1);
+			}
 		}
 	}
 
@@ -832,7 +836,7 @@ static int get_pack(struct fetch_pack_args *args,
 		argv_array_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (do_keep) {
+	if (do_keep || args->from_promisor) {
 		if (pack_lockfile)
 			cmd.out = -1;
 		cmd_name = "index-pack";
@@ -842,7 +846,7 @@ static int get_pack(struct fetch_pack_args *args,
 			argv_array_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
-		if (args->lock_pack || unpack_limit) {
+		if (do_keep && (args->lock_pack || unpack_limit)) {
 			char hostname[HOST_NAME_MAX + 1];
 			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
@@ -852,6 +856,8 @@ static int get_pack(struct fetch_pack_args *args,
 		}
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
+		if (args->from_promisor)
+			argv_array_push(&cmd.args, "--promisor");
 	}
 	else {
 		cmd_name = "unpack-objects";
diff --git a/fetch-pack.h b/fetch-pack.h
index b6aeb43..aeac152 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -29,6 +29,14 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+	unsigned from_promisor:1;
+
+	/*
+	 * If 1, fetch_pack() will also not modify any object flags.
+	 * This allows fetch_pack() to safely be called by any function,
+	 * regardless of which object flags it uses (if any).
+	 */
+	unsigned no_dependents:1;
 };
 
 /*
diff --git a/remote-curl.c b/remote-curl.c
index 0053b09..4318391 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -33,7 +33,9 @@ struct options {
 		thin : 1,
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert : 2,
-		deepen_relative : 1;
+		deepen_relative : 1,
+		from_promisor : 1,
+		no_dependents : 1;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -157,6 +159,12 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 0;
 #endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
+	} else if (!strcmp(name, "from-promisor")) {
+		options.from_promisor = 1;
+		return 0;
+	} else if (!strcmp(name, "no-dependents")) {
+		options.no_dependents = 1;
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -822,6 +830,10 @@ static int fetch_git(struct discovery *heads,
 				 options.deepen_not.items[i].string);
 	if (options.deepen_relative && options.depth)
 		argv_array_push(&args, "--deepen-relative");
+	if (options.from_promisor)
+		argv_array_push(&args, "--from-promisor");
+	if (options.no_dependents)
+		argv_array_push(&args, "--no-dependents");
 	argv_array_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
diff --git a/transport.c b/transport.c
index f1e2f61..f2fbc6f 100644
--- a/transport.c
+++ b/transport.c
@@ -160,6 +160,12 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FROM_PROMISOR)) {
+		opts->from_promisor = !!value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_NO_DEPENDENTS)) {
+		opts->no_dependents = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -228,6 +234,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.from_promisor = data->options.from_promisor;
+	args.no_dependents = data->options.no_dependents;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index bc55715..c49a8ed 100644
--- a/transport.h
+++ b/transport.h
@@ -15,6 +15,8 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned from_promisor : 1;
+	unsigned no_dependents : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -210,6 +212,15 @@ void transport_check_allowed(const char *type);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Indicate that these objects are being fetched by a promisor */
+#define TRANS_OPT_FROM_PROMISOR "from-promisor"
+
+/*
+ * Indicate that only the objects wanted need to be fetched, not their
+ * dependents
+ */
+#define TRANS_OPT_NO_DEPENDENTS "no-dependents"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.9.3

