Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C255920281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbdI2UMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:51 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:50919 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbdI2UMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:24 -0400
Received: by mail-pf0-f178.google.com with SMTP id m63so334412pfk.7
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fqu1YMcxv2a6GTbQTZ+hU13MYtbHtM4KGpPS+uMM50U=;
        b=QDbUTpIXkJZin+7Ld1aV6sHFjrZTfJjydiUeksH//UsjxBYoS371zedhrv4JXlD1y6
         NdE2+/T+wnyGvvS7Q9cDCSkSoTjAmTjbpDPUEquVf7zTCFZZf0utzpwlEU0Qqz36lY6y
         7Y4DM5USvTBGsna6J0AkfRDyK36Tu4/guCEmLCybTeXaaWFkD5wQvhIPPDoyThbONlFd
         eNv0fVj4j7vZDVJmqzZuf9ILvt8sp2FjhvmLxlp55/o2jWF3AHnSHrTdc8nZS6JxfF3i
         Ew/JLGoH6uhB5i6jhRwqWN4OtoMTSEsSfy1x+pMXY2uRZpnCAQauY1msJNOTbPP7MpEr
         eoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fqu1YMcxv2a6GTbQTZ+hU13MYtbHtM4KGpPS+uMM50U=;
        b=Sdst7p71EP8Yg13rbb1zgbu/jPKpJKRVU2ssNev0UVG9FcrnsZlolkl0QbA7s6sXWx
         COVsXwf1AvTkSei5S3GykIFEjVyuVVoBTe0ZW09q16YdE54DyE8DZFo7W4ukJJazjIY+
         uWaV7Oa1mQDK1ODnjhJggD/Kv5bHXLTuW3/uLHorft97ciSjNzwQAklh+Up5DD/H56qf
         pwYcaboiRQPQ6C+rycoTVthu9VmyVA7V+bWrixJ4F4jPDkw7ChOaDHsae2bForCQevYA
         nGkBWGMn2e8sZPcy4jE29NaoTvH9dUg64ZnfSz8PL+DUn0D8NfbqMB6odXfkw8y6qokW
         H5zA==
X-Gm-Message-State: AHPjjUjncRMTcZGucsR7lM2lafaUqmIy9XqSe5Xku5Lbgcd+9M6FQSBB
        48Mb2UVxKGfyvAsA1IKDA6/mCSt9SW0=
X-Google-Smtp-Source: AOwi7QADUcqnTC3kI/ytUUNdZCrKBkrdOEFWXlk+0lR3BYjmD9+163VmkYcuBreDNw5nH2IIz+V4DA==
X-Received: by 10.98.33.80 with SMTP id h77mr8968915pfh.18.1506715943087;
        Fri, 29 Sep 2017 13:12:23 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 12/18] fetch-pack: support excluding large blobs
Date:   Fri, 29 Sep 2017 13:11:48 -0700
Message-Id: <f211093280b422c32cc1b7034130072f35c5ed51.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch-pack and upload-pack to support excluding large blobs
through a blob-max-bytes parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/pack-protocol.txt         |  9 ++++++++
 Documentation/technical/protocol-capabilities.txt |  7 ++++++
 builtin/fetch-pack.c                              | 11 +++++++++
 fetch-pack.c                                      | 11 +++++++++
 fetch-pack.h                                      |  1 +
 t/t5500-fetch-pack.sh                             | 27 +++++++++++++++++++++++
 upload-pack.c                                     | 16 +++++++++++++-
 7 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index ed1eae8b8..db0e1150b 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -212,6 +212,7 @@ out of what the server said it could do with the first 'want' line.
   upload-request    =  want-list
 		       *shallow-line
 		       *1depth-request
+		       *1blob-max-bytes
 		       flush-pkt
 
   want-list         =  first-want
@@ -223,10 +224,14 @@ out of what the server said it could do with the first 'want' line.
 		       PKT-LINE("deepen-since" SP timestamp) /
 		       PKT-LINE("deepen-not" SP ref)
 
+  blob-max-bytes    =  PKT-LINE("blob-max-bytes" SP magnitude)
+
   first-want        =  PKT-LINE("want" SP obj-id SP capability-list)
   additional-want   =  PKT-LINE("want" SP obj-id)
 
   depth             =  1*DIGIT
+
+  magnitude         =  1*DIGIT
 ----
 
 Clients MUST send all the obj-ids it wants from the reference
@@ -249,6 +254,10 @@ complete those commits. Commits whose parents are not received as a
 result are defined as shallow and marked as such in the server. This
 information is sent back to the client in the next step.
 
+The client can optionally request a partial packfile that omits blobs
+above a certain size threshold using "blob-max-bytes". Files whose names
+start with ".git" are always included in the packfile, however.
+
 Once all the 'want's and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
 that it is done sending the list.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 26dcc6f50..7e878fce5 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -309,3 +309,10 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+blob-max-bytes
+--------------
+
+If the upload-pack server advertises this capability, fetch-pack
+may send "blob-max-bytes" to request the server to omit blobs above a
+certain size from the packfile.
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9a7ebf6e9..116be9bf5 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -4,6 +4,7 @@
 #include "remote.h"
 #include "connect.h"
 #include "sha1-array.h"
+#include "config.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
@@ -153,6 +154,16 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.no_haves = 1;
 			continue;
 		}
+		if (skip_prefix(arg, "--blob-max-bytes=", &arg)) {
+			unsigned long *ptr = xmalloc(sizeof(*ptr));
+			if (!git_parse_ulong(arg, ptr)) {
+				error("Invalid --blob-max-bytes value: %s",
+				      arg);
+				usage(fetch_pack_usage);
+			}
+			args.blob_max_bytes = ptr;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/fetch-pack.c b/fetch-pack.c
index d376c4ef1..19b8e9322 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -26,6 +26,7 @@ static int prefer_ofs_delta = 1;
 static int no_done;
 static int deepen_since_ok;
 static int deepen_not_ok;
+static int blob_max_bytes_ok;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
@@ -407,6 +408,13 @@ static int find_common(struct fetch_pack_args *args,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
+	if (args->blob_max_bytes) {
+		if (blob_max_bytes_ok)
+			packet_buf_write(&req_buf, "blob-max-bytes %ld",
+					 *args->blob_max_bytes);
+		else
+			warning("blob-max-bytes not recognized by server, ignoring");
+	}
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -983,6 +991,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("Server does not support --shallow-exclude"));
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
+	if (server_supports("blob-max-bytes"))
+		blob_max_bytes_ok = 1;
 
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
@@ -1169,6 +1179,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
+
 	prepare_shallow_info(&si, shallow);
 	ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 				&si, pack_lockfile);
diff --git a/fetch-pack.h b/fetch-pack.h
index 84904c348..3743a0ab2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -12,6 +12,7 @@ struct fetch_pack_args {
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
+	unsigned long *blob_max_bytes;
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 80a1a3239..62e384230 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -755,4 +755,31 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success '--blob-max-bytes' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_config -C server uploadpack.advertiseblobmaxbytes 1 &&
+
+	test_create_repo client &&
+	git -C client fetch-pack --blob-max-bytes=0 ../server HEAD &&
+
+	# Ensure that object is not inadvertently fetched
+	test_must_fail git -C client cat-file -e $(git hash-object server/one.t)
+'
+
+test_expect_success '--blob-max-bytes has no effect if support for it is not advertised' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_create_repo client &&
+	git -C client fetch-pack --blob-max-bytes=0 ../server HEAD 2> err &&
+
+	# Ensure that object is fetched
+	git -C client cat-file -e $(git hash-object server/one.t) &&
+
+	test_i18ngrep "blob-max-bytes not recognized by server" err
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbf..484704eb6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -63,6 +63,8 @@ static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
+static int advertise_blob_max_bytes;
+static char *blob_max_bytes;
 
 static void reset_timeout(void)
 {
@@ -131,6 +133,8 @@ static void create_pack_file(void)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
+	if (blob_max_bytes)
+		argv_array_push(&pack_objects.args, blob_max_bytes);
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
@@ -794,6 +798,13 @@ static void receive_needs(void)
 			deepen_rev_list = 1;
 			continue;
 		}
+		if (skip_prefix(line, "blob-max-bytes ", &arg)) {
+			unsigned long s;
+			if (!git_parse_ulong(arg, &s))
+				die("git upload-pack: invalid blob-max-bytes value: %s", line);
+			blob_max_bytes = xstrfmt("--blob-max-bytes=%lu", s);
+			continue;
+		}
 		if (!skip_prefix(line, "want ", &arg) ||
 		    get_oid_hex(arg, &oid_buf))
 			die("git upload-pack: protocol error, "
@@ -940,7 +951,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 		struct strbuf symref_info = STRBUF_INIT;
 
 		format_symref_info(&symref_info, cb_data);
-		packet_write_fmt(1, "%s %s%c%s%s%s%s%s agent=%s\n",
+		packet_write_fmt(1, "%s %s%c%s%s%s%s%s%s agent=%s\n",
 			     oid_to_hex(oid), refname_nons,
 			     0, capabilities,
 			     (allow_unadvertised_object_request & ALLOW_TIP_SHA1) ?
@@ -949,6 +960,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-reachable-sha1-in-want" : "",
 			     stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
+			     advertise_blob_max_bytes ? " blob-max-bytes" : "",
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
@@ -1028,6 +1040,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	} else if (current_config_scope() != CONFIG_SCOPE_REPO) {
 		if (!strcmp("uploadpack.packobjectshook", var))
 			return git_config_string(&pack_objects_hook, var, value);
+	} else if (!strcmp("uploadpack.advertiseblobmaxbytes", var)) {
+		advertise_blob_max_bytes = git_config_bool(var, value);
 	}
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
-- 
2.14.2.822.g60be5d43e6-goog

