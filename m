Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E0C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 12:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349544AbiETMuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 08:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349453AbiETMty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 08:49:54 -0400
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB8B5166D44
        for <git@vger.kernel.org>; Fri, 20 May 2022 05:49:53 -0700 (PDT)
Received: from fedora.redhat.com (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id E1DFA44CF1;
        Fri, 20 May 2022 14:49:52 +0200 (CEST)
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     git@vger.kernel.org
Cc:     Frantisek Hrbata <frantisek@hrbata.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/3] transport: unify return values and exit point from transport_push()
Date:   Fri, 20 May 2022 14:49:51 +0200
Message-Id: <20220520124952.2393299-3-frantisek@hrbata.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520124952.2393299-1-frantisek@hrbata.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <20220520124952.2393299-1-frantisek@hrbata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems there is no reason to return 1 instead of -1 when push_refs()
is not set in transport vtable. Let's unify the error return values and
use the done label as a single exit point from transport_push().

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Frantisek Hrbata <frantisek@hrbata.com>
---
 transport.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index 0b9c5a427d..dd7fca51bf 100644
--- a/transport.c
+++ b/transport.c
@@ -1276,29 +1276,30 @@ int transport_push(struct repository *r,
 		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
-	struct ref *remote_refs;
-	struct ref *local_refs;
+	struct ref *remote_refs = NULL;
+	struct ref *local_refs = NULL;
 	int match_flags = MATCH_REFS_NONE;
 	int verbose = (transport->verbose > 0);
 	int quiet = (transport->verbose < 0);
 	int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 	int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
-	int push_ret, ret, err;
+	int push_ret, err;
+	int ret = -1;
 	struct transport_ls_refs_options transport_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
 	*reject_reasons = 0;
 
 	if (transport_color_config() < 0)
-		return -1;
+		goto done;
 
 	if (!transport->vtable->push_refs)
-		return 1;
+		goto done;
 
 	local_refs = get_local_heads();
 
 	if (check_push_refs(local_refs, rs) < 0)
-		return -1;
+		goto done;
 
 	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
 
@@ -1319,7 +1320,7 @@ int transport_push(struct repository *r,
 		match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
 	if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
-		return -1;
+		goto done;
 
 	if (transport->smart_options &&
 	    transport->smart_options->cas &&
@@ -1333,7 +1334,7 @@ int transport_push(struct repository *r,
 
 	if (!(flags & TRANSPORT_PUSH_NO_HOOK))
 		if (run_pre_push_hook(transport, remote_refs))
-			return -1;
+			goto done;
 
 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
@@ -1417,6 +1418,7 @@ int transport_push(struct repository *r,
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
 		fprintf(stderr, "Everything up-to-date\n");
 
+done:
 	return ret;
 }
 
-- 
2.35.1

