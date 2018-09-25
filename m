Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3021F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeIZFDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 01:03:53 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56210 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIZFDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 01:03:53 -0400
Received: by mail-qk1-f201.google.com with SMTP id z18-v6so27530678qki.22
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1d3lfiQB4ywh3qiVa2d17Uimqs3mJkVP5N72yBJSyHo=;
        b=bgXSWTUYQ7EFh98FQFuLkDcmee+M3GuJpCbiIuo21OmjmJxjSRkqgQCx5XTriw3yHL
         SH169wG7lhUh37lojM8qaHKph/KXJtQqtVcs2dPuJ9YzVt18oxRZhejku76Msnk8d5yP
         SuP6XPBdqt1hwsacMUjWCiTsY6zzvQrUVBLf4n2v54LVoeCVaqsfTFMEW1WQIgau9iwx
         4bOol/MlsHo+lTc8SxoooLtXiFbl3fZ6W3uEBhUKFnPHs743TZSUcxU5eW4+hWXOT/aK
         NefINqHCgRvuqh7bkCfy9RGwXPMOJs/UyJCjhci1WpodRlsD7mEbgl0F+T0MpegGuHtQ
         h+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1d3lfiQB4ywh3qiVa2d17Uimqs3mJkVP5N72yBJSyHo=;
        b=RTh0B4roslvnF2K73QTDSFsZ6ZzvM0f6/7/Jeor1oIvbrlpkIpwuqbfiYU0c63vwQ2
         ckdUxN+IF9sdpAYQ+8MLFXh648DcPTP1UhFCdeIaw0JPYNDXHMYHXSG2gRbhNe7jWKzI
         dgTRcrCaqir0n0VC/GzKP6UWTkX/oMBOij9Be413SaXjp1sof8tMRJV9bcZAb3LLK/KH
         FYpDj2TLE6HFQKjfXooREMDBKhIGfPwMEjahyxI9yyGzNt1aG/SQVGQS1Y9dhx2PSgyx
         c74h3RpofLfZpw6anD0zeVRUAZMWu0fmEQGC/D4d2gQMGSB6Qpaq4Lw1tNGihfVqfYIH
         3i0w==
X-Gm-Message-State: ABuFfoi/AuN24yiW8aH6VuxzJhvRfrQtGs3jvu/wMtx90ifrYVnGMxJF
        UQt/K/+0/espQipMxE2NqmKmZ8OG58Q1IsL/gdkGw3hQlEU872dECAOo+bYCU/BFLD2MTHi8okr
        zhystAnMW9cDHphEnSt3DNUWHwgJvIwPytKVn1Z8LNho/cn/+PEIo7Kq795h5jQfla2tU4DeKCT
        6E
X-Google-Smtp-Source: ACcGV601w3YHk1LFk1wDDM55BTlU4OpRX8F572GIrdE3j+z496or6nU1oIyqAS0nb3aiwzUDjdwjAZ8h7JgkxSOw2uMS
X-Received: by 2002:a37:a790:: with SMTP id q138-v6mr1180033qke.48.1537916043307;
 Tue, 25 Sep 2018 15:54:03 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:53:55 -0700
Message-Id: <20180925225355.74237-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH] transport: list refs before fetch if necessary
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The built-in bundle transport and the transport helper interface do not
work when transport_fetch_refs() is called immediately after transport
creation.

Evidence: fetch_refs_from_bundle() relies on data->header being
initialized in get_refs_from_bundle(), and fetch() in transport-helper.c
relies on either data->fetch or data->import being set by get_helper(),
but neither transport_helper_init() nor fetch() calls get_helper().

Up until the introduction of the partial clone feature, this has not
been a problem, because transport_fetch_refs() is always called after
transport_get_remote_refs(). With the introduction of the partial clone
feature, which involves calling transport_fetch_refs() (to fetch objects
by their OIDs) without transport_get_remote_refs(), this is still not a
problem, but only coincidentally - we do not support partially cloning a
bundle, and as for cloning using a transport-helper-using protocol, it
so happens that before transport_fetch_refs() is called, fetch_refs() in
fetch-object.c calls transport_set_option(), which means that the
aforementioned get_helper() is invoked through set_helper_option() in
transport-helper.c. In the future, though, there may be other use cases
in which we want to fetch without requiring listing of remote refs, so
this is still worth fixing.

This could be fixed by fixing the transports themselves, but it doesn't
seem like a good idea to me to open up previously untested code paths;
also, there may be transport helpers in the wild that assume that "list"
is always called before "fetch". Instead, fix this by having
transport_fetch_refs() call transport_get_remote_refs() to ensure that
the latter is always called at least once, unless the transport
explicitly states that it supports fetching without listing refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I discovered this while investigating the possibility of taking
advantage of the fact that protocol v2 allows us to fetch without first
invoking ls-refs. This is useful both when lazily fetching to a partial
clone, and when invoking "git fetch --no-tags <remote> <sha-1>" (note
that tag following must be disabled).

Any comments on this (for or against) is appreciated, and suggestions of
better approaches are appreciated too.
---
 transport-helper.c   |  1 +
 transport-internal.h |  6 ++++++
 transport.c          | 12 ++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index 143ca008c8..7213fa0d32 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1105,6 +1105,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 }
 
 static struct transport_vtable vtable = {
+	0,
 	set_helper_option,
 	get_refs_list,
 	fetch,
diff --git a/transport-internal.h b/transport-internal.h
index 1cde6258a7..004bee5e36 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -6,6 +6,12 @@ struct transport;
 struct argv_array;
 
 struct transport_vtable {
+	/**
+	 * This transport supports the fetch() function being called
+	 * without get_refs_list() first being called.
+	 */
+	unsigned fetch_without_list : 1;
+
 	/**
 	 * Returns 0 if successful, positive if the option is not
 	 * recognized or is inapplicable, and negative if the option
diff --git a/transport.c b/transport.c
index 1c76d64aba..ee8a78ff37 100644
--- a/transport.c
+++ b/transport.c
@@ -703,6 +703,7 @@ static int disconnect_git(struct transport *transport)
 }
 
 static struct transport_vtable taken_over_vtable = {
+	1,
 	NULL,
 	get_refs_via_connect,
 	fetch_refs_via_pack,
@@ -852,6 +853,7 @@ void transport_check_allowed(const char *type)
 }
 
 static struct transport_vtable bundle_vtable = {
+	0,
 	NULL,
 	get_refs_from_bundle,
 	fetch_refs_from_bundle,
@@ -861,6 +863,7 @@ static struct transport_vtable bundle_vtable = {
 };
 
 static struct transport_vtable builtin_smart_vtable = {
+	1,
 	NULL,
 	get_refs_via_connect,
 	fetch_refs_via_pack,
@@ -1224,6 +1227,15 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	struct ref **heads = NULL;
 	struct ref *rm;
 
+	if (!transport->vtable->fetch_without_list)
+		/*
+		 * Some transports (e.g. the built-in bundle transport and the
+		 * transport helper interface) do not work when fetching is
+		 * done immediately after transport creation. List the remote
+		 * refs anyway (if not already listed) as a workaround.
+		 */
+		transport_get_remote_refs(transport, NULL);
+
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
-- 
2.19.0.605.g01d371f741-goog

