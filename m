Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A90A20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfDESOG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:14:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESOF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:14:05 -0400
Received: (qmail 11406 invoked by uid 109); 5 Apr 2019 18:14:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:14:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28421 invoked by uid 111); 5 Apr 2019 18:14:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:14:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:14:04 -0400
Date:   Fri, 5 Apr 2019 14:14:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 12/13] server-info: drop objdirlen pointer arithmetic
Message-ID: <20190405181403.GL32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing objects/info/packs, we use the basename of each pack
(i.e., just the "pack-1234abcd.pack" part). We compute that manually by
adding "objdirlen + 6" to the name.

This _should_ work consistently, as we do not include non-local packs,
meaning everything should be in $objdir/pack/. Before f13d7db4af
(server-info.c: use pack_local like everybody else., 2005-12-05), this
was definitely true, since we computed "local" based on comparing the
objdir string.  Since then, we're relying on the code on packfile.c to
match our expectations of p->pack_name and p->local.

I think our expectations do still hold today, but we can be a bit more
defensive by just using pack_basename() to get the base. That
future-proofs us, and should hopefully be more obviously safe to
somebody reading the code.

Signed-off-by: Jeff King <peff@peff.net>
---
 server-info.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/server-info.c b/server-info.c
index c9fbfd3a51..ab03c1b3c2 100644
--- a/server-info.c
+++ b/server-info.c
@@ -93,16 +93,13 @@ static struct pack_info {
 	int new_num;
 } **info;
 static int num_pack;
-static const char *objdir;
-static int objdirlen;
 
 static struct pack_info *find_pack_by_name(const char *name)
 {
 	int i;
 	for (i = 0; i < num_pack; i++) {
 		struct packed_git *p = info[i]->p;
-		/* skip "/pack/" after ".git/objects" */
-		if (!strcmp(p->pack_name + objdirlen + 6, name))
+		if (!strcmp(pack_basename(p), name))
 			return info[i];
 	}
 	return NULL;
@@ -196,9 +193,6 @@ static void init_pack_info(const char *infofile, int force)
 	int stale;
 	int i = 0;
 
-	objdir = get_object_directory();
-	objdirlen = strlen(objdir);
-
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
@@ -246,7 +240,7 @@ static int write_pack_info_file(FILE *fp)
 {
 	int i;
 	for (i = 0; i < num_pack; i++) {
-		if (fprintf(fp, "P %s\n", info[i]->p->pack_name + objdirlen + 6) < 0)
+		if (fprintf(fp, "P %s\n", pack_basename(info[i]->p)) < 0)
 			return -1;
 	}
 	if (fputc('\n', fp) == EOF)
-- 
2.21.0.729.g7d31bf3764

