From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Sun, 04 Apr 2010 11:22:18 -0700
Message-ID: <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 04 20:22:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyUT0-0003YX-OC
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 20:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab0DDSWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 14:22:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab0DDSWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 14:22:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 44F92A8F3B;
	Sun,  4 Apr 2010 14:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o2SYJdhis7jORaVi3qWT9tvtkEg=; b=oKus/A
	oOunvKUC6js+kPlAq1Y0H8LGXSmqm6xqzR4OytMU9lk0rdYcjvnJrCDIERMNds31
	BPk0Qa24rRNQ3VtXok1PSVB6qrGdMEpSnMbk+5rUHScM8YTpbU3/CZItaTarws1D
	lRaDtb7Bo1aLby2CuNEKRSIWLmQIBFpxFTbO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sXUZAoH3cbk9zLtmhfAhjUuVhKpEsDO/
	aZYIiuF4dNUDJOfDCOHfMcIHGcMXR+CIsLsVMkhZC7ZAqobpmqRB4jf0TOtX+t8K
	ljeeH5aaelX0LBqNvZzbWiTq8K8kobmRRYW8sZmMvZkwsW4AG2GtsnSB7pVt3U//
	XbFmhsmvuuU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 008EFA8F3A;
	Sun,  4 Apr 2010 14:22:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0218A8F39; Sun,  4 Apr
 2010 14:22:19 -0400 (EDT)
In-Reply-To: <20100403203507.GA12262@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 3 Apr 2010 16\:35\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0495860C-4017-11DF-B7AE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143937>

Jeff King <peff@peff.net> writes:

> Thanks, I was able to get it and reproduce your problem. The slowness is
> in the expire-unreachable code. You can work around it with:
>
>   git config gc.reflogExpireUnreachable never
>
> Obviously that's not really a fix, but it should let your "git gc" work.
>
> It looks like we do two merge-base calculations for each reflog entry,
> which is what takes so long. Perhaps if we know we are going to do a
> large number of reachability checks, we can pre-mark all reachable
> commits, and then each reflog entry would just need to check the commit
> mark.

Thanks for the analysis, but expire_reflog() that is run for each ref
already does that, I think.  It first runs mark_reachable(), then walks
each reflog entry for the ref to call expire_reflog_ent(), which in turn
calls unreachable() that first checks if mark_reachable() has marked the
commit, and if so we don't run in_merge_bases().

But if the commit in question is not reachable, then we end up running
in_merge_bases() to double-check anyway, which is probably the symptom
that was observed.

So perhaps this is a workable compromise?

 builtin/reflog.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 64e45bd..7e278b8 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -230,6 +230,13 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 	/* Reachable from the current ref?  Don't prune. */
 	if (commit->object.flags & REACHABLE)
 		return 0;
+	/*
+	 * Unless there was a clock skew, younger ones that are
+	 * reachable should have been marked by mark_reachable().
+	 */
+	if (cb->cmd->expire_total < commit->date)
+		return 1;
+
 	if (in_merge_bases(commit, &cb->ref_commit, 1))
 		return 0;
 
