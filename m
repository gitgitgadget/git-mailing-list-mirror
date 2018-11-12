Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0A01F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeKMAka (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:40:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:35658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:40:30 -0500
Received: (qmail 29222 invoked by uid 109); 12 Nov 2018 14:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:46:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11189 invoked by uid 111); 12 Nov 2018 14:46:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:46:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:46:54 -0500
Date:   Mon, 12 Nov 2018 09:46:54 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 1/9] fsck: do not reuse child_process structs
Message-ID: <20181112144654.GA7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The run-command API makes no promises about what is left in a struct
child_process after a command finishes, and it's not safe to simply
reuse it again for a similar command. In particular:

 - if you use child->args or child->env_array, they are cleared after
   finish_command()

 - likewise, start_command() may point child->argv at child->args->argv;
   reusing that would lead to accessing freed memory

 - the in/out/err may hold pipe descriptors from the previous run

These two calls are _probably_ OK because they do not use any of those
features. But it's only by chance, and may break in the future; let's
reinitialize our struct for each program we run.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..b10f2b154c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -841,6 +841,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 		prepare_alt_odb(the_repository);
 		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+			child_process_init(&commit_graph_verify);
+			commit_graph_verify.argv = verify_argv;
+			commit_graph_verify.git_cmd = 1;
 			verify_argv[2] = "--object-dir";
 			verify_argv[3] = alt->path;
 			if (run_command(&commit_graph_verify))
@@ -859,6 +862,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 		prepare_alt_odb(the_repository);
 		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+			child_process_init(&midx_verify);
+			midx_verify.argv = midx_argv;
+			midx_verify.git_cmd = 1;
 			midx_argv[2] = "--object-dir";
 			midx_argv[3] = alt->path;
 			if (run_command(&midx_verify))
-- 
2.19.1.1577.g2c5b293d4f

