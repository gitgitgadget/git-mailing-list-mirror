From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] push -s: support pre-receive-signature hook
Date: Thu,  8 Sep 2011 13:01:42 -0700
Message-ID: <1315512102-19022-8-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 00:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nXL-0005F6-Kb
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab1IHW47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:56:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab1IHW4n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:56:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D25F9465E
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=PkxG
	S8qiLT+gZ4eKQKMDvp/Ob14=; b=GsduB/fbWPWi7CQSe7i9QU5DgA9PYYNJwKNg
	jfWTHc3ATZcalEGa7ah/XU6HTzKkF41BNH+qDs4KNWveuVdb1WbkK4VjyLpCZ6kH
	jSFfZTKHH4Ad3rYiYNtfhgW/rHTk6WaGdsfo+t/4Xmj78ghQ+DurlBIksyaX7IJp
	ov11UpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ojrtxq
	HpWcUQTIMKTsfcRFh7ZowGvt+NYccQ0+edrDiWw9yYZ1ZzcQsDlvBws1d9GlceA2
	sjv1Ljk6xHXHP2M3OjZ9Z/gvgpA8yZGLlD1G1N37Ho5i4WgQFQ5E5GCptVRFjnMy
	/b3kptr4iQJ9iOszINf8uuLOcAouYIJI7xr94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAAB4465A
	for <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A4884659 for
 <git@vger.kernel.org>; Thu,  8 Sep 2011 16:01:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315512102-19022-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 68A44708-DA55-11E0-8758-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180985>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 939b867..b5a54e7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -303,6 +303,27 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	return status;
 }
 
+static int feed_signature_hook(void *state_, const char **bufp, size_t *sizep)
+{
+	const char **cert_p = state_;
+
+	if (!*cert_p)
+		return -1; /* EOF */
+	*bufp = *cert_p;
+	*cert_p = NULL; /* just return once */
+	*sizep = strlen(*bufp);
+	return 0;
+}
+
+static int run_receive_signature_hook(const char *cert)
+{
+	static const char hook[] = "hooks/pre-receive-signature";
+
+	if (!cert)
+		return 0;
+	return run_and_feed_hook(hook, feed_signature_hook, &cert);
+}
+
 static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
@@ -642,10 +663,6 @@ static int record_signed_push(char *cert)
 	 * certificate, grab the commit object names the push updates
 	 * refs to, and append the certificate to the notes to these
 	 * commits.
-	 *
-	 * You could also feed the signed push certificate to GPG,
-	 * verify the signer identity, and all the other fun stuff,
-	 * including feeding it to "pre-receive-signature" hook.
 	 */
 	size_t total, payload;
 	char *cp, *ep;
@@ -714,6 +731,12 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
 		return;
 	}
 
+	if (run_receive_signature_hook(push_certificate)) {
+		for (cmd = commands; cmd; cmd = cmd->next)
+			cmd->error_string = "n/a (pre-receive-signature hook declined)";
+		return;
+	}
+
 	if (record_signed_push(push_certificate)) {
 		for (cmd = commands; cmd; cmd = cmd->next)
 			cmd->error_string = "n/a (push signature error)";
-- 
1.7.7.rc0.188.g3793ac
