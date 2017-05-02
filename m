Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB151F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbdEBQBk (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:01:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:56585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbdEBQBj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:01:39 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7Yhz-1e2eN81ojn-00xNug; Tue, 02
 May 2017 18:01:33 +0200
Date:   Tue, 2 May 2017 18:01:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 07/25] difftool: address a couple of resource/memory
 leaks
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <04aa5ca2e4c5b3edc0c9dd36b2ecdb4f34e30228.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sjYAFsCYo5XJw7B45A1aBWKTwkadUtkovn8RbBFSUIMqDrvUR8x
 qBIgOEm0RTztYo/7tCrVZo3uJioxyMiQAImi75RkGV7IIBwdeJAQTBLZz+1rINSmev0s8Gn
 LQ11Q9hJI4rEu2e4xYppMoD1WoW0uhI3kuSsleNetAuVrZsd5vIwugr2+AZxzzmUdJZBwJP
 V+CbkI8NvjCUNxrBgiQxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q6YTiS4rJnQ=:2y/7aewNk+nGPVV7YIKc+D
 vLk1JR94yqy0vkjKqIJGNJv39umZLwKZEh01tOpqWrmyW0jf1EkcC95apB7p7sBVBHbT1vzx1
 gwoU/3ZOTMSNuFpo1EmkJnjAzl7CGd4AAtz53hveTREMXZmBD0NFkBd3CW6ef/4W4W/VdXXd/
 xpmUYFN8cL4K1bgr5KZCQjD4Eb0+H0FkAtMUrAVlESmp8rlaf8qsKIR3i+QMqW/LuBPLEHSq0
 BQTmDolP9Wwi7K96/+llL15rvMkAE6hnEAjFt8YzwrxskzLAjQIyOIVqLkBdwyPG2yaLl/Auc
 3+UC4lLnwO+TLGXIVDGP5/KsRJaojFhX8s1X/fOcGTUglg36zQHS335tZKX7XNDmI+uXJa/Wv
 3E9YqtJleASIjXFirx1WA5YPAw4crGcx+/7vtwNllcSrUhdUnDUq9LsCEOZlpp368nOjhLKit
 KUKYqfqkAu5EseZhGzfv+o8ztxSchKGjl5GDRmspyiXVEd7k2JvvuVbHtv/eHat4O9Nnw3Ldp
 Q/rX9VHOBWLstAqc13vF9GQ5FuotYCtRGWv6zlIge4g7CR/lSQtrPngQimGD9MZnZk7PXqe8N
 FAZ1fG91RMzyUL4+ArGZFs6y/8kFRhRb785w1fLw/9i8gehkjM7Z+6qGAEQvOSK8Mu7FaQyM4
 JelXN6XzFVTQvSRdujPt2FXZcOEXQ2AZGfq8yEW02mUaGrQfHGDB3Hwn9wRyszlLmQHJbwXyL
 6xtMdGBeBP2dboB4xUtpxqQuCvLl1Np4mDkCnDVayrwjqh0RbW2XKNIQ7EQZT8zmvvTT8Cg9B
 5DAab6L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change plugs a couple of memory leaks and makes sure that the file
descriptor is closed in run_dir_diff().

Spotted by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1354d0e4625..b9a892f2693 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -226,6 +226,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 		hashmap_entry_init(entry, strhash(buf.buf));
 		hashmap_add(result, entry);
 	}
+	fclose(fp);
 	if (finish_command(&diff_files))
 		die("diff-files did not exit properly");
 	strbuf_release(&index_env);
@@ -439,8 +440,10 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 
 		if (lmode && status != 'C') {
-			if (checkout_path(lmode, &loid, src_path, &lstate))
-				return error("could not write '%s'", src_path);
+			if (checkout_path(lmode, &loid, src_path, &lstate)) {
+				ret = error("could not write '%s'", src_path);
+				goto finish;
+			}
 		}
 
 		if (rmode && !S_ISLNK(rmode)) {
@@ -456,9 +459,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			hashmap_add(&working_tree_dups, entry);
 
 			if (!use_wt_file(workdir, dst_path, &roid)) {
-				if (checkout_path(rmode, &roid, dst_path, &rstate))
-					return error("could not write '%s'",
-						     dst_path);
+				if (checkout_path(rmode, &roid, dst_path,
+						  &rstate)) {
+					ret = error("could not write '%s'",
+						    dst_path);
+					goto finish;
+				}
 			} else if (!is_null_oid(&roid)) {
 				/*
 				 * Changes in the working tree need special
@@ -473,10 +479,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 						ADD_CACHE_JUST_APPEND);
 
 				add_path(&rdir, rdir_len, dst_path);
-				if (ensure_leading_directories(rdir.buf))
-					return error("could not create "
-						     "directory for '%s'",
-						     dst_path);
+				if (ensure_leading_directories(rdir.buf)) {
+					ret = error("could not create "
+						    "directory for '%s'",
+						    dst_path);
+					goto finish;
+				}
 				add_path(&wtdir, wtdir_len, dst_path);
 				if (symlinks) {
 					if (symlink(wtdir.buf, rdir.buf)) {
@@ -497,13 +505,15 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 	}
 
+	fclose(fp);
+	fp = NULL;
 	if (finish_command(&child)) {
 		ret = error("error occurred running diff --raw");
 		goto finish;
 	}
 
 	if (!i)
-		return 0;
+		goto finish;
 
 	/*
 	 * Changes to submodules require special treatment.This loop writes a
@@ -626,6 +636,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		exit_cleanup(tmpdir, rc);
 
 finish:
+	if (fp)
+		fclose(fp);
+
 	free(lbase_dir);
 	free(rbase_dir);
 	strbuf_release(&ldir);
-- 
2.12.2.windows.2.800.gede8f145e06


