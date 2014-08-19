From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/18] send-pack: always send capabilities
Date: Tue, 19 Aug 2014 15:06:16 -0700
Message-ID: <1408485987-3590-8-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:07:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrZI-0005yl-5s
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaHSWHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:07:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63829 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733AbaHSWHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:07:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A84A330F4;
	Tue, 19 Aug 2014 18:07:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6pOh
	lLn9ZjITp0Zc32zxsnfDPic=; b=woE3XWfH5iiqng9bQhk2vAt84HNPje7GqDLv
	dFu+WXtZsZ8fWr3MzdD2hFFg2T9xteK/0Yb9kt0iLaUc/dK70YkJHyvfHAari0Ld
	Uo+HPovtHbLSWdrTZcM84Hr/rrPkHpi5hUmWZaArsFRy2FtBGuob06Uxs/XKFOF1
	nrCjt6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=k0fObj
	cZ1E3OGriv2tFXVGxwUGjVJ/HPffwpPIfpwwpuaSPQio+NshaVf0CcfKC9cKh/tk
	QAZ0U+wlv0voQ+0QA4BRP+sw8JmuyUg4W0vNMf7pWglymGozRfVQCvXXv2olTKan
	hPMOnPemUb3l2T9RSMZnQ309cOFu4gjrMnlak=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3AD1330F2;
	Tue, 19 Aug 2014 18:07:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 52379330DF;
	Tue, 19 Aug 2014 18:07:37 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3AB27FE8-27ED-11E4-AF60-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255527>

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
2.1.0-301-g54593e2
