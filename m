From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/21] receive-pack: factor out capability string generation
Date: Thu,  4 Sep 2014 13:04:45 -0700
Message-ID: <1409861097-19151-10-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHu-0000jh-0v
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbaIDUFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57685 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396AbaIDUFj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32F38381B3;
	Thu,  4 Sep 2014 16:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WUhX
	GwDe7FUYgEAD7/POboEF6Ig=; b=e5J75oTYDvEF08hJTUwcJF5XTWuiJtVNxma5
	ksCYF1zU8jNs15mR35y6zpWrJNbZ4bxyZfMVKDoIXdaeQaVZZcxusLwrfOoZjWR5
	FumPoa9CYiW4XSVXK9TX6S7xZLYelUkn2LjZqHNB88qfrJxepPG8SNnIWan3O0Ve
	j+vmGZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oj8dBf
	atfxZcKiutRxqkt4hts/NPISJHiJc8dtv75DFJnuqFQRcuQrciIZixQn/IhbfDfS
	RgWNi3h8F1bj8Gu1gEgYqWBZPZWgp3iVnoOnA6vBqNBOUbHS3wORMsM5HgBAqepE
	46TRtW1f8V6ZxkqsyEc7Uw8bI0JuWNgg+g/eM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94872381AF;
	Thu,  4 Sep 2014 16:05:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 222BA38198;
	Thu,  4 Sep 2014 16:05:32 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D32648BC-346E-11E4-93B9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256469>

Similar to the previous one for send-pack, make it easier and
cleaner to add to capability advertisement.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 341bb46..9c39fb7 100644
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
2.1.0-399-g1364b4d
