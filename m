Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE682208DE
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdH3Ru4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:56 -0400
Received: from mout.web.de ([212.227.17.11]:54599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdH3RuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:07 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJro-1e6ppm0F8S-00Jvo1 for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:06 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 03/34] am: release strbuf after use in safe_to_abort()
Date:   Wed, 30 Aug 2017 19:49:34 +0200
Message-Id: <20170830175005.20756-4-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:mm8we0WbVjGmi6URtCRVX8L4+m2FGF3gYp955lhIm4dGWCDVyAM
 YRJbOLh7X4mrZqvhtA6FMBAy3HbkQBiUjxafINlVymfXCMUCBauxOXqhPnUhyGo9ioBqxZi
 VO8+rY5g3ZFA5bmPab2VjRy1p05xFjcqbny9m0jnIhurLlcLvgQUcAKeywjRxjeDhmAyEFV
 uXfP6SboaNergJhxdOQLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rOJ7CNh+bik=:dv2KbceYUY4x1uDzcQ+YmX
 e27Frc8vegeuMG8iDAmocaHyqxlYXx2po/w3ukcIbazQzQLdUfxRN2PncemorRF87NyRWv2De
 1pcJCMv2AphBqtNy7sLbbE4a91ZPHRSO7T/BEcHWHEcpLKi+Lpc0uJ+b+F9JBpCE3wpJM1i/u
 tu2iK8PVyEwoVzxfMA0pR9LWFrHX8wXdAfAc+Vcigl82icZQYXzwsETeO5MrwbuVcM4mGDFmf
 H+H4OueLHMTllUyU4OGqqHCNsXodp+BaOxe1DspbayJp6a2ZJCnPryK9l4xGHu05E7PbZUK5M
 FCOBO+/izC9Vjh2CmsvCk8e/ovoTcXeySKIYG6Uvaz9bCva+b7KU4lY9eydGMBPOgPLj1I5xj
 RkkK44Ntbq/sqRGSSlu2Sy7oVDZYPbLZcRKLDEP+bTHfb+DrPBsAAcDLV1dmvqo09nWjk0Xgf
 /j3NOrBRBFZBIrMql5wxkWr9mYsh3GxfsWIOsw7YDYKc5XZwxB99EL/ySXRXupdNAK84vCv4r
 QbG6aCyivDytEgScPyxrOarzYEHMLqqcgok6k6LXPiGuEUHCdaHEydr9lpZ9GrNXJt/GOZnQX
 KkBj92A0FziBopiUYAUvYR65MCvp5TUEEPaV+VC39DA6GVdSOsiB0OODAlQPRXPe33d5HVmPi
 O+fm/qQdrjGh8qp4+lsXKnHTDg1oVMR3uhmsr6QxCaz2uuUx+TgnP2gbfYK0BE+uLLJC0JKDL
 EoujpUdqx9DUSE0j7uSvWi9WupdK4UgonVhaBcrs32bq4jeqCW+t994F/RRVvmLw5uKmiRuHb
 ix1r7uel0NeBa0lJFPlHoJWiuorTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/am.c b/builtin/am.c
index 3d38b3fe9f..d7513f5375 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2095,29 +2095,30 @@ static void am_skip(struct am_state *state)
 static int safe_to_abort(const struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct object_id abort_safety, head;
 
 	if (file_exists(am_path(state, "dirtyindex")))
 		return 0;
 
 	if (read_state_file(&sb, state, "abort-safety", 1) > 0) {
 		if (get_oid_hex(sb.buf, &abort_safety))
 			die(_("could not parse %s"), am_path(state, "abort-safety"));
 	} else
 		oidclr(&abort_safety);
+	strbuf_release(&sb);
 
 	if (get_oid("HEAD", &head))
 		oidclr(&head);
 
 	if (!oidcmp(&head, &abort_safety))
 		return 1;
 
 	warning(_("You seem to have moved HEAD since the last 'am' failure.\n"
 		"Not rewinding to ORIG_HEAD"));
 
 	return 0;
 }
 
 /**
  * Aborts the current am session if it is safe to do so.
  */
-- 
2.14.1

