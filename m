Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA17C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiA0F1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiA0F06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:26:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE6DC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so2374536wrg.12
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1Z4pYdw2r7o4bLtu+9LKIhBbIJzKGv7DuIEzQnHj3w=;
        b=Q80s3+a378JjyXrxxoUMDi/JBg1iubT9EzI7LSo+vfGIDNNyHgXU6V05kekadvzccG
         /VTqauzk7BvHwVbSPitd/2etoJhtfK0r7FAbzkYBaTXHtmvgh3E7Z7wVqseBSVc2mkhF
         qptbF6DK/UpQDXbtPlNvkWXvgFTKVzxMupjyWt4pXlDP2J377rrrgMv7O3JIohworHvi
         3j9nvUZ1ADvDOcYtqm5x2Ok2S+5GMlJ4ILdWYCJGuXqkHf1pP/QCoHZQBDrz/U7ZGt1C
         kd9lJeWibwUmq7FxbyAhTT9E1YEtv5Cq40h9ixWCHYLc8MTl8O4CQcadmkcuqWJlgIcZ
         SQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1Z4pYdw2r7o4bLtu+9LKIhBbIJzKGv7DuIEzQnHj3w=;
        b=PCUi3ZMA+edFuRVblty6KJ0uwL+xf5bgARkUKuvfFioEjlIcOZA37v56JhURiBdpHt
         VSmU4Pr9iI10vAX7IgomD04fX/7uUmheqySJRLFPiWRkiTTpsaSPhAtxknxYU/GL1M4k
         VL5UX6cwI3ihyScBnlmod5rGRD7zHU4YHaBP5V5LSIZ2rivH9Hmxu0X/6BGmir17szPM
         bM2qf5STUx9s6rAdFgRe0Cl6IKEIvmCgyEEB/4NbECjDwZ0pOsc/o8/5AStZwykGv9mo
         /72yfFRZmJVmOb9NuEbOBPQjhg0wAVpRPpO4ErW3NNXxQOPaLhbpcu93ge1QEgFi2J7+
         I+ZA==
X-Gm-Message-State: AOAM532K8Gbw0RFuleTQI7zQIpsrxPkfywzpvayaL2gtvC0/2L5+luWl
        jzgJDx4VncT3GPYCjFIge14e42VBnUzdaA==
X-Google-Smtp-Source: ABdhPJzgqPUKkU2HCva3uKdlYftSIFDK073K0Q0VxKkuFz3hymM6N3nHeJ85rNP4CxjCDgIVmyTO5Q==
X-Received: by 2002:adf:a11b:: with SMTP id o27mr1442260wro.645.1643261216467;
        Wed, 26 Jan 2022 21:26:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.55
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
Subject: [PATCH v8 3/7] object-name: explicitly handle bad tags in show_ambiguous_object()
Date:   Thu, 27 Jan 2022 06:26:45 +0100
Message-Id: <patch-v8-3.7-eaede34fa4f-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up the handling of OBJ_BAD in the preceding commit and
explicitly handle those cases where parse_tag() fails, or we don't end
up with a non-NULL pointer in in tag->tag.

If we run into such a tag we'd previously be silent about it. We
really should also be handling these batter in parse_tag_buffer() by
being more eager to emit an error(), instead of silently aborting with
"return -1;".

One example of such a tag is the one that's tested for in
"t3800-mktag.sh", where the code takes the "size <
the_hash_algo->hexsz + 24" branch.

But in lieu of earlier missing "error" output let's show the user
something to indicate why we're not showing a tag message in these
cases, now instead of showing:

    hint:   deadbeef tag

We'll instead display:

    hint:   deadbeef tag [tag could not be parsed]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/object-name.c b/object-name.c
index 9750634ee76..298b742bac9 100644
--- a/object-name.c
+++ b/object-name.c
@@ -382,6 +382,8 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 		struct tag *tag = lookup_tag(ds->repo, oid);
 		if (!parse_tag(tag) && tag->tag)
 			strbuf_addf(&desc, " %s", tag->tag);
+		else
+			strbuf_addstr(&desc, " [tag could not be parsed]");
 	}
 
 out:
-- 
2.35.0.890.gd7e422415d9

