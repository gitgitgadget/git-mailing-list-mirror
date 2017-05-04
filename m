Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAEF4207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbdEDNz7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:55:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:65013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbdEDNz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:55:57 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbuCq-1dpTs212F2-00jGDD; Thu, 04
 May 2017 15:55:50 +0200
Date:   Thu, 4 May 2017 15:55:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 07/25] difftool: address a couple of resource/memory
 leaks
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <c11fc0730bff65d15566ead2334f9172f1849c4f.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Hj+xgFIWZFU6CCFfeYWUqKCfZUZyZC1/adGv+0SkpUm3afD54T5
 v6sHYer1AI7vmcL28YfXrkW31iXroFUy4E1txQPuxuYPWN4/RGNs4XsIBSOHxdz1dHeq/1I
 VFXKH7B8uiGut1hJT/LRrHPD5px4uD+VSS9vIMvRcd+alIH3I9ncvZjBrxJ27p8QjP74DNc
 0x4DB6x2W+y1LOvBB/VZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/dT0jn1b6Go=:C03zZiwRQsC61m24kFzDVr
 TjOPTk1GIgHDQ6HbIfRdvQg+GmFO8sHpJK8XP2ZGsu3a40bxUEk0QwEMxzb1PPt9UAq5HkhOK
 eDbm+Jbe2lNxoFYX/IEN57IuhY9AKITrNXYyIuqaS3kQ1s5FjaHJw3B3NX6BTVusxvQ92+17L
 mecp9aX+u7DSUIzRcdkqf2Nb7uRc0GNGKmlarN5EVtKer5kCH9PIQSpYcpoxByIJg14WIi8if
 cw96/E3cAxnpxz5YoFCkio3GMFx3iAIDjJ2NwD3rrUqzOlvyrRtT+1iNEbT0lN77C+8MS1/HF
 cS6Pyo7x1rxq1egD2Lp358wX7w2OA2e64q6o2iVXY1GAhW1mhyCYDhP6WN/JYxU+EaAjJHGD9
 X1SrfC6m6nmLprolrGazC2F7jSFLbsogSNta/PyjRZS34RvfrkIb1qCwBAvNjaWhmr5f3l4bl
 tAdK+nRYRtMnU/0D7hC+KjF5Lzyl828XaZquTZAt0SfLBRNbA6vNkwwEv9Lv6XaBCcQnjpibp
 toIDxlUfHxkRIg1nke2gTNkR1uYzfp5+Jj5kcBvaoMup4vFIqhViA4WiLkcbIjt1PGeR8kN1U
 Es7Q7rd1BPeNkTeAxoI/2Kbch1G1oqVoxFjlB9mdjyyHxCWg5YDuKd3G6O5ERcLRQVhKGC3Kv
 jDzDu8Ssuw3leV/718E+D1j35vGAY4CBDPpjbU6Lo8hccixIpDfCj7NYlaZqn6ngtpOWtp+OB
 yELvag5P7DuGxl4p7D96H7+FMLi4bnPOk6nCvI7b3mSFfRQlHDBYJ7fJz9gCB7i3DExG0zWGW
 Bs17adK
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


