Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998B81FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbcHZODt (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 10:03:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:55807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbcHZODs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 10:03:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MMjgF-1bloyu3F43-008X9D; Fri, 26 Aug 2016 15:47:11
 +0200
Date:   Fri, 26 Aug 2016 15:47:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/14] sequencer: lib'ify sequencer_pick_revisions()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <1c74a1ef148a6aa32dc7089b20d6fa2500a0ce39.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vf5ZI6DRmpqKn2kELqb5O+vit83M+Nef+QywZgpma4G+f6bRTjn
 2HJ5NwvSzr76hcZunmF+Wdqphull7jnMCDHgLdHGSwNfpaNfH2dfAnVHQAb43z2hUawxxys
 VKR17T2JJjnlJt1kLq6NabEn4LTco/NeDUX5IgCOUDUAzoLHLqWdCreDIZlXgi0HHb1rlGS
 kF3wDhE2ILlTYkcck/s9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S4N8DMOpX18=:uytYM5DJ4+XBNEbO+u1dJB
 Cq5dJ2G5UxLXtqJ6jIUrs1mrGr8SaEXFhEoYHV1NGM2//vZGWqQKGiDzqXcYicvOw4QZtRqG6
 WoqfMwaz+Syec/pmc9a5Z4y8Qc32inXVEsgQXATdLbUcUCwRPM4bDLkPqmNu6OoFQa4q7BXxt
 3CKu79DdufZtp8J+DwD6WHZgmmuLaN//x1lm50fA+06f2Fgg/jqd+8hGfoKbpE7WwmYbYs8gi
 fn42ryEtfoOO3ZgxZ/Sb9Yb6UnaqxtDRvc5+br2q1mTvb2juA2cQjc+5PIOcXi4gdXoOX1Iui
 XZAjRXKl4nWxWCBn3WwTiuaStkUs1G2DcbU5qAyTmYlP3exCCfJhFYg7ADzoeWPJHfHJATwxR
 uQC/D6oL6Vz1hZuKkhzReb0+YaWvbxYW8QL2XanGk+S2JIdwGJvxTogv+2o6ewQlNuJhiKD4+
 Mk0fY/XI7FG2eMpW6it8Q+BVpC6oc9gVFlpCJYDqhqWvQR+WX7aYg+ME89D8KcUdv2lOkbm3j
 Jf4++0Iuiq5anNpjceJNW0TCrrTnRlsoYMuq6J5unUTFtlFEmPidyFJNNT2gHzXHjvjsjBL+u
 m4kvv7LcS1xR54I6pwGKdmK5lyr16zGaz2XrL4xZIFeG40It8QCARZYxZPur/4vdXNsWsWTaH
 7Gg2tKh+FGj4UHgSesNG4IxS8yn1qM49BMAT2NRuSCr/jvCvu+UmSNO4fAHdt4EuKkt20JiVY
 AHaFY5UJCJYdvFZu3awhv+5pmjtFw/DzDgsy1GWdPuU+PO1/9/8x57a5PoYO77FhPf8aMfAWq
 h9Z5Fbb
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
2.10.0.rc1.99.gcd66998


