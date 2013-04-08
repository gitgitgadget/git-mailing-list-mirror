From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] decorate: add "clear_decoration()"
Date: Sun, 07 Apr 2013 23:14:17 -0700
Message-ID: <7v1ual35xi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5tC-0000sy-5t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934873Ab3DHGOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 02:14:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934870Ab3DHGOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 02:14:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C7CF10697;
	Mon,  8 Apr 2013 06:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	k2uwOB9OYwLDkqZu1Q6RXImvns=; b=iLB0Q4eU6b9Vw3luCUCb23rCsCRCBDJxi
	NC7CVsymk5XDgYpA//o8kMhinnZk8oEXHpQ9mtL3JBVSDkOScV7fH+lTEl8StiWR
	F7ZTL8i830CkUllg0D9kNFSDDIkpXJV0Tidc67zrS09lpb3wn3Ds4SB5bNGfAXh3
	i5btWwSIKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rkX
	SL6RyqkinI1ujtCKmkJV6UCW+l2rJft2O3L8pk+q1O0hAmbYmPuFXA0J1sKuGqTs
	OSlYDQawlMJ2oGBZJ7TPPeEHBO7yQBGY8dWfMsZEp79vT5I1+yit81X3M0jKDHCS
	nXJL0HQZ1zXdQRBTcyqEMvdyA31lzdxqIXDijQEg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EC410696;
	Mon,  8 Apr 2013 06:14:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3E7110694; Mon,  8 Apr
 2013 06:14:18 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BFF3552-A013-11E2-B6D2-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220404>

So far, all the users of the decoration API used decoration that
only grows and discarded at the end of the program execution.

Introduce for_each_decoration() that lets the caller iterate over
all defined decorations and use it to implement clear_decoration()
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-decorate.txt | 22 ++++++++++++++++++++++
 decorate.c                               | 19 +++++++++++++++++++
 decorate.h                               |  4 ++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/technical/api-decorate.txt b/Documentation/technical/api-decorate.txt
index 0cc2b64..600366d 100644
--- a/Documentation/technical/api-decorate.txt
+++ b/Documentation/technical/api-decorate.txt
@@ -35,3 +35,25 @@ the `obj`.  You cannot tell if `obj` does not appear in the hashtable
 at all, or if `obj` has decoration whose value is NULL, so if you want
 to use the decoration API for "Did I see this object?" hashtable,
 use decoration value that is _not_ NULL.
+
+Iterating
+---------
+
+`for_each_decoration(struct decoration *deco, for_each_decoration_fn fn)`
+iterates over all the entries in the hashtable, and calls `fn` on each
+entry.  The `fn` callback function takes a single `struct object_decoration`
+as its parameter, that has `base` field that points at the `obj`
+given to an earlier call to `add_decoration` and `decoration` field
+that remembers the `decoration`.
+
+Clearing
+--------
+
+`clear_decoration(struct decoration *deco, for_each_decoration_fn fn)`,
+when `fn` is not NULL, iterates over all the entries and calls the
+callback function `fn` using `for_each_decoration`, and then frees
+the memory used for the hashtable but not the `struct decoration` itself.
+
+The callback function can be used to release the resource used by
+the `decoration` the earlier `add_decoration` registered to the
+hashtable.
diff --git a/decorate.c b/decorate.c
index 2f8a63e..3e15358 100644
--- a/decorate.c
+++ b/decorate.c
@@ -86,3 +86,22 @@ void *lookup_decoration(struct decoration *n, const struct object *obj)
 			j = 0;
 	}
 }
+
+void for_each_decoration(struct decoration *n, for_each_decoration_fn fn)
+{
+	int i;
+
+	for (i = 0; i < n->size; i++) {
+		struct object_decoration *entry = &n->hash[i];
+		if (!entry->base)
+			continue;
+		fn(entry);
+	}
+}
+
+void clear_decoration(struct decoration *n, for_each_decoration_fn fn)
+{
+	if (fn)
+		for_each_decoration(n, fn);
+	free(n->hash);
+}
diff --git a/decorate.h b/decorate.h
index e732804..4a0d37e 100644
--- a/decorate.h
+++ b/decorate.h
@@ -15,4 +15,8 @@ struct decoration {
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
 extern void *lookup_decoration(struct decoration *n, const struct object *obj);
 
+typedef void (*for_each_decoration_fn)(struct object_decoration *);
+extern void for_each_decoration(struct decoration *, for_each_decoration_fn);
+extern void clear_decoration(struct decoration *, for_each_decoration_fn);
+
 #endif
-- 
1.8.2.1-450-gd047976
