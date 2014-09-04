From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/21] signed push: remove duplicated protocol info
Date: Thu,  4 Sep 2014 13:04:55 -0700
Message-ID: <1409861097-19151-20-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:06:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ4-0001FP-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbaIDUGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:06:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56723 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755418AbaIDUGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:06:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 639863820A;
	Thu,  4 Sep 2014 16:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qtLl
	eRp6+T6EdFS1KB6+w+HnAvI=; b=XIMdbTWmcVr1KXkMPUfmGiN8vi8t+7k9AntP
	gSzEzARz2jycirlIjcRUGWpY7uXyvYuxd1w4gZIhpyT5gMYhJ1t/BXvmF4L7B2CQ
	vb+m7OksMI7fuGJlVgYfQtWCHj8cDqo3tUYNRu8sJHA+mevr0W3hdrGbglnkEkMe
	FDuCKIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MZMQr1
	H2VhHTGZG2CK3/Jw/GuQlK3OFp2JV26Kgn1+hRR47eqWMX3qulDQi7oEpswmCUZB
	F8qyda3EaLw+e6FGLccTJINXUmH5czHqNUHbe9sOXtASk966lu68brpdwBpViXco
	h+aK642zdFenYAvExpHshO09snm/etIMsh2so=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53C8938208;
	Thu,  4 Sep 2014 16:06:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91449381F0;
	Thu,  4 Sep 2014 16:06:03 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E5E8664C-346E-11E4-A22E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256471>

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
 builtin/receive-pack.c                            | 30 +++++++++++++++++++--
 send-pack.c                                       |  2 +-
 4 files changed, 71 insertions(+), 6 deletions(-)

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
index bfd078c..2d93c87 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -899,7 +899,7 @@ static void execute_commands(struct command *commands,
 		      "the reported refs above");
 }
 
-static struct command **queue_command(struct command **p,
+static struct command **queue_command(struct command **tail,
 				      const char *line,
 				      int linelen)
 {
@@ -922,10 +922,32 @@ static struct command **queue_command(struct command **p,
 	hashcpy(cmd->new_sha1, new_sha1);
 	memcpy(cmd->ref_name, refname, reflen);
 	cmd->ref_name[reflen] = '\0';
-	*p = cmd;
+	*tail = cmd;
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
index 4125892..61f321d 100644
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
2.1.0-399-g1364b4d
