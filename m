From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] push --signed: tighten what the receiving end can ask to sign
Date: Thu, 02 Apr 2015 15:09:15 -0700
Message-ID: <xmqqlhiagp2s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jann Horn <jann@thejh.net>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 00:09:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdnIh-0005Rc-8S
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 00:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbbDBWJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 18:09:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752324AbbDBWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 18:09:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A902442F0;
	Thu,  2 Apr 2015 18:09:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	1Kqq9O1yCX4OwTpYg4R7F/7mOs=; b=cgCKYDZwpQrVwGVb5j9bXEm9XTZaT79lR
	EUtvYdKn9lVdShwa2Yx95ppU5MEmChfwzL38M29041JGBbedmUm5QxRQucGTgDoN
	xnQNDlab9rNUrrncg/eGhDWkeLoOxGgXAvAdZm8Y3n6qkywaDWHhvEB0PdrdQFfQ
	dvwpmXxuy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=PilRKzVwWpLCccNTrRimZ3gjIWM2lidfVsn94ila/u+L2hS7LsGaMs8P
	ZdJpBkFb9TSTB90ExR4nWXpq2JnLOwkz9/pd4FHAuTDRMtR+r5tyPmJ+bVLAqn59
	NXCtua6yFOISwlJLukiV3ksgVZsX3QTQ6ceBI13eEmjnPE9lhy8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61F10442EF;
	Thu,  2 Apr 2015 18:09:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D951E442E8;
	Thu,  2 Apr 2015 18:09:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E764F1C8-D984-11E4-8608-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266686>

Instead of blindly trusting the receiving side to give us a sensible
nonce to sign, limit the length (max 256 bytes) and the alphabet
(alnum and a few selected punctuations, enough to encode in base64)
that can be used in nonce.

Noticed-by: Jann Horn <jann@thejh.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 7ad1a59..2249808 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -279,6 +279,28 @@ free_return:
 	return update_seen;
 }
 
+#define NONCE_LEN_LIMIT 256
+
+static void reject_invalid_nonce(const char *nonce, int len)
+{
+	int i = 0;
+
+	if (NONCE_LEN_LIMIT <= len)
+		die("the receiving end asked to sign an invalid nonce <%.*s>",
+		    len, nonce);
+
+	for (i = 0; i < len; i++) {
+		int ch = nonce[i] & 0xFF;
+		if (isalnum(ch) ||
+		    ch == '-' || ch == '.' ||
+		    ch == '/' || ch == '+' ||
+		    ch == '=' || ch == '_')
+			continue;
+		die("the receiving end asked to sign an invalid nonce <%.*s>",
+		    len, nonce);
+	}
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -321,6 +343,7 @@ int send_pack(struct send_pack_args *args,
 		push_cert_nonce = server_feature_value("push-cert", &len);
 		if (!push_cert_nonce)
 			die(_("the receiving end does not support --signed push"));
+		reject_invalid_nonce(push_cert_nonce, len);
 		push_cert_nonce = xmemdupz(push_cert_nonce, len);
 	}
 
-- 
2.4.0-rc1-147-g8712228
