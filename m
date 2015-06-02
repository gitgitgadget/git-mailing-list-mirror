From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 13/16] fetch-pack: use the configured transport protocol
Date: Mon,  1 Jun 2015 17:02:15 -0700
Message-ID: <1433203338-27493-14-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfo-0000kR-IV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbbFBADL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:11 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38555 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbbFBACu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:50 -0400
Received: by igbjd9 with SMTP id jd9so74730435igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EljAjRq0CkqW7aW5yuSJIbs7lMcM55dMHjG9l8OT1wo=;
        b=Yh8v7Qh3KNNFgpZbH+0KUWge+IujiSvtMkWOb+XlUavDQaGsbr8xTN1igdUAme/UPF
         fUhPygNm6cZRJWnYKJ+M2xUusHmdasg3d+HHW2FMsPcIxoJHMOmfil5yoJmcvToc6rRv
         gMirtZ3FnmxyOvP/AyJ5tJsM1K24nzb7CYdxPSip2eoYl56DucclGAm9KpZ8ecbn/vQj
         DtFtEYqmBuXPuyYg4FwshbQcC6T3UXHXl8zCcHDcJAlw2c04IB38q4NslMLTyoFaC5NL
         rAQ52iALrZsCZNA/vQQJ32vSesptHdtnwSW5LLt7obN8QddAQ5PQbuQ/oL0Yp/3VFcm9
         ms4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EljAjRq0CkqW7aW5yuSJIbs7lMcM55dMHjG9l8OT1wo=;
        b=khiKwlqE665oUxIfRpwgZYnmzgRlENcTDs2P2Nr7h8LYRJ6OMoMp0uajGHYHzoyIh0
         OX15eFQJJ0pqX/GuXovOAmUZUeFe0Y1MwI46Yo+WOgIIB5uqFPIInHRdOY5/3yXTV/EJ
         tri52imPdUlpPd2qc9Z4jQ1f7ULorYU/ulru/5FuHsNL0qak/D19W9A3i+N0gDzp6l1L
         PPNteQ274bpr/N5Ft+1FLmUY3gwiiUa0miZQKH7qgur5lz7gFv+7Y1Jeb9jwBCcZp4e3
         tLYSWNfbd+oTyKu8EUqcCFa0YI0nrRcQAgsbkYzdlDCVni08n+J40/T4q5fvLwwpflP3
         E76w==
X-Gm-Message-State: ALoCoQkGj3gTJm/TRgmncfEvS1o8ohD06eflhqhyBQM0JewmVcA2GLtfafg3Af6Y8I1VWm8aW6Hj
X-Received: by 10.50.41.8 with SMTP id b8mr16689763igl.38.1433203370029;
        Mon, 01 Jun 2015 17:02:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id ot6sm8904869igb.11.2015.06.01.17.02.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:49 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270492>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch-pack.c |  22 ++++++++++-
 fetch-pack.c         | 109 +++++++++++++++++++++++++++------------------------
 fetch-pack.h         |   1 +
 3 files changed, 80 insertions(+), 52 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4a6b340..be5c43e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -48,6 +48,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct child_process *conn;
 	struct fetch_pack_args args;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
+	struct transport_options select_options;
 
 	packet_trace_identity("fetch-pack");
 
@@ -127,6 +128,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!skip_prefix(arg, "--transport-version", &arg)) {
+			args.version = strtol(arg, NULL, 0);
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 
@@ -175,7 +180,22 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+	if (args.version == 0)
+		args.version = DEFAULT_TRANSPORT_VERSION;
+
+	switch (args.version) {
+	case 2:
+
+		get_remote_capabilities(fd[0], NULL, 0);
+		select_capabilities(args, &select_options);
+		request_capabilities(fd[1], &select_options);
+		/* fall through */
+	case 1:
+		get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+		break;
+	default:
+		die("Transport version %d not supported", args.version);
+	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr);
diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..b617128 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -23,7 +23,6 @@ static int prefer_ofs_delta = 1;
 static int no_done;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
-static int agent_supported;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
 
@@ -43,7 +42,8 @@ static int marked;
 #define MAX_IN_VAIN 256
 
 static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband, allow_tip_sha1_in_want;
+static int non_common_revs;
+static struct transport_options select_options;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -257,7 +257,7 @@ static int find_common(struct fetch_pack_args *args,
 	struct strbuf req_buf = STRBUF_INIT;
 	size_t state_len = 0;
 
-	if (args->stateless_rpc && multi_ack == 1)
+	if (args->stateless_rpc && select_options.multi_ack == 1)
 		die("--stateless-rpc requires multi_ack_detailed");
 	if (marked)
 		for_each_ref(clear_marks, NULL);
@@ -290,17 +290,17 @@ static int find_common(struct fetch_pack_args *args,
 		remote_hex = sha1_to_hex(remote);
 		if (!fetching) {
 			struct strbuf c = STRBUF_INIT;
-			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
-			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
-			if (no_done)            strbuf_addstr(&c, " no-done");
-			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
-			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
-			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
-			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
-			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
-			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
-			if (agent_supported)    strbuf_addf(&c, " agent=%s",
-							    git_user_agent_sanitized());
+			if (select_options.multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
+			if (select_options.multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
+			if (select_options.no_done)            strbuf_addstr(&c, " no-done");
+			if (select_options.use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
+			if (select_options.use_sideband == 1)  strbuf_addstr(&c, " side-band");
+			if (select_options.use_thin_pack)      strbuf_addstr(&c, " thin-pack");
+			if (select_options.no_progress)        strbuf_addstr(&c, " no-progress");
+			if (select_options.include_tag)        strbuf_addstr(&c, " include-tag");
+			if (select_options.prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			if (select_options.agent_supported)    strbuf_addf(&c, " agent=%s",
+									   git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
@@ -391,7 +391,7 @@ static int find_common(struct fetch_pack_args *args,
 				switch (ack) {
 				case ACK:
 					flushes = 0;
-					multi_ack = 0;
+					select_options.multi_ack = 0;
 					retval = 0;
 					goto done;
 				case ACK_common:
@@ -440,14 +440,14 @@ done:
 	if (args->verbose)
 		fprintf(stderr, "done\n");
 	if (retval != 0) {
-		multi_ack = 0;
+		select_options.multi_ack = 0;
 		flushes++;
 	}
 	strbuf_release(&req_buf);
 
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, fd[0]);
-	while (flushes || multi_ack) {
+	while (flushes || select_options.multi_ack) {
 		int ack = get_ack(fd[0], result_sha1);
 		if (ack) {
 			if (args->verbose)
@@ -455,7 +455,7 @@ done:
 					sha1_to_hex(result_sha1));
 			if (ack == ACK)
 				return 0;
-			multi_ack = 1;
+			select_options.multi_ack = 1;
 			continue;
 		}
 		flushes--;
@@ -542,7 +542,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	/* Append unmatched requests to the list */
-	if (allow_tip_sha1_in_want) {
+	if (select_options.allow_tip_sha1_in_want) {
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
@@ -671,7 +671,7 @@ static int get_pack(struct fetch_pack_args *args,
 	int ret;
 
 	memset(&demux, 0, sizeof(demux));
-	if (use_sideband) {
+	if (select_options.use_sideband) {
 		/* xd[] is talking with upload-pack; subprocess reads from
 		 * xd[0], spits out band#2 to stderr, and feeds us band#1
 		 * through demux->out.
@@ -752,7 +752,7 @@ static int get_pack(struct fetch_pack_args *args,
 		close(cmd.out);
 	}
 
-	if (!use_sideband)
+	if (!select_options.use_sideband)
 		/* Closed by start_command() */
 		xd[0] = -1;
 
@@ -763,84 +763,91 @@ static int get_pack(struct fetch_pack_args *args,
 			ret == 0;
 	else
 		die("%s failed", cmd_name);
-	if (use_sideband && finish_async(&demux))
+	if (select_options.use_sideband && finish_async(&demux))
 		die("error in sideband demultiplexer");
 	return 0;
 }
 
-static int cmp_ref_by_name(const void *a_, const void *b_)
-{
-	const struct ref *a = *((const struct ref **)a_);
-	const struct ref *b = *((const struct ref **)b_);
-	return strcmp(a->name, b->name);
-}
-
-static struct ref *do_fetch_pack(struct fetch_pack_args *args,
-				 int fd[2],
-				 const struct ref *orig_ref,
-				 struct ref **sought, int nr_sought,
-				 struct shallow_info *si,
-				 char **pack_lockfile)
+void select_capabilities(struct fetch_pack_args *args, struct transport_options *options)
 {
-	struct ref *ref = copy_ref_list(orig_ref);
-	unsigned char sha1[20];
 	const char *agent_feature;
 	int agent_len;
 
-	sort_ref_list(&ref, ref_compare_name);
-	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
-
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
 	if (server_supports("multi_ack_detailed")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
-		multi_ack = 2;
+		options->multi_ack = 2;
 		if (server_supports("no-done")) {
 			if (args->verbose)
 				fprintf(stderr, "Server supports no-done\n");
 			if (args->stateless_rpc)
-				no_done = 1;
+				options->no_done = 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports multi_ack\n");
-		multi_ack = 1;
+		options->multi_ack = 1;
 	}
 	if (server_supports("side-band-64k")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports side-band-64k\n");
-		use_sideband = 2;
+		options->use_sideband = 2;
 	}
 	else if (server_supports("side-band")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports side-band\n");
-		use_sideband = 1;
+		options->use_sideband = 1;
 	}
 	if (server_supports("allow-tip-sha1-in-want")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports allow-tip-sha1-in-want\n");
-		allow_tip_sha1_in_want = 1;
+		options->allow_tip_sha1_in_want = 1;
 	}
 	if (!server_supports("thin-pack"))
-		args->use_thin_pack = 0;
+		options->use_thin_pack = 0;
 	if (!server_supports("no-progress"))
-		args->no_progress = 0;
+		options->no_progress = 0;
 	if (!server_supports("include-tag"))
-		args->include_tag = 0;
+		options->include_tag = 0;
 	if (server_supports("ofs-delta")) {
 		if (args->verbose)
 			fprintf(stderr, "Server supports ofs-delta\n");
+		options->prefer_ofs_delta = 1;
 	} else
-		prefer_ofs_delta = 0;
+		options->prefer_ofs_delta = 0;
 
 	if ((agent_feature = server_feature_value("agent", &agent_len))) {
-		agent_supported = 1;
+		options->agent_supported = 1;
 		if (args->verbose && agent_len)
 			fprintf(stderr, "Server version is %.*s\n",
 				agent_len, agent_feature);
 	}
+}
+
+static int cmp_ref_by_name(const void *a_, const void *b_)
+{
+	const struct ref *a = *((const struct ref **)a_);
+	const struct ref *b = *((const struct ref **)b_);
+	return strcmp(a->name, b->name);
+}
+
+static struct ref *do_fetch_pack(struct fetch_pack_args *args,
+				 int fd[2],
+				 const struct ref *orig_ref,
+				 struct ref **sought, int nr_sought,
+				 struct shallow_info *si,
+				 char **pack_lockfile)
+{
+	struct ref *ref = copy_ref_list(orig_ref);
+	unsigned char sha1[20];
+
+	sort_ref_list(&ref, ref_compare_name);
+	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
+
+	select_capabilities(args, &select_options);
 
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..b48b4f5 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	int version;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
-- 
2.4.1.345.gab207b6.dirty
