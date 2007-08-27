From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Mon, 27 Aug 2007 05:12:25 -0700
Message-ID: <7vy7fxyy52.fsf@gitster.siamese.dyndns.org>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Aug 27 14:12:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPdSU-0003lu-0Z
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 14:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbXH0MMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 08:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbXH0MMe
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 08:12:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbXH0MMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 08:12:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 95A7E127A6E;
	Mon, 27 Aug 2007 08:12:51 -0400 (EDT)
In-Reply-To: <7v3ay5l5wq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Aug 2007 01:48:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56822>

Junio C Hamano <gitster@pobox.com> writes:

> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>
>> Keeping the last used delta base object, if it would be dropped,
>> supports creating smaller packs with shorter delta chains.
>
> Instead of treating the "the last used one happened to be on the
> horizon -- try not to drop it" special case, I wonder if it
> makes sense to float the last used delta base object early in
> the window _after_ it is used.  Wouldn't we keep more than one
> very recently used delta base objects in the window that way?

The attached is my quick-and-dirty one.  

I had a bit more objects (59140) than you did in my repository.
The runtime from three versions were comparable.  It seems to
make the resulting chain even shorter, which can only be good.

(stock "master") 15782196 bytes
chain length = 1: 2972 objects
chain length = 2: 2651 objects
chain length = 3: 2369 objects
chain length = 4: 2121 objects
chain length = 5: 1877 objects
chain length = 6: 1715 objects
chain length = 7: 1469 objects
chain length = 8: 1296 objects
chain length = 9: 1185 objects
chain length = 10: 1111 objects
...
chain length = 46: 490 objects
chain length = 47: 515 objects
chain length = 48: 527 objects
chain length = 49: 570 objects
chain length = 50: 408 objects

(with your patch) 15745736 bytes (0.23% smaller)
chain length = 1: 3137 objects
chain length = 2: 2688 objects
chain length = 3: 2322 objects
chain length = 4: 2146 objects
chain length = 5: 1824 objects
chain length = 6: 1664 objects
chain length = 7: 1462 objects
chain length = 8: 1329 objects
chain length = 9: 1201 objects
chain length = 10: 1126 objects
...
chain length = 46: 503 objects
chain length = 47: 509 objects
chain length = 48: 536 objects
chain length = 49: 588 objects
chain length = 50: 357 objects

(with this patch) 15612086 bytes (1.08% smaller)
chain length = 1: 4831 objects
chain length = 2: 3811 objects
chain length = 3: 2964 objects
chain length = 4: 2352 objects
chain length = 5: 1944 objects
chain length = 6: 1667 objects
chain length = 7: 1465 objects
chain length = 8: 1267 objects
chain length = 9: 1210 objects
chain length = 10: 1050 objects
...
chain length = 46: 327 objects
chain length = 47: 353 objects
chain length = 48: 304 objects
chain length = 49: 298 objects
chain length = 50: 135 objects

---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9b3ef94..2a5ea29 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1439,6 +1439,61 @@ static void free_unpacked(struct unpacked *n)
 	n->depth = 0;
 }
 
+static void shift_base(int idx, int window, struct unpacked *array, struct object_entry *delta_base)
+{
+	/*
+	 * The delta_base was a useful one to deltify the object at
+	 * idx (circular).  Shift the contents of array (circular
+	 * buffer) so that it will be evicted last.
+	 */
+	int good_base, good_at;
+	struct unpacked swap;
+
+	for (good_base = 0; good_base < window; good_base++)
+		if (array[good_base].entry == delta_base)
+			break;
+	if (window <= good_base)
+		die("Junio is an idiot");
+
+	if (window <= ++idx)
+		idx = 0;
+	/*
+	 * The entry at idx modulo window will be evicted first during
+	 * the next round.  Where in the next window is the good_base
+	 * found?
+	 */
+	good_at = (good_base + window - idx) % window;
+
+	/*
+	 * If it is already at the furthest edge, nothing needs to be done.
+	 */
+	if (good_at == window - 1)
+		return;
+
+	/*
+	 * Otherwise, stash it away, shift the others down and swap it in.
+	 */
+	swap = array[good_base];
+
+	while (good_at < window) {
+		int dst, src;
+
+		dst = good_at + idx;
+		if (window <= dst)
+			dst -= window;
+		src = dst + 1;
+		if (window <= src)
+			src -= window;
+		array[dst] = array[src];
+		good_at++;
+	}
+
+	good_at = idx + window - 1;
+	if (window <= good_at)
+		good_at -= window;
+	array[good_at] = swap;
+}
+
 static void find_deltas(struct object_entry **list, int window, int depth)
 {
 	uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
@@ -1519,6 +1574,13 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (entry->delta && depth <= n->depth)
 			continue;
 
+		/*
+		 * The delta base was a useful one.  Move it up in the
+		 * window to keep it longer.
+		 */
+		if (entry->delta)
+			shift_base(idx, window, array, entry->delta);
+
 		next:
 		idx++;
 		if (count + 1 < window)
