From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 1/8] fixup! combine_diff: simplify intersect_paths() further
Date: Mon,  3 Feb 2014 16:47:15 +0400
Message-ID: <60ec61bdd2ef3cba7537e29c42f9c8a810da245d.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 13:46:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAIuY-0006tq-L4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 13:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbaBCMpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 07:45:51 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:37320 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbaBCMpu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 07:45:50 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WAIuK-0004ZY-DH; Mon, 03 Feb 2014 16:45:48 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WAIw7-0007Fg-W0; Mon, 03 Feb 2014 16:47:39 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391430523.git.kirr@mns.spb.ru>
References: <cover.1391430523.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241428>

That cleanup patch is good, but I've found a bug in it. In the item removal
code

> +                      /* p->path not in q->queue[]; drop it */
> +                      struct combine_diff_path *next = p->next;
> +
> +                      if ((*tail = next) != NULL)
> +                              tail = &next->next;
> +                      free(p);
>                        continue;

        *tail = next

is right, but

        tail = &next->next

is wrong, because it will lead to skipping the element after removed
one. Proof:

    tail        p
      |         |
      |         |
      v         v
     +-+       +------+-+       +------+-+       +------+-+
     | |       |      | |       |      | |       |      | |
     |o------->|      |o------->|      |o------->|      |o------->
     |0|       |     1| |       |     2| |       |     3| |
     +-+       +------+-+       +------+-+       +------+-+

suppose, we are removing element 1. p->next points to 2, after

    *tail = next

0 points to 2, which != NULL. After

    tail = &next->next

tail points to &2->next.

On the next cycle iteration, after

    p = *tail

we'll have

    p = *2->next = 3

so 2 was skipped, oops.

I've actually hit the bug - when generating combine-diff, for merges with
should-be empty `log -c` output, every second path was present in the diff.
That, by the way, means we need to extend combine-diff tests somewhat.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 0809e79..a03147c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -58,8 +58,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			/* p->path not in q->queue[]; drop it */
 			struct combine_diff_path *next = p->next;
 
-			if ((*tail = next) != NULL)
-				tail = &next->next;
+			*tail = next;
 			free(p);
 			continue;
 		}
-- 
1.9.rc1.181.g641f458
