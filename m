Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5705E20323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbdCQFs0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:48:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:35739 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdCQFs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:48:26 -0400
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ABFBF237DD57F;
        Fri, 17 Mar 2017 05:48:20 +0000 (GMT)
Received: from PUMAIL01.pu.imgtec.org (192.168.91.250) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 17 Mar 2017 05:48:22 +0000
Received: from pudesk287-linux.pu.imgtec.org (192.168.91.23) by
 PUMAIL01.pu.imgtec.org (192.168.91.250) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 17 Mar 2017 11:18:21 +0530
From:   Rahul Bedarkar <rahul.bedarkar@imgtec.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, Rahul Bedarkar <rahul.bedarkar@imgtec.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] grep: fix build with no thread support
Date:   Fri, 17 Mar 2017 11:17:36 +0530
Message-ID: <1489729656-17709-1-git-send-email-rahul.bedarkar@imgtec.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.91.23]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 0281e487fd91 ("grep: optionally recurse into submodules")
added functions grep_submodule() and grep_submodule_launch() which
uses "struct work_item" which is defined only when thread support
is available.

When building git with toolchain that don't have thread support, we
get following build errors:

      CC builtin/hash-object.o
  builtin/grep.c: In function 'grep_submodule_launch':
  builtin/grep.c:596:34: error: dereferencing pointer to incomplete type 'struct work_item'
    status = capture_command(&cp, &w->out, 0);
                                    ^
  builtin/grep.c: In function 'grep_submodule':
  builtin/grep.c:644:20: error: storage size of 'w' isn't known
     struct work_item w;
                      ^
  make[2]: *** [builtin/grep.o] Error 1
  make[2]: *** Waiting for unfinished jobs....

This commit fixes above build issue by using "struct grep_source" and
"struct strbuf" instead of "struct work_item" in grep_submodule() and
grep_submodule_launch() when thread support is not available.

This build failure is detected by Buildroot Autobuilder:
http://autobuild.buildroot.net/results/94b/94bce9a99a5ce9894a6918774ab75e23d12c1394/

Cc: Brandon Williams <bmwill@google.com>
Fixes: 0281e487fd91 ("grep: optionally recurse into submodules")
Signed-off-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
---

This patch is tested by running t7814-grep-recurse-submodules.sh with
both with/without thread support builds.

 builtin/grep.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef..4373d79 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -183,11 +183,13 @@ static void *run(void *arg)
 		if (!w)
 			break;
 
-		opt->output_priv = w;
-		if (w->source.type == GREP_SOURCE_SUBMODULE)
+		if (w->source.type == GREP_SOURCE_SUBMODULE) {
+			opt->output_priv = &w->out;
 			hit |= grep_submodule_launch(opt, &w->source);
-		else
+		} else {
+			opt->output_priv = w;
 			hit |= grep_source(opt, &w->source);
+		}
 		grep_source_clear_data(&w->source);
 		work_done(w);
 	}
@@ -538,7 +540,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	int status, i;
 	const char *end_of_base;
 	const char *name;
-	struct work_item *w = opt->output_priv;
+	struct strbuf *w = opt->output_priv;
 
 	end_of_base = strchr(gs->name, ':');
 	if (gs->identifier && end_of_base)
@@ -593,10 +595,10 @@ static int grep_submodule_launch(struct grep_opt *opt,
 	 * child process.  A '0' indicates a hit, a '1' indicates no hit and
 	 * anything else is an error.
 	 */
-	status = capture_command(&cp, &w->out, 0);
+	status = capture_command(&cp, w, 0);
 	if (status && (status != 1)) {
 		/* flush the buffer */
-		write_or_die(1, w->out.buf, w->out.len);
+		write_or_die(1, w->buf, w->len);
 		die("process for submodule '%s' failed with exit code: %d",
 		    gs->name, status);
 	}
@@ -641,19 +643,19 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
 	} else
 #endif
 	{
-		struct work_item w;
+		struct grep_source gs;
 		int hit;
+		struct strbuf outbuf = STRBUF_INIT;
 
-		grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
+		grep_source_init(&gs, GREP_SOURCE_SUBMODULE,
 				 filename, path, sha1);
-		strbuf_init(&w.out, 0);
-		opt->output_priv = &w;
-		hit = grep_submodule_launch(opt, &w.source);
+		opt->output_priv = &outbuf;
+		hit = grep_submodule_launch(opt, &gs);
 
-		write_or_die(1, w.out.buf, w.out.len);
+		write_or_die(1, outbuf.buf, outbuf.len);
 
-		grep_source_clear(&w.source);
-		strbuf_release(&w.out);
+		grep_source_clear(&gs);
+		strbuf_release(&outbuf);
 		return hit;
 	}
 }
-- 
2.6.2

