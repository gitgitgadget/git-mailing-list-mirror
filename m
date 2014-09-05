From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 07/22] send-pack: always send capabilities
Date: Fri,  5 Sep 2014 13:54:55 -0700
Message-ID: <1409950510-10209-8-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xu-0005bR-KD
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbaIEUzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57023 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbaIEUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3461636669;
	Fri,  5 Sep 2014 16:55:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Rzva
	FCiUEKrCbhGH8uFpNiDSeDM=; b=sK2FbOjA+U46ZN8VChx+0DTjEsAx2785o+AD
	HvVcK3AqhSBMp7XTMydwGhuKjj+sNd+CLzPJmBjMB4XqgY2CpJxM9ieffN8B44Er
	742/hLwtD8c5U2Wk1gUnjQqHKfcI+2ar8y0/OAVFOAdPz60Bq+Qom/FbM9SIZa8Q
	aqtzeZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xyMhU2
	f8VlosMYcX+/vA+aswGUzNBQ1m8ZVmMLiaNU0idSssjdTl9NYWoA/36Krb4F0q9R
	skChoDCyRjBoEp8gx9c8QGZgbqGvWWAD6iNugplxxeDeww/aweM63d7MGPj5fEn4
	nrMwKjEe3jCdUD8UMWeC/8DmqjSidi5nnZNUQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D052536668;
	Fri,  5 Sep 2014 16:55:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A50CB36660;
	Fri,  5 Sep 2014 16:55:29 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F83B7F34-353E-11E4-BB07-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256524>

We tried to avoid sending one extra byte, NUL and nothing behind it
to signal there is no protocol capabilities being sent, on the first
command packet on the wire, but it just made the code look ugly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 43e98fa..e81f741 100644
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
2.1.0-399-g2df620b
