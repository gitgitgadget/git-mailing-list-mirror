From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 19/23] signed push: remove duplicated protocol info
Date: Mon, 15 Sep 2014 15:24:20 -0700
Message-ID: <1410819864-22967-20-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehx-0006V4-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005AbaIOWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:25:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58919 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758728AbaIOWZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:25:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBFC13B1D2;
	Mon, 15 Sep 2014 18:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1J5s
	96LTjRsoaFeNyy8wd/3J7BA=; b=Eg2ocJNav69ndIFd8dJzHowZihMhTP1NW0mE
	Afi70Krd+RTkt06rxl4a/WM8/P/xz9P3np0JjjmGnpQpA/J29bVvmC3eA+K//uvB
	rJT/D0xgf8K8TWSvJuAjNeMzeu9rpzJKXOhewSHz92p/U6QOhNZ1WSsxmSbV9lBa
	IoHtNqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vPq89p
	g4ekNBE9LthDPIURTO3OjUOoCK9jcJtjwjYOI2h4zZSAVMM7He6gT4Hz2XvsjkN/
	L0BvNjVAXNqa0dJ7YRsTa418MVX7o+5S5Nf0wGEnx75J8jV2DnrOrVMicu1aHoJ+
	KBE999F5UmXJUYzKzRkU3KUewhB9u2+wGEW2Q=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B38223B1D1;
	Mon, 15 Sep 2014 18:25:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C7B83B1D0;
	Mon, 15 Sep 2014 18:25:03 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 23BD5E1C-3D27-11E4-A847-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257102>

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

Finally, start documenting the protocol.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt         | 33 ++++++++++++++++++++++-
 Documentation/technical/protocol-capabilities.txt | 12 +++++++--
 builtin/receive-pack.c                            | 26 ++++++++++++++++++
 send-pack.c                                       |  2 +-
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index a845d51..4a5c2e8 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -465,7 +465,7 @@ contain all the objects that the server will need to complete the new
 references.
 
 ----
-  update-request    =  *shallow command-list [pack-file]
+  update-request    =  *shallow ( command-list | push-cert ) [pack-file]
 
   shallow           =  PKT-LINE("shallow" SP obj-id)
 
@@ -481,12 +481,25 @@ references.
   old-id            =  obj-id
   new-id            =  obj-id
 
+  push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
+		      PKT-LINE("certificate version 0.1" LF)
+		      PKT-LINE("pusher" SP ident LF)
+		      PKT-LINE(LF)
+		      *PKT-LINE(command LF)
+		      *PKT-LINE(gpg-signature-lines LF)
+		      PKT-LINE("push-cert-end" LF)
+
   pack-file         = "PACK" 28*(OCTET)
 ----
 
 If the receiving end does not support delete-refs, the sending end MUST
 NOT ask for delete command.
 
+If the receiving end does not support push-cert, the sending end
+MUST NOT send a push-cert command.  When a push-cert command is
+sent, command-list MUST NOT be sent; the commands recorded in the
+push certificate is used instead.
+
 The pack-file MUST NOT be sent if the only command used is 'delete'.
 
 A pack-file MUST be sent if either create or update command is used,
@@ -501,6 +514,24 @@ was being processed (the obj-id is still the same as the old-id), and
 it will run any update hooks to make sure that the update is acceptable.
 If all of that is fine, the server will then update the references.
 
+Push Certificate
+----------------
+
+A push certificate begins with a set of header lines.  After the
+header and an empty line, the protocol commands follow, one per
+line.
+
+Currently, the following header fields are defined:
+
+`pusher` ident::
+	Identify the GPG key in "Human Readable Name <email@address>"
+	format.
+
+The GPG signature lines are a detached signature for the contents
+recorded in the push certificate before the signature block begins.
+The detached signature is used to certify that the commands were
+given by the pusher, who must be the signer.
+
 Report Status
 -------------
 
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index e174343..a478cc4 100644
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
+send a push-cert packet unless the receive-pack server advertises
+this capability.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c0a3189..431af39 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -926,6 +926,28 @@ static struct command **queue_command(struct command **tail,
 	return &cmd->next;
 }
 
+static void queue_commands_from_cert(struct command **tail,
+				     struct strbuf *push_cert)
+{
+	const char *boc, *eoc;
+
+	if (*tail)
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
+		tail = queue_command(tail, boc, eol ? eol - boc : eoc - eol);
+		boc = eol ? eol + 1 : eoc;
+	}
+}
+
 static struct command *read_head_info(struct sha1_array *shallow)
 {
 	struct command *commands = NULL;
@@ -981,6 +1003,10 @@ static struct command *read_head_info(struct sha1_array *shallow)
 
 		p = queue_command(p, line, linelen);
 	}
+
+	if (push_cert.len)
+		queue_commands_from_cert(p, &push_cert);
+
 	return commands;
 }
 
diff --git a/send-pack.c b/send-pack.c
index d392f5b..857beb3 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -363,7 +363,7 @@ int send_pack(struct send_pack_args *args,
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *old_hex, *new_hex;
 
-		if (args->dry_run)
+		if (args->dry_run || args->push_cert)
 			continue;
 
 		if (!ref_update_to_be_sent(ref, args))
-- 
2.1.0-410-gd72dacd
