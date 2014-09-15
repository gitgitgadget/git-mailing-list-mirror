From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 07/23] send-pack: always send capabilities
Date: Mon, 15 Sep 2014 15:24:08 -0700
Message-ID: <1410819864-22967-8-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTeic-0006mn-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbaIOWZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61715 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbaIOWYl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A35013B18C;
	Mon, 15 Sep 2014 18:24:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bKNp
	UVPptWyE2CEK/zn7/fcO4Oo=; b=TJIAcN24osdNaEy6oQI/RSprroE/Kdj6wi2O
	15mwTAc47UqaDX3FiUZKRulAh3z1gDLhAe1ksxkLIGjM7HXqHyIWnMN04zUtAN9T
	6H+pK9mc9QyA0po0jLF2B30aE4lqSb3+L8H0JmIbEjhhtkpDE4rjkG325898eT58
	zQLNoQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vfCQLx
	cPHRCNOn+UtymPnnew+ryMeZUCPhE1N2dn64ZMysLcknJBVEjznM2jten8giPNyX
	yVtkr/QGuxofE49Jzkkq/CzSKRIt+2XPjoHlVYU0iLoQLsMZyGfzsmnoAQkC9gV8
	9EfFQnrLsdME0jhnTiofJ5NfRQdBC8uOdxqU4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9ACA53B18B;
	Mon, 15 Sep 2014 18:24:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 156163B188;
	Mon, 15 Sep 2014 18:24:40 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1575111A-3D27-11E4-9701-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257110>

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
2.1.0-410-gd72dacd
