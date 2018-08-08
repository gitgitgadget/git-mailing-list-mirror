Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB1E1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 23:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeHIBeH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 21:34:07 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:42209 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIBeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 21:34:07 -0400
Received: by mail-ua0-f202.google.com with SMTP id g10-v6so3104293uap.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0sowqt4oMV847ORWK2g9RAJ29jyu0cLEaqhLrZMls6k=;
        b=I+bIW18SLz8ku8i7EZX5VmXjL1GOCr/FQuHAtmMLNRO30aVs8erjHFzYIpu6elgOlc
         qlGP2PbudlIu+GA2n5NtD5tKN+7p81bY07QCuA0CM+WoCBLF3EJlu2HAuPEje8Xw+w3V
         6Zhfdt+N0zgUAHp25JlLpllRTpfZbr0H576Sk1hZHAk9yXMVGYX2ncptLeAtPin+36pU
         oaptDdibZbut3aF9D2zGdPB5CYANm6bRZ7TMVpkOZX2w+DvpVOcQivFByzADwVUYvsy5
         WL68w+7dY9rllreBfldOWiFN1NAKh/ssxUR0O4OLsEdVw5PXjcYrkWdUWC855U1Kwtyp
         uayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0sowqt4oMV847ORWK2g9RAJ29jyu0cLEaqhLrZMls6k=;
        b=pFqZcxcMbQKKRcMckS3aZyNFP5himi7vI3Ka9eSx5gLw8LLyHOCaBx+oXIoyxeCk/d
         dd0mPeBJkPEi6/kbjjqDwS5puJ+zIuYZLAcAir5hMM1JSD5NroYAXhFCDyz/j30wZs8j
         xHStaQm4ZDmC3fuSPmulucBToINP8BdS6LDq4YMTwEuV/R1jk9ABRTBW14xm1Z0LCt0D
         5RbZd9L1nUXB5dLOZamQZXLaLOKv5Eh+0cZxPz2hv+7ExkQjtr6EJE32xOK8D00Nxl6b
         36SLuNPhYmWSFm9tyUOgo29qDq8jVORknqklhF2D7txie68mpJrdj7yHOeg3cLIdQd3k
         F/dQ==
X-Gm-Message-State: AOUpUlFHszAJ2woup22V06hWf4rNsf7k0wDfSa6b5p5VVli18JtCVc/x
        CW/RwtGa/uhBaQ3/ia8XdFmQgQovml1dPrzW6kHsuIJbrueU7A//lBqJikUNgsVYJK1esrNH07W
        YXZ8k7jIznZKkFY7ckP6kTaM9ma5ozEvY2sSMV4t6nRDcouvZJztymsm61qgJv9MISyRXmP3TOa
        MY
X-Google-Smtp-Source: AA+uWPxTEZWC/hmthzF3DswtCSSHeY446iWih/O56jesB98Qoj2iuQE5W+RWrP6+a87U8G6bvT7+sjYAGGEC22b1ysKN
X-Received: by 2002:a1f:3987:: with SMTP id g129-v6mr2608444vka.94.1533769934448;
 Wed, 08 Aug 2018 16:12:14 -0700 (PDT)
Date:   Wed,  8 Aug 2018 16:12:10 -0700
Message-Id: <20180808231210.242120-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [RFC PATCH] packfile: iterate packed objects in pack order
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many invocations of for_each_object_in_pack() and
for_each_packed_object() (which invokes the former) subsequently check
at least the type of the packed object, necessitating accessing the
packfile itself. For locality reasons, it is thus better to iterate in
pack order, instead of index order. Teach for_each_object_in_pack() to
iterate in pack order by first creating a reverse index.

This is based off work by Jeff King.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
After writing this patch and looking at it further, I'm not sure if this
is a clear benefit, but here's the patch anyway. In particular,
builtin/fsck.c and builtin/cat-file.c just deal with the OID directly
and does not access the packfile at all (at least at the time of
invoking for_each_packed_object). And revision.c, if we are excluding
promisor objects, parses each packed promisor object, but it seems
possible to avoid doing that (replacing the parse_object() by
lookup_unknown_object() still passes tests).
---
 packfile.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 6974903e5..371b64e9b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
+#include "pack-revindex.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -1890,14 +1891,17 @@ int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void
 	uint32_t i;
 	int r = 0;
 
+	load_pack_revindex(p);
+
 	for (i = 0; i < p->num_objects; i++) {
+		uint32_t pack_nr = p->revindex[i].nr;
 		struct object_id oid;
 
-		if (!nth_packed_object_oid(&oid, p, i))
+		if (!nth_packed_object_oid(&oid, p, pack_nr))
 			return error("unable to get sha1 of object %u in %s",
-				     i, p->pack_name);
+				     pack_nr, p->pack_name);
 
-		r = cb(&oid, p, i, data);
+		r = cb(&oid, p, pack_nr, data);
 		if (r)
 			break;
 	}
-- 
2.18.0.597.ga71716f1ad-goog

