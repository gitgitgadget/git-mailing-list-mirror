From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/19] send-pack: send feature request on push-cert packet
Date: Fri, 22 Aug 2014 13:30:22 -0700
Message-ID: <1408739424-31429-18-git-send-email-gitster@pobox.com>
References: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvWq-0000Qq-TP
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaHVUdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:33:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51443 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaHVUdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:33:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0257C33267;
	Fri, 22 Aug 2014 16:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ST3O
	7LEUc5HMkJLhhfX4nDR2ok4=; b=ggCPCFViZ9ObMTf8bpk3Y+FqKULwQyAs51tx
	bxUMMgwcuv/KFm825tYc3NBJyEU48eQDx7/2blDuAuv0zyIOVppr9PUCNdSLZmZj
	m+9TcHq2Xj6cmHSXQTzC0/phgmfWtZu6igLh9yhn4Jxin/gu/hkW4w1P4UavaDwB
	6GnWY34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZRyDlm
	Zm5NOQnMzFgTEa6beSlZkW8KSyM82WoqPYcnWba1AXPyI2ogiVsT6ZVU0x2YbpB1
	HPJTd4W0uH3CgIfNpjkxK+yqYDW4z02nq1m2Lk5A61qwr8cPdJO2eagStPzU97vA
	po8LWlAuBne4iXI2EiJQwQO0ecOQbpvXTij0c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB04E33266;
	Fri, 22 Aug 2014 16:33:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BDFBF3325F;
	Fri, 22 Aug 2014 16:33:23 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
In-Reply-To: <1408739424-31429-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 902704A8-2A3B-11E4-B9A4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255717>

We would want to update the interim protocol so that we do not send
the usual update commands when the push certificate feature is in
use, as the same information is in the certificate.  Once that
happens, the push-cert packet may become the only protocol command,
but then there is no packet to put the feature request behind, like
we always did.

As we have prepared the receiving end that understands the push-cert
feature to accept the feature request on the first protocol packet
(other than "shallow ", which was an unfortunate historical mistake
that has to come before everything else), we can give the feature
request on the push-cert packet instead of the first update protocol
packet, in preparation for the next step to actually update to the
final protocol.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 10c907f..4125892 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -225,9 +225,10 @@ static const char *next_line(const char *line, size_t len)
 	return nl + 1;
 }
 
-static void generate_push_cert(struct strbuf *req_buf,
-			       const struct ref *remote_refs,
-			       struct send_pack_args *args)
+static int generate_push_cert(struct strbuf *req_buf,
+			      const struct ref *remote_refs,
+			      struct send_pack_args *args,
+			      const char *cap_string)
 {
 	const struct ref *ref;
 	char stamp[60];
@@ -256,7 +257,7 @@ static void generate_push_cert(struct strbuf *req_buf,
 	if (sign_buffer(&cert, &cert, signing_key))
 		die(_("failed to sign the push certificate"));
 
-	packet_buf_write(req_buf, "push-cert\n");
+	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
 	for (cp = cert.buf; cp < cert.buf + cert.len; cp = np) {
 		np = next_line(cp, cert.buf + cert.len - cp);
 		packet_buf_write(req_buf,
@@ -267,6 +268,7 @@ static void generate_push_cert(struct strbuf *req_buf,
 free_return:
 	free(signing_key);
 	strbuf_release(&cert);
+	return 1;
 }
 
 int send_pack(struct send_pack_args *args,
@@ -335,7 +337,8 @@ int send_pack(struct send_pack_args *args,
 		advertise_shallow_grafts_buf(&req_buf);
 
 	if (!args->dry_run && args->push_cert)
-		generate_push_cert(&req_buf, remote_refs, args);
+		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
+					       cap_buf.buf);
 
 	/*
 	 * Clear the status for each ref and see if we need to send
-- 
2.1.0-304-g950f846
