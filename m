From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 17:25:17 -0700
Message-ID: <7viq4k6xea.fsf@alter.siamese.dyndns.org>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
 <7vaapw8ehn.fsf@alter.siamese.dyndns.org>
 <7vocec6xlt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Pickens\, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTJS-0005hS-H7
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab0GMAZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 20:25:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0GMAZY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 20:25:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FEC8C4A14;
	Mon, 12 Jul 2010 20:25:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OQuF7QKtz+xvcMVMe6N96rkyUzc=; b=cpxDOm
	1cMm+mT177QzIHpR7gqF8XiJ4nJ7Hz/SkKV5l5Vj3bNu6YzctE07JobA3QZKYxum
	RXHUYUUmKGOWHJ5i5IcEKJV1R9cJUVxZGIaePNuRPwPbzOnHt1gnh7atJT0SR2I2
	5OwO6IrQYNBw9vx+ZW7J5HCD10j3+gNsYK5Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RBlnQouhndZH241RmqBAhF0X/Nkq/su+
	ViM1TIo1g7JUCH43WPPBklb1LE95+T2qsG7zENElreOkouoDj15EsQyvw76OOnGX
	OWKphbHgddSyVP/Z4dR5DwloDCvcibiNkG2PrsIxeOWqjvJxk8wMOQMpWV2rmBMw
	dptoFHM3qjk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A990C4A11;
	Mon, 12 Jul 2010 20:25:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2009DC4A10; Mon, 12 Jul
 2010 20:25:18 -0400 (EDT)
Importance: high
In-Reply-To: <7vocec6xlt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 12 Jul 2010 17\:20\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FA5A2DC-8E15-11DF-8DB7-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150857>

Junio C Hamano <gitster@pobox.com> writes:

> I prepared a patch to reject such a request when there are more than one
> merge base (see below---it is against 1.6.4 maintenance track).  While I
> think giving _one_ possible explanation of what you did since you forked
> would be better than rejecting, which I'll try in a separate message, but
> at the same time it may be misleading to give such an output without
> telling the user that we chose one merge base at random to diff against
> it.

And this is the other one (not relative to the previous patch) that shows
diff since one randomly chosen merge base.

 builtin-diff.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 2e51f40..1f44f5b 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -405,12 +405,28 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		result = builtin_diff_index(&rev, argc, argv);
 	else if (ents == 2)
 		result = builtin_diff_tree(&rev, argc, argv, ent);
-	else if ((ents == 3) && (ent[0].item->flags & UNINTERESTING)) {
-		/* diff A...B where there is one sane merge base between
-		 * A and B.  We have ent[0] == merge-base, ent[1] == A,
-		 * and ent[2] == B.  Show diff between the base and B.
+	else if (ent[0].item->flags & UNINTERESTING) {
+		/*
+		 * Perhaps the user gave us A...B, which expands
+		 * to a list of negative merge bases followed by
+		 * A (symmetric-left) and B?  Let's make sure...
 		 */
-		ent[1] = ent[2];
+		for (i = 1; i < ents; i++)
+			if (!(ent[i].item->flags & UNINTERESTING))
+				break;
+		if (ents != i + 2 ||
+		    (ent[i+1].item->flags & UNINTERESTING) ||
+		    (!ent[i].item->flags & SYMMETRIC_LEFT) ||
+		    (ent[i+1].item->flags & SYMMETRIC_LEFT))
+			die("what do you mean by that?");
+		/*
+		 * diff A...B where there is at least one merge base
+		 * between A and B.  We have ent[0] == merge-base,
+		 * ent[ents-2] == A, and ent[ents-1] == B.  Show diff
+		 * between the base and B.  Note that we pick one
+		 * merge base at random if there are more than one.
+		 */
+		ent[1] = ent[ents-1];
 		result = builtin_diff_tree(&rev, argc, argv, ent);
 	}
 	else
