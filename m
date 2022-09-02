Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A91C54EE9
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 23:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIBXtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIBXtU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 19:49:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBF106DA4
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 16:49:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so3515272pjc.3
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=IF05TBrY9Vg5XlqrApK5BO9TxhRF32VbN+bsnjNtsOA=;
        b=WaeHVQPo+Ksc4jRSwlsYQLXzzr/suKkqGQrsr6oibpu4oVNxTaBi5HvjPfZg3QWrnL
         JL7ae1h6tHokhR6vD+3na+Bu36cTU1x7uv0tJCU3HEk9XMxdwOYf4gs/rVrNs/9dC94A
         V4INjX+UAvul0nSSOYFf5vnDSIp66lHws0gl2dN1YGcUGQog5Qyl+wM4IS+PmHVFzoDW
         ym4jVSWrNoGKUhzZtSjY98O6rhQjEzj/NtwKvNFEYQGQQUQrDiCOtmhcl5p0WW9jqj2a
         HbajxEJuoQtQFDehnwbzLfzXEYpsWNC+WWp3aiZ72SaSloDsAvrIm+Vw8c7qZhlFgMri
         raHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=IF05TBrY9Vg5XlqrApK5BO9TxhRF32VbN+bsnjNtsOA=;
        b=Nl8vAFt9JACzQJHJ15rQUs5VMF+aMrIfvhIUErLqb7etPXgq21oyqU25FX4yoyJxoQ
         FMsP836COAO7vMg2u5XSYHgFAljVaLCrhp0ZSb+SdP+DXKi4Zdlii5d/2vrKYMIwfZlM
         fwcZfdFdSdf08livtGD8QvzcX2ZetsXgfNNdu9d3l0qdM719rWDBJvT5OY1g9b7caiXR
         GL6O9H5COp5JJg6GcTBs7vZ5HLducbNXFGodU77c8hg4Km1hdAnQhw7k+ZoE5Jb24t9p
         J3BHZPSw1GO0Se7OhWI8BAhmfAgtLdQCRY44X/iNfRhHr8g9zFUmOmQbK8l+GgOn32y/
         NnaA==
X-Gm-Message-State: ACgBeo3vcyc9IgMwuvG8IXl4ou/CD11GzO9lf3ctH9dP+1EHopi+jChi
        JLnI2LxjoqqP52A2pT2+qDcQafIcsPc=
X-Google-Smtp-Source: AA6agR5CNLdpcBOYJEBtA/My5UJY+k5nEYFrJGmlvfMN1yAoStKZa98eEJvvo9G6YVFKghv4khpOuw==
X-Received: by 2002:a17:902:d885:b0:172:868f:188c with SMTP id b5-20020a170902d88500b00172868f188cmr37364814plz.78.1662162558370;
        Fri, 02 Sep 2022 16:49:18 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o185-20020a62cdc2000000b005364e0ec330sm2398931pfg.59.2022.09.02.16.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:49:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] diff --no-index: unleak paths[] elements
References: <xmqqilm579hc.fsf@gitster.g>
Date:   Fri, 02 Sep 2022 16:49:17 -0700
Message-ID: <xmqqilm51gn6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git diff --no-index" codepath starts with the two elements in
argv[] and munges them into two paths to be compared, stored in a
separate path[] arrays.  The munging is implemented in a rather
haphazard way, sometimes overwriting old version with a new copy,
and sometimes a constant string assigned to path[], making it
impossible to release the resources properly:

 * A single dash "-" from the command line is a special signal that
   the standard input is used for the side to be compared, and is
   internally replaced with a copy of string "-" at a known address.

 * When run in a subdirectory, full paths to the two paths are
   allocated and placed in path[].

 * After the above happens, when comparing a file with a directory,
   the directory side is replaced with the path to a file in the
   directory with the same name as the file.

This was perfectly fine for just two strings that are pathnames used
during the lifetime of the program and cleaned up upon program exit,
but it gets in the way when leak sanitizer is in effect.  The third
step can be losing the full path that was allocated in the second
step, but it is not easy to tell if its input is an allocated piece
of memory to begin with.

Loosen the earlier two steps a bit so that elements of the path[]
array that come to the directory/file comparison code are either the
singleton "-" or an allocated piece of memory.  Use that knowledge
in the third step to release an allocated piece of memory when it
replaces the path to a directory with the path to a file in that
directory, and also at the end to release the two elements of the
path[] array as needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The previous one allowed strbuf_release() to free replacement.buf
   which may be used in path[0] or path[1] potentially leading to
   double freeing.  The kosher way may be to use strbuf_detach() in
   fixup_paths(), but this is a simpler fix, it is getting late in
   the day, and I am getting sick of fighting the leak-checker, so...

 diff-no-index.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)


diff --git a/diff-no-index.c b/diff-no-index.c
index 9a8b09346b..77a126469b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -208,6 +208,14 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
 	strbuf_addstr(path, tail ? tail + 1 : file);
 }
 
+static void free_allocated_path(const char *path)
+{
+	if (!path ||
+	    (path == file_from_standard_input))
+		return;
+	free((char *)path);
+}
+
 /*
  * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
  * Note that we append the basename of F to D/, so "diff a/b/file D"
@@ -226,9 +234,11 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 		return;
 	if (isdir0) {
 		append_basename(replacement, path[0], path[1]);
+		free_allocated_path(path[0]);
 		path[0] = replacement->buf;
 	} else {
 		append_basename(replacement, path[1], path[0]);
+		free_allocated_path(path[1]);
 		path[1] = replacement->buf;
 	}
 }
@@ -274,6 +284,8 @@ int diff_no_index(struct rev_info *revs,
 			p = file_from_standard_input;
 		else if (prefix)
 			p = prefix_filename(prefix, p);
+		else
+			p = xstrdup(p);
 		paths[i] = p;
 	}
 
@@ -294,13 +306,21 @@ int diff_no_index(struct rev_info *revs,
 	setup_diff_pager(&revs->diffopt);
 	revs->diffopt.flags.exit_with_status = 1;
 
-	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
+	if (queue_diff(&revs->diffopt, paths[0], paths[1])) {
+		free_allocated_path(paths[0]);
+		free_allocated_path(paths[1]);
 		return 1;
+	}
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 
-	strbuf_release(&replacement);
+	/*
+	 * do not strbuf_release(&replacement), as it is in paths[]
+	 * when replacement was actually used.
+	 */
+	free_allocated_path(paths[0]);
+	free_allocated_path(paths[1]);
 
 	/*
 	 * The return code for --no-index imitates diff(1):
-- 
2.37.3-661-g73a641a77a

