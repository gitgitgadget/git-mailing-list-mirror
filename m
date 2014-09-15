From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 09/23] receive-pack: factor out capability string generation
Date: Mon, 15 Sep 2014 15:24:10 -0700
Message-ID: <1410819864-22967-10-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehc-0006LV-3s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712AbaIOWYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60496 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbaIOWYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 581CF3B193;
	Mon, 15 Sep 2014 18:24:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=o8l9
	6Xvn3ssyd5SUJbCdsK4Bzag=; b=Vf+PquoCMueB9txm6M/0+77EEz2iVXQMQEEX
	QfGqnyN5QvkUvG26DsuJ6qpHSx7JiT6fp8HI2VnpK0+Sd/JLj/Sy6ZCYEq4JRXlJ
	cn4spYxdR2RcVFZHkGqVqX3Q/rFo6FRsdP2WC8HKGe5sV75WBblATEOmNx2n1Pm/
	E/KdwSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Pirs83
	M1biX53vcnFwGJTcOpMMR6sqYQiUMjRqZEITIyUMQob1ZkwEssBQzEqCQ9yzsbqm
	9UZROvudvsmh2leGSx5qxOBes+i+Y+Ukb0rb2YDThSzayGjXGP3WAzC0ib0CODu7
	6QkfSvUWvmhzynXaH7YVf36XFDdCwEXrfa5Ek=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F05E3B192;
	Mon, 15 Sep 2014 18:24:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB7513B191;
	Mon, 15 Sep 2014 18:24:43 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 17B0977E-3D27-11E4-A50F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257094>

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
2.1.0-410-gd72dacd
