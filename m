Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B261F461
	for <e@80x24.org>; Thu, 29 Aug 2019 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfH2LW4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 07:22:56 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:43220 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfH2LW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 07:22:56 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1i3IVt-0008P7-CS; Thu, 29 Aug 2019 20:22:49 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] replace: stop replace lookup when reaching a self-reference
Date:   Thu, 29 Aug 2019 20:22:49 +0900
Message-Id: <20190829112249.32262-1-mh@glandium.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to end up in situations where a replace ref points to
itself. In that case, it would seem better to stop the lookup rather
than try to follow the link infinitely and fail with "replace depth too
high".

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 replace-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I'm not entirely sure whether it's actually worth fixing. Arguably, `git
replace` should also avoid the footgun in the first place (although in
my case, it wasn't due to `git replace` itself).

diff --git a/replace-object.c b/replace-object.c
index e295e87943..97e479fe2b 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -66,7 +66,7 @@ const struct object_id *do_lookup_replace_object(struct repository *r,
 	while (depth-- > 0) {
 		struct replace_object *repl_obj =
 			oidmap_get(r->objects->replace_map, cur);
-		if (!repl_obj)
+		if (!repl_obj || oideq(cur, &repl_obj->replacement))
 			return cur;
 		cur = &repl_obj->replacement;
 	}
-- 
2.23.0

