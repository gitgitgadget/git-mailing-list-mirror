From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/21] send-pack: send feature request on push-cert packet
Date: Thu,  4 Sep 2014 13:04:54 -0700
Message-ID: <1409861097-19151-19-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ5-0001FP-3K
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbaIDUGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:06:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51214 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbaIDUGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:06:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4894838203;
	Thu,  4 Sep 2014 16:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TIFH
	INlc0WDldj6NgBJZ+NfTwkQ=; b=f/6TS8BsEKHZedx0JbS74SySiQCG/iGHLpEL
	GBCai0TfLBpRBXMmi6fBN+OUPS/4qFkAOQYUjeZkPaiOyvdnZYgOMRD5cukxBghV
	IrJqVIhU2MGWavapmwq9HAr1ODaL9B66oQCnXgADlZIiUOyEg4afsTxDzYOw8rDC
	c3VJlnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FB+TIo
	dj0hylFEkqmSeDUibyakb20FShSNFB2vQ1E2/VY9Fr7t3JaycQFM+dso5L5IjiT7
	5ELFSaeynSwBVcJtMuLANPMvm9Quf/utI7FAmB9J+S/UlxjY0gE5LFYLLJNBaPHk
	oonjzm1Ml1fuxLPaHIpUm7d1xI9uOQCQ3F3C4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 381CD38202;
	Thu,  4 Sep 2014 16:06:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D4690381EA;
	Thu,  4 Sep 2014 16:05:58 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E31A7EA0-346E-11E4-94F4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256479>

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
2.1.0-399-g1364b4d
