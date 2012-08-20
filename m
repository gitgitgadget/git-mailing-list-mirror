From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] get_fetch_map(): tighten checks on dest refs
Date: Mon, 20 Aug 2012 10:39:57 -0700
Message-ID: <1345484397-10958-3-git-send-email-gitster@pobox.com>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 19:40:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Vxa-0001Gt-F6
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 19:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab2HTRkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 13:40:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110Ab2HTRkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 13:40:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FD6A8B3E;
	Mon, 20 Aug 2012 13:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=n5ZD
	F/J9QJhFFk61dFzz9zIqed0=; b=ssyWmZVHkSeZ3WfVF93e+hbHBhEbIxBBBeYJ
	3W+FVtLYAoyS47+HbLvahqn/4CPQlntlZfuhpV5NzzRo1QOQwRFJOvegDkMkx4VU
	G35snq+rxwUkVJMdzDWHquV1pTOLfAFEmFnFJI20oxwQjzfWCi2x+I9sfutGtD+P
	aGdC8us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	BKFRZPbrjF48dN7uPZKBmHpaXIhso6Ld0HaxToZJfjxcVjOw+y6s9PS+m8aAzYdZ
	dg83GkRJYnRFBZlSb0lATcHeCtEDNLUno+eargzNjD+YG60K54THwW4UzIHKG8Ge
	k28hSCX+c0mxUlC88/YK7+KsMpgpUfWsCQw1vl1zLBw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F15E98B3D;
	Mon, 20 Aug 2012 13:40:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6441D8B3C; Mon, 20 Aug 2012
 13:40:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.92.g7963261
In-Reply-To: <1345484397-10958-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 13DCBC78-EAEE-11E1-ABDB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203862>

The code to check the refname we store the fetched result locally did not
bother checking the first 5 bytes of it, presumably assuming that it
always begin with "refs/".  For a fetch refspec (or the result of applying
wildcard on one), we always want the RHS to map to something inside
"refs/" hierarchy, so let's spell that rule out in a more explicit way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index eacd8ad..0f2b1db 100644
--- a/remote.c
+++ b/remote.c
@@ -1402,8 +1402,8 @@ int get_fetch_map(const struct ref *remote_refs,
 
 	for (rmp = &ref_map; *rmp; ) {
 		if ((*rmp)->peer_ref) {
-			if (check_refname_format((*rmp)->peer_ref->name + 5,
-				REFNAME_ALLOW_ONELEVEL)) {
+			if (prefixcmp((*rmp)->peer_ref->name, "refs/") ||
+			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
 				error("* Ignoring funny ref '%s' locally",
 				      (*rmp)->peer_ref->name);
-- 
1.7.12.92.g7963261
