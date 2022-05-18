Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6746C433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiERXMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiERXL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:11:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0154EC8BF7
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e3so4019998ios.6
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oSVjQUb7EmptIC85D/M8vXMsjJUfRJ55GFl0VvGVHJk=;
        b=eAK0Q5MOZet+sAsLy6oyO+ldIT4DhK+xvji6MNuKvOlvYQTaWK/3+JPaGHDFcMUd0R
         ilPwLi7+F0ZUBzsH0QMAUjJev8poOBl1E6UhyvktxGTKkMapQJeqRem8IB72eGbh7OqZ
         YHIOK1K8byYOgrtfu4CmqkAMQxSgEHK20ANp482ESM/oFQ6qV6fExGeINTagtpcp/cwC
         RecxxX0/v/axnrxMKV/EuwgOw7zJ3LX+m6+o1wFNp2STwH47CotKYOxYZJ0dABjsXDkO
         mWVrDrIV5YwP295ls9D9baFLVCXx7TluWFg+pGDwWp9I2uA0DzHJ4PThRPtC2zElJtvS
         xcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oSVjQUb7EmptIC85D/M8vXMsjJUfRJ55GFl0VvGVHJk=;
        b=vDeklJMf/oywFVU3AMPb9vapvxK3OVClUJXDqrDl3OfQkG2w6HdIQ5/7v6UULQdUVL
         CXnXA28XVonjwukvjCG8tZ5SZpfBsSnALe7n5uqDueRJ4JQ1u7tOv78szwtK+Na9acDi
         o8ZFOGF7GID90imL9Euz3b75T2/CNhchofXchXafghJEZWTZ0MZr4TvBSlwOPov2/+41
         wekzr5na2jxYkZNItBXpKdYPtjFRGWEPS7N4qOAU9aukPfQ0hjEpHTGX08AJHcAYbvcU
         Xi7WdU5ZY7+F4vTlq7i9YX0ykAE2gBfGBNiQGVrsgZYLJuYemWkY7aJe62UHgllleruR
         WN3Q==
X-Gm-Message-State: AOAM532QwYmjMASAIXjnsqjltDj6trEIJsblKzd9aGGgX7EmWA52ZajU
        xNEZelxJlreCrEbgxWfvYDpl+EZ1cuj60wsO
X-Google-Smtp-Source: ABdhPJydZzJCulkRP6iyeJfPfcafHz2UjIqObxj3deBxhvA+5CXaE9dnbypXtsRrwJphMVgekcOjEQ==
X-Received: by 2002:a05:6638:2493:b0:32b:ef71:454d with SMTP id x19-20020a056638249300b0032bef71454dmr1097706jat.250.1652915491188;
        Wed, 18 May 2022 16:11:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16-20020a0566022c9000b0065a47e16f53sm237647iow.37.2022.05.18.16.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:11:30 -0700 (PDT)
Date:   Wed, 18 May 2022 19:11:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 15/17] builtin/repack.c: add cruft packs to MIDX during
 geometric repack
Message-ID: <0743e373baaaaee2bc5f8664b1e64038e6dbf4c2.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using cruft packs, the following race can occur when a geometric
repack that writes a MIDX bitmap takes place afterwords:

  - First, create an unreachable object and do an all-into-one cruft
    repack which stores that object in the repository's cruft pack.
  - Then make that object reachable.
  - Finally, do a geometric repack and write a MIDX bitmap.

Assuming that we are sufficiently unlucky as to select a commit from the
MIDX which reaches that object for bitmapping, then the `git
multi-pack-index` process will complain that that object is missing.

The reason is because we don't include cruft packs in the MIDX when
doing a geometric repack. Since the "make that object reachable" doesn't
necessarily mean that we'll create a new copy of that object in one of
the packs that will get rolled up as part of a geometric repack, it's
possible that the MIDX won't see any copies of that now-reachable
object.

Of course, it's desirable to avoid including cruft packs in the MIDX
because it causes the MIDX to store a bunch of objects which are likely
to get thrown away. But excluding that pack does open us up to the above
race.

This patch demonstrates the bug, and resolves it by including cruft
packs in the MIDX even when doing a geometric repack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c              | 19 +++++++++++++++++--
 t/t5329-pack-objects-cruft.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 36d1f03671..e9e3a2b4e3 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -23,6 +23,7 @@
 #define PACK_CRUFT 4
 
 #define DELETE_PACK 1
+#define CRUFT_PACK 2
 
 static int pack_everything;
 static int delta_base_offset = 1;
@@ -161,8 +162,11 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
 		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
 			string_list_append_nodup(fname_kept_list, fname);
-		else
-			string_list_append_nodup(fname_nonkept_list, fname);
+		else {
+			struct string_list_item *item = string_list_append_nodup(fname_nonkept_list, fname);
+			if (file_exists(mkpath("%s/%s.mtimes", packdir, fname)))
+				item->util = (void*)(uintptr_t)CRUFT_PACK;
+		}
 	}
 	closedir(dir);
 }
@@ -564,6 +568,17 @@ static void midx_included_packs(struct string_list *include,
 
 			string_list_insert(include, strbuf_detach(&buf, NULL));
 		}
+
+		for_each_string_list_item(item, existing_nonkept_packs) {
+			if (!((uintptr_t)item->util & CRUFT_PACK)) {
+				/*
+				 * no need to check DELETE_PACK, since we're not
+				 * doing an ALL_INTO_ONE repack
+				 */
+				continue;
+			}
+			string_list_insert(include, xstrfmt("%s.idx", item->string));
+		}
 	} else {
 		for_each_string_list_item(item, existing_nonkept_packs) {
 			if ((uintptr_t)item->util & DELETE_PACK)
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index e4744e4465..13158e4ab7 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -648,4 +648,30 @@ test_expect_success 'cruft --local drops unreachable objects' '
 	)
 '
 
+test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit reachable &&
+		test_commit cruft &&
+		unreachable="$(git rev-parse cruft)" &&
+
+		git reset --hard $unreachable^ &&
+		git tag -d cruft &&
+		git reflog expire --all --expire=all &&
+
+		git repack --cruft -d &&
+
+		# resurrect the unreachable object via a new commit. the
+		# new commit will get selected for a bitmap, but be
+		# missing one of its parents from the selected packs.
+		git reset --hard $unreachable &&
+		test_commit resurrect &&
+
+		git repack --write-midx --write-bitmap-index --geometric=2 -d
+	)
+'
+
 test_done
-- 
2.36.1.94.gb0d54bedca

