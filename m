Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BCC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEAB61039
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbhJZVDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhJZVDm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:03:42 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27907C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:18 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w15so676362ilv.5
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W4T2W1htd3p2LLktcrdA5PdgIx+a3UO+/AQGYzg0OHs=;
        b=QH5Dd/f+L4qbK4dkCICTmAiYBD7v95Yd7ShTSJQDljRNZFFC2nI2jTSZVn67ZcHIpo
         RRytzn+J6Zr9SzG46ubOhXO2m9SWWFrk4IRqb6KMLgvcuBnbRJSnsN/iqa0YES67SaGU
         5zPeA9PL6X5qX9CziLLeUL1vdN7UdCrFf2fEd0jHNiBKlmfQbLiuOXHRXSPizled5mik
         NgS6tH5imFlRV0tCOBePZL7vd0TyPteYwHmibL1rnter2MDAfa01E14TUVzr0SKvw85p
         7HcO9Dda3Mef2R776tX5AwqrR0y1e7GMfSihGw+k/GzUH4rknhNwC1NPp8Br2c/TL4N6
         50bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W4T2W1htd3p2LLktcrdA5PdgIx+a3UO+/AQGYzg0OHs=;
        b=5d+Xc6nUSu1n9lWnZP/ynQIeWu4jE9clwUq2Xuro4ptxDUnQo/qLQPmhK8tM6G8h/l
         E3dYiQXAt3IPue7R5TdX1JX6rI867GAxVM1JVi+kgRslTmA6k20ZdFwDvQSkxBMCuf57
         V756QRkAlXNPmgP5iv/UBPxYvZzxxOwZpPqUgM4PYSXiUjJKerlKMBMh6BzNIMKQ/x4Z
         Oo+67pxLd1fmmL+CjZFpLGC6cYeSO+6G+TaPi0PYP4+pc57efICcKJMXcdO3PT4lQvY5
         hb0W9Mc3V8bDwhbMScDPiSsrechNWp1d6SK0MWe2GC2SjmQaecuzQKtcV6D2/I0XRrvE
         V4BA==
X-Gm-Message-State: AOAM530KHitmThVcxYWMxTpWKXRWNbOpmwfcNzf+3IMLGf091XQiOYgh
        g6MPuoDs0xwWZcxxYbBmqOvmcbnFsBNcTQ==
X-Google-Smtp-Source: ABdhPJxRK0QBnWBSUEESOBRaKrHKYhWWZ4dc89XZvoqpOejYoj4Ds9m3jaNsVuU7Bru1NiogKZ+ILA==
X-Received: by 2002:a05:6e02:1b0f:: with SMTP id i15mr4231656ilv.21.1635282077223;
        Tue, 26 Oct 2021 14:01:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm11953541iow.31.2021.10.26.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:01:16 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:01:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH v2 5/9] builtin/repack.c: avoid leaking child arguments
Message-ID: <bcd12ecab81029be825a646348cb7ae69970a819.1635282024.git.me@ttaylorr.com>
References: <cover.1635282024.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1635282024.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git repack` invokes a handful of child processes: one to write the
actual pack, and optionally ones to repack promisor objects and update
the MIDX.

In none of these cases do we bother to call child_process_clear(), which
frees the memory associated with each child's arguments and environment.

Make sure that we call child_process_clear() in any functions which
initialize a struct child_process before returning along a path which
did not call finish_command().

In cmd_repack(), take a slightly different approach to use a cleanup
label to clear the child_process, unless finish_command() was called.
This allows us to free other memory allocated during the lifetime of
that function. But it avoids calling child_process_clear() twice (the
other call coming from inside of finish_command()) to avoid assuming the
function's implementation is idempotent.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82..b82f6b485c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -258,9 +258,11 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	for_each_packed_object(write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
-	if (cmd.in == -1)
+	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
+		child_process_clear(&cmd);
 		return;
+	}
 
 	close(cmd.in);
 
@@ -586,8 +588,10 @@ static int write_midx_included_packs(struct string_list *include,
 		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
 
 	ret = start_command(&cmd);
-	if (ret)
+	if (ret) {
+		child_process_clear(&cmd);
 		return ret;
+	}
 
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, include)
@@ -608,9 +612,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
-	int i, ext, ret;
+	int i, ext, ret = 0;
 	FILE *out;
 	int show_progress = isatty(2);
+	int cmd_cleared = 0;
 
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
@@ -794,7 +799,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (geometry) {
 		FILE *in = xfdopen(cmd.in, "w");
@@ -818,8 +823,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
+	cmd_cleared = 1;
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
@@ -893,7 +899,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		string_list_clear(&include, 0);
 
 		if (ret)
-			return ret;
+			goto cleanup;
 	}
 
 	reprepare_packed_git(the_repository);
@@ -946,12 +952,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		write_midx_file(get_object_directory(), NULL, NULL, flags);
 	}
 
+cleanup:
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
 	strbuf_release(&line);
+	if (!cmd_cleared)
+		child_process_clear(&cmd);
 
-	return 0;
+	return ret;
 }
-- 
2.33.0.96.g73915697e6

