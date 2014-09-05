From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/22] send-pack: clarify that cmds_sent is a boolean
Date: Fri,  5 Sep 2014 13:55:00 -0700
Message-ID: <1409950510-10209-13-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:56:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xx-0005bR-TA
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbaIEUzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54292 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbaIEUzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DD3A366A6;
	Fri,  5 Sep 2014 16:55:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0O9W
	lrcgIWTpfB6Co7bxaqJolSo=; b=iiXQ3a1MNdVRbJkXXb8zTDzm0BRaZmgGrMkk
	aIPyi8LzBWO94hOD7CX3JbD81xVgCpiIqiW7OLRCq200YeM0OGgSbMqZi2v3qclC
	jIi+iaEBHZsqwdvReIn6IVFuI2awpbH6Wvs9Vk+49+DpaPJDgDyExSte5XTQU3KW
	aEleEuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fO3OtS
	w0TrXcCHK5xkmnM9QqWbHb6xei0biSpQobDx+73vNQKvEM8io0SJS08v7/u+XgHO
	vik4KR/V+VUgw6mviPXx1rHXpPRypLfQDwkvMEYX0gtJ+UmoUdc9V1mnNYdz+eWr
	HWQwG6WCUUGQU8J73yO1Bd38ply49w4zG4XIk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 14CE5366A5;
	Fri,  5 Sep 2014 16:55:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 23E9B366A0;
	Fri,  5 Sep 2014 16:55:41 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FF11B2E2-353E-11E4-BA5D-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256532>

We use it to make sure that the feature request is sent only once on
the very first request packet (ignoring the "shallow " line, which
was an unfortunate mistake we cannot retroactively fix with existing
receive-pack already deployed in the field) and we set it to "true"
with cmds_sent++, not because we care about the actual number of
updates sent but because it is merely an idiomatic way.

Set it explicitly to one to clarify that the code that uses this
variable only cares about its zero-ness.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6dc8a46..bb13599 100644
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
2.1.0-399-g2df620b
