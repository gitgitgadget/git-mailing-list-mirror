Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2538C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjBBJmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjBBJmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:42:33 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD2686EB2
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:42:18 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 072771F5A0;
        Thu,  2 Feb 2023 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1675330938;
        bh=JNeUVWtt14qzj0+CFdaHadF8X2nXOguVJUt30Gj7HA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJ7ULZGSH8c6J/88WjOzYV0NiKChTkNAFWROTirOVxQpBtwRu5mEfoqbc6mjv4Czn
         sVESh/c0jE2j6+u2fMX0LdREw1QoM76gZgLyNNIHkqglj54dhW0SxewL1+LTzTtTQH
         bp47Fqim33TOzI+DYL1OhatCBQ6VsxHhbLprdmXo=
Date:   Thu, 2 Feb 2023 09:42:17 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] delta-islands: free island_marks and bitmaps
Message-ID: <20230202094217.M955476@dcvr>
References: <20230202010353.23391-1-e@80x24.org>
 <230202.86mt5wq1i7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230202.86mt5wq1i7.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Feb 02 2023, Eric Wong wrote:
> 
> > +	kh_foreach_value(island_marks, bitmap, {
> > +		if (--bitmap->refcount == 0)
> 
> Style nit: if (!--x) rather than if (--x == 0) ?

Oops, fixed in v2

> > +			free(bitmap);
> > +	});
> > +	kh_destroy_oid_map(island_marks);
> > +	island_marks = (void *)1; /* crash on unintended future use */
> 
> This seems counter-productive. If you just leave it free'd then various
> analysis tools will spot a use-after-free earlier, won't they?

*shrug*  I thought it might be better to use an explicitly bad
pointer to catch lifetime issues that I might've missed from
reading the code.  Since I've run and tested at this point,
it probably doesn't matter, now.  So I'll just omit the
assignment and save some icache footprint.

Thanks for the review!

--------8<-------
Subject: [PATCH] delta-islands: free island_marks and bitmaps

On my mirror of linux.git forkgroup with 780 islands, this saves
nearly 4G of heap memory in pack-objects.  This savings only
benefits delta island users of pack bitmaps, as the process
would otherwise be exiting anyways.

However, there's probably not many delta island users, but the
majority of delta island users would also be pack bitmaps users.

Signed-off-by: Eric Wong <e@80x24.org>
---
 delta-islands.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/delta-islands.c b/delta-islands.c
index 90c0d6958f..c09dab31a4 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -513,12 +513,28 @@ void propagate_island_marks(struct commit *commit)
 	}
 }
 
+static void free_island_marks(void)
+{
+	struct island_bitmap *bitmap;
+
+	kh_foreach_value(island_marks, bitmap, {
+		if (!--bitmap->refcount)
+			free(bitmap);
+	});
+	kh_destroy_oid_map(island_marks);
+}
+
 int compute_pack_layers(struct packing_data *to_pack)
 {
 	uint32_t i;
 
-	if (!core_island_name || !island_marks)
+	if (!island_marks)
+		return 1;
+
+	if (!core_island_name) {
+		free_island_marks();
 		return 1;
+	}
 
 	for (i = 0; i < to_pack->nr_objects; ++i) {
 		struct object_entry *entry = &to_pack->objects[i];
@@ -533,6 +549,7 @@ int compute_pack_layers(struct packing_data *to_pack)
 				oe_set_layer(to_pack, entry, 0);
 		}
 	}
+	free_island_marks();
 
 	return 2;
 }
