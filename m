From: Junio C Hamano <gitster@pobox.com>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 17:31:42 -0800
Message-ID: <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 02:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlVzi-0007Hc-Rw
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 02:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab2AMBbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 20:31:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756825Ab2AMBbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 20:31:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34BCF78A7;
	Thu, 12 Jan 2012 20:31:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AG2lspR7ek2V0a6V3uHKmOj1mUA=; b=E2JdHN
	CHQBpKzG/dg6AHff2Eu0kJHbfjiphiEifPZ9AZt500twVjt9zICtJW3A0nQnektT
	JTQr/fpCZfqyZ9r1P+kLz5VwzwSK9KE6iOLHACVlmo7q4XC8nNeNCOhix+zRki3A
	KYZtmxD6SLOMd0LQfLexhhmZlGaTl+nl3b0v8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qf0oJjMRGiJig57mnA9cBB61Dvq/I0DW
	2rKUf9WALee4wWdVt3cWrgkSKl6HSd2aga2WK2LHOt/cMsUZQdWheI8jjkugne2L
	80Bjs21MM3vTqRVmNylDD++z6dSfhES89hhGV7py03X07Sjr47fwuwdz4Kxeimy5
	DEt5w/Z/3Vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2993E78A6;
	Thu, 12 Jan 2012 20:31:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1B5778A5; Thu, 12 Jan 2012
 20:31:43 -0500 (EST)
In-Reply-To: <20120112223234.GA4949@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Jan 2012 17:32:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59A5312E-3D86-11E1-B166-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188490>

From: Jeff King <peff@peff.net>
Subject: [PATCH] thin-pack: try harder to create delta against preferred base

When creating a pack using objects that reside in existing packs, we try
to avoid recomputing futile delta between an object (trg) and a candidate
for its base object (src) if they are stored in the same packfile, and trg
is not recorded as a delta already. This heuristics makes sense because it
is likely that we tried to express trg as a delta based on src but it did
not produce a good delta when we created the existing pack.

As the pack heuristics prefer producing delta to remove data, and Linus's
law dictates that the size of a file grows over time, we tend to record
the newest version of the file as inflated, and older ones as delta
against it.

When creating a thin-pack to transfer recent history, it is likely that we
will try to send an object that is recorded in full, as it is newer.  But
the heuristics to avoid recomputing futile delta effectively forbids us
from attempting to express such an object as a delta based on another
object. Sending an object in full is often more expensive than sending a
suboptimal delta based on other objects, and it is even more so if we
could use an object we know the receiving end already has (i.e. referred
base object) as the delta base.

Tweak the recomputation avoidance logic, so that we do not punt on
computing delta against a preferred base object.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/pack-objects.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c6e2d87..8bfe3a6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1248,11 +1248,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		return -1;
 
 	/*
-	 * We do not bother to try a delta that we discarded
-	 * on an earlier try, but only when reusing delta data.
+	 * We do not bother to try a delta that we discarded on an
+	 * earlier try, but only when reusing delta data.  Note that
+	 * src_entry that is marked as the preferred_base should always
+	 * be considered, as even if we produce a suboptimal delta against
+	 * it, we will still save the transfer cost, as we already know
+	 * the other side has it and we won't send src_entry at all.
 	 */
 	if (reuse_delta && trg_entry->in_pack &&
 	    trg_entry->in_pack == src_entry->in_pack &&
+	    !src_entry->preferred_base &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
 		return 0;
-- 
1.7.9.rc0.53.gc8bc2
