Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474A11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbeGBVlP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:41:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:56938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753604AbeGBVlF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:41:05 -0400
Received: (qmail 9059 invoked by uid 109); 2 Jul 2018 21:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 21:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27643 invoked by uid 111); 2 Jul 2018 21:41:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 17:41:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 17:41:03 -0400
Date:   Mon, 2 Jul 2018 17:41:03 -0400
From:   Jeff King <peff@peff.net>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Feature request : "git fsck" should show the percentage of
 completeness in step "Checking connectivity:"
Message-ID: <20180702214103.GA26121@sigill.intra.peff.net>
References: <3d6b38a8-7dbe-0633-5c54-603161ee3fd4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d6b38a8-7dbe-0633-5c54-603161ee3fd4@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 01, 2018 at 06:21:40PM +0200, Toralf Förster wrote:

> as "git fsck" does it already for "Checking objects:"
> 
> Is this a valid feature request?

It's actually hard to do accurately. We don't know how many objects are
reachable until we traverse the graph...which is exactly what the
"checking connectivity" operation is doing.

The operation is bounded by the total number of objects in the
repository. We may have duplicates (in multiple packs, or loose/packed),
and objects which aren't reachable at all. But we could make that a
guess, and just "jump" to 100% at the end.

The code might look something like the patch below. I'm not sure if it's
a good idea or not (I mostly copied the counting from
builtin/count-objects.c; it might be nice to factor that out).

-Peff

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 3ad4f160f9..52e79aed76 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -192,17 +192,49 @@ static int traverse_one_object(struct object *obj)
 	return result;
 }
 
+static int count_loose(const struct object_id *oid, const char *path,
+		       void *data)
+{
+	unsigned int *nr = data;
+	nr++;
+	return 0;
+}
+
+static unsigned object_max(void)
+{
+	unsigned max = 0;
+	struct packed_git *p;
+
+	for_each_loose_object(count_loose, &max, 0);
+
+	for (p = get_packed_git(the_repository); p; p = p->next) {
+		if (open_pack_index(p))
+			continue;
+		max += p->num_objects;
+	}
+
+	return max;
+}
+
 static int traverse_reachable(void)
 {
 	struct progress *progress = NULL;
 	unsigned int nr = 0;
 	int result = 0;
-	if (show_progress)
-		progress = start_delayed_progress(_("Checking connectivity"), 0);
+	unsigned int max = 0;
+
+	if (show_progress) {
+		max = object_max();
+		progress = start_delayed_progress(_("Checking connectivity"),
+						  max);
+	}
+
 	while (pending.nr) {
 		result |= traverse_one_object(object_array_pop(&pending));
 		display_progress(progress, ++nr);
 	}
+
+	display_progress(progress, max);
 	stop_progress(&progress);
 	return !!result;
 }
