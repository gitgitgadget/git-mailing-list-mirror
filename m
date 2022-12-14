Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63691C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiLNQTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiLNQTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:19:07 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C7286C8
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:18:50 -0800 (PST)
Received: (qmail 25899 invoked by uid 109); 14 Dec 2022 16:18:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 16:18:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19946 invoked by uid 111); 14 Dec 2022 16:18:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 11:18:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 11:18:49 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] ref-filter: reject arguments to %(HEAD)
Message-ID: <Y5n3aePWhM0/MlJm@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The %(HEAD) atom doesn't take any arguments, but unlike other atoms in
the same boat (objecttype, deltabase, etc), it does not detect this
situation and complain. Let's make it consistent with the others.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index caf10ab23e..08ac5f886e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -571,8 +571,10 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 }
 
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
-			    const char *arg, struct strbuf *unused_err)
+			    const char *arg, struct strbuf *err)
 {
+	if (arg)
+		return strbuf_addf_ret(err, -1, _("%%(HEAD) does not take arguments"));
 	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 	return 0;
 }
-- 
2.39.0.550.g5015380a67

