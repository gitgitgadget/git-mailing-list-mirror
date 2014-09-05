From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/22] send-pack: factor out capability string generation
Date: Fri,  5 Sep 2014 13:54:56 -0700
Message-ID: <1409950510-10209-9-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xw-0005bR-9H
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbaIEUzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56688 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbaIEUzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24FAE36687;
	Fri,  5 Sep 2014 16:55:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=68Hp
	/r2Syx8bwbwZJ7+FB38jL2Y=; b=LT/xXkFtjxfoRVBjDUXbh4+rFZfRylzj+9R4
	Az1sBBvsevTGd7Yv3ntUpa45KeqCSakil3hbLHpHl0g7OadZhYmcwIgP2N/3jemy
	Hu6SKAMYw0ANaif6tXUmGDtp1cNQPs5rcVZFJ4LGdgdM2v54CMvh6U9MhDf0vjlQ
	U0/2Ar8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wYR2v6
	3pehaPIKMCR/S27gwM0MXNQ4LPxlL0+1ol+odHeVfV/eXY9k/9r+VwK0atRXuGB/
	FY0mlDjK7gqRa+hzYcZgJIHLQ9EnxQxQHjXf8wvUVVkYfBTb4S3JsYlKVf1lA5G5
	EtF5tMaHwEFKn8kigCCyw4xYYF/f+dD2QAGNc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62BB536685;
	Fri,  5 Sep 2014 16:55:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 483EA36671;
	Fri,  5 Sep 2014 16:55:32 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F9CB2EB2-353E-11E4-BCA5-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256529>

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
2.1.0-399-g2df620b
