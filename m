From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/19] send-pack: clarify that cmds_sent is a boolean
Date: Fri, 22 Aug 2014 13:30:16 -0700
Message-ID: <1408739424-31429-12-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvVi-00087e-Os
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaHVUcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:32:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61113 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbaHVUca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:32:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4ECB331D5;
	Fri, 22 Aug 2014 16:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pfhb
	nShMBLKm2bWtuSQDKWyliR0=; b=VFM1v3OHTkYifD4sEj59KZBWtioWfRU8cRsN
	HXum3UM6eiOcTOF6z2p382go0Gc1yAV7E9KGu1M8uUSayx49yqxfyp/RTEeRPvXu
	x9R95obFQmGhWzqQgB/dCkf+7vLAdt2s7bCNW+qoDFRBzaMDXJGA/Ow6SnmMOueu
	UEI785s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sjJ00Q
	U44OtlVWX7/klE0Zmz5yIePU1pTS0SmzxoIxT0/2Hn+W+Xk5UPQR1612VZfblIUm
	rblv4m5Cyg2vGQUCkylE0Q+JFl/+Is/+GNeA42bJBWot9nPnyKvAO78CsKoWLDem
	mFykpb3jU1oOMDnFsUmtO68G/d/VZ5pAfFjww=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99E66331D4;
	Fri, 22 Aug 2014 16:32:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91230331C8;
	Fri, 22 Aug 2014 16:32:19 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 69EC2412-2A3B-11E4-90C1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255712>

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
2.1.0-304-g950f846
