From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/21] send-pack: always send capabilities
Date: Thu,  4 Sep 2014 13:04:43 -0700
Message-ID: <1409861097-19151-8-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHs-0000jh-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbaIDUFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59416 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755385AbaIDUFd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C53A38196;
	Thu,  4 Sep 2014 16:05:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/V3u
	jSfgoT0q+gZaPAZwmJw9F9E=; b=sF/pv/9PnDKwZFX9VdcFOYWHBjLlCRmEV7wW
	9wEIbcnQHOlIKQWnwYEjfu19xDKbhwQIYtnwGWf1BVU2UG7/XbJ9Krtb+e/NOvw3
	8LkRTMbXK8Y7ia5yFeO/tk9juB82AZgq0uT+mJAwDrDhNtnV2P5ZvUhJ83F6tOTB
	46dDng4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jgXsiM
	6PQoYnaE+Ej2/Ck4rPZvFHk86gtMR17rBwgfDaBb1qQRvXg8mIIR1Xfgz/CqvuQI
	yJCYqCwMpepfaCCKz712Ap0PrZOVqmFXROfdEipDuNgvAD0OJQJHbKdiawUI/yJH
	cu0S3FiH7iXkIH7AqrlNznmKc+yNxULe+oEM4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CAAF338194;
	Thu,  4 Sep 2014 16:05:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33EB03817B;
	Thu,  4 Sep 2014 16:05:25 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CF053C20-346E-11E4-92B5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256467>

We tried to avoid sending one extra byte, NUL and nothing behind it
to signal there is no protocol capabilities being sent, on the first
command packet on the wire, but it just made the code look ugly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f3c5ebe..2fa6c34 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -281,8 +281,7 @@ int send_pack(struct send_pack_args *args,
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 			int quiet = quiet_supported && (args->quiet || !args->progress);
 
-			if (!cmds_sent && (status_report || use_sideband ||
-					   quiet || agent_supported)) {
+			if (!cmds_sent)
 				packet_buf_write(&req_buf,
 						 "%s %s %s%c%s%s%s%s%s",
 						 old_hex, new_hex, ref->name, 0,
@@ -292,7 +291,6 @@ int send_pack(struct send_pack_args *args,
 						 agent_supported ? " agent=" : "",
 						 agent_supported ? git_user_agent_sanitized() : ""
 						);
-			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
 						 old_hex, new_hex, ref->name);
-- 
2.1.0-399-g1364b4d
