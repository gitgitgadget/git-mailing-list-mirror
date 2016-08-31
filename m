Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970321F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbcHaI4A (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:49610 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbcHaIz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:56 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LfHs4-1bL5lY36ue-00olgL; Wed, 31 Aug 2016 10:55:52
 +0200
Date:   Wed, 31 Aug 2016 10:55:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 22/34] sequencer (rebase -i): run the post-rewrite hook, if
 needed
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <22df98870d37c140296439115f32706cc8e436c2.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o69fF3UH79h+hmD36W27bf8bo0cqtvWZYb5FAvslg2xoZ95bq3H
 sH7OGo726Lf9YAlJ2kvIspuS4nnbRN03D5JTshGrTKrElx3sRxepOl0OWV1f2LXXRWbMz5h
 ZcbAeZ4m4bdJPdyR4yLBwYURO4YqLcrVjCbmtcIHJFv0NVU/fTrbbo30YwzGKGweIlmE/pi
 sZFcVk5I3n+Dj6zBlwbng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rei6tf1p1Qg=:5GV9uwaWqbuR4YyLGjsv5C
 ED/JakHGIJzYsSrnN7h9ODKl4Xw4+otPVDArsK30MsF0R/O2uzqKIOM5xNIL2WKubkyoHSDSM
 SBZGZ7p3eV7CO2IeMCgXf+d5cyw2aa/wFK3jFv75molpu5S54gpYEyKwDAst3dnyyMjbTWUOR
 IQ9o/K63alJB4ZmcV2HYjruvw9yoVEq8Dkasv1TLLN9bIVYlkSFlAZbKLkn9bGDUQO6D3/2WD
 87RPKDNt9tf99xhsLsBjwGxojtMH2Iy/4x5yxs8b7gaBnHpzsidMkzVQwcgLCzRYS2RV7RUI7
 uuOhVOklib5D22gNe1yCVreaiNPu4Fu3rDscXFfKh2F6dFa6/jTnJCv7ZBlsy3M4Vr8VXzhAD
 VmwD5c0Ge9emiFRoPu/s/i06mJgiUOA4vGKWw2MKjlD5fesCCqczU44ATwgQ9gD+ESKL/baxI
 YossztGnidSH9oUF+Wsh/wiSR3JDLQf4m/J7zAMtOG4QLbSw6YWTzHFlH/kwJzQ9MNcYo46eq
 gdmQL23sJmj2j/9d6fQVKny6Vbumo4GE2g23XpTaD5r4Py1eLgoro9bQjkA+bfU42MrwUvK1R
 exPODPMcVgYyuE0P9/ez5MNYU8YpMpPfHyUiqhNmsK+HfwSElFmVkOOig5UQBBcBxfJfsggy3
 bUDI8sSsYUKrw4BwccjferdqBVM960rcZu7Xg57JoykctUpqHiwT1ZlVVfSw2N5tGZIwQ25zD
 Wgv2J6O5DO4Ao44Wk+tibYI88ZynJA5sw/q35hDJb4syUIHEt0GUfhQ3e0Sqs6xlmJ40KjcN1
 DSU4kL3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index a00d349..153116e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1922,6 +1922,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
+			const char *post_rewrite_hook =
+				find_hook("post-rewrite");
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -1930,6 +1932,17 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			argv_array_push(&child.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
 			run_command(&child);
+
+			if (post_rewrite_hook) {
+				struct child_process hook = CHILD_PROCESS_INIT;
+
+				hook.in = open(rebase_path_rewritten_list(),
+					O_RDONLY);
+				argv_array_push(&hook.args, post_rewrite_hook);
+				argv_array_push(&hook.args, "rebase");
+				/* we don't care if this hook failed */
+				run_command(&hook);
+			}
 		}
 
 		strbuf_release(&buf);
-- 
2.10.0.rc2.102.g5c102ec


