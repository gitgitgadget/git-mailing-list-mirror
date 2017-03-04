Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 686ED2023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbdCDTgJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:36:09 -0500
Received: from dalaran.tastycake.net ([212.13.201.165]:55237 "EHLO
        dalaran.tastycake.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbdCDTgF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:36:05 -0500
Received: from [176.27.107.90] (helo=localhost.localdomain)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <markbt@efaref.net>)
        id 1ckFCv-0001xc-Ue; Sat, 04 Mar 2017 19:19:09 +0000
From:   Mark Thomas <markbt@efaref.net>
To:     git@vger.kernel.org
Cc:     Mark Thomas <markbt@efaref.net>
Subject: [RFC 2/4] on-demand: Fetch missing files from remote
Date:   Sat,  4 Mar 2017 19:18:59 +0000
Message-Id: <20170304191901.9622-3-markbt@efaref.net>
X-Mailer: git-send-email 2.12.0.193.g9dc7f06
In-Reply-To: <20170304191901.9622-1-markbt@efaref.net>
References: <20170304191901.9622-1-markbt@efaref.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If an object (tree, blob, ...) is not found either in the
packs or loose, check if it is available on-demand from
the remote.

Signed-off-by: Mark Thomas <markbt@efaref.net>
---
 Makefile    |   1 +
 cache.h     |   3 +-
 on_demand.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 on_demand.h |   8 ++++
 sha1_file.c |   8 +++-
 5 files changed, 174 insertions(+), 3 deletions(-)
 create mode 100644 on_demand.c
 create mode 100644 on_demand.h

diff --git a/Makefile b/Makefile
index 1b84322..fb8ca6c 100644
--- a/Makefile
+++ b/Makefile
@@ -784,6 +784,7 @@ LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
 LIB_OBJS += oidset.o
+LIB_OBJS += on_demand.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-check.o
diff --git a/cache.h b/cache.h
index 80b6372..d34af06 100644
--- a/cache.h
+++ b/cache.h
@@ -1730,7 +1730,8 @@ struct object_info {
 		OI_CACHED,
 		OI_LOOSE,
 		OI_PACKED,
-		OI_DBCACHED
+		OI_DBCACHED,
+		OI_ONDEMAND
 	} whence;
 	union {
 		/*
diff --git a/on_demand.c b/on_demand.c
new file mode 100644
index 0000000..a0aaf18
--- /dev/null
+++ b/on_demand.c
@@ -0,0 +1,157 @@
+#include "transport.h"
+#include "pkt-line.h"
+#include "remote.h"
+#include "commit.h"
+
+static struct remote *remote = NULL;
+static struct transport *transport = NULL;
+static int fd[2];
+static int connected;
+
+struct trace_key trace_on_demand = TRACE_KEY_INIT(ON_DEMAND);
+
+static void on_demand_cleanup(void)
+{
+	if (connected) {
+		packet_write_fmt(fd[1], "end\n");
+		transport_disconnect(transport);
+		connected = 0;
+	}
+}
+
+static int on_demand_connect(void)
+{
+	if (!connected) {
+		if (!remote)
+			remote = remote_get(NULL);
+		if (remote && !transport)
+			transport = transport_get(remote, NULL);
+		if (!remote || !transport)
+			return 0;
+		if (transport_connect(transport, transport->url, "git-upload-file", fd))
+			return 0;
+		connected = 1;
+		atexit(on_demand_cleanup);
+	}
+	return 1;
+}
+
+void *read_remote_on_demand(const unsigned char *sha1, enum object_type *type,
+			    unsigned long *size)
+{
+	const char *line;
+	const char *arg;
+	int line_size;
+
+	if (!on_demand_connect())
+		return NULL;
+
+	packet_write_fmt(fd[1], "get %s\n", sha1_to_hex(sha1));
+
+	line = packet_read_line(fd[0], &line_size);
+
+	if (line_size == 0)
+		return NULL;
+
+	if (skip_prefix(line, "missing ", &arg))
+		return NULL;
+
+	if (skip_prefix(line, "found ", &arg)) {
+		char *end = NULL;
+		void *buffer;
+		unsigned char file_sha1[GIT_SHA1_RAWSZ];
+		enum object_type file_type;
+		unsigned long file_size;
+		ssize_t size_read;
+
+		if (get_sha1_hex(arg, file_sha1))
+			die("git on-demand: protocol error, "
+			    "expected to get sha in '%s'", line);
+		arg += GIT_SHA1_HEXSZ;
+
+		file_type = strtol(arg, &end, 0);
+		if (!end || file_type < 0 || file_type >= OBJ_MAX)
+			die("git on-demand: protocol error, "
+			    "invalid object type in '%s'", line);
+		arg = end;
+
+		file_size = strtoul(arg, &end, 0);
+		if (!end || *end || file_size > LONG_MAX)
+			die("git on-demand: protocol error, "
+			    "invalid file size in '%s'", line);
+
+		buffer = xmalloc(file_size);
+		if (!buffer)
+			die("git on-demand: failed to allocate "
+			    "buffer for %ld bytes", file_size);
+
+		size_read = read_in_full(fd[0], buffer, file_size);
+		if (size_read != (ssize_t)file_size)
+			die("git on-demand: protocol error, "
+			    "failed to read file data");
+
+		trace_printf_key(&trace_on_demand, "on-demand: fetched %s\n",
+				 sha1_to_hex(sha1));
+		*type = file_type;
+		*size = file_size;
+		return buffer;
+	}
+
+	die("git on-demand: protocol error, "
+	    "unexpected response: '%s'", line);
+}
+
+int object_info_on_demand(const unsigned char *sha1, struct object_info *oi)
+{
+	const char *line;
+	const char *arg;
+	int line_size;
+
+	if (!on_demand_connect())
+		return -1;
+
+	packet_write_fmt(fd[1], "info %s\n", sha1_to_hex(sha1));
+
+	line = packet_read_line(fd[0], &line_size);
+
+	if (line_size == 0)
+		return -1;
+
+	if (skip_prefix(line, "missing ", &arg))
+		return -1;
+
+	if (skip_prefix(line, "found ", &arg)) {
+		char *end = NULL;
+		unsigned char sha1[GIT_SHA1_RAWSZ];
+		enum object_type file_type;
+		unsigned long file_size;
+
+		if (get_sha1_hex(arg, sha1))
+			die("git on-demand: protocol error, "
+			    "expected to get sha in '%s'", line);
+		arg += GIT_SHA1_HEXSZ;
+
+		file_type = strtol(arg, &end, 0);
+		if (!end || file_type < 0 || file_type >= OBJ_MAX)
+			die("git on-demand: protocol error, "
+			    "invalid object type in '%s'", line);
+		arg = end;
+
+		file_size = strtoul(arg, &end, 0);
+		if (!end || *end || file_size > LONG_MAX)
+			die("git on-demand: protocol error, "
+			    "invalid file size in '%s'", line);
+
+		if (oi->typep)
+			*oi->typep = file_type;
+		if (oi->sizep)
+			*oi->typep = file_size;
+		if (oi->disk_sizep)
+			*oi->disk_sizep = 0;
+		oi->whence = OI_ONDEMAND;
+		return 0;
+	}
+
+	die("git on-demand: protocol error, "
+	    "unexpected response: '%s'", line);
+}
diff --git a/on_demand.h b/on_demand.h
new file mode 100644
index 0000000..09a8072
--- /dev/null
+++ b/on_demand.h
@@ -0,0 +1,8 @@
+#ifndef ON_DEMAND_H
+#define ON_DEMAND_H
+
+void *read_remote_on_demand(const unsigned char *sha1, enum object_type *type,
+			    unsigned long *size);
+int object_info_on_demand(const unsigned char *sha1, struct object_info *oi);
+
+#endif
diff --git a/sha1_file.c b/sha1_file.c
index 6628f06..510da41 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -27,6 +27,7 @@
 #include "list.h"
 #include "mergesort.h"
 #include "quote.h"
+#include "on_demand.h"
 
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
@@ -2979,7 +2980,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
 		if (!find_pack_entry(real, &e))
-			return -1;
+			return object_info_on_demand(real, oi);
 	}
 
 	/*
@@ -3091,7 +3092,10 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 		return buf;
 	}
 	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	buf = read_packed_sha1(sha1, type, size);
+	if (buf)
+		return buf;
+	return read_remote_on_demand(sha1, type, size);
 }
 
 /*
-- 
2.7.4

