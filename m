From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff A...B: do not limit the syntax too narrowly
Date: Fri, 16 Jul 2010 12:14:53 -0700
Message-ID: <7vsk3js0gi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 21:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZqNH-0005e2-OP
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 21:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758991Ab0GPTPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 15:15:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758977Ab0GPTO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 15:14:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A986C5B7E;
	Fri, 16 Jul 2010 15:14:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=TYkT
	0BbLqaAqiZcgdfq9GIrARuc=; b=aLH18GVUwEulwxNO9wdUP4abtIn6knVJhJFx
	9bl4ttbpow+ATcfq4FcVMS2606Ztn9m1Zn6L8g7hR9VvclsRx3uzRaqY+Y2T2xZQ
	rfbPBoPEFwANOFYQ/ppTBnkjqO4HlkSyndNqTjW800rrvB2s+KbJOXJBk5zVNNI6
	Cy3OmVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=O7A
	8aTq+Sz+27Bnz4wamvpEqcZh6el6fc/c7GEqQ3qxFN8V8hTq2y+UEWEoAgTUFLz7
	V7irQXhvorv68aDJxKh9t4a/lOcVoZbRP/Mky4B+Ay0jtS+qafyX5wT8UM5eVay/
	2DaCkbE4k/ak4/biW1/sPdkJ/o9UrVa1dT+x34sQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16124C5B7C;
	Fri, 16 Jul 2010 15:14:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52BE8C5B79; Fri, 16 Jul
 2010 15:14:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6BEC660C-910E-11DF-A182-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151164>

Earlier we tried to make sure that the trees we get are what A...B
syntax produced, by checking that earlier ones are all marked
uninteresting (which has to be true as they are merge bases),
there are two remaining ones that are interesting, and they are
marked as non-symmetric-left and symmetric-left respectively.

The "the last two must be interesting" condition is however wrong when one
is an ancestor of the other between A and B (i.e. fast-forward).  In such
a case, one of them is marked uninteresting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This breakage should have been obvious (e.g. "git diff master...next"
   should exhibit it).  Sorry about it.

   Also "the second from the last one should not be SYMMETRIC_LEFT"
   condition does not hold if somebody does "git diff HEAD...HEAD", but
   that is a bit of borderline insanity.

   We *could* tighten the rule to say "the last two must be interesting or
   listed as one of the merge bases" to tighten the rule again, but I
   don't think it is worth it.

 builtin-diff.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 62b483b..192cbb2 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -407,19 +407,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		result = builtin_diff_tree(&rev, argc, argv, ent);
 	else if (ent[0].item->flags & UNINTERESTING) {
 		/*
-		 * Perhaps the user gave us A...B, which expands
-		 * to a list of negative merge bases followed by
-		 * A (symmetric-left) and B?  Let's make sure...
-		 */
-		for (i = 1; i < ents; i++)
-			if (!(ent[i].item->flags & UNINTERESTING))
-				break;
-		if (ents != i + 2 ||
-		    (ent[i+1].item->flags & UNINTERESTING) ||
-		    (!(ent[i].item->flags & SYMMETRIC_LEFT)) ||
-		    (ent[i+1].item->flags & SYMMETRIC_LEFT))
-			die("what do you mean by that?");
-		/*
 		 * diff A...B where there is at least one merge base
 		 * between A and B.  We have ent[0] == merge-base,
 		 * ent[ents-2] == A, and ent[ents-1] == B.  Show diff
-- 
1.7.2.rc3.255.g7a7d8
