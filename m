From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] diff: pass the whole diff_options to diffcore_apply_filter()
Date: Wed, 17 Jul 2013 17:30:01 -0700
Message-ID: <1374107406-14357-2-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc6v-0006Up-PI
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933607Ab3GRAaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756575Ab3GRAaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA76D20AA1;
	Thu, 18 Jul 2013 00:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ysG7
	JbsfpfXzU51qbv1jl/w/f9Y=; b=vwxIiOBcLQUAqvrIC5NDjwHFZ5S45F5sC7mp
	OjoGTrRZv5sbkVKnkgcRnz6ymwx6eBUNamqoExSDw9nzltsRjLd7r7NvgW2wR3Uk
	UFYA8z802M/z5+dZ61toZ31mWUGU7+Jh+X8ztDaAv5b1kyV5Galvbj4qfAbBZ9Xg
	d0SJ5ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	n7unh3dEkwQqwjKrnm6PPjEh3oP9lBU1bm+g8PTzJNNJ5tU8JRYZH4S45MHEFAGy
	jFA12Aeqxy6qpo/ZspsOb/DAKqti3g7TdAci0vI1zrrtWRwU/mTpA09CrD4eRG5a
	imV4ksgcfGlJBZt4OLDzVLF4zuPMSyfSZXB3It2nQls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D050720AA0;
	Thu, 18 Jul 2013 00:30:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C35A20A97;
	Thu, 18 Jul 2013 00:30:11 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <1374107406-14357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 34C6BE04-EF41-11E2-96A4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230665>

The --diff-filter=<arg> option given by the user is kept as a
string, and passed to the underlying diffcore_apply_filter()
function as a string for each resulting path we run number of
strchr() to see if each class of change among ACDMRTXUB is meant to
be given.

Change the function signature to pass the whole diff_options, so
that we can pre-parse this string in the next patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 649ec86..41c64f2 100644
--- a/diff.c
+++ b/diff.c
@@ -4509,11 +4509,13 @@ free_queue:
 	}
 }
 
-static void diffcore_apply_filter(const char *filter)
+static void diffcore_apply_filter(struct diff_options *options)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
+	const char *filter = options->filter;
+
 	DIFF_QUEUE_CLEAR(&outq);
 
 	if (!filter)
@@ -4661,7 +4663,7 @@ void diffcore_std(struct diff_options *options)
 	if (!options->found_follow)
 		/* See try_to_follow_renames() in tree-diff.c */
 		diff_resolve_rename_copy();
-	diffcore_apply_filter(options->filter);
+	diffcore_apply_filter(options);
 
 	if (diff_queued_diff.nr && !DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
 		DIFF_OPT_SET(options, HAS_CHANGES);
-- 
1.8.3.3-962-gf04df43
