From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: Extremely slow progress during 'git reflog expire --all'
Date: Wed, 07 Apr 2010 11:43:22 -0700
Message-ID: <7vk4sjcddh.fsf@alter.siamese.dyndns.org>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
 <20100405062621.GA30934@coredump.intra.peff.net>
 <7v1vetpw63.fsf@alter.siamese.dyndns.org>
 <20100406060217.GF3901@coredump.intra.peff.net>
 <7vochvcdkc.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 07 20:43:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzaDz-0008BA-5d
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 20:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab0DGSne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 14:43:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab0DGSnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 14:43:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F14CFA8196;
	Wed,  7 Apr 2010 14:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oBrXDqdqJTRwRfXRaL4KsUGiuoQ=; b=Ic5Z5/
	xUQgfT9QJ/zGUdiie7dwkvjTZnRpfDXYD/prJ8lIQbZT7VlFVOqE5cS5PcPrwYff
	PmgvBhdILGo6uK7+7Sa9/dZFdUceFY2mkzfVhkj3wCENaA9vVESxmDRMPbU847Yz
	UQ84VRbg82aQjUFbUzwRC7yU/ibVr1y83OyGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hm85jp7l2/EvUhOHmRqKN5lg62v7xjRS
	//1MnxBdRXBYi3ZQLhIeMGFk79D+jmOCxTVD9dFa36kRG7TPX8Ch0PSkT2MX+N4J
	c5VzuzJt8DSC69QkLoUaq2UqipUr8XwjzZQm+nm+Bw9lHwpV5InvPF3lqwQvW6LX
	AlJPFvcO/Vc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B012DA8191;
	Wed,  7 Apr 2010 14:43:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C47D6A8174; Wed,  7 Apr
 2010 14:43:23 -0400 (EDT)
In-Reply-To: <7vochvcdkc.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 07 Apr 2010 11\:39\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 750A0C04-4275-11DF-B821-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144266>

Side note.

It may be an improvement to dig the history even more incrementally.

Inside unreachable(), we currently dig immediately down to root, but it
may give us a better performance in a long history with reflog entries
that wildly jump everywhere in that history if we dug down to the
timestamp of the commit we are looking at.  A patch to do so on top of the
previous one may look like this.

 builtin-reflog.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 9792090..42d225f 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -274,16 +274,19 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 			return 0;
 	}
 
-	/* Reachable from the current ref?  Don't prune. */
-	if (commit->object.flags & REACHABLE)
-		return 0;
+	while (1) {
+		/* Reachable from the current ref?  Don't prune. */
+		if (commit->object.flags & REACHABLE)
+			return 0;
 
-	if (cb->mark_list && cb->mark_limit) {
-		cb->mark_limit = 0; /* dig down to the root */
+		/* Did we mark everything?  Then we know we cannot reach it. */
+		if (!cb->mark_list || !cb->mark_limit)
+			return 1;
+
+		/* Dig down to the timestamp of this commit, or down to root. */
+		cb->mark_limit = (cb->mark_limit < commit->date) ? 0 : commit->date;
 		mark_reachable(cb);
 	}
-
-	return !(commit->object.flags & REACHABLE);
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-- 
1.7.1.rc0.212.gbd88f
