From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon,  1 Dec 2008 06:12:54 -0800
Message-ID: <1228140775-29212-6-git-send-email-gitster@pobox.com>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
 <1228140775-29212-4-git-send-email-gitster@pobox.com>
 <1228140775-29212-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:15:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79YG-0007w7-SQ
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbYLAONk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYLAONk
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbYLAONj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 694B617DAA
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D268817DA6 for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:34 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
In-Reply-To: <1228140775-29212-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4042E44C-BFB2-11DD-B7C5-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102044>

This implements the server side of protocol extension to show which branch
the HEAD points at.  The information is sent after the terminating NUL
that comes after the server capabilities list, to cause older clients to
ignore it, while allowing newer clients to make use of that information

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..4aa444a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -579,9 +579,17 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 
-	if (capabilities)
-		packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
-			0, capabilities);
+	if (capabilities) {
+		unsigned char dummy[20];
+		const char *target = resolve_ref("HEAD", dummy, 0, NULL);
+
+		if (!target)
+			packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname,
+				     0, capabilities);
+		else
+			packet_write(1, "%s %s%c%s%c%s\n", sha1_to_hex(sha1), refname,
+				     0, capabilities, 0, target);
+	}
 	else
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname);
 	capabilities = NULL;
-- 
1.6.0.4.864.g0f47a
