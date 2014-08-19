From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/18] signed push: final protocol update
Date: Tue, 19 Aug 2014 15:06:27 -0700
Message-ID: <1408485987-3590-19-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrbC-0006ya-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaHSWJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:09:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51397 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbaHSWJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16318331B8;
	Tue, 19 Aug 2014 18:09:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rUOw
	FjgWrPoeFooeqvK7L4Ehu+M=; b=aTsZoJy1luVda1GRNlZ9uOZryieOOhHjhQtS
	eueKhVapg2an1M4Ahtd/oArBYyAr9UgTcSVpt7Ebitsu277lgqKVB6zG4YNKBvIs
	LK5N+/eUn07wry55VpKHVa5aBo0bRRfQQN/dU89F5mhaV+z6StF085ubtMLTdrEW
	HhkQKI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=iDiJBz
	Qigo18p59a+iWmclr6AJEMkfPqbHnPil05g2YIfdqJow6MPYL3cWU52KivyCor5z
	cT88KK45mKZXyhuzrMuRyo0xpvlPRMg7xIrz6SG6IRHQj9uZJfSE/t5vrKCaWm86
	ozr1mOWDXwwxCEHtFMzrImRgKh5SVQuDa3MbI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CD5E331B7;
	Tue, 19 Aug 2014 18:09:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 00B61331A0;
	Tue, 19 Aug 2014 18:09:23 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7A466DD6-27ED-11E4-A531-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255537>

With the interim protocol, we used to send the update commands even
though we already send a signed copy of the same information when
push certificate is in use.  Update the send-pack/receive-pack pair
not to do so.

The notable thing on the receive-pack side is that it makes sure
that there is no command sent over the traditional protocol packet
outside the push certificate.  Otherwise a pusher can claim to be
pushing one set of ref updates in the signed certificate while
issuing commands to update unrelated refs, and such an update will
evade later audits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt         | 20 ++++++++++++++++-
 Documentation/technical/protocol-capabilities.txt | 12 +++++++++--
 builtin/receive-pack.c                            | 26 +++++++++++++++++++++++
 send-pack.c                                       |  2 +-
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index a845d51..f6c3073 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -465,7 +465,7 @@ contain all the objects that the server will need to complete the new
 references.
 
 ----
-  update-request    =  *shallow command-list [pack-file]
+  update-request    =  *shallow ( command-list | push-cert ) [pack-file]
 
   shallow           =  PKT-LINE("shallow" SP obj-id)
 
@@ -481,12 +481,30 @@ references.
   old-id            =  obj-id
   new-id            =  obj-id
 
+  push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
+		      PKT-LINE("certificate version 0.1" LF)
+		      PKT-LINE("pusher" ident LF)
+		      PKT-LINE(LF)
+		      *PKT-LINE(command LF)
+		      *PKT-LINE(GPG signature lines LF)
+		      PKT-LINE("push-cert-end" LF)
+
   pack-file         = "PACK" 28*(OCTET)
 ----
 
 If the receiving end does not support delete-refs, the sending end MUST
 NOT ask for delete command.
 
+If the receiving end does not support push-cert, the sending end MUST
+NOT send a push-cert command.
+
+When a push-cert command is sent, command-list MUST NOT be sent; the
+commands recorded in the push certificate is used instead.  The GPG
+signature lines are detached signature for the contents recorded in
+the push certificate before the signature block begins and is used
+to certify that the commands were given by the pusher which must be
+the signer.
+
 The pack-file MUST NOT be sent if the only command used is 'delete'.
 
 A pack-file MUST be sent if either create or update command is used,
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index e174343..5b398e9 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -18,8 +18,8 @@ was sent.  Server MUST NOT ignore capabilities that client requested
 and server advertised.  As a consequence of these rules, server MUST
 NOT advertise capabilities it does not understand.
 
-The 'report-status', 'delete-refs', and 'quiet' capabilities are sent and
-recognized by the receive-pack (push to server) process.
+The 'report-status', 'delete-refs', 'quiet', and 'push-cert' capabilities
+are sent and recognized by the receive-pack (push to server) process.
 
 The 'ofs-delta' and 'side-band-64k' capabilities are sent and recognized
 by both upload-pack and receive-pack protocols.  The 'agent' capability
@@ -250,3 +250,11 @@ allow-tip-sha1-in-want
 If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
+
+push-cert
+---------
+
+The receive-pack server that advertises this capability is willing
+to accept a signed push certificate.  A send-pack client MUST NOT
+send push-cert packet unless the receive-pack server advertises this
+capability.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index abdc296..96e4c99 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -907,6 +907,28 @@ static struct command **queue_command(struct command **p,
 	return &cmd->next;
 }
 
+static void queue_commands_from_cert(struct command **p,
+				     struct strbuf *push_cert)
+{
+	const char *boc, *eoc;
+
+	if (*p)
+		die("protocol error: got both push certificate and unsigned commands");
+
+	boc = strstr(push_cert->buf, "\n\n");
+	if (!boc)
+		die("malformed push certificate %.*s", 100, push_cert->buf);
+	else
+		boc += 2;
+	eoc = push_cert->buf + parse_signature(push_cert->buf, push_cert->len);
+
+	while (boc < eoc) {
+		const char *eol = memchr(boc, '\n', eoc - boc);
+		p = queue_command(p, boc, eol ? eol - boc : eoc - eol);
+		boc = eol ? eol + 1 : eoc;
+	}
+}
+
 static struct command *read_head_info(struct sha1_array *shallow)
 {
 	struct command *commands = NULL;
@@ -962,6 +984,10 @@ static struct command *read_head_info(struct sha1_array *shallow)
 
 		p = queue_command(p, line, linelen);
 	}
+
+	if (push_cert.len)
+		queue_commands_from_cert(p, &push_cert);
+
 	return commands;
 }
 
diff --git a/send-pack.c b/send-pack.c
index 2de9826..ca2ae2b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -365,7 +365,7 @@ int send_pack(struct send_pack_args *args,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *old_hex, *new_hex;
 
-		if (args->dry_run)
+		if (args->dry_run || args->push_cert)
 			continue;
 
 		if (!ref_update_to_be_sent(ref, args))
-- 
2.1.0-301-g54593e2
