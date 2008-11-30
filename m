From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] upload-pack: implement protocol extension "symbolic-ref"
Date: Sun, 30 Nov 2008 01:57:29 -0800
Message-ID: <1228039053-31099-2-git-send-email-gitster@pobox.com>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 10:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6j5P-00010i-LM
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 10:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbYK3J54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbYK3J5z
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:57:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbYK3J5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:57:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 30D5B82470
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 04:57:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 467248246E for
 <git@vger.kernel.org>; Sun, 30 Nov 2008 04:57:47 -0500 (EST)
X-Mailer: git-send-email 1.6.0.4.850.g6bd829
In-Reply-To: <1228039053-31099-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5B601968-BEC5-11DD-BF90-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101953>

This extends the fetch-pack protocol to allow the receiving end to ask
which actual ref each symbolic ref points at.

Although the new capability is advertised on the first available ref in
the same way as the other extensions, the way to trigger this extension
from the receiving end is not by adding it in the first "want" line as
usual.  Instead, the receiving end sends a "symbolic-ref" request packet
before the usual sequence of "want" lines.

This is unfortunate because it forces an extra round trip (receiving end
sends a "please tell me symbolic-ref" packet, and then upload side sends
"here are the requested information" packet), but it has to be implemented
this way because (1) ls-remote may need to ask for this information, in
which case there is no "want" to be sent; and (2) the transport API
insists that transport_get_remote_refs() returns the final list, and does
not allow augmenting what was initially obtained from the call to it by
later calls to transport_fetch_refs() easily.

It also is unfortunate that with this change on the server side, older
clients running "ls-remote" without actually downloading anything will
trigger "The remote end hung up unexpectedly" error on the uploading side,
which is annoying even though it is benign.  You can observe it by applying
only this patch but not the patch to the receiving end and running t5601
under "sh -x".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4029019..a925f69 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -494,6 +494,23 @@ static void exchange_shallows(int depth, struct object_array *shallows)
 		}
 }
 
+static int one_symref_info(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	if ((flag & REF_ISSYMREF)) {
+		unsigned char dummy[20];
+		const char *target = resolve_ref(refname, dummy, 0, NULL);
+		packet_write(1, "symref %s %s", refname, target);
+	}
+	return 0;
+}
+
+static void send_symref_info(void)
+{
+	head_ref(one_symref_info, NULL);
+	for_each_ref(one_symref_info, NULL);
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows = {0, 0, NULL};
@@ -502,11 +519,29 @@ static void receive_needs(void)
 
 	if (debug_fd)
 		write_in_full(debug_fd, "#S\n", 3);
-	for (;;) {
+
+	/*
+	 * This is very unfortunate, but the "transport" abstraction
+	 * is screwed up and insists that getting the list of refs
+	 * to finish before actually sending the "needs" list from
+	 * the client end.
+	 */
+	len = packet_read_line(0, line, sizeof(line));
+	if (len) {
+		if (!prefixcmp(line, "symbolic-ref")) {
+			reset_timeout();
+			send_symref_info();
+			len = 0;
+		}
+	}
+	for (;; len = 0) {
 		struct object *o;
 		unsigned char sha1_buf[20];
-		len = packet_read_line(0, line, sizeof(line));
-		reset_timeout();
+
+		if (!len) {
+			len = packet_read_line(0, line, sizeof(line));
+			reset_timeout();
+		}
 		if (!len)
 			break;
 		if (debug_fd)
@@ -577,7 +612,7 @@ static void receive_needs(void)
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress"
+		" side-band-64k ofs-delta shallow no-progress symbolic-ref"
 		" include-tag";
 	struct object *o = parse_object(sha1);
 
-- 
1.6.0.4.850.g6bd829
