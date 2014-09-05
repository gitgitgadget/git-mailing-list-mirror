From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/22] receive-pack: factor out capability string generation
Date: Fri,  5 Sep 2014 13:54:57 -0700
Message-ID: <1409950510-10209-10-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xv-0005bR-N9
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbaIEUzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54156 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbaIEUzg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A11A73668E;
	Fri,  5 Sep 2014 16:55:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Urss
	vvG59wy4Rt6MqgsUD68ArC8=; b=JZRq9VATkslaXKZEv7tGIVglsOt3Wwp2Mygs
	d2TV5Zi6ykS6Ddt1lgK2mkTMSaLKf9YfIChQvCzKP5NXIxF/0SzG58ZzIRfQIYXA
	pZ1B6YZyn/B5Ewvm5ztr8uImVun2z4MfpOWMgOxcliZH+vd870rZutCijm3Z5B43
	2NShTVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=kyxrV5
	zOE7UH2CoLZo87Lrxz7ClTWZYrvHwKDL7XAdCZO5esthtfOm8+BMnbfEQ3pL1Flf
	AqNweMg/LZ5KZCwTzsvQ6TTFrysmc9fPfcvKGPUpGT+fz6to2zpUX0QMis2R02bd
	TbfvTw2yGTOghXO6W4ANkkhWpIJtIHehd1ng4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 565D53668D;
	Fri,  5 Sep 2014 16:55:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE9D436686;
	Fri,  5 Sep 2014 16:55:34 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FB3C5F78-353E-11E4-81CB-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256528>

Similar to the previous one for send-pack, make it easier and
cleaner to add to capability advertisement.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.1.0-399-g2df620b
