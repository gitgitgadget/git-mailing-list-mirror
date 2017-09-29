Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0AEF20281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbdI2UMj (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:39 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:49990 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbdI2UM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:27 -0400
Received: by mail-pf0-f180.google.com with SMTP id l188so335169pfc.6
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pkmI/8TRjRCAkkgLnk4E8gtlaNdIRA6hjsPOjkj51j0=;
        b=m+BwX5J1/5R74aNxdr33ilBsNAMEf1rIVizeyH+Tn5rItAdw4m5Xu986J5+ZrCNb+n
         arD3zvhBa1Udb0dx3unRNZiuI83difw4Bb/GNsoxYsI788yVRu8sU/1srEMLbGvNRWl/
         5/KWjpC/vcRUNAIfuOsUaKFK9xGAM4h2GMTJVNR6RmLxFDs6scJpxAyKXZgY9t/+Ij5W
         AA+uMeHRYAAkPiYwHzWQqeow1o5lO3iLGOkSW+1NCfOzNJuXP39jWDcp2DA/01xeoXSP
         sicS+WMytFr3DTMid70bo3+8I7xNPYq2MvjwCGuFiDz77LWCv1FxMz0Qj89Z5ukPAy9B
         gAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pkmI/8TRjRCAkkgLnk4E8gtlaNdIRA6hjsPOjkj51j0=;
        b=dNAxmnqfPqzPxkhRxMaa0UPqQSD6mol43AkStZjrMAfKAdWy1GPuSqv22VZ3fH+yGI
         ZGv9A155VDvQrKyNBaCzOaVtvKvU4FHPTSdH8jlEcGK9a3khXg5wT8x00xQx0Oh8gdt2
         0+OEHtdZDI8vWFzoolxTRr41IFZcTvbBBekUoT34S4CIoG1qkWaHZHfdCp775WCYx0LD
         o3BYRhNfHSeTcqVvY4GJu4SI0rCx8051kv6d2W61jg3ZVh6BowOmJ3q6+dB/SqplFkQd
         iR3CQlqArRCqS1sUGfPHgdEyF5R87K81FJ9rUTwTklt+vSunImfq6vSwP/VnE27ArqVH
         4GaQ==
X-Gm-Message-State: AHPjjUh4tDS7VyEHsG8xbTKB+wIvHbEe/lJz4VYfA64FncmQPNBKFGIR
        iJ2y+N+g2Uu5m5FgteuJlKp5FBF5UxQ=
X-Google-Smtp-Source: AOwi7QBg902nMa6/E/O2JSytTuTdhUWZdnhcWVDvR2ttsKrV+QKK+bSlJOM0TQtrNPq5I1rnOOmzbA==
X-Received: by 10.98.131.141 with SMTP id h135mr8847901pfe.204.1506715946115;
        Fri, 29 Sep 2017 13:12:26 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:25 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 14/18] fetch: support excluding large blobs
Date:   Fri, 29 Sep 2017 13:11:50 -0700
Message-Id: <ca676ac57279ff21c23b5fe0bb3391845b166f20.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch to support excluding large blobs through a blob-max-bytes
parameter. This is only allowed for the remote configured in
extensions.partialclone.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c       | 22 ++++++++++++++++++++--
 connected.c           |  1 +
 remote-curl.c         |  7 +++++++
 t/t5500-fetch-pack.sh | 36 ++++++++++++++++++++++++++++++++++++
 transport-helper.c    |  4 ++++
 transport.c           | 10 ++++++++++
 transport.h           |  4 ++++
 7 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1b1f03923..07beaf5b5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -55,6 +55,7 @@ static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static const char *blob_max_bytes;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -160,6 +161,8 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_STRING(0, "blob-max-bytes", &blob_max_bytes, N_("bytes"),
+		   N_("do not fetch blobs above this size")),
 	OPT_END()
 };
 
@@ -1044,6 +1047,10 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (blob_max_bytes) {
+		set_option(transport, TRANS_OPT_BLOB_MAX_BYTES, blob_max_bytes);
+		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	}
 	return transport;
 }
 
@@ -1328,6 +1335,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch");
 
+	fetch_if_missing = 0;
+
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
@@ -1361,6 +1370,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
+	if (blob_max_bytes && !repository_format_partial_clone)
+		die("--blob-max-bytes can only be used when extensions.partialClone is set");
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
@@ -1390,10 +1402,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (remote)
+	if (remote) {
+		if (blob_max_bytes &&
+		    strcmp(remote->name, repository_format_partial_clone))
+			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
 		result = fetch_one(remote, argc, argv);
-	else
+	} else {
+		if (blob_max_bytes)
+			die(_("--blob-max-bytes can only be used with the remote configured in core.partialClone"));
 		result = fetch_multiple(&list);
+	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct argv_array options = ARGV_ARRAY_INIT;
diff --git a/connected.c b/connected.c
index f416b0505..a51c01d63 100644
--- a/connected.c
+++ b/connected.c
@@ -56,6 +56,7 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args,"rev-list");
 	argv_array_push(&rev_list.args, "--objects");
 	argv_array_push(&rev_list.args, "--stdin");
+	argv_array_push(&rev_list.args, "--exclude-promisor-objects");
 	argv_array_push(&rev_list.args, "--not");
 	argv_array_push(&rev_list.args, "--all");
 	argv_array_push(&rev_list.args, "--quiet");
diff --git a/remote-curl.c b/remote-curl.c
index 34a81b8d3..18fd184c1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -24,6 +24,7 @@ struct options {
 	char *deepen_since;
 	struct string_list deepen_not;
 	struct string_list push_options;
+	char *blob_max_bytes;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -165,6 +166,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "no-haves")) {
 		options.no_haves = 1;
 		return 0;
+	} else if (!strcmp(name, "blob-max-bytes")) {
+		options.blob_max_bytes = xstrdup(value);
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -834,6 +838,9 @@ static int fetch_git(struct discovery *heads,
 		argv_array_push(&args, "--from-promisor");
 	if (options.no_haves)
 		argv_array_push(&args, "--no-haves");
+	if (options.blob_max_bytes)
+		argv_array_pushf(&args, "--blob-max-bytes=%s",
+				 options.blob_max_bytes);
 	argv_array_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 62e384230..b2682862f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -782,4 +782,40 @@ test_expect_success '--blob-max-bytes has no effect if support for it is not adv
 	test_i18ngrep "blob-max-bytes not recognized by server" err
 '
 
+fetch_blob_max_bytes () {
+	SERVER="$1"
+	URL="$2"
+
+	rm -rf "$SERVER" client &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" one &&
+	test_config -C "$SERVER" uploadpack.advertiseblobmaxbytes 1 &&
+
+	git clone "$URL" client &&
+	test_config -C client extensions.partialclone origin &&
+
+	test_commit -C "$SERVER" two &&
+
+	git -C client fetch --blob-max-bytes=0 origin HEAD:somewhere &&
+
+	# Ensure that commit is fetched, but blob is not
+	test_config -C client extensions.partialclone "arbitrary string" &&
+	git -C client cat-file -e $(git -C "$SERVER" rev-parse two) &&
+	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
+}
+
+test_expect_success 'fetch with --blob-max-bytes' '
+	fetch_blob_max_bytes server server
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetch with --blob-max-bytes and HTTP' '
+	fetch_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+'
+
+stop_httpd
+
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 42b960ff8..9c1874b70 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -672,6 +672,10 @@ static int fetch(struct transport *transport,
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
+	if (data->transport_options.blob_max_bytes)
+		set_helper_option(transport, "blob-max-bytes",
+				  data->transport_options.blob_max_bytes);
+
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
diff --git a/transport.c b/transport.c
index fb46e33bf..6408af19e 100644
--- a/transport.c
+++ b/transport.c
@@ -167,6 +167,9 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_NO_HAVES)) {
 		opts->no_haves = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_BLOB_MAX_BYTES)) {
+		opts->blob_max_bytes = value;
+		return 0;
 	}
 	return 1;
 }
@@ -237,6 +240,13 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 	args.from_promisor = data->options.from_promisor;
 	args.no_haves = data->options.no_haves;
+	if (data->options.blob_max_bytes) {
+		unsigned long *ptr = xmalloc(sizeof(*ptr));
+		if (!git_parse_ulong(data->options.blob_max_bytes, ptr))
+			die("Invalid blob-max-bytes value: %s",
+			    data->options.blob_max_bytes);
+		args.blob_max_bytes = ptr;
+	}
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index 67428f6df..79d4442b1 100644
--- a/transport.h
+++ b/transport.h
@@ -23,6 +23,7 @@ struct git_transport_options {
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
+	const char *blob_max_bytes;
 };
 
 enum transport_family {
@@ -218,6 +219,9 @@ void transport_check_allowed(const char *type);
 /* Do not send "have" lines */
 #define TRANS_OPT_NO_HAVES "no-haves"
 
+/* Exclude blobs above a certain size */
+#define TRANS_OPT_BLOB_MAX_BYTES "blob-max-bytes"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.14.2.822.g60be5d43e6-goog

