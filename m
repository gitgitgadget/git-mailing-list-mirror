From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 09/23] receive-pack: factor out capability string generation
Date: Wed, 17 Sep 2014 15:45:44 -0700
Message-ID: <1410993958-32394-10-git-send-email-gitster@pobox.com>
References: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNza-000283-88
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbaIQWq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50148 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757095AbaIQWqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C43839E0A;
	Wed, 17 Sep 2014 18:46:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Z1uw
	ZOIkbX/iGMVurz76e+7yu3E=; b=m8gVcDNbQzR7jWdJ/6dve0jjsD2FgtoM+d5m
	ULbMOhXVcP5Glpq+naUcvVZj8lCvRfEvYjxKI5wCj6Gm68yKVoQa175/CEW6NVm0
	cz7Mifg0SsyIr7EA6CWY05YMhQfx49djWSvnMRSqDHCjiem5UcVCuc+cdXBAqhm/
	DoVAcv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WE3GcP
	oOQFFECoy1jofziqnVlGkqcMbJqcKCsO2XnfL5NDFphswPehU0z5l/ugRebzvG3S
	bfCH9AnpG4sKRtyaP5sDX8gImwJBkcc+5i7weUipfvPOJyXnseFCL4RnNgafrp+N
	GJD6hZDsLRxWxk7BvcDpS7Kky+ES8fCcODY/U=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1238D39E09;
	Wed, 17 Sep 2014 18:46:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 714B739DFF;
	Wed, 17 Sep 2014 18:46:19 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
In-Reply-To: <1410993958-32394-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 70C5F03E-3EBC-11E4-A910-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257234>

Similar to the previous one for send-pack, make it easier and
cleaner to add to capability advertisement.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Unchanged since v5.

 builtin/receive-pack.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 587f7da..cbbad54 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -137,15 +137,21 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	if (ref_is_hidden(path))
 		return;
 
-	if (sent_capabilities)
+	if (sent_capabilities) {
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
-	else
-		packet_write(1, "%s %s%c%s%s agent=%s\n",
-			     sha1_to_hex(sha1), path, 0,
-			     " report-status delete-refs side-band-64k quiet",
-			     prefer_ofs_delta ? " ofs-delta" : "",
-			     git_user_agent_sanitized());
-	sent_capabilities = 1;
+	} else {
+		struct strbuf cap = STRBUF_INIT;
+
+		strbuf_addstr(&cap,
+			      "report-status delete-refs side-band-64k quiet");
+		if (prefer_ofs_delta)
+			strbuf_addstr(&cap, " ofs-delta");
+		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
+		packet_write(1, "%s %s%c%s\n",
+			     sha1_to_hex(sha1), path, 0, cap.buf);
+		strbuf_release(&cap);
+		sent_capabilities = 1;
+	}
 }
 
 static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *unused)
-- 
2.1.0-403-g099cf47
