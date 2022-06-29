Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FBC43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiF2SrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiF2SrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 14:47:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C8275FF
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:47:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t16so26263256qvh.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=54HJQC/LI5ra5plJoOqbEYLvaFE3OeMEQ89PfY0Caro=;
        b=jKL9usEzYiyUQ3NzxE2r/T+2zRd1zvDLaoWHs6+PSXYoRHRCeNirmj3TrW+3zDRi7O
         DE5bFHk/pBNzUjgZL8BA2trbSMgQVy+2NI20+sE5x+aTojo/svekRwST8pV/4MIazieJ
         UY1ix8CZmUO/4pSqmqQxAJWhjYyuE1orQ741CITt34cvi11PpJsdyGUiajsHEQDS+VWF
         qQV1qG1tCddbGcoVN3swf/CwMBGMpjR4hCh6ZXQCzKhuWVuxMIS/1TFHJqP+JqMiHIVt
         nJXnAq/o/XzfG6VJobvOT36VSibuFkqhH5JtYbVv4MltbgGFD3Xi2vx92Hjpefr1kmUo
         AYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=54HJQC/LI5ra5plJoOqbEYLvaFE3OeMEQ89PfY0Caro=;
        b=00Cd35V2NXsOy8zMFmXJdrN74Jziq/+xkaKXMkHw5MC4OWH/ycPi+ibwv3gdNbfnEi
         du4InhTpbF1KLO5JcU5/aJ5SPeLWRcJOTUQJx4qjaM5mSc6WDjJ2diKQmwRhXI0P6V34
         ofvABOYh05rWNN74bPK+xeeWo7t/wxaPleo6owKRmxYtHs8Yy1lKdaFXb2LTUzw0wPM4
         h9Cp4SS53xon7gKL/w2FjB/+fhvIlBBl5x/O9+VhfsJCu+Fo+pMGgvuXtIN/Ftm8fqr+
         16E05mQXS+X8ebEgFgIDdqA65D+phVtqL4cljLVpZPmGGlWCKEku0kDzdXuQWd4KB/1h
         05Ng==
X-Gm-Message-State: AJIora/prwc2yoXZlx7I+yHB78zDsu4CJhgJS1VM9qm+0PNwhnDGv997
        lr8JQYQC//uZlG12FSHsvXKsIppBskhCFA==
X-Google-Smtp-Source: AGRyM1sJswwXM6RwOZztHgW9Fk2ErnI9ScPACoI7mgbnYS+zGjfHYqwZwI00N2n/j9vxHl3UoTxZqA==
X-Received: by 2002:ac8:5a89:0:b0:31b:f68d:5cee with SMTP id c9-20020ac85a89000000b0031bf68d5ceemr4005668qtc.468.1656528436722;
        Wed, 29 Jun 2022 11:47:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5-20020ae9e005000000b006af1f0af045sm8744639qkk.107.2022.06.29.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:47:16 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:47:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: [RFC PATCH 3/4] builtin/repack.c: write cruft packs to arbitrary
 locations
Message-ID: <86bfb40904427f68d5094e00d568eaa1ad341cad.1656528415.git.me@ttaylorr.com>
References: <cover.1656528343.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1656528343.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the following commit, a new write_cruft_pack() caller will be added
which wants to write a cruft pack to an arbitrary location. Prepare for
this by adding a parameter which controls the destination of the cruft
pack.

For now, provide "packtmp" so that this commit does not change any
behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 19e789d745..ab976007e1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -662,6 +662,7 @@ static int write_midx_included_packs(struct string_list *include,
 }
 
 static int write_cruft_pack(const struct pack_objects_args *args,
+			    const char *destination,
 			    const char *pack_prefix,
 			    const char *cruft_expiration,
 			    struct string_list *names,
@@ -673,8 +674,10 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	struct string_list_item *item;
 	FILE *in, *out;
 	int ret;
+	const char *scratch;
+	int local = skip_prefix(destination, packdir, &scratch);
 
-	prepare_pack_objects(&cmd, args, packtmp);
+	prepare_pack_objects(&cmd, args, destination);
 
 	strvec_push(&cmd.args, "--cruft");
 	if (cruft_expiration)
@@ -714,7 +717,12 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only "
 			      "from pack-objects."));
-		string_list_append(names, line.buf);
+                /*
+		 * avoid putting packs written outside of the repository in the
+		 * list of names
+		 */
+		if (local)
+			string_list_append(names, line.buf);
 	}
 	fclose(out);
 
@@ -987,7 +995,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
 
-		ret = write_cruft_pack(&cruft_po_args, pack_prefix,
+		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
 				       cruft_expiration, &names,
 				       &existing_nonkept_packs,
 				       &existing_kept_packs);
-- 
2.37.0.1.g1379af2e9d

