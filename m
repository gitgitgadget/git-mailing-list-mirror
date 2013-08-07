From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] fetch: refactor code that fetches leftover tags
Date: Wed,  7 Aug 2013 16:30:41 -0700
Message-ID: <1375918242-4655-5-git-send-email-gitster@pobox.com>
References: <1375918242-4655-1-git-send-email-gitster@pobox.com>
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:31:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7DCF-0005Nz-SS
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933724Ab3HGXa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 19:30:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933682Ab3HGXay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 19:30:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 316EA37FA4;
	Wed,  7 Aug 2013 23:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Hj6b
	jFdmXdgHVMzrCf0E/RmMsI0=; b=mOKezamz44lJEhp5XG2/bSS3j3pikxZvsqUt
	FyBzCdr+n0F7D5JEOJUgdVDuiT+UGMSC4EnvCc3ZZ0O8Tn2lHBGYH6GZZDou8aqk
	LBlUvb1BLK5J3lW38rGB1IYSYGM1+4b14F/LNeTwq6Rn5/jupU9UlFJuWXHJ0w4K
	2fDXR0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	sJP6ehLtj10trob+CiSMOOjARlpvrmQH9AJ+iEWiQSRlCEzbdtV+okCunbObUMQY
	NxO4+Axfml2U5CArXDP9idJ4hLVuUFx24bHpfEpjkBi32lGVOduuCZVJ/i5AsWNH
	wsW82eB+ekLkElVRD60mhteG9kBXTgPruPzh5O7BdMc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 276D837FA3;
	Wed,  7 Aug 2013 23:30:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69EC237FA1;
	Wed,  7 Aug 2013 23:30:53 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375918242-4655-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 66DE8E7A-FFB9-11E2-A4FF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231850>

Usually the upload-pack process running on the other side will give
us all the reachable tags we need during the primary object transfer
in do_fetch().  If that does not happen (e.g. the other side may be
running a third-party implementation of upload-pack), we will run
another fetch to pick up leftover tags that we know point at the
commits reachable from our updated tips.

Separate out the code to run this second fetch into a helper
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 39a3fc8..0b21f07 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -745,6 +745,13 @@ struct transport *prepare_transport(struct remote *remote)
 	return transport;
 }
 
+static void backfill_tags(struct transport *transport, struct ref *ref_map)
+{
+	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
+	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+	fetch_refs(transport, ref_map);
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
@@ -828,11 +835,8 @@ static int do_fetch(struct transport *transport,
 		struct ref **tail = &ref_map;
 		ref_map = NULL;
 		find_non_local_tags(transport, &ref_map, &tail);
-		if (ref_map) {
-			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
-			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
-			fetch_refs(transport, ref_map);
-		}
+		if (ref_map)
+			backfill_tags(transport, ref_map);
 		free_refs(ref_map);
 	}
 
-- 
1.8.4-rc1-210-gf6d87e2
