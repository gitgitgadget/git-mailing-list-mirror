Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDFF1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdGaVDI (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:03:08 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35776 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdGaVDB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:03:01 -0400
Received: by mail-pf0-f182.google.com with SMTP id t86so15656099pfe.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ufvSRY2sR3quoJEZCB+ju28/miJEFHys/nVHMhFThik=;
        b=XD9Hh2l7XC+ULj8pTxWmTDUfwPKm9zR8xGLN9e6FGl0EU28cO/LBfq/DH+V+3QpF7c
         diuwhOokRtLNJOUYKsQSQQb1VouL4r6vsGYK8dcoblmUpG6Y1PBo+Sc4vvwL1ugf9xGB
         Ngm33NxJeUdju8PijFhPYfwg0TnTXsV2kyyhQVmQI3wDmzhZLYb8WjwLAG5ijKaYzXRk
         lxSX7KmglU+ftJWEiBgY6DZl8CoYH2c9ABxtjlG0vM6LKcTyFjWXan35OjGe4Z6dINS4
         FqyXETD83OYz87hLEqMBOMMdxFmgh4kujvD/DkznOP/+Kd8Q6fVLY0dQZvOeGGe3ROgu
         27Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ufvSRY2sR3quoJEZCB+ju28/miJEFHys/nVHMhFThik=;
        b=eHv6KMxzeXsY8SvEIQzTYoauyAiT3/l4uoBDVmndy8+2u+bFY4vpwaE1iw1lH2le9R
         bumLktFjufOEK66fFveCa5D4c55AJtH0gczqPlI7j3A9s9o81Umn/LUMl4XASHjOysgW
         qrdI1iC71lrNDyi4NPD+Ma6muC6DWkIkf8JOC49aqG9sTroUFQfhej7E1Fy4o0eAvILR
         um6+7VNHz8DjGaeh6ZrZEcg+gLMzxc3zgRS8qda1+u9BwnxOzqZa6yftK6d3DwaM2BID
         pDoowLVsNHOAHxy+s8wFgd29M2JsnSahxAXz3qpO6dlogR9m2q/O5Kp2V22TEVgBS6te
         FL+g==
X-Gm-Message-State: AIVw110eJuQaON9txCFLsSj+XOBYzKrbw15nORNKD2cAAeYm4wdqqRgx
        pOLJYyNdqbQjKOZHJ8lg1g==
X-Received: by 10.99.1.203 with SMTP id 194mr16430833pgb.315.1501534980147;
        Mon, 31 Jul 2017 14:03:00 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k185sm53231673pgc.31.2017.07.31.14.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 14:02:58 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peartben@gmail.com, christian.couder@gmail.com
Subject: [PATCH v2 3/5] fsck: support referenced lazy objects
Date:   Mon, 31 Jul 2017 14:02:45 -0700
Message-Id: <9228491818d5983fd11a53977487b97b677755e4.1501532294.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501532294.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com> <cover.1501532294.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat missing objects indirectly pointed to by refs as
an error when extensions.lazyobject is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c         | 11 +++++++++++
 t/t0410-lazy-object.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 38ed630d8..19681c5b3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -149,6 +149,15 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		return 0;
 	obj->flags |= REACHABLE;
 	if (!(obj->flags & HAS_OBJ)) {
+		if (repository_format_lazy_object)
+			/*
+			 * Return immediately; this is not an error, and further
+			 * recursion does not need to be performed on this
+			 * object since it is missing (so it does not need to be
+			 * added to "pending").
+			 */
+			return 0;
+
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
 				 printable_type(parent), describe_object(parent));
@@ -212,6 +221,8 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
+		if (repository_format_lazy_object)
+			return;
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", printable_type(obj),
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 00e1b4a88..45f665a15 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -49,4 +49,31 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck
 '
 
+test_expect_success 'fsck fails on lazy object indirectly pointed to by ref' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+	test_commit -C repo 3 &&
+	git -C repo tag -a annotated_tag -m "annotated tag" &&
+
+	C=$(git -C repo rev-parse 1) &&
+	T=$(git -C repo rev-parse 2^{tree}) &&
+	B=$(git hash-object repo/3.t) &&
+	AT=$(git -C repo rev-parse annotated_tag) &&
+
+	# missing commit, tree, blob, and tag
+	delete_object repo "$C" &&
+	delete_object repo "$T" &&
+	delete_object repo "$B" &&
+	delete_object repo "$AT" &&
+	test_must_fail git -C repo fsck
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

