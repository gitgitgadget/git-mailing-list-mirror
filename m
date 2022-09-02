Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F7ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 21:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIBV1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiIBV1a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 17:27:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964BE86B2
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 14:27:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so3314338pji.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date;
        bh=psNVrbd/9u7z8vLm/eZ0Nx+Uey3+uxYRL9VSCgyXcTk=;
        b=f3Ys5pOOMLA47vmdoUP/tebpozXA3KGtd+AVFIElJS92w/Uic8Qhn/bUIyOTs9I+iz
         5Dh9S1ol6SUVx532ZuYA77tvKLe7k86hnDDtcGjCD2I3YY2lytnPjd3NQEpGnLSEX9t/
         Foy7JmT6SYf5TB83HyzQQ7vic+DUl2pVPl/0kF1vjGSYwJj2nFrQdY5Jqtzx5Fsup+vT
         +PE5Hj6H69+nnhPCoyvEXdTcItcD+2HF51xR2MjLoGZIHPv0E503BgL4YrzQuqp+VvlM
         /d/7IXunNYtTZl0b7sADdPucN9E+3N0wZrfnjCwO928NXgVHpPnmtuXVQwAFE3yDmY9V
         HGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=psNVrbd/9u7z8vLm/eZ0Nx+Uey3+uxYRL9VSCgyXcTk=;
        b=DzjzksRITOdaLuIMFZFvHDiqTyPZPHgIWGqiqKPiW9Ru5hrerR1D2fY7NwQOUqp2Ii
         mPWNRjWIWI+EQjpg2JNxnMzJxbgd4gb4wyN3uGiiHC4OEJRJO6pb/IvSEhPmWdUNMUhR
         mpTJBFQ3WK4RHqnLqywQVoi2otLFt1qviJs4GEJdvohbg1NU668mk12hRshedVmfXbFY
         4jD0R6vIctzd3zpIxxYri459xsfB5+fL+yI4sjzaGZ4G426DQ84Ri9k5AIM4nrQY/f70
         hxGAz0cgB/HKKU4R9XRNcZnkpXSOEMuY6HkmE/sHzboKx3b3pn9Q2ZzeZIi72qtZxAmt
         TghA==
X-Gm-Message-State: ACgBeo10VL4DUeWLBomAh8FnN9ade6gTeyICu7OVbydiPb8ybZ4j9V58
        P1MLKlmEPAx9aMzYeosDSyG0OwivWWE=
X-Google-Smtp-Source: AA6agR5ZvThwjW7ZMFhAEjSkAyqL0r73GaGZwZAGzk2IKbBrVDGiFtuu0DlEsqbaFWnNimDU6fAKWQ==
X-Received: by 2002:a17:903:2406:b0:174:f1c8:76bc with SMTP id e6-20020a170903240600b00174f1c876bcmr22693921plo.168.1662154048184;
        Fri, 02 Sep 2022 14:27:28 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t11-20020a1709027fcb00b00172ea32fa9bsm2088885plb.287.2022.09.02.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:27:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] unleak paths allocated in "diff --no-index"
Date:   Fri, 02 Sep 2022 14:27:27 -0700
Message-ID: <xmqqilm579hc.fsf@gitster.g>
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

 * Because we never pass NULL to the new helper, !path check is not
   strictly necessary, but it is conventional for free()-like
   functions to take NULL and safely become a no-op.

 diff-no-index.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git c/diff-no-index.c w/diff-no-index.c
index 9a8b09346b..2770b7d15a 100644
--- c/diff-no-index.c
+++ w/diff-no-index.c
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
 
@@ -294,13 +306,18 @@ int diff_no_index(struct rev_info *revs,
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
 
 	strbuf_release(&replacement);
+	free_allocated_path(paths[0]);
+	free_allocated_path(paths[1]);
 
 	/*
 	 * The return code for --no-index imitates diff(1):
