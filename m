Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154E1C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiLNQYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiLNQYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:24:05 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12C21A9
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:24:04 -0800 (PST)
Received: (qmail 26040 invoked by uid 109); 14 Dec 2022 16:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 16:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19999 invoked by uid 111); 14 Dec 2022 16:24:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 11:24:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 11:24:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] ref-filter: convert email atom parser to use
 err_bad_arg()
Message-ID: <Y5n4o3s0DW8ilXDA@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message for a bogus argument to %(authoremail), etc, is:

   $ git for-each-ref --format='%(authoremail:foo)'
   fatal: unrecognized email option: foo

Saying just "email" is a little vague; most of the other atom parsers
would use the full name "%(authoremail)", but we can't do that here
because the same function also handles %(taggeremail), etc. Until
recently, passing atom->name was a bad idea, because it erroneously
included the arguments in the atom name. But since the previous commit
taught err_bad_arg() to handle this, we can now do so and get:

  fatal: unrecognized %(authoremail) argument: foo

which is consistent with other atoms.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index f40bc4d9c9..733b0149e8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -489,7 +489,7 @@ static int person_email_atom_parser(struct ref_format *format, struct used_atom
 	else if (!strcmp(arg, "localpart"))
 		atom->u.email_option.option = EO_LOCALPART;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized email option: %s"), arg);
+		return err_bad_arg(err, atom->name, arg);
 	return 0;
 }
 
-- 
2.39.0.550.g5015380a67
