From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Sun, 16 Mar 2014 23:33:53 -0700
Message-ID: <7vtxax2v1q.fsf@alter.siamese.dyndns.org>
References: <20140308183501.GH18371@serenity.lan>
	<1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
	<8738ijzbue.fsf@thomasrast.ch>
	<20140316020018.GA20019@sigill.intra.peff.net>
	<7v1ty14z8x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Guillaume Gelin <contact@ramnes.eu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 17 07:32:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPR6Q-0004ir-OQ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 07:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbaCQGcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 02:32:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61894 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaCQGcq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 02:32:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D1A26B51A;
	Mon, 17 Mar 2014 02:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ST6LPbGGn9CGfUHzojjIKWiRJ2I=; b=hSTzq0
	T2GJsJh2lOUzXl9DDhHkwsFoxipn0WjscqRDV2nMD1xO94Ed8ewYsSeeh20o+U5d
	f/gpEBcqzjPNWLnJ8RqV7V7gA8RvQIBrd6T8VRjwRFvzN0aHUS4tgO+Jojqq4tyZ
	Y5lzVF8NW4YftH4VVBloEpJXbP30YlXUoYTo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=foJWYWonuWtiEybEgFqtaOuvJLQrE4gA
	kYB6jNDZ2y1Z+c9rofThxX+v8YhyB7/1WhzWzBJnZ+2B7kY6I5rqKBC3fyOyM7aM
	voqPOPqnHNbHZ9cLpSRtZGvyvgGDNr//KkvoKnys8Dg15jrDqEgWrhhy4nYdssAe
	DE6zUIYge9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A116B519;
	Mon, 17 Mar 2014 02:32:45 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 651306B515;
	Mon, 17 Mar 2014 02:32:44 -0400 (EDT)
In-Reply-To: <7v1ty14z8x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 16 Mar 2014 14:20:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: F2AE5092-AD9D-11E3-ABD0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244221>

Junio C Hamano <gitster@pobox.com> writes:

> Would it make sense to go one step further to introduce two macros
> to make this kind of screw-up less likely?
> ...
> After letting my eyes coast over hits from "git grep memmove", there
> do seem to be some places that these would help readability, but not
> very many.

I see quite a many hits that follow this pattern

	memmove(array + pos, array + pos + 1, sizeof(*array) * (nr - pos))

to make a single slot in a middle of array available, which would be
good candidates to use MOVE_DOWN().  Just to show a few:

builtin/mv.c:226:	memmove(source + i, source + i + 1,
builtin/mv.c-227-		(argc - i) * sizeof(char *));
builtin/mv.c:228:	memmove(destination + i,
builtin/mv.c-229-		destination + i + 1,
builtin/mv.c-230-		(argc - i) * sizeof(char *));
cache-tree.c:92:	memmove(it->down + pos + 1,
cache-tree.c-93-		it->down + pos,
cache-tree.c-94-		sizeof(down) * (it->subtree_nr - pos - 1));


Perhaps something like this patch to start off; I am not sure
MOVE_DOWN_BOUNDED is needed, though.

 cache.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/cache.h b/cache.h
index b66cb49..b2615ab 100644
--- a/cache.h
+++ b/cache.h
@@ -455,6 +455,39 @@ extern int daemonize(void);
 		} \
 	} while (0)
 
+/*
+ * With an array "array" that currently holds "nr" elements, move
+ * elements at "at" and later down by "count" elements to make room to
+ * add in new elements.  The caller is responsible for making sure
+ * that the array has enough room to hold "nr" + "count" slots.
+ */
+#define MOVE_DOWN(array, nr, at, count)			\
+	memmove((array) + (at) + (count),		\
+		(array) + (at),				\
+		sizeof((array)[0]) * ((nr) - (at)))
+
+/*
+ * With an array "array" that has enough memory to hold "alloc"
+ * elements allocated and currently holds "nr" elements, move elements
+ * at "at" and later down by "count" elements to make room to add in
+ * new elements.
+ */
+#define MOVE_DOWN_BOUNDED(array, nr, at, count, alloc)		     \
+	do {							     \
+		if ((alloc) <= (nr) + (count))			     \
+			BUG("MOVE_DOWN beyond the end of an array"); \
+		MOVE_DOWN((array), (nr), (at), (count));	     \
+	} while (0)
+
+/*
+ * With an array "array" that curently holds "nr" elements, move elements
+ * at "at" + "count" and later down by "count" elements, removing the
+ * elements between "at" and "at" + "count".
+ */
+#define MOVE_UP(array, nr, at, count)				\
+	memmove((array) + (at), (array) + (at) + (count),	\
+		sizeof((array)[0]) * ((nr) - ((at) + (count))))
+
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const struct pathspec *pathspec);
