Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34161F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbcIIOhP (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:52491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbcIIOhK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MX19U-1bWG0A3qeC-00Vxoc; Fri, 09 Sep 2016 16:37:03
 +0200
Date:   Fri, 9 Sep 2016 16:37:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/17] sequencer: do not die() in do_pick_commit()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <5a090b8f817bbe5a9b32b3af556416b2e341d221.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wX2c7p8lsNjb1JckpjrG6lUMnUYu44oC6tX47RsFJzixY+ajO8H
 VwBwmnYB4KhPnKXl94Pxw6IpWJtJn2I0CphnGHeeY3SYMuKiTlnlNMMHJvtdBph7Rqv/kfZ
 k1DsymCtpxQw/MXhxlsBgSIR2mpup7ORsPXhfODg7cWfn9imjA23yHx4rHKlA05+Z6bQgHk
 C86/RJiunycGEVRbxDLGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+7+DXbFb+iY=:US7gQEw6PBWf4AiB4rG6vK
 hEkr/3iLuDWXrH/BfOa7NoHod52ug9U+Hnyn5SyyPA0ZLu/q+EFhMPiDFXhmKVxh+EOQ8OPHy
 sgrTPwh1N85gB3wpNCe0PS71KSi01bPs23u8gW51j/3drcEdCiZ+/sFnhtIrIHIzeIjRCu+FT
 oPH/JNjG110/noH6uMqQcSGG5Od+OHCLpvftIsmaS8cABiQZEVB8zDEuzaO+wP/58o7GcAJLi
 WWUmLfVNG0Gen+Au8Gw10yjxihCMNRCuBAZ/ZYYIqB7zWMQy44h0vcYOkemoK0s8OoDvgndO+
 w3iBkNgKIzLqz3f4VXLL69F6G1oD2rF9E7r5kY6EnzomTlzCReuo3qdqt+ljlhRFV1jaG7s9V
 allwByLmPNitWgqqKd3QvMGQeKmNbC68VgdQRzLMiIvoXwdRQM0ZZLaAiMg+5A+jc8AWqRkCe
 Ks7UnCVoECpYwCMFSEzmBXkBSYq43chzzzr4oI5r77KUY5MYiFDV6k4qW/jSPGB9rt9bhVzwf
 v7ThX0Kdd4Lb/vMMX+8z6mUm310QJES8DFgoldt1N6pARwmISF4pwdqH0wwyiiVXJarJLBfha
 AEd9Hodd21CRJsFghS3fIAUFXPwwLtz1Pot6bGSqBRk70YSt4uum+fK0Pnbn0+/YaQkV8rrmo
 7KzhKb0qM8NEP5bBBSeF7PCiG9sAYLFNmBbC6Jd2z3+YZx3hhdeVbf/V0C0T9hczjI02eGXz3
 Do20pPv/PnEY+B65MvZbWACePjzg6AlT/dIN2ugUZIZLMnlc50riiWfGZW7wL0xzOSxyeZThq
 OcuATle
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The eventual caller of do_pick_commit() is sequencer_pick_revisions(),
which already relays a reported error from its helper functions
(including this one), and both of its two callers know how to react to
a negative return correctly.

So this makes do_pick_commit() callable from new callers that want it
not to die, without changing the external behaviour of anything
existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 76b1c52..baf6b40 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -585,12 +585,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
-	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
-			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1) &&
+	    update_ref(NULL, "CHERRY_PICK_HEAD", commit->object.oid.hash, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		res = -1;
+	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
+	    update_ref(NULL, "REVERT_HEAD", commit->object.oid.hash, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+		res = -1;
 
 	if (res) {
 		error(opts->action == REPLAY_REVERT
-- 
2.10.0.windows.1.10.g803177d


