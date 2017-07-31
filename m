Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F585208B4
	for <e@80x24.org>; Mon, 31 Jul 2017 21:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdGaVDI (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:03:08 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36891 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdGaVDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:03:05 -0400
Received: by mail-pg0-f46.google.com with SMTP id y129so142876291pgy.4
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HbfquKvZZ+Pb2VRw2GGF79hc0aPtF81hG03ymtQ38go=;
        b=ODbtnXp+ef3VUSA17ZWZGhXw+c+jIK27QrruCjyUextdHMXAfLTmFPfJvR1mdfJtbD
         xzoaTTtlXVQV3docQ6aMFCF0a64K0++VHg2GO75yP+ATEdtfN/Pnv6UkeC5I2tSX/4K2
         0RSGnutE5fdSNAzjDeqZm+8GWAkxRzl83pA8pSqh2+RjojfapCzquVsdVmULP3hjnCCb
         SQFCsL3ORgooXeEiiaGb5SQZO9KGUhEiv8yjHIpXoVwCpjMcq+Fn7zkoEBumDAqLtveN
         iWNSD/nnq9P9n9/M2OlqJW8EfLAQV8HGfYhsqoPQuG1mfVPXr+kEosMj//4FxuDdJVWO
         1zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HbfquKvZZ+Pb2VRw2GGF79hc0aPtF81hG03ymtQ38go=;
        b=tUFX0eYa/fklGWlG0V4czRL/u0m2SIB2Bt1rh42/jhJ/UXwmt7U1ivSrPwk5ZMQJ1r
         GhebyWx6VK+7biPC0s/7fDedmgVoiF7epmb1GuAXzVrmsB+pdH1ojsSkjO6DV6JTA9Wp
         R99aKvz2nTmuvYrQK14T+6uOSuuuiYAL/aSPjeoqdHIuWfnmG70em2HZW9EBRSbKS6I6
         /C5i7GShM6jX9OBT9384FHbC9TiQuAtwFyyB4xa8UboeChDCjdGAYz2LwIUxdMF1pI5P
         zlGx55tPz/iUz1ue7/0UTRgIN4VDCVgU0cdMJThBCUj+nwtMy87uvFOqbFp7IDR/lsbc
         Tfkg==
X-Gm-Message-State: AIVw110S9VGAWIfnHOETklUXbGqQOhkUjMEja/LimNSLykzK5ZkHh42Q
        5vxARr/QaB0Ym/SwCY6tbQ==
X-Received: by 10.99.112.13 with SMTP id l13mr16891004pgc.199.1501534983707;
        Mon, 31 Jul 2017 14:03:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k185sm53231673pgc.31.2017.07.31.14.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 14:03:02 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: [PATCH v2 5/5] sha1_file: support loading lazy objects
Date:   Mon, 31 Jul 2017 14:02:47 -0700
Message-Id: <eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501532294.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com> <cover.1501532294.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach sha1_file to invoke the command configured in
extensions.lazyObject whenever an object is requested and unavailable.

The usage of the hook can be suppressed through a flag when invoking
has_object_file_with_flags() and other similar functions.

This is meant as a temporary measure to ensure that all Git commands
work in such a situation. Future patches will update some commands to
either tolerate missing objects (without invoking the command) or be
more efficient in invoking this command.

In order to determine the code changes in sha1_file.c necessary, I
investigated the following:
 (1) functions in sha1_file that take in a hash, without the user
     regarding how the object is stored (loose or packed)
 (2) functions in sha1_file that operate on packed objects (because I
     need to check callers that know about the loose/packed distinction
     and operate on both differently, and ensure that they can handle
     the concept of objects that are neither loose nor packed)

(1) is handled by the modification to sha1_object_info_extended().

For (2), I looked at for_each_packed_object and at the packed-related
functions that take in a hash. For for_each_packed_object, the callers
either already work or are fixed in this patch:
 - reachable - only to find recent objects
 - builtin/fsck - already knows about missing objects
 - builtin/cat-file - warning message added in this commit

Callers of the other functions do not need to be changed:
 - parse_pack_index
   - http - indirectly from http_get_info_packs
 - find_pack_entry_one
   - this searches a single pack that is provided as an argument; the
     caller already knows (through other means) that the sought object
     is in a specific pack
 - find_sha1_pack
   - fast-import - appears to be an optimization to not store a
     file if it is already in a pack
   - http-walker - to search through a struct alt_base
   - http-push - to search through remote packs
 - has_sha1_pack
   - builtin/fsck - already knows about promised objects
   - builtin/count-objects - informational purposes only (check if loose
     object is also packed)
   - builtin/prune-packed - check if object to be pruned is packed (if
     not, don't prune it)
   - revision - used to exclude packed objects if requested by user
   - diff - just for optimization

An alternative design that I considered but rejected:

 - Adding a hook whenever a packed object is requested, not on any
   object.  That is, whenever we attempt to search the packfiles for an
   object, if it is missing (from the packfiles and from the loose
   object storage), to invoke the hook (which must then store it as a
   packfile), open the packfile the hook generated, and report that the
   object is found in that new packfile. This reduces the amount of
   analysis needed (in that we only need to look at how packed objects
   are handled), but requires that the hook generate packfiles (or for
   sha1_file to pack whatever loose objects are generated), creating one
   packfile for each missing object and potentially very many packfiles
   that must be linearly searched. This may be tolerable now for repos
   that only have a few missing objects (for example, repos that only
   want to exclude large blobs), and might be tolerable in the future if
   we have batching support for the most commonly used commands, but is
   not tolerable now for repos that exclude a large amount of objects.

Helped-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/Makefile                             |   1 +
 Documentation/gitattributes.txt                    |  54 ++---------
 Documentation/gitrepository-layout.txt             |   3 +
 .../technical/long-running-process-protocol.txt    |  50 ++++++++++
 Documentation/technical/repository-version.txt     |  16 ++++
 Makefile                                           |   1 +
 builtin/cat-file.c                                 |   2 +
 builtin/fsck.c                                     |   2 +-
 cache.h                                            |   2 +
 lazy-object.c                                      |  80 ++++++++++++++++
 lazy-object.h                                      |  12 +++
 object.c                                           |   7 ++
 object.h                                           |  13 +++
 sha1_file.c                                        |  44 ++++++---
 t/t0410-lazy-object.sh                             |  18 ++++
 t/t0410/lazy-object                                | 102 +++++++++++++++++++++
 16 files changed, 345 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/technical/long-running-process-protocol.txt
 create mode 100644 lazy-object.c
 create mode 100644 lazy-object.h
 create mode 100755 t/t0410/lazy-object

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2415e0d65..5657d49c2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -69,6 +69,7 @@ SP_ARTICLES += $(API_DOCS)
 
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
+TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/pack-protocol
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c4f2be254..ed5e8204e 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -387,46 +387,14 @@ Long Running Filter Process
 If the filter command (a string value) is defined via
 `filter.<driver>.process` then Git can process all blobs with a
 single filter invocation for the entire life of a single Git
-command. This is achieved by using a packet format (pkt-line,
-see technical/protocol-common.txt) based protocol over standard
-input and standard output as follows. All packets, except for the
-"*CONTENT" packets and the "0000" flush packet, are considered
-text and therefore are terminated by a LF.
-
-Git starts the filter when it encounters the first file
-that needs to be cleaned or smudged. After the filter started
-Git sends a welcome message ("git-filter-client"), a list of supported
-protocol version numbers, and a flush packet. Git expects to read a welcome
-response message ("git-filter-server"), exactly one protocol version number
-from the previously sent list, and a flush packet. All further
-communication will be based on the selected version. The remaining
-protocol description below documents "version=2". Please note that
-"version=42" in the example below does not exist and is only there
-to illustrate how the protocol would look like with more than one
-version.
-
-After the version negotiation Git sends a list of all capabilities that
-it supports and a flush packet. Git expects to read a list of desired
-capabilities, which must be a subset of the supported capabilities list,
-and a flush packet as response:
-------------------------
-packet:          git> git-filter-client
-packet:          git> version=2
-packet:          git> version=42
-packet:          git> 0000
-packet:          git< git-filter-server
-packet:          git< version=2
-packet:          git< 0000
-packet:          git> capability=clean
-packet:          git> capability=smudge
-packet:          git> capability=not-yet-invented
-packet:          git> 0000
-packet:          git< capability=clean
-packet:          git< capability=smudge
-packet:          git< 0000
-------------------------
-Supported filter capabilities in version 2 are "clean", "smudge",
-and "delay".
+command. This is achieved by using the long-running process protocol
+(described in technical/long-running-process-protocol.txt).
+
+When Git encounters the first file that needs to be cleaned or smudged,
+it starts the filter and performs the handshake. In the handshake, the
+welcome message sent by Git is "git-filter-client", only version 2 is
+suppported, and the supported capabilities are "clean", "smudge", and
+"delay".
 
 Afterwards Git sends a list of "key=value" pairs terminated with
 a flush packet. The list will contain at least the filter command
@@ -512,12 +480,6 @@ the protocol then Git will stop the filter process and restart it
 with the next file that needs to be processed. Depending on the
 `filter.<driver>.required` flag Git will interpret that as error.
 
-After the filter has processed a command it is expected to wait for
-a "key=value" list containing the next command. Git will close
-the command pipe on exit. The filter is expected to detect EOF
-and exit gracefully on its own. Git will wait until the filter
-process has stopped.
-
 Delay
 ^^^^^
 
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index f51ed4e37..a690fdcd5 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -47,6 +47,9 @@ use with dumb transports but otherwise is OK as long as
 `objects/info/alternates` points at the object stores it
 borrows from.
 +
+. If `extensions.lazyObject` is set, some objects could be missing, to
+be lazily loaded by Git when required.
++
 This directory is ignored if $GIT_COMMON_DIR is set and
 "$GIT_COMMON_DIR/objects" will be used instead.
 
diff --git a/Documentation/technical/long-running-process-protocol.txt b/Documentation/technical/long-running-process-protocol.txt
new file mode 100644
index 000000000..aa0aa9af1
--- /dev/null
+++ b/Documentation/technical/long-running-process-protocol.txt
@@ -0,0 +1,50 @@
+Long-running process protocol
+=============================
+
+This protocol is used when Git needs to communicate with an external
+process throughout the entire life of a single Git command. All
+communication is in pkt-line format (see technical/protocol-common.txt)
+over standard input and standard output.
+
+Handshake
+---------
+
+Git starts by sending a welcome message (for example,
+"git-filter-client"), a list of supported protocol version numbers, and
+a flush packet. Git expects to read the welcome message with "server"
+instead of "client" (for example, "git-filter-server"), exactly one
+protocol version number from the previously sent list, and a flush
+packet. All further communication will be based on the selected version.
+The remaining protocol description below documents "version=2". Please
+note that "version=42" in the example below does not exist and is only
+there to illustrate how the protocol would look like with more than one
+version.
+
+After the version negotiation Git sends a list of all capabilities that
+it supports and a flush packet. Git expects to read a list of desired
+capabilities, which must be a subset of the supported capabilities list,
+and a flush packet as response:
+------------------------
+packet:          git> git-filter-client
+packet:          git> version=2
+packet:          git> version=42
+packet:          git> 0000
+packet:          git< git-filter-server
+packet:          git< version=2
+packet:          git< 0000
+packet:          git> capability=clean
+packet:          git> capability=smudge
+packet:          git> capability=not-yet-invented
+packet:          git> 0000
+packet:          git< capability=clean
+packet:          git< capability=smudge
+packet:          git< 0000
+------------------------
+
+Shutdown
+--------
+
+Git will close
+the command pipe on exit. The filter is expected to detect EOF
+and exit gracefully on its own. Git will wait until the filter
+process has stopped.
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index f0482cae4..38c8f966e 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -93,3 +93,19 @@ objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 When the config key `extensions.lazyObject` is set, Git does not treat missing
 objects as errors. The value of `extensions.lazyObject` must be a string,
 naming the command used to make a missing object appear whenever it is needed.
+
+Git communicates with this command using the long-running process
+protocol described in technical/long-running-process-protocol.txt.
+During the handshake, the welcome message used is "git-lazy-object", the
+only supported version is 1, and the only supported capability is "get".
+After the handshake, for each object to be loaded, Git will send
+"command=get\n", "sha1=<sha1>\n", and a flush packet, and will expect
+"status=success\n" or "status=error\n" and a flush packet. For example:
+
+------------------------
+packet:          git> command=get
+packet:          git> sha1=1234567890123456789012345678901234567890
+packet:          git> 0000
+packet:          git< status=success
+packet:          git< 0000
+------------------------
diff --git a/Makefile b/Makefile
index cd7d36c7d..3cac24775 100644
--- a/Makefile
+++ b/Makefile
@@ -800,6 +800,7 @@ LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += kwset.o
+LIB_OBJS += lazy-object.o
 LIB_OBJS += levenshtein.o
 LIB_OBJS += line-log.o
 LIB_OBJS += line-range.o
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 62c8cf0eb..ef016b84e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -473,6 +473,8 @@ static int batch_objects(struct batch_options *opt)
 
 		for_each_loose_object(batch_loose_object, &sa, 0);
 		for_each_packed_object(batch_packed_object, &sa, 0);
+		if (repository_format_lazy_object)
+			warning("This repository has extensions.lazyObject set. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 20415902f..327b087c2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -447,7 +447,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 {
 	struct object *obj;
 
-	obj = parse_object(oid);
+	obj = parse_maybe_missing_object(oid);
 	if (!obj) {
 		if (repository_format_lazy_object) {
 			/*
diff --git a/cache.h b/cache.h
index 9e6bc0a21..375f5b700 100644
--- a/cache.h
+++ b/cache.h
@@ -1837,6 +1837,8 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
+/* Never invoke extensions.lazyObject, even if object is missing */
+#define OBJECT_INFO_NO_LAZY 16
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
diff --git a/lazy-object.c b/lazy-object.c
new file mode 100644
index 000000000..d4b271a4e
--- /dev/null
+++ b/lazy-object.c
@@ -0,0 +1,80 @@
+#include "cache.h"
+#include "lazy-object.h"
+#include "sha1-lookup.h"
+#include "strbuf.h"
+#include "run-command.h"
+#include "sha1-array.h"
+#include "config.h"
+#include "sigchain.h"
+#include "sub-process.h"
+#include "pkt-line.h"
+
+#define CAP_GET    (1u<<0)
+
+static struct hashmap subprocess_map;
+
+int start_lazy_object_fn(struct subprocess_entry *subprocess)
+{
+	static int versions[] = {1, 0};
+	static struct subprocess_capability capabilities[] = {
+		{ "get", CAP_GET },
+		{ NULL, 0 }
+	};
+
+	unsigned int supported_capabilities = 0;
+	int ret = subprocess_handshake(subprocess, "git-lazy-object", versions,
+				       NULL, capabilities,
+				       &supported_capabilities);
+	if (ret)
+		return ret;
+	return supported_capabilities != CAP_GET;
+}
+
+void load_lazy_object(const unsigned char *sha1)
+{
+	struct subprocess_entry *entry;
+	struct child_process *process;
+	struct strbuf status = STRBUF_INIT;
+
+	if (!repository_format_lazy_object)
+		die("BUG: extensions.lazyObject is not set");
+
+	if (!subprocess_map.tablesize) {
+		hashmap_init(&subprocess_map,
+			     (hashmap_cmp_fn) cmd2process_cmp, NULL, 0);
+		entry = NULL;
+	} else {
+		entry = subprocess_find_entry(&subprocess_map,
+					      repository_format_lazy_object);
+	}
+	if (!entry) {
+		entry = xmalloc(sizeof(*entry));
+
+		if (subprocess_start(&subprocess_map, entry,
+				     repository_format_lazy_object,
+				     start_lazy_object_fn)) {
+			free(entry);
+			die("could not start '%s'", repository_format_lazy_object);
+		}
+	}
+	process = subprocess_get_child_process(entry);
+
+	packet_write_fmt(process->in, "command=get\n");
+	packet_write_fmt(process->in, "sha1=%s\n", sha1_to_hex(sha1));
+	packet_flush(process->in);
+	if (subprocess_read_status(process->out, &status))
+		die("Could not read status from '%s'", repository_format_lazy_object);
+	
+	if (!strcmp(status.buf, "success"))
+		return;
+	if (!strcmp(status.buf, "error"))
+		die("external process '%s' returned error",
+		    repository_format_lazy_object);
+	die("external process '%s' failed", repository_format_lazy_object);
+
+	/*
+	 * The command above may have updated packfiles, so update our record
+	 * of them.
+	 */
+	reprepare_packed_git();
+}
diff --git a/lazy-object.h b/lazy-object.h
new file mode 100644
index 000000000..1ec6ff203
--- /dev/null
+++ b/lazy-object.h
@@ -0,0 +1,12 @@
+#ifndef LAZY_OBJECT_H
+#define LAZY_OBJECT_H
+
+#include "cache.h"
+#include "sha1-array.h"
+
+/*
+ * Invokes repository_format_lazy_object to load the given missing object.
+ */
+void load_lazy_object(const unsigned char *sha1);
+
+#endif
diff --git a/object.c b/object.c
index 321d7e920..e3e734f67 100644
--- a/object.c
+++ b/object.c
@@ -279,6 +279,13 @@ struct object *parse_object(const struct object_id *oid)
 	return NULL;
 }
 
+struct object *parse_maybe_missing_object(const struct object_id *oid)
+{
+	if (has_object_file_with_flags(oid, OBJECT_INFO_NO_LAZY))
+		return parse_object(oid);
+	return NULL;
+}
+
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p)
 {
diff --git a/object.h b/object.h
index 0a419ba8d..b98e73572 100644
--- a/object.h
+++ b/object.h
@@ -87,10 +87,23 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet);
 /*
  * Returns the object, having parsed it to find out what it is.
  *
+ * This function automatically invokes the command in extensions.lazyObject if
+ * the object is missing and extensions.lazyObject is set.
+ *
  * Returns NULL if the object is missing or corrupt.
  */
 struct object *parse_object(const struct object_id *oid);
 
+/*
+ * Returns the object, having parsed it to find out what it is.
+ *
+ * This function never invokes the command in extensions.lazyObject, unlike
+ * parse_object().
+ *
+ * Returns NULL if the object is missing or corrupt.
+ */
+struct object *parse_maybe_missing_object(const struct object_id *oid);
+
 /*
  * Like parse_object, but will die() instead of returning NULL. If the
  * "name" parameter is not NULL, it is included in the error message
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f7..1785c61d8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -28,6 +28,11 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+#include "sha1-lookup.h"
+#include "lazy-object.h"
+#include "sha1-array.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -2984,6 +2989,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
 				    lookup_replace_object(sha1) :
 				    sha1;
+	int already_retried = 0;
 
 	if (!oi)
 		oi = &blank_oi;
@@ -3008,30 +3014,38 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-	if (!find_pack_entry(real, &e)) {
-		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
-			oi->whence = OI_LOOSE;
-			return 0;
-		}
+retry:
+	if (find_pack_entry(real, &e))
+		goto found_packed;
 
-		/* Not a loose object; someone else may have just packed it. */
-		if (flags & OBJECT_INFO_QUICK) {
-			return -1;
-		} else {
-			reprepare_packed_git();
-			if (!find_pack_entry(real, &e))
-				return -1;
-		}
+	/* Most likely it's a loose object. */
+	if (!sha1_loose_object_info(real, oi, flags)) {
+		oi->whence = OI_LOOSE;
+		return 0;
 	}
 
+	/* Not a loose object; someone else may have just packed it. */
+	reprepare_packed_git();
+	if (find_pack_entry(real, &e))
+		goto found_packed;
+
+	/* Check if it is a missing object */
+	if (repository_format_lazy_object && !already_retried &&
+	    !(flags & OBJECT_INFO_NO_LAZY)) {
+		load_lazy_object(real);
+		already_retried = 1;
+		goto retry;
+	}
+
+	return -1;
+
+found_packed:
 	if (oi == &blank_oi)
 		/*
 		 * We know that the caller doesn't actually need the
 		 * information below, so return early.
 		 */
 		return 0;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 3ac61c1c5..d8888baa0 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -92,4 +92,22 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck "$HASH"
 '
 
+test_expect_success 'sha1_object_info_extended (through git cat-file)' '
+	rm -rf repo client &&
+
+	test_create_repo server &&
+	test_commit -C server 1 1.t abcdefgh &&
+	HASH=$(git hash-object server/1.t) &&
+
+	test_create_repo client &&
+	test_must_fail git -C client cat-file -p "$HASH"
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C client config core.repositoryformatversion 1 &&
+	git -C client config extensions.lazyobject \
+		"\"$TEST_DIRECTORY/t0410/lazy-object\" \"$(pwd)/server/.git\"" &&
+	git -C client cat-file -p "$HASH"
+'
+
 test_done
diff --git a/t/t0410/lazy-object b/t/t0410/lazy-object
new file mode 100755
index 000000000..4f4a9c38a
--- /dev/null
+++ b/t/t0410/lazy-object
@@ -0,0 +1,102 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git lazyObject protocol version 1. See
+# the documentation for extensions.lazyObject in
+# Documentation/technical/repository-version.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# Please note, this sample is a minimal skeleton. No proper error handling
+# was implemented.
+
+use strict;
+use warnings;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = $ARGV[0];
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+
+		# EOF - Git stopped talking to us!
+		exit();
+	}
+	elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	}
+	elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	}
+	else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.";
+	}
+	return ( $res, $buf );
+}
+
+sub packet_bin_write {
+	my $buf = shift;
+	print STDOUT sprintf( "%04x", length($buf) + 4 );
+	print STDOUT $buf;
+	STDOUT->flush();
+}
+
+sub packet_txt_write {
+	packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+	print STDOUT sprintf( "%04x", 0 );
+	STDOUT->flush();
+}
+
+( packet_txt_read() eq ( 0, "git-lazy-object-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=1" ) )		 || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                       || die "bad version end";
+
+packet_txt_write("git-lazy-object-server");
+packet_txt_write("version=1");
+packet_flush();
+
+( packet_txt_read() eq ( 0, "capability=get" ) )    || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+
+packet_txt_write("capability=get");
+packet_flush();
+
+while (1) {
+	my ($command) = packet_txt_read() =~ /^command=([^=]+)$/;
+
+	if ( $command eq "get" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | git -c extensions.lazyobject=false hash-object -w --stdin >/dev/null 2>&1');
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

