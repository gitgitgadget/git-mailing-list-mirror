Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC33203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbdGXViS (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:38:18 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35206 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbdGXViQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:38:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id h29so16482695pfd.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XERmNw2kecfOBbQnUvQoXHT1nU1gLzQrNAGIxxs95bQ=;
        b=SGu2b7GNeCrrQNQHE6CilIAofuEi5BIEmNoVk86p5lcC3a5fmtzpZygNJA/+DPQwuM
         RfLrAZLNMxN6QkQ0RiK43vP2uG7Rhx4ajMeHeqWcGEilfvfN2g6lnKasvxgWeoxEn60i
         W8aAgt6AURPZinuS8Ydpb9BZMhzagSUku+sdkm6UdXWxD1hMeZZ0BpLVioVo2Oh/NQ0c
         wDXfjXKkEFlyoPyttkE+SnKGCGtCwGn8Zv3DIKxrlOmmygFhGfq19YLTp/TzX13BxSFQ
         46syeX0fV5WNiELQe3z9P3WUilwvsZZBrlvRaTK+ug0H5aLYvaE/23ObtWp+HV1iyOPq
         5bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XERmNw2kecfOBbQnUvQoXHT1nU1gLzQrNAGIxxs95bQ=;
        b=cJ8Gap5nmv5vZ8IGD6TFu+H+KSJ0rxbw/4gRFaAwENZE9E0dqPcilBAgzpNfb6Hnt7
         3naeI+fPswzIBZ6j5xx3Tt/Juno4dFFMMX2kz5rd7QdcfUeEBTI1yvU64VkUvy/CoBFU
         HB26k8ct4UvHSAfmD2NIpWHK1rNduOPiM6fJmUNdPvIpaYoesqJEh3wkuXH+cRsidiBk
         bFpzuL4O30rB2TLpRdfdrL/03JU+7EADBdfDA89y07qJ/g/FrmRlPJ+zfhpHuKP7ZLgh
         IdBgL3r1eQBUMF1rC7OuxplQ2nfL4TQeoBrW39bZAH877gQPE2tLKKT3G+N8FY/c6SKJ
         RIBw==
X-Gm-Message-State: AIVw112GlRSrwAs1fGspYP5IuCBh5kCPkBcve9hV+9vL2L+LuhsUrWcL
        ZGL9z7oUep2ITZTkXMGlJg==
X-Received: by 10.84.131.71 with SMTP id 65mr18941912pld.35.1500932294893;
        Mon, 24 Jul 2017 14:38:14 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r62sm25166730pfl.45.2017.07.24.14.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 14:38:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, benpeart@microsoft.com,
        larsxschneider@gmail.com
Subject: [PATCH] sub-process: refactor handshake to common function
Date:   Mon, 24 Jul 2017 14:38:10 -0700
Message-Id: <20170724213810.29831-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor, into a common function, the version and capability negotiation
done when invoking a long-running process as a clean or smudge filter.
This will be useful for other Git code that needs to interact similarly
with a long-running process.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This will be useful for anyone implementing functionality like that in
[1].

It is unfortunate that the code grew larger because it had to be more
generic, but I think this is better than having (in the future) 2 or
more separate handshake functions.

I also don't think that the protocol should be permissive - I think
things would be simpler if all protocol errors were fatal errors. As it
is, most parts are permissive, but packet_read_line() already dies
anyway upon a malformed packet, so it may not be too drastic a change to
change this. For reference, the original protocol comes from [2].

[1] https://public-inbox.org/git/20170714132651.170708-2-benpeart@microsoft.com/
[2] edcc858 ("convert: add filter.<driver>.process option", 2016-10-17)
---
 convert.c             | 61 ++++-----------------------------
 pkt-line.c            | 19 -----------
 pkt-line.h            |  2 --
 sub-process.c         | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sub-process.h         | 18 ++++++++++
 t/t0021-conversion.sh |  2 +-
 6 files changed, 120 insertions(+), 76 deletions(-)

diff --git a/convert.c b/convert.c
index deaf0ba7b..ec8ecc2ea 100644
--- a/convert.c
+++ b/convert.c
@@ -512,62 +512,15 @@ static struct hashmap subprocess_map;
 
 static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	int err;
+	static int versions[] = {2, 0};
+	static struct subprocess_capability capabilities[] = {
+		{"clean", CAP_CLEAN}, {"smudge", CAP_SMUDGE}, {NULL, 0}
+	};
 	struct cmd2process *entry = (struct cmd2process *)subprocess;
-	struct string_list cap_list = STRING_LIST_INIT_NODUP;
-	char *cap_buf;
-	const char *cap_name;
-	struct child_process *process = &subprocess->process;
-	const char *cmd = subprocess->cmd;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
-	if (err)
-		goto done;
-
-	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
-	if (err) {
-		error("external filter '%s' does not support filter protocol version 2", cmd);
-		goto done;
-	}
-	err = strcmp(packet_read_line(process->out, NULL), "version=2");
-	if (err)
-		goto done;
-	err = packet_read_line(process->out, NULL) != NULL;
-	if (err)
-		goto done;
-
-	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
-
-	for (;;) {
-		cap_buf = packet_read_line(process->out, NULL);
-		if (!cap_buf)
-			break;
-		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
-
-		if (cap_list.nr != 2 || strcmp(cap_list.items[0].string, "capability"))
-			continue;
-
-		cap_name = cap_list.items[1].string;
-		if (!strcmp(cap_name, "clean")) {
-			entry->supported_capabilities |= CAP_CLEAN;
-		} else if (!strcmp(cap_name, "smudge")) {
-			entry->supported_capabilities |= CAP_SMUDGE;
-		} else {
-			warning(
-				"external filter '%s' requested unsupported filter capability '%s'",
-				cmd, cap_name
-			);
-		}
-
-		string_list_clear(&cap_list, 0);
-	}
-
-done:
-	sigchain_pop(SIGPIPE);
 
-	return err;
+	return subprocess_handshake(subprocess, "git-filter-", versions, NULL,
+				    capabilities,
+				    &entry->supported_capabilities);
 }
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
diff --git a/pkt-line.c b/pkt-line.c
index 9d845ecc3..7db911957 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,25 +171,6 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
-int packet_writel(int fd, const char *line, ...)
-{
-	va_list args;
-	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 450183b64..66ef610fc 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,8 +25,6 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-LAST_ARG_MUST_BE_NULL
-int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
diff --git a/sub-process.c b/sub-process.c
index a3cfab1a9..1a3f39bdf 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -105,3 +105,97 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	hashmap_add(hashmap, entry);
 	return 0;
 }
+
+int subprocess_handshake(struct subprocess_entry *entry,
+			 const char *welcome_prefix,
+			 int *versions,
+			 int *chosen_version,
+			 struct subprocess_capability *capabilities,
+			 unsigned int *supported_capabilities) {
+	int version_scratch;
+	unsigned int capabilities_scratch;
+	struct child_process *process = &entry->process;
+	int i;
+	char *line;
+	const char *p;
+
+	if (!chosen_version)
+		chosen_version = &version_scratch;
+	if (!supported_capabilities)
+		supported_capabilities = &capabilities_scratch;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (packet_write_fmt_gently(process->in, "%sclient\n",
+				    welcome_prefix)) {
+		error("Could not write client identification");
+		goto error;
+	}
+	for (i = 0; versions[i]; i++) {
+		if (packet_write_fmt_gently(process->in, "version=%d\n",
+					    versions[i])) {
+			error("Could not write requested version");
+			goto error;
+		}
+	}
+	if (packet_flush_gently(process->in))
+		goto error;
+
+	if (!(line = packet_read_line(process->out, NULL)) ||
+	    !skip_prefix(line, welcome_prefix, &p) ||
+	    strcmp(p, "server")) {
+		error("Unexpected line '%s', expected %sserver",
+		      line ? line : "<flush packet>", welcome_prefix);
+		goto error;
+	}
+	if (!(line = packet_read_line(process->out, NULL)) ||
+	    !skip_prefix(line, "version=", &p) ||
+	    strtol_i(p, 10, chosen_version)) {
+		error("Unexpected line '%s', expected version",
+		      line ? line : "<flush packet>");
+		goto error;
+	}
+	for (i = 0; versions[i]; i++) {
+		if (versions[i] == *chosen_version)
+			goto version_found;
+	}
+	error("Version %d not supported", *chosen_version);
+	goto error;
+version_found:
+	if ((line = packet_read_line(process->out, NULL))) {
+		error("Unexpected line '%s', expected flush", line);
+		goto error;
+	}
+
+	for (i = 0; capabilities[i].name; i++) {
+		if (packet_write_fmt_gently(process->in, "capability=%s\n",
+					    capabilities[i].name)) {
+			error("Could not write requested capability");
+			goto error;
+		}
+	}
+	if (packet_flush_gently(process->in))
+		goto error;
+
+	while ((line = packet_read_line(process->out, NULL))) {
+		if (!skip_prefix(line, "capability=", &p))
+			continue;
+
+		for (i = 0; capabilities[i].name; i++) {
+			if (!strcmp(p, capabilities[i].name)) {
+				*supported_capabilities |= capabilities[i].flag;
+				goto capability_found;
+			}
+		}
+		warning("external filter requested unsupported filter capability '%s'",
+			p);
+capability_found:
+		;
+	}
+
+	sigchain_pop(SIGPIPE);
+	return 0;
+error:
+	sigchain_pop(SIGPIPE);
+	return 1;
+}
diff --git a/sub-process.h b/sub-process.h
index 96a2cca36..a72e7f7cf 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -18,6 +18,11 @@ struct subprocess_entry {
 	struct child_process process;
 };
 
+struct subprocess_capability {
+	const char *name;
+	unsigned int flag;
+};
+
 /* subprocess functions */
 
 extern int cmd2process_cmp(const void *unused_cmp_data,
@@ -41,6 +46,19 @@ static inline struct child_process *subprocess_get_child_process(
 	return &entry->process;
 }
 
+/*
+ * Perform the handshake to a long-running process as described in the
+ * gitattributes documentation using the given requested versions and
+ * capabilities. The "versions" and "capabilities" parameters are arrays
+ * terminated by a 0 or blank struct.
+ */
+int subprocess_handshake(struct subprocess_entry *entry,
+			 const char *welcome_prefix,
+			 int *versions,
+			 int *chosen_version,
+			 struct subprocess_capability *capabilities,
+			 unsigned int *supported_capabilities);
+
 /*
  * Helper function that will read packets looking for "status=<foo>"
  * key/value pairs and return the value from the last "status" packet
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 161f56044..d191a7228 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -697,7 +697,7 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 
 		cp "$TEST_ROOT/test.o" test.r &&
 		test_must_fail git add . 2>git-stderr.log &&
-		grep "does not support filter protocol version" git-stderr.log
+		grep "expected git-filter-server" git-stderr.log
 	)
 '
 
-- 
2.14.0.rc0.400.g1c36432dff-goog

