Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CFDC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbiA0F06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiA0F05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:26:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D561C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e2so2652479wra.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UU/6gUMshEycNWEKbnVcb9laMhbI36Z4CDYpXl5We0E=;
        b=BLOQW9oWSYmIKYEuQHBVmFeckLkOzmJEDCv/VALjsyzg5tp0rmPsGV2wYtO7M/hos2
         EC9mI0rRRYnlC6ujll/YsYl8wJmo0gcjcP2qu7/quPqTmyZc9FxVHpXGtt6F1mrKAgWC
         RUzCx0ZtlU6/12/8WYqX8Ei1Ak1Qsa7jGQQKw1WNPPnHNYBj9h8JaiAsAA5eZhwNR/kc
         WJgXP3KqEeADVYwxWR43BdKj+o+Pg11vCqiSU4bs3gCqxHhcY3qhD5g/QgXQwExm1Dtz
         Df0nwUVBk1MLcxzM9np/I9O8dflHzB4A14mv1zSuO93yPjTuJI2fR2djzIYOVjWo36he
         mifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UU/6gUMshEycNWEKbnVcb9laMhbI36Z4CDYpXl5We0E=;
        b=tFXadGJFuIeuAiyY9Eo5Q3OfZniY9GOD3+NzOcuMnzQpE5JFpzgeQZuIaSocm7LpKc
         QuTefSgVLmBvQFbOLmjfkATpWE4IVHylPTxy7vJA/xcPBRgtCcvfQsvf3cSPS6D970uQ
         wAe3iNwb6MJrhlHcVLNv+bnxuhq/v7G5hzCiOWDjcyi7QVFEmX2doKKiyyR2B/Bbr35F
         rQs4wThFhg9/9fUBEn7pmYosWfcVo+Ca/Jr8KcitUr5zv5hFXn7Q91orap4lTxgaAFUS
         jAZbsB+chkMiypcpAVr4CNzviNn1yQ7AcUI9gICEOumbn0ZZx5Z9A5f7fMtNK4nrZdeO
         4moA==
X-Gm-Message-State: AOAM531TxXP8Y5qZcW7ECQNJEhzxOADczp5FxMgLc7W3QLIg0cJGPXjb
        cPx1boukQ9gVzLQtqcdZYceLzZfIOnRoVg==
X-Google-Smtp-Source: ABdhPJw8JwBUjIQx7DTH+i5ckVTU654W71YFBwwUNdWvQOu+cHWG8NJh05O7I6D3H9T7nFheAVdwDA==
X-Received: by 2002:adf:fb10:: with SMTP id c16mr1598527wrr.200.1643261215624;
        Wed, 26 Jan 2022 21:26:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 2/7] object-name: explicitly handle OBJ_BAD in show_ambiguous_object()
Date:   Thu, 27 Jan 2022 06:26:44 +0100
Message-Id: <patch-v8-2.7-e60f100003a-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "unknown type" handling in the code that displays the
ambiguous object list to assert() that we're either going to get the
"real" object types we can pass to type_name(), or a -1 (OBJ_BAD)
return value from oid_object_info().

See [1] for the current output, and [1] for the commit that added the
"unknown type" handling.

We are never going to get an "unknown type" in the sense of custom
types crafted with "hash-object --literally", since we're not using
the OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag.

If we manage to otherwise unpack such an object without errors we'll
die() in parse_loose_header_extended() called by sort_ambiguous()
before we get to show_ambiguous_object(), as is asserted by the test
added in the preceding commit.

So saying "unknown type" here was always misleading, we really meant
to say that we had a failure parsing the object at all, i.e. that we
had repository corruption. If the problem is only that it's type is
unknown we won't reach this code.

So let's emit a generic "[bad object]" instead. As our tests added in
the preceding commit show, we'll have emitted various "error" output
already in those cases.

We should do better in the truly "unknown type" cases, which we'd need
to handle if we were passing down the OBJECT_INFO_ALLOW_UNKNOWN_TYPE
flag. But let's leave that for some future improvement. In a
subsequent commit I'll improve the output we do show, and not having
to handle the "unknown type" (as in OBJECT_INFO_ALLOW_UNKNOWN_TYPE)
simplifies that change.

1. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)
2. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c                       | 14 ++++++++++++--
 t/t1512-rev-parse-disambiguation.sh |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..9750634ee76 100644
--- a/object-name.c
+++ b/object-name.c
@@ -361,6 +361,16 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		return 0;
 
 	type = oid_object_info(ds->repo, oid, NULL);
+
+	if (type < 0) {
+		strbuf_addstr(&desc, "[bad object]");
+		goto out;
+	}
+
+	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
+	       type == OBJ_BLOB || type == OBJ_TAG);
+	strbuf_addstr(&desc, type_name(type));
+
 	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(ds->repo, oid);
 		if (commit) {
@@ -374,9 +384,9 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 			strbuf_addf(&desc, " %s", tag->tag);
 	}
 
-	advise("  %s %s%s",
+out:
+	advise("  %s %s",
 	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       type_name(type) ? type_name(type) : "unknown type",
 	       desc.buf);
 
 	strbuf_release(&desc);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index c14d88eae20..80102cc43a3 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -99,7 +99,7 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 	error: unable to unpack cafe... header
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
-	hint:   cafe... unknown type
+	hint:   cafe... [bad object]
 	hint:   cafe... blob
 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
 	Use '\''--'\'' to separate paths from revisions, like this:
-- 
2.35.0.890.gd7e422415d9

