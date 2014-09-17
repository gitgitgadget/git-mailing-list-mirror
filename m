From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 07/23] send-pack: always send capabilities
Date: Wed, 17 Sep 2014 15:45:42 -0700
Message-ID: <1410993958-32394-8-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzZ-000283-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138AbaIQWqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60753 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095AbaIQWqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD5FD39E04;
	Wed, 17 Sep 2014 18:46:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=stNb
	vUe4JZP+yy3nAibpzqVPfj0=; b=yBVdhnNdotdw1N/VQxyn1+0gucOLo5aFpA//
	xL+CXJsEesTBwlk3iFkDj1R9jMupx1AjVczx4MeKE9qktzZHZ/6edfNOgoQ935u9
	+6UOTMYP0belwCTxZQVH6utgvWjgSWbjn1RTvcYFPe5cbZpjLXHsYAeJhX2d79T0
	K7DM8FI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=XBGlUU
	5p2WXMTx6xAJEzhLeGo52B5fPukV56ZQ5Wlgrny/pQtwA0NETHkmgYmFxYJGT5/H
	pBvxenpPz5Ms9+HJ68vLXnyENcrxil/T7AggDBvniHx44u/0H7JHcZR20bWSX2id
	GA/61Qu9NLJ0RXSF7+hnS+do0UyIwimY+hZuA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D165939E01;
	Wed, 17 Sep 2014 18:46:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 287C339DF5;
	Wed, 17 Sep 2014 18:46:15 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6E35B23C-3EBC-11E4-BAEF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257233>

We tried to avoid sending one extra byte, NUL and nothing behind it
to signal there is no protocol capabilities being sent, on the first
command packet on the wire, but it just made the code look ugly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

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
2.1.0-403-g099cf47
