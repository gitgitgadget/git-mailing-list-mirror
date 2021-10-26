Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F65C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0367C60FE8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbhJZVDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239362AbhJZVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:41 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688EEC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:15 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w15so676239ilv.5
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jnvYuC9YIyrSRrdpUg3msJq8OxB1kQRC4M327pK9p1w=;
        b=1X9YqqYoGZJQnN/5fdUdqtnWv/BvpVH4e4tUKhuQntdZ9wLFd8AhQmJMlpR0wb7WsQ
         YwaxMIYgFFdFQR6nhITzg8tcKzwjbwpp7F1W8TrA4cibgbe4UU6Ha0K4l8gqs/x1o7zc
         WUEmGWbFVIePRucRBbXTebU0mu54V++0CzjX50KUrfPXlLf+HOAqSSU1oojYR3iAwEr5
         oDe/nlQ/SmfVrxCk0+KBgHcRskCGri+mvSnd05MiduyVB2mkyI60QN1VJFD4ocOUM+WZ
         VbNjtSycDc50TT6FNczI/0cdFPD4eizr/zs4YqrFV9k320ct/cT32HLmh7/6KxbupFmr
         KkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jnvYuC9YIyrSRrdpUg3msJq8OxB1kQRC4M327pK9p1w=;
        b=K/Wa/qKVeU7Sm8N6+0yoDQfl+9C0wk8MCyzZR7J/dp57+/5458ntt8I2bxzGvjqSAK
         piNFqEsyrTT4Xsv8no7niUZFWlbFg1YYwTjhcv1l8EI6QL3dG5ZQOWUWhhE7ENIaEQxU
         3psyyWaqTiLuWMmyaiQN/ondO13/K7S4ULbYRi6fmAKevscP8zMeDfg7/Z9qjfD+eb7x
         jz9w8oUJgMg+erGBJCGL6VplgxpCp54a8wU65tTrQV4D84+THmYtvjaA8vm9FtgylBjs
         fqFPDXJ8kM4sDdhLYKvOqhtAHAMXTIwEy9qhdVsxHPwIDNC7uFWUnodHcDCnoOGZXs+A
         rMVA==
X-Gm-Message-State: AOAM531eZWp1sU8cEX1M+myHjgrROmt6jPdWkX9P2v+TBpTabLJ2wNDL
        UdMcoBGaab6FXEnVP2kD7plklN4+xamLbA==
X-Google-Smtp-Source: ABdhPJwGJMKSJ52zcvIU5/UFF2fVpeYqiK1dUriGCAasYDAKIplqfD52YJKzt6VWZI+coGlGn9ksDQ==
X-Received: by 2002:a92:3642:: with SMTP id d2mr16265563ilf.91.1635282074684;
        Tue, 26 Oct 2021 14:01:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y20sm8850136ilq.74.2021.10.26.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:14 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 4/9] builtin/pack-objects.c: don't leak memory via
 arguments
Message-ID: <aedb1713b40f5e0e7c316dd6f5c9b9a1cc0df39c.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing arguments to pass to setup_revision(), pack-objects
only frees the memory used by that array after calling
get_object_list().

Ensure that we call strvec_clear() whether or not we use the arguments
array by cleaning up whenever we exit the function (and rewriting one
early return to jump to a label which frees the memory and then
returns).

We could avoid setting this array up altogether unless we are in the
if-else block that calls get_object_list(), but setting up the argument
array is intermingled with lots of other side-effects, e.g.:

    if (exclude_promisor_objects) {
      use_internal_rev_list = 1;
      fetch_if_missing = 0;
      strvec_push(&rp, "--exclude-promisor-objects");
    }

So it would be awkward to check exclude_promisor_objects twice: first to
set use_internal_rev_list and fetch_if_missing, and then again above
get_object_list() to push the relevant argument onto the array.

Instead, leave the array's construction alone and make sure to free it
unconditionally.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a3dd445f8..857be7826f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4148,11 +4148,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		read_packs_list_from_stdin();
 		if (rev_list_unpacked)
 			add_unreachable_loose_objects();
-	} else if (!use_internal_rev_list)
+	} else if (!use_internal_rev_list) {
 		read_object_list_from_stdin();
-	else {
+	} else {
 		get_object_list(rp.nr, rp.v);
-		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
 	if (include_tag && nr_result)
@@ -4162,7 +4161,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			    the_repository);
 
 	if (non_empty && !nr_result)
-		return 0;
+		goto cleanup;
 	if (nr_result) {
 		trace2_region_enter("pack-objects", "prepare-pack",
 				    the_repository);
@@ -4183,5 +4182,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			     " pack-reused %"PRIu32),
 			   written, written_delta, reused, reused_delta,
 			   reuse_packfile_objects);
+
+cleanup:
+	strvec_clear(&rp);
+
 	return 0;
 }
-- 
2.33.0.96.g73915697e6

