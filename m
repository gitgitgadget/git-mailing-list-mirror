From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 18/22] send-pack: send feature request on push-cert packet
Date: Fri,  5 Sep 2014 13:55:06 -0700
Message-ID: <1409950510-10209-19-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:56:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0YZ-0006DI-8G
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbaIEUz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57413 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbaIEUzy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9DA7D366CF;
	Fri,  5 Sep 2014 16:55:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=IQHB
	Jlmzzv6VPqLC0vOVDnd1ne0=; b=xpTAJSTwsEjoD+0nW3AdTX/LyJIT2nRAS4wv
	VFX5yXYXG4rrhidVAhkh/IPrbmwJulgGCwGRfRzkOkUZGsJm0YVm3+8u8d4GskPi
	qbB2GaAWMx7KIYMuzZcM5Rm66hUhVbISy4oEyR7Ip+DBbhQWOt5aRs9NSTsCYoKo
	IRudjRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VY2veX
	6ej6jPBgrhExLJWxQMIBGDPVJuhxYB8gMIYc/qkJ2q1LK/haqcwR1/9UDYQg3pRY
	M9YlyjntgyLuFmAj7eknGbUbXFKXx19pH10I9ZnkzeP6COMOCiC7pEuT1qt0l7de
	ikqUKowIpkSdPjkiAAgIjaqwzB+Y9HeWBmQus=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9540E366CE;
	Fri,  5 Sep 2014 16:55:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17AA6366CB;
	Fri,  5 Sep 2014 16:55:53 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0631274C-353F-11E4-84E8-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256537>

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
 send-pack.c            | 13 ++++++++-----
 t/t5534-push-signed.sh | 13 +++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index ef93f33..d392f5b 100644
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
+	return update_seen;
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
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index ad004d4..e664110 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -67,6 +67,19 @@ test_expect_success 'push --sign fails with a receiver without push certificate
 	test_i18ngrep "the receiving end does not support" err
 '
 
+test_expect_success GPG 'no certificate for a signed push with no update' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi
+	EOF
+	git push dst noop &&
+	! test -f dst/push-cert
+'
+
 test_expect_success GPG 'signed push sends push certificate' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
-- 
2.1.0-399-g2df620b
