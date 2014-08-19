From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/18] send-pack: clarify that cmds_sent is a boolean
Date: Tue, 19 Aug 2014 15:06:20 -0700
Message-ID: <1408485987-3590-12-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:08:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJra7-0006OJ-AU
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbaHSWI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:08:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61029 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaHSWIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:08:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5165833133;
	Tue, 19 Aug 2014 18:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dDef
	CVuQczmsmjO8r90Ow0E1KkY=; b=psqAOqS1QUtnwATDLiZnaKorBBSim7fCXKZT
	NlHKeecxw6xQUExrJST6s3BLLvwivNS1bpwHqP1bho975CyOICuGzSQTaSGxCi/3
	q+n+vumhOROJ7k/EEsxYdMC8qbFn52kUwjkioRTyNTMg9m7oihaHL9fK9sGW4941
	oq52p2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Abl+d2
	4ZrjEEkD782cgJfL/KyhI77Ox1EveIwt9bWdPKggbdfFrQuDOOTDEghZEhYnM8SD
	uvts6xleipowtO2Rl/d6mYn+ywDEtTy1/LCy8ZgdLKrLuiovT1bI4/Z0WqNRUkqW
	YYeYxQy6auMHapdVzllZsEmt0OVXr75oaigTs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4889C33132;
	Tue, 19 Aug 2014 18:08:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD3673312B;
	Tue, 19 Aug 2014 18:08:16 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 523E2FFE-27ED-11E4-9627-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255530>

We use it to make sure that the feature request is sent only once on
the very first request packet (ignoring the "shallow " line, which
was an unfortunate mistake we cannot retroactively fix with existing
receive-pack already deployed in the field) and we set it to "true"
with cmds_sent++, not because we care about the actual number of
updates sent but because it is merely an old idiomatic way.

Set it explicitly to one to clarify that the code that uses this
variable only cares about its zero-ness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f3262f2..05926d2 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -304,15 +304,16 @@ int send_pack(struct send_pack_args *args,
 
 		old_hex = sha1_to_hex(ref->old_sha1);
 		new_hex = sha1_to_hex(ref->new_sha1);
-		if (!cmds_sent)
+		if (!cmds_sent) {
 			packet_buf_write(&req_buf,
 					 "%s %s %s%c%s",
 					 old_hex, new_hex, ref->name, 0,
 					 cap_buf.buf);
-		else
+			cmds_sent = 1;
+		} else {
 			packet_buf_write(&req_buf, "%s %s %s",
 					 old_hex, new_hex, ref->name);
-		cmds_sent++;
+		}
 	}
 
 	if (args->stateless_rpc) {
-- 
2.1.0-301-g54593e2
