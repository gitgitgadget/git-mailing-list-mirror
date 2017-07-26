Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250172047F
	for <e@80x24.org>; Wed, 26 Jul 2017 18:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdGZSRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 14:17:46 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32944 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdGZSRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 14:17:44 -0400
Received: by mail-pf0-f170.google.com with SMTP id d67so6046312pfc.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mM2Es+EEE/JbOOAs8AwdSIRXRu/QBCI1mYXTqxyCEUY=;
        b=pZVIxczXDTnNlpSjpROPvXD1Wy/u+60QmiO15VQ3hMgPbZChNukYhClpj+Kbuf32qB
         SUFP5zT9rcDbeD463rE3THTZkV8pQS3H4aQjtdGY1H+gr5gQL+OQ9AEEvElj/wMgXeI6
         Rx+dPYzoXgLppCGGbl7xcez3O2wH5XMOC1dLn+RNBSD+NeT9JfgvcOKL0n+x4G/nQdQL
         NmFs2+KF7NEdtejrIvgu3u6RH7vklBxRFnbeE57Qj8J8Vem6bS5iGnBDdxiIc/PLyhl0
         fFMriH2uqn2RfqSZDP8O89gEdgn6gDay5L8CqOTrBqeCzfqobkobsw96HSZqjFXrdjC2
         Wj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mM2Es+EEE/JbOOAs8AwdSIRXRu/QBCI1mYXTqxyCEUY=;
        b=hBmKLBgHGDH12IKcJXovY6GrUdVxmVNPLUFQ874D6TO8/05vPmeVTBGb46o03IgaLR
         Uaz8FUJ+S8ICJ8Kp95pGnwI2/HeTHgwn5LeBunqPtqc/v98Nuqa7GsW//CLXsNapPm/S
         b7UGtX420VnS6Tl/BkKKbHhh3o5hNu8AnljRdiEDxFvctqZoOHRJ7yFqCa4emnARB/ar
         Lf/hBYOKKz+yjURRLj9iHdlqJ/7ikqx3qkgO3gbVCz+0LHtgB/5JURE8UX2LeHuFJyVy
         Grazd4vQvFHGam0GWocnToBxf0KdajmZxDEHDv7U5hhNcRy+/wAGPQJpnak+D23LTO6n
         nkbQ==
X-Gm-Message-State: AIVw111iyWKAErCCZeJAy6RtcvlNZaza5VfijUpa6ce1XfunBrnMelsB
        OPe2SuIEb96eSnD7ERv/cQ==
X-Received: by 10.99.51.142 with SMTP id z136mr1672842pgz.275.1501093063531;
        Wed, 26 Jul 2017 11:17:43 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w24sm6637038pfk.183.2017.07.26.11.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 11:17:41 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: [PATCH for NEXT v3 2/2] sub-process: refactor handshake to common function
Date:   Wed, 26 Jul 2017 11:17:29 -0700
Message-Id: <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501092795.git.jonathantanmy@google.com>
References: <cover.1501092795.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501092795.git.jonathantanmy@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com> <cover.1501092795.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor, into a common function, the version and capability negotiation
done when invoking a long-running process as a clean or smudge filter.
This will be useful for other Git code that needs to interact similarly
with a long-running process.

As you can see in the change to t0021, this commit changes the error
message reported when the long-running process does not introduce itself
with the expected "server"-terminated line. Originally, the error
message reports that the filter "does not support filter protocol
version 2", differentiating between the old single-file filter protocol
and the new multi-file filter protocol - I have updated it to something
more generic and useful.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 convert.c             |  75 ++++--------------------------------
 pkt-line.c            |  19 ----------
 pkt-line.h            |   2 -
 sub-process.c         | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sub-process.h         |  26 +++++++++++++
 t/t0021-conversion.sh |   2 +-
 6 files changed, 137 insertions(+), 90 deletions(-)

diff --git a/convert.c b/convert.c
index dbdbb24e4..1012462e3 100644
--- a/convert.c
+++ b/convert.c
@@ -513,78 +513,17 @@ static struct hashmap subprocess_map;
 
 static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	int err, i;
-	struct cmd2process *entry = (struct cmd2process *)subprocess;
-	struct string_list cap_list = STRING_LIST_INIT_NODUP;
-	char *cap_buf;
-	const char *cap_name;
-	struct child_process *process = &subprocess->process;
-	const char *cmd = subprocess->cmd;
-
-	static const struct {
-		const char *name;
-		unsigned int cap;
-	} known_caps[] = {
+	static int versions[] = {2, 0};
+	static struct subprocess_capability capabilities[] = {
 		{ "clean",  CAP_CLEAN  },
 		{ "smudge", CAP_SMUDGE },
 		{ "delay",  CAP_DELAY  },
+		{ NULL, 0 }
 	};
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
-	for (i = 0; i < ARRAY_SIZE(known_caps); ++i) {
-		err = packet_write_fmt_gently(
-			process->in, "capability=%s\n", known_caps[i].name);
-		if (err)
-			goto done;
-	}
-	err = packet_flush_gently(process->in);
-	if (err)
-		goto done;
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
-		i = ARRAY_SIZE(known_caps) - 1;
-		while (i >= 0 && strcmp(cap_name, known_caps[i].name))
-			i--;
-
-		if (i >= 0)
-			entry->supported_capabilities |= known_caps[i].cap;
-		else
-			warning("external filter '%s' requested unsupported filter capability '%s'",
-			cmd, cap_name);
-
-		string_list_clear(&cap_list, 0);
-	}
-
-done:
-	sigchain_pop(SIGPIPE);
-
-	return err;
+	struct cmd2process *entry = (struct cmd2process *)subprocess;
+	return subprocess_handshake(subprocess, "git-filter", versions, NULL,
+				    capabilities,
+				    &entry->supported_capabilities);
 }
 
 static void handle_filter_error(const struct strbuf *filter_status,
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
index 6cbffa440..37b4bd0ad 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -108,3 +108,106 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	hashmap_add(hashmap, entry);
 	return 0;
 }
+
+static int handshake_version(struct child_process *process,
+			     const char *welcome_prefix, int *versions,
+			     int *chosen_version)
+{
+	int version_scratch;
+	int i;
+	char *line;
+	const char *p;
+
+	if (!chosen_version)
+		chosen_version = &version_scratch;
+
+	if (packet_write_fmt_gently(process->in, "%s-client\n",
+				    welcome_prefix))
+		return error("Could not write client identification");
+	for (i = 0; versions[i]; i++) {
+		if (packet_write_fmt_gently(process->in, "version=%d\n",
+					    versions[i]))
+			return error("Could not write requested version");
+	}
+	if (packet_flush_gently(process->in))
+		return error("Could not write flush packet");
+
+	if (!(line = packet_read_line(process->out, NULL)) ||
+	    !skip_prefix(line, welcome_prefix, &p) ||
+	    strcmp(p, "-server"))
+		return error("Unexpected line '%s', expected %s-server",
+			     line ? line : "<flush packet>", welcome_prefix);
+	if (!(line = packet_read_line(process->out, NULL)) ||
+	    !skip_prefix(line, "version=", &p) ||
+	    strtol_i(p, 10, chosen_version))
+		return error("Unexpected line '%s', expected version",
+			     line ? line : "<flush packet>");
+	if ((line = packet_read_line(process->out, NULL)))
+		return error("Unexpected line '%s', expected flush", line);
+
+	/* Check to make sure that the version received is supported */
+	for (i = 0; versions[i]; i++) {
+		if (versions[i] == *chosen_version)
+			break;
+	}
+	if (!versions[i])
+		return error("Version %d not supported", *chosen_version);
+
+	return 0;
+}
+
+static int handshake_capabilities(struct child_process *process,
+				  struct subprocess_capability *capabilities,
+				  unsigned int *supported_capabilities)
+{
+	int i;
+	char *line;
+
+	for (i = 0; capabilities[i].name; i++) {
+		if (packet_write_fmt_gently(process->in, "capability=%s\n",
+					    capabilities[i].name))
+			return error("Could not write requested capability");
+	}
+	if (packet_flush_gently(process->in))
+		return error("Could not write flush packet");
+
+	while ((line = packet_read_line(process->out, NULL))) {
+		const char *p;
+		if (!skip_prefix(line, "capability=", &p))
+			continue;
+
+		for (i = 0;
+		     capabilities[i].name && strcmp(p, capabilities[i].name);
+		     i++)
+			;
+		if (capabilities[i].name) {
+			if (supported_capabilities)
+				*supported_capabilities |= capabilities[i].flag;
+		} else {
+			warning("external filter requested unsupported filter capability '%s'",
+				p);
+		}
+	}
+
+	return 0;
+}
+
+int subprocess_handshake(struct subprocess_entry *entry,
+			 const char *welcome_prefix,
+			 int *versions,
+			 int *chosen_version,
+			 struct subprocess_capability *capabilities,
+			 unsigned int *supported_capabilities) {
+	int retval;
+	struct child_process *process = &entry->process;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	retval = handshake_version(process, welcome_prefix, versions,
+				   chosen_version) ||
+		 handshake_capabilities(process, capabilities,
+					supported_capabilities);
+
+	sigchain_pop(SIGPIPE);
+	return retval;
+}
diff --git a/sub-process.h b/sub-process.h
index d37c1499a..6857eb1b5 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -29,6 +29,16 @@ struct subprocess_entry {
 	struct child_process process;
 };
 
+struct subprocess_capability {
+	const char *name;
+
+	/*
+	 * subprocess_handshake will "|=" this value to supported_capabilities
+	 * if the server reports that it supports this capability.
+	 */
+	unsigned int flag;
+};
+
 /* subprocess functions */
 
 /* Function to test two subprocess hashmap entries for equality. */
@@ -62,6 +72,22 @@ static inline struct child_process *subprocess_get_child_process(
 	return &entry->process;
 }
 
+/*
+ * Perform the version and capability negotiation as described in the "Long
+ * Running Filter Process" section of the gitattributes documentation using the
+ * given requested versions and capabilities. The "versions" and "capabilities"
+ * parameters are arrays terminated by a 0 or blank struct.
+ *
+ * This function is typically called when a subprocess is started (as part of
+ * the "startfn" passed to subprocess_start).
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
index eb3d83744..46f8e583c 100755
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

