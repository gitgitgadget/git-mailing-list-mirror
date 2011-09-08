From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/2] push -s: send signed push certificate
Date: Wed, 07 Sep 2011 21:38:14 -0700
Message-ID: <7vehzrzm0e.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 06:38:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1WO5-0008CP-SF
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 06:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab1IHEip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 00:38:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab1IHEin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 00:38:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4781254BB;
	Thu,  8 Sep 2011 00:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=+LobPQahPJcpT3rGLRggTVeVEGY=; b=os5/MJhjRZMaX+SgagMJ
	cAWXnVbYYmNyHB3va1lvD2PexbGGylDHUWcArib/VFyg4goAPkA8MwAGANYtjlli
	Dc07AuNN2l5WfYUrYKW8jL4vmoBaFLIMA0tpCv+XeWDWQtuRjaHAzJ7HR9jxgwWy
	zwQUupu2qMiJ9omNO6CMCUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=F5UUEiB8/GlrJZFu7vgcS/Gq9PTu5KrbwJg/+//bcrdn9s
	GzfRACaps7qIYVSQlgoJ/xkiokhD4+0jZMsIjWBJXgIZ7+XQr+NX9aWeHQsby228
	D3y5bTqEwkwobtABHoUyIa3rDFZoUnPCLfXPmSGVVH/CX7SXHi/KCt5ihtxFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F24954BA;
	Thu,  8 Sep 2011 00:38:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C18E554B9; Thu,  8 Sep 2011
 00:38:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E4E64E4-D9D4-11E0-970C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180938>

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
index 3193f34..298e181 100644
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
@@ -370,7 +364,8 @@ int send_pack(struct send_pack_args *args,
 	if (signed_push) {
 		char *cp, *ep;
 
-		sign_push_certificate(&push_cert);
+		if (sign_push_certificate(&push_cert))
+			return error(_("failed to sign push certificate"));
 		strbuf_reset(&req_buf);
 		for (cp = push_cert.buf; *cp; cp = ep) {
 			ep = strchrnul(cp, '\n');
-- 
1.7.7.rc0.188.g3793ac
