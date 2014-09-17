From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 08/23] send-pack: factor out capability string generation
Date: Wed, 17 Sep 2014 15:45:43 -0700
Message-ID: <1410993958-32394-9-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUO0L-0002S5-2y
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbaIQWrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:47:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62518 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099AbaIQWqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F85E39E07;
	Wed, 17 Sep 2014 18:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nOPH
	aTB5kTrrH2GfX44tyubX/wk=; b=UeVU/E9QM2fxX2euAk/VhW8aLZN6NPcZayv6
	eWXt81MkBMeyapWQkCMp+yySu6cGk186AFW6QiFcr5W3iizReiD78E+WbIGAYGs0
	Qfh3q3yH2+xBJa+xG8pk2i0Wys0nOFevRwybZowvf+usfJOve2ZAcex8lAZgi58e
	ftih2UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jlWsuG
	ot9/y/4tL50rQ9WrvRPWL1JChZg6VlXHU8O3bnzUBt+EZWGWPi9mi5udKMx8rbSj
	YohegPkgQK5hqYYst6an4qnHCry6fsbHlnAnlyUCijbbSpCAf7X0R41UBl63GWgP
	XT2d7msu86wmeHR/0/apZfUlIbkNAfacVxirk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9642439E06;
	Wed, 17 Sep 2014 18:46:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2769439DF8;
	Wed, 17 Sep 2014 18:46:17 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6F664842-3EBC-11E4-9021-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257250>

A run of 'var ? " var" : ""' fed to a long printf string in a deeply
nested block was hard to read.  Move it outside the loop and format
it into a strbuf.

As an added bonus, the trick to add "agent=<agent-name>" by using
two conditionals is replaced by a more readable version.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

 send-pack.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index e81f741..0cb44ab 100644
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
 	 * NEEDSWORK: why does delete-refs have to be so specific to
 	 * send-pack machinery that set_ref_status_for_push() cannot
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
2.1.0-403-g099cf47
