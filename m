From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/21] signed push: add "pushee" header to push certificate
Date: Thu,  4 Sep 2014 13:04:56 -0700
Message-ID: <1409861097-19151-21-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ6-0001FP-3i
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbaIDUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:06:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60612 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755428AbaIDUGN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:06:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE44C3820F;
	Thu,  4 Sep 2014 16:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=b4uL
	uRfuVXU9UJ+WSV3LBF+f154=; b=RyZPB5khanJQRPkN5uKZ1FJYY64uK1wvUmkm
	12rraNkzy2Sm+W0Q3dHRhNAvlZbWYxhW3+XJKSNMXNGIhv1XZHyyo29FeWqHpCMf
	CSaZFd0xR5J2hNPc2ujkItEmTBbZM4YWUm12yatiNJwT5xTEh1tNoAovjfgbRsRm
	5MY3Tc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QYi56s
	13CohQJyKSocgJGkzH5rxn+HyZxpzN1awu56qU3JeCrFfUP6cZiBVO98eWTOCNXi
	xXdhDFRgelX830NzS4YiydGaRk7N9vls2JaqfqAC8zjHrwJLh49iL0ocvN7fdOKH
	02eJqGfjJ772YkbRs7503vVt4eIQRuQLf3ONc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C76923820E;
	Thu,  4 Sep 2014 16:06:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2B0C1381FD;
	Thu,  4 Sep 2014 16:06:06 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E76FCB36-346E-11E4-ADEE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256473>

Record the URL of the intended recipient for a push (after
anonymizing it if it has authentication material) on a new "pushee
URL" header.  Because the networking configuration (SSH-tunnels,
proxies, etc.) on the pushing user's side varies, the receiving
repository may not know the single canonical URL all the pushing
users would refer it as (besides, many sites allow pushing over
ssh://host/path and https://host/path protocols to the same
repository but with different local part of the path).  So this
value may not be reliably used for replay-attack prevention
purposes, but this will still serve as a human readable hint to
identify the repository the certificate refers to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt | 6 ++++++
 send-pack.c                               | 5 +++++
 send-pack.h                               | 1 +
 transport.c                               | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 4a5c2e8..7b543dc 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -484,6 +484,7 @@ references.
   push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
 		      PKT-LINE("certificate version 0.1" LF)
 		      PKT-LINE("pusher" SP ident LF)
+		      PKT-LINE("pushee" SP url LF)
 		      PKT-LINE(LF)
 		      *PKT-LINE(command LF)
 		      *PKT-LINE(gpg-signature-lines LF)
@@ -527,6 +528,11 @@ Currently, the following header fields are defined:
 	Identify the GPG key in "Human Readable Name <email@address>"
 	format.
 
+`pushee` url::
+	The repository URL (anonymized, if the URL contains
+	authentication material) the user who ran `git push`
+	intended to push into.
+
 The GPG signature lines are a detached signature for the contents
 recorded in the push certificate before the signature block begins.
 The detached signature is used to certify that the commands were
diff --git a/send-pack.c b/send-pack.c
index 61f321d..642ebc8 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -240,6 +240,11 @@ static int generate_push_cert(struct strbuf *req_buf,
 	datestamp(stamp, sizeof(stamp));
 	strbuf_addf(&cert, "certificate version 0.1\n");
 	strbuf_addf(&cert, "pusher %s %s\n", signing_key, stamp);
+	if (args->url && *args->url) {
+		char *anon_url = transport_anonymize_url(args->url);
+		strbuf_addf(&cert, "pushee %s\n", anon_url);
+		free(anon_url);
+	}
 	strbuf_addstr(&cert, "\n");
 
 	for (ref = remote_refs; ref; ref = ref->next) {
diff --git a/send-pack.h b/send-pack.h
index 3555d8e..5635457 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -2,6 +2,7 @@
 #define SEND_PACK_H
 
 struct send_pack_args {
+	const char *url;
 	unsigned verbose:1,
 		quiet:1,
 		porcelain:1,
diff --git a/transport.c b/transport.c
index 07fdf86..1df1375 100644
--- a/transport.c
+++ b/transport.c
@@ -827,6 +827,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
 	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
+	args.url = transport->url;
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
-- 
2.1.0-399-g1364b4d
