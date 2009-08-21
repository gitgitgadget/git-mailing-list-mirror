From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 13:39:27 -0700
Message-ID: <7vws4wdhq8.fsf@alter.siamese.dyndns.org>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:39:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meatp-0000Aw-2C
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbZHUUjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbZHUUjj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:39:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbZHUUji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:39:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A77613674;
	Fri, 21 Aug 2009 16:39:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUi10UIGXxzxs2LSUr/LDrN7F38=; b=nTO15D
	Cbvp5tJWwszSC9mQxmZfxzMQKBeCf7NfdsRoxfQW7uVC+bEf6aqXkh0kV9rozq8R
	bYNsbk2bUSmYGxTw47LBdiBwGqen887X9uyjFdk6htaEMpIHlrE/6iLS6/UOFAN4
	hZBDoZ5DRwYWvPK8ybrk+44fjl77wjHJAnVHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p8LVx9HMb9Q9cqRRxfC8C7S2uSd+RDs5
	U/izmwn/4JR0Eq2IHFmHiJduNdqU7oYKCAH80Te6XSlocsVUqlcOBtYLuR9JKAPG
	IL92iaRhv4EKQoXh8+0B7Pw3vJBN9x7hH6snNmfagzmYi+aICai6IDMrC8Wy64dX
	yhuodyU3dp4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D223513673;
	Fri, 21 Aug 2009 16:39:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6AE41366D; Fri, 21 Aug
 2009 16:39:28 -0400 (EDT)
In-Reply-To: <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 (Marius Storm-Olsen's message of "Fri\, 21 Aug 2009 15\:30\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BC9AD388-8E92-11DE-81AC-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126751>

Marius Storm-Olsen <mstormo@gmail.com> writes:

> MSVC doesn't munge the non-constant expression, so use xmalloc instead.

Thanks.

These things are called variable length array, and MSVC is not the only
one that do not glok vla.

	Subject: Avoid use of variable length array

        Some compilers unfortunately do not understand these constructs.
	In codepaths that are not performance critical, use xmalloc()
        and free() instead.

There is another use of vla; I would suggest squashing the following patch
in.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c433748..5065abd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1599,7 +1599,7 @@ static void *threaded_find_deltas(void *arg)
 static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			   int window, int depth, unsigned *processed)
 {
-	struct thread_params p[delta_search_threads];
+	struct thread_params *p;
 	int i, ret, active_threads = 0;
 
 	if (delta_search_threads <= 1) {
@@ -1610,6 +1610,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		fprintf(stderr, "Delta compression using up to %d threads.\n",
 				delta_search_threads);
 
+	p = xcalloc(delta_search_threads, sizeof(*p));
+
 	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
 		unsigned sub_size = list_size / (delta_search_threads - i);
@@ -1717,6 +1719,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 			active_threads--;
 		}
 	}
+
+	free(p);
 }
 
 #else
