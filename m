From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 17:20:46 -0700
Message-ID: <7vocec6xlt.fsf@alter.siamese.dyndns.org>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
 <7vaapw8ehn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Pickens\, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 02:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYTF9-0004OU-Mh
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 02:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887Ab0GMAU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 20:20:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab0GMAUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 20:20:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC6C4C497C;
	Mon, 12 Jul 2010 20:20:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BB3af/ZwrnFlRgRx3dmbQRMy2WA=; b=K7dHqO
	mtkgQBgWJGzFmXZ0Pt++d/G9jvBwsSswwg+ddQtUdzpN5GGnyPeg2eCRotE5FDMW
	T8exnTS8QPd4q6FoyBXTiUZGrj8mpIwdf6Fp1eXSySfBuZ6R+NJOcd92T/WLxnb9
	sJyvGWHs/vc/nHuY/8gNdIhp9YnQ4F8+cEtmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWoFNzJZPBrNXQ5x2G7nQgDxWV5yApRN
	8eTCkb9UNFZkxx2t0kaWeA5xWrrLwaKumgyu1AT3fPyUTl8mBTcF9foTgIQ6OVh7
	DPoKSOECGmeBzTzXPUMtqEwRPZiFVXtx4aFWIgfXUQrzqxBCZNkUVVbWa3R+B+lD
	0odNsG9xWF0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A4E7C497A;
	Mon, 12 Jul 2010 20:20:51 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5275C4974; Mon, 12 Jul
 2010 20:20:48 -0400 (EDT)
In-Reply-To: <7vaapw8ehn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 12 Jul 2010 16\:30\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E63E3CA-8E14-11DF-8DB7-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150856>

Junio C Hamano <gitster@pobox.com> writes:

> "Pickens, James E" <james.e.pickens@intel.com> writes:
>
>> The command 'git diff A...B' is supposed to be equivalent to 'git diff $(git
>> merge-base A B) B'.  But when there are multiple merge bases between A and B,
>> the former gives no output...
>> ...
> It should not be too hard to add logic to reverse the list of revisions as
> another special case in the above else-if chain to support the old output
> you saw before Matt's fix if such an output were useful.  You would detect
> if the list begins with a run of UNINTERESTING ones followed by two
> interesting ones (because that is how A...B parser gives its output to
> us), and in that case feed diff_combined with a reversed list.
>
> But I do not see how such an pseudo-merge output is useful, so please
> enlighten me with an illustration.  Your "earlier it showed something, now
> it doesn't show anything" is not good enough here, as I am doubting that
> something we used to show in a criss-cross merge case was a useful output.

I think I half-misread what you wanted to do.  "git diff A...B" is not
equivalent to "git diff $(git merge-base A B) B" but is supposed to be
equivalent to "git diff $(git merge-base --all A B) B".

I prepared a patch to reject such a request when there are more than one
merge base (see below---it is against 1.6.4 maintenance track).  While I
think giving _one_ possible explanation of what you did since you forked
would be better than rejecting, which I'll try in a separate message, but
at the same time it may be misleading to give such an output without
telling the user that we chose one merge base at random to diff against
it.

 builtin-diff.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 2e51f40..f65bc99 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -405,10 +405,28 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
+		 */
+		for (i = 1; i < ents; i++)
+			if (!(ent[i].item->flags & UNINTERESTING))
+				break;
+		if (ents != i + 2 ||
+		    (ent[i+1].item->flags & UNINTERESTING) ||
+		    (!ent[i].item->flags & SYMMETRIC_LEFT) ||
+		    (ent[i+1].item->flags & SYMMETRIC_LEFT))
+			die("what do you mean by that?");
+		if (ents != 3)
+			die("There are more than one merge bases in %s",
+			    ent[ents-2].name);
+		/*
+		 * diff A...B where there is one sane merge base
+		 * between A and B.  We have ent[0] == merge-base,
+		 * ent[1] == A, and ent[2] == B.  Show diff between
+		 * the base and B.
 		 */
 		ent[1] = ent[2];
 		result = builtin_diff_tree(&rev, argc, argv, ent);
