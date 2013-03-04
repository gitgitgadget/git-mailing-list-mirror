From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] match_push_refs(): nobody sets src->peer_ref anymore
Date: Mon, 04 Mar 2013 14:36:33 -0800
Message-ID: <7vlia2x05q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 04 23:37:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCe0E-0007MD-AG
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 23:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758887Ab3CDWgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 17:36:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758783Ab3CDWgg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 17:36:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D0AB405;
	Mon,  4 Mar 2013 17:36:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	xILaSRPU6ba2PQk6ekMEb4DIzg=; b=IGbFo1X9EFzmNqLA3ZKEcczaAmtC7ZaXg
	X6J12PPl8SzN9IqIg+gELzaC2+doS6xtn5v8yrXF//emilun4yWqUl+NXZaLaWvt
	tnD1un4Rq+5/4B8b0lDYRYE1UahtTYn1ItFFO8VpETMFqjaJy/PKUf+6X+DTXIpb
	1HI4+YebnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Mc+
	NmbUVSidJc5Fnh62LJ27nsnfhT8Q2jRInI9pWMEcgHBxfcA3QS/WeWU/Lr8UY2iX
	WuiEqzox7CmXqJZ6bHv8yNnaCMfmfluJ/+nzXfIPwawi1cBqTRkif8gsjsyClTVS
	UY7B+A7WCbly+O2nrF2I/NXLEqYGRHBtMQpbl+GQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76526B404;
	Mon,  4 Mar 2013 17:36:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D38B6B402; Mon,  4 Mar 2013
 17:36:34 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F82B4044-851B-11E2-B59B-2F862E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217416>

In ancient times, we used to disallow the same source ref to be
pushed to more than one places, e.g. "git push there master:master
master:naster" was disallowed.  We later lifted this restriction
with db27ee63929f (send-pack: allow the same source to be pushed
more than once., 2005-08-06) and there no longer is anybody that
sets peer_ref for the source side of the ref list in the push
codepath since then.

Remove one leftover no-op in a loop that iterates over the source
side of ref list (i.e. our local ref) to see if it can/should be
sent to a matching destination ref while skipping ones that is
marked with peer_ref (which will never exist, so we do not skip
anything).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/remote.c b/remote.c
index e53a6eb..bac2b02 100644
--- a/remote.c
+++ b/remote.c
@@ -1227,9 +1227,6 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec *pat = NULL;
 		char *dst_name;
 
-		if (ref->peer_ref)
-			continue;
-
 		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
-- 
1.8.2-rc2-182-g857a7fa
