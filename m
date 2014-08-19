From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/18] send-pack: factor out capability string generation
Date: Tue, 19 Aug 2014 15:06:17 -0700
Message-ID: <1408485987-3590-9-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrZS-00064F-3A
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbaHSWH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:07:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50264 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbaHSWH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:07:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B345C3310A;
	Tue, 19 Aug 2014 18:07:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=24f9
	mgzCYxpIsgh7QAeUKnWGVWs=; b=CSCSD9tae0f1XtoyPFQvhIxjoDXAn+Ho6LcP
	MaO1m1sv2YT8mpZJYn62nnquko0n+gBB+8waFY5O3t/GzkXZbCHksxq2J+TXC0U7
	5tqT22xZuli/ZIVmCVwqLw6SjVYRaj0WzXrMRUJNjx+3ksEwx45yzv7lfzHZnjUH
	8F4B6U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=O0AVfF
	j7jAJHTg3As7QaavGO6oHLcksASRnaQOsBHCiYpuyeYofKjp2HjRhlZW7sEQkRH4
	81w7AAdqmRWErvB44ueNR9+NkKXCTLuGrmu7qxpLFlYnXZLdHAYbQZNa220rHAW7
	8ILJ+dePdnbcWkZl9+TqdzQogAK/+K7QrY4Qc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAA6B33109;
	Tue, 19 Aug 2014 18:07:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 77FC933100;
	Tue, 19 Aug 2014 18:07:48 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 41588E64-27ED-11E4-93FF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255528>

A run of 'var ? " var" : ""' fed to a long printf string in a deeply
nested block was hard to read.  Move it outside the loop and format
it into a strbuf.

As an added bonus, the trick to add "agent=<agent-name>" by using
two conditionals is replaced by a more readable version.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 2fa6c34..c1c64ee 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -218,6 +218,7 @@ int send_pack(struct send_pack_args *args,
 	int in = fd[0];
 	int out = fd[1];
 	struct strbuf req_buf = STRBUF_INIT;
+	struct strbuf cap_buf = STRBUF_INIT;
 	struct ref *ref;
 	int new_refs;
 	int allow_deleting_refs = 0;
@@ -251,6 +252,15 @@ int send_pack(struct send_pack_args *args,
 		return 0;
 	}
 
+	if (status_report)
+		strbuf_addstr(&cap_buf, " report-status");
+	if (use_sideband)
+		strbuf_addstr(&cap_buf, " side-band-64k");
+	if (quiet_supported && (args->quiet || !args->progress))
+		strbuf_addstr(&cap_buf, " quiet");
+	if (agent_supported)
+		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
+
 	/*
 	 * NEEDSWORK: why is delete-refs so specific to send-pack
 	 * machinery that set_ref_status_for_push() cannot set this
@@ -279,18 +289,12 @@ int send_pack(struct send_pack_args *args,
 		} else {
 			char *old_hex = sha1_to_hex(ref->old_sha1);
 			char *new_hex = sha1_to_hex(ref->new_sha1);
-			int quiet = quiet_supported && (args->quiet || !args->progress);
 
 			if (!cmds_sent)
 				packet_buf_write(&req_buf,
-						 "%s %s %s%c%s%s%s%s%s",
+						 "%s %s %s%c%s",
 						 old_hex, new_hex, ref->name, 0,
-						 status_report ? " report-status" : "",
-						 use_sideband ? " side-band-64k" : "",
-						 quiet ? " quiet" : "",
-						 agent_supported ? " agent=" : "",
-						 agent_supported ? git_user_agent_sanitized() : ""
-						);
+						 cap_buf.buf);
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
 						 old_hex, new_hex, ref->name);
@@ -311,6 +315,7 @@ int send_pack(struct send_pack_args *args,
 		packet_flush(out);
 	}
 	strbuf_release(&req_buf);
+	strbuf_release(&cap_buf);
 
 	if (use_sideband && cmds_sent) {
 		memset(&demux, 0, sizeof(demux));
-- 
2.1.0-301-g54593e2
