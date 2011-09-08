From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] push -s: send signed push certificate
Date: Thu,  8 Sep 2011 13:01:39 -0700
Message-ID: <1315512102-19022-5-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nXK-0005F6-4y
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab1IHW45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab1IHW4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 710D0464A
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=33/m
	C3ui5pZNt9dWRdITibXrxls=; b=c1dotET3BicOaBN2NZsNGRYlfHEsu31n0mv2
	nh0eBMKcXczvTH2sSVGjRuRO2y307whW2vOyC6OBDDoFfBe6SKZbu/elZ8AR9A9c
	/8CXTTuwEdlTImPZg2Q0ado4pi4/U9vvfP8OLwr3QL+gZFVzJ+sBEs1tSkDdEoib
	uXtUYZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qrYRUD
	V5v1y3sI2HOaMOBDGh+5c5ArepWpD+47KoGpagGZIu0fTM9/ytlN3ebXyf0/PwBE
	+qkijg0TVFm3BiqQn4CauO0VKpKpMlPFji8XK8OotYZUZ98Nob2cwOTKVkwpUPYP
	hyq1VgQaMpT4PGAeJTfc/z2+G4wq4MOXgUQJ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B884649
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED9F34647 for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 64D4607C-DA55-11E0-AC1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180987>

And this uses the GPG interface to sign the push certificate. The format
of the signed certificate is very similar to a signed tag, in that the
result is a concatenation of the payload, immediately followed by a
detached signature.

This places the same constraint as an annotated tag on the push
certificate payload; it has to be a text file and the final line
must not be an incomplete line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7f4778c..f715324 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -8,6 +8,7 @@
 #include "send-pack.h"
 #include "quote.h"
 #include "transport.h"
+#include "gpg-interface.h"
 
 static const char send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -237,25 +238,18 @@ static int sideband_demux(int in, int out, void *data)
 	return ret;
 }
 
-static void sign_push_certificate(struct strbuf *cert)
+/*
+ * Take the contents of cert->buf, and have the user GPG sign it, and
+ * read it back in the strbuf.
+ */
+static int sign_push_certificate(struct strbuf *cert)
 {
 	/*
-	 * Here, take the contents of cert->buf, and have the user GPG
-	 * sign it, and read it back in the strbuf.
-	 *
-	 * You may want to append some extra info to cert before giving
-	 * it to GPG, possibly via a hook.
-	 *
-	 * Here we upcase them just to demonstrate that the codepath
-	 * is being exercised.
+	 * You may want to append some extra info to cert before
+	 * giving it to GPG, possibly via a hook, here.
 	 */
-	char *cp;
-	for (cp = cert->buf; *cp; cp++) {
-		int ch = *cp;
-		if ('a' <= ch && ch <= 'z')
-			*cp = toupper(ch);
-	}
-	return;
+
+	return sign_buffer(cert, git_committer_info(IDENT_NO_DATE));
 }
 
 int send_pack(struct send_pack_args *args,
@@ -369,7 +363,8 @@ int send_pack(struct send_pack_args *args,
 	if (signed_push && cmds_sent) {
 		char *cp, *ep;
 
-		sign_push_certificate(&push_cert);
+		if (sign_push_certificate(&push_cert))
+			return error(_("failed to sign push certificate"));
 		strbuf_reset(&req_buf);
 		for (cp = push_cert.buf; *cp; cp = ep) {
 			ep = strchrnul(cp, '\n');
-- 
1.7.7.rc0.188.g3793ac
