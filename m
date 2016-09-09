Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316631F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbcIIOgC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:36:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:56627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbcIIOgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:36:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MUILK-1bYzEo2y26-00Qxt0; Fri, 09 Sep 2016 16:35:52
 +0200
Date:   Fri, 9 Sep 2016 16:35:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/17] sequencer: lib'ify sequencer_pick_revisions()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <2646059f7b3e7366744106380466f1b8904b4e85.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:F9kS0KSOF/wd9LTJ+cb3UqKBNOYp4JS3ZYfMo0F2+2EKPkN28a/
 BUBqL0+s652+LfDPLdxFLKyLDDOwf7/V46jBNHLfvAyjsI1kmh1y1AQId+Tn1Q/ZNEPjOF6
 yozGCcd2PEkcItd8DPN0LSBxTaL2sOUGgldMe5YOSQCyHxLxGeW7pVqSQe23JLuWlCKbygm
 nnI9bJe65s4ts4DsQxvDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vdy/jaDNLzM=:aOXMC6o157ac/pWIOPoXsV
 2/I5Ub3wr5Vt86phC9L+ijWrp0LWYabbL2ldRiszEplkeOtOt/WfzoIqYVCv5ubM60A+JT2RJ
 JvTtwvkaRjFfe1RhBchTTHalI+CaVts3PSEL1yqV3pptVQfza0ypY0oxIXVvqLChNVzfx17Lz
 qH0pl6y9qiILrRi9bmrdxAsHHVmuDtWGEkomaldmpnc8fM4rJ9aMmFsT/PGqbNatopt8wc0eE
 0zICi3WpPKAi2ZHOrUzh8Vb5VYNJFhwfce1XhfQ2BqfkjaLVaS9rvjC38N6Z3K3kBjvk2FAFs
 4KrYyf8ek7im/9ee3TL+op/Z5EXVUsf2JX701kklvFARrMdXQbpQ6mbehBv3zOBdDiLUGjkxQ
 S5PqLHrsC0XPUJLWDcSny5AF1qYfRc3sdDrRzpTh1tswtXPirQbCwfXMcFkElVz0Awoy/01oh
 dO1Ku904D92/xW7x5np46yzcSZjg5o/TZYc6inwS3bCzLBrsksBNhkbZll0d9Q7ZSnxeH1eHW
 m0FVJ1hsdZ1cObUyips8tP/ArJP9pDL9eOOOXJZUlKAIALTQOMQ+nklDDq9eWKZ0kKjv6Kh06
 6a8sHrQLf9zb4NqAazCuZn4uD9+/eag4Dr3CbgahEKYzC5F3qO44++3QPxcfWOQ7BbD0U+Fj7
 1LZx9zMzh3RV1cAluA7VZ/14qjTEwRk40CiWW5CyRAXTv69jD/VRIOtCjDJCJW/XSVmTlrkS6
 03nk/Ek3VXnisdMhxwfzkt5/Ud6Dn5+BXbU6gr+ZcrH1Gg7S8r3xn1v0DF9U2FlHemNNj9CnH
 NRhbdhZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The function sequencer_pick_revisions() has only two callers,
cmd_revert() and cmd_cherry_pick(), both of which check the return
value and react appropriately upon errors.

So this is a safe conversion to make sequencer_pick_revisions()
callable from new callers that want it not to die, without changing
the external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3804fa9..76b1c52 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1063,10 +1063,11 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		if (!get_sha1(name, sha1)) {
 			if (!lookup_commit_reference_gently(sha1, 1)) {
 				enum object_type type = sha1_object_info(sha1, NULL);
-				die(_("%s: can't cherry-pick a %s"), name, typename(type));
+				return error(_("%s: can't cherry-pick a %s"),
+					name, typename(type));
 			}
 		} else
-			die(_("%s: bad revision"), name);
+			return error(_("%s: bad revision"), name);
 	}
 
 	/*
@@ -1082,10 +1083,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	    !opts->revs->cmdline.rev->flags) {
 		struct commit *cmit;
 		if (prepare_revision_walk(opts->revs))
-			die(_("revision walk setup failed"));
+			return error(_("revision walk setup failed"));
 		cmit = get_revision(opts->revs);
 		if (!cmit || get_revision(opts->revs))
-			die("BUG: expected exactly one commit from walk");
+			return error("BUG: expected exactly one commit from walk");
 		return single_pick(cmit, opts);
 	}
 
-- 
2.10.0.windows.1.10.g803177d


