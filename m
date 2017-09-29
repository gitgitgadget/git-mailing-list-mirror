Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107C820281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdI2UMi (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:38 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:49151 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdI2UM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:28 -0400
Received: by mail-pg0-f42.google.com with SMTP id v23so351371pgc.5
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MO8O17ChEdGL8ZdghhIArrIIocTz4HPt4K1a53zONFw=;
        b=QVu8qNhFB9t5VX8KCahvBLoyro9QGatBnLO/aFS1BQtvbwwffUYLBsYzybwqRIbCvt
         3sKxzpTUoiBhvOQeAaFAwNomfIdTiq6Q5tZXQ5tP/xiRJoKMbu+sUDMOxmWma9D6ERun
         Qjb6iSShYDIEmlUQIjNOa1HQqJIU3sl75As9DhKV28zLBnGO6qzNcVj05UNY83lmRr4m
         Q+RAb0Y7oyzTz9ufkEUwckM8NSTEcBA70r6TZmG0wuSetlkigfICDZuuFbV7rwIshcf9
         Y+jPi5Z1OERJyZvr1Pv4Pq3KKeSpbW50NtCFCHOMn7/VJmmT5SDv49GyR6+L/vhH+zXP
         SqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MO8O17ChEdGL8ZdghhIArrIIocTz4HPt4K1a53zONFw=;
        b=tcohRBgYJlbXoyOoEgUzqxH+R6IA8tcuFTC8uw0skA6esbYsV2J2eV660EiJfTo2o4
         yHB6nDMyczaHNKgKKtBi0imGAw2B0xsnHdH3pujF6M8ihNopNc7em594+G7eBQ/rOiGj
         SIBsjFbpOFxMLrdZGaQcwPa28MqL8Qx79KYacrt0ZYYfz7vP29L63HMVpg59hpZlhFWY
         4b+J3/8gllbjvNK0CaECa+3jP7bzilqetYsOBAhT4E5Y/IdffdAhRXjAMqq4D1RoAR3r
         FSLrLgasOk4WAyRO/z1usXb1AO1QyIl62Jw/iZhKTFLW8ahlqLsn+kBQHcPcyOCLpElH
         px+Q==
X-Gm-Message-State: AMCzsaX47jhF1DrOcY00iuDAt3Dog0ZWDP2mDGkb4BqM811Z6gMWkurG
        6CPfige600D21IvLKaVzBbhwnrW4X4U=
X-Google-Smtp-Source: AOwi7QBxOjQlOZPuIbeTgnVM7/IGJgCgfDUeYX62EF1pYw+Cq8VuszMznVMvY0yxSm38JE7eEdtN0g==
X-Received: by 10.98.16.203 with SMTP id 72mr882250pfq.150.1506715947308;
        Fri, 29 Sep 2017 13:12:27 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:26 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 15/18] clone: support excluding large blobs
Date:   Fri, 29 Sep 2017 13:11:51 -0700
Message-Id: <9f0c6eb5aea49a5620de8e56fab2065805570f0e.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach clone to support excluding large blobs through a blob-max-bytes
parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c  | 23 +++++++++++++++++++++--
 t/t5601-clone.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index dbddd98f8..4c2193dc4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -60,6 +60,7 @@ static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
+static char *blob_max_bytes;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -135,6 +136,8 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_STRING(0, "blob-max-bytes", &blob_max_bytes, N_("bytes"),
+		   N_("do not fetch blobs above this size")),
 	OPT_END()
 };
 
@@ -886,6 +889,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	fetch_if_missing = 0;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1104,7 +1109,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
-	if (transport->smart_options && !deepen)
+	if (blob_max_bytes) {
+		transport_set_option(transport, TRANS_OPT_BLOB_MAX_BYTES,
+				     blob_max_bytes);
+		transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	}
+
+	if (transport->smart_options && !deepen && !blob_max_bytes)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 	refs = transport_get_remote_refs(transport);
@@ -1164,13 +1175,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	write_refspec_config(src_ref_prefix, our_head_points_at,
 			remote_head_points_at, &branch_top);
 
+	if (blob_max_bytes) {
+		git_config_set("core.repositoryformatversion", "1");
+		git_config_set("extensions.partialclone", "origin");
+		repository_format_partial_clone = "origin";
+	}
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport, !is_local);
+			   branch_top.buf, reflog_msg.buf, transport,
+			   !is_local && !blob_max_bytes);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
@@ -1191,6 +1209,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
+	fetch_if_missing = 1;
 	err = checkout(submodule_progress);
 
 	strbuf_release(&reflog_msg);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9c56f771b..951b1ffa8 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -571,4 +571,53 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
 	git -C replay.git index-pack -v --stdin <tmp.pack
 '
 
+partial_clone () {
+	SERVER="$1" &&
+	URL="$2" &&
+
+	rm -rf "$SERVER" client &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" one &&
+	HASH1=$(git hash-object "$SERVER/one.t") &&
+	git -C "$SERVER" revert HEAD &&
+	test_commit -C "$SERVER" two &&
+	HASH2=$(git hash-object "$SERVER/two.t") &&
+	test_config -C "$SERVER" uploadpack.advertiseblobmaxbytes 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	git clone --blob-max-bytes=0 "$URL" client &&
+
+	git -C client fsck &&
+
+	# Ensure that unneeded blobs are not inadvertently fetched.
+	test_config -C client extensions.partialclone "not a remote" &&
+	test_must_fail git -C client cat-file -e "$HASH1" &&
+
+	# But this blob was fetched, because clone performs an initial checkout
+	git -C client cat-file -e "$HASH2"
+}
+
+test_expect_success 'partial clone' '
+	partial_clone server "file://$(pwd)/server"
+'
+
+test_expect_success 'partial clone: warn if server does not support blob-max-bytes' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	git clone --blob-max-bytes=0 "file://$(pwd)/server" client 2> err &&
+
+	test_i18ngrep "blob-max-bytes not recognized by server" err
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'partial clone using HTTP' '
+	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+'
+
+stop_httpd
+
 test_done
-- 
2.14.2.822.g60be5d43e6-goog

