From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/19] send-pack: factor out capability string generation
Date: Fri, 22 Aug 2014 13:30:13 -0700
Message-ID: <1408739424-31429-9-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:32:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvVE-0007rP-1z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaHVUb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:31:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52492 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbaHVUb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:31:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A4EED3319D;
	Fri, 22 Aug 2014 16:31:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3rB+
	6BJUbTrkRxDaVp9l809HI2o=; b=NYB9YwFecbHljloX0bmd3iIioAeKEbWQo0HV
	Jhc5jv/+af0LgDgYYapNWe50rDHDOnHXw/eg/ljLbbCXnz7AmT+FQIHiHQ0G6qsR
	BUHfnUPO4OOiztB9Hz8FlMIJYW7axxBfvScA1iRC3U01eEfIM3wSB+xkGIGpgIln
	01jHtgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VOaoei
	0+X00VZsb5mXrUkqeaijpZFXnyMc5MALtB/krJT0xvMYSmT7C3PyfQ23AAcuCac6
	DVGNos429qux2R58qO7mrnpKqbFbldWokjQMHB8Mvj8/dBZvCQy1zemsAkiZIwMf
	5hONyJ9WPjiQfpVUkrU4HpgIUFw4HgeUsxoug=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C1FF3319C;
	Fri, 22 Aug 2014 16:31:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0150133195;
	Fri, 22 Aug 2014 16:31:50 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 58DB74A2-2A3B-11E4-B4DD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255709>

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
2.1.0-304-g950f846
