From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/5] gpg-interface: check good signature in a reliable way
Date: Thu, 14 Feb 2013 17:04:42 +0100
Message-ID: <e0f3c48e474c64e33c67c772468bbf7bba0169af.1360857415.git.git@drmicha.warpmail.net>
References: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
Cc: Mariusz Gronczewski <xani666@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 17:05:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61JD-0004kJ-1k
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761382Ab3BNQEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:04:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51944 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761317Ab3BNQEr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Feb 2013 11:04:47 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6D890209DE;
	Thu, 14 Feb 2013 11:04:46 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 14 Feb 2013 11:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=qX
	w8BBy0K5sQfTTMNS6mG/C6rqU=; b=FDXaSpzqphh9WHLU74WgudY8VhIkFVxENm
	4zktLugdvovl1On4pz72vJH7MDJi8Eiwsq17/3sOKHVooaGJ9v2/8WfNSlqDuN2S
	eYM5mI+iBgi2aQOclt86wAKuQ+IiJqtc9sEP955+da56yf657R1pn/IlJpgpqZel
	nix1QOrik=
X-Sasl-enc: yWIYL15BIyq6LRqfNEcRKwhMA/FVnPw3id0cyoh9QM1n 1360857886
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0D5F48E018E;
	Thu, 14 Feb 2013 11:04:45 -0500 (EST)
X-Mailer: git-send-email 1.8.1.3.797.ge0260c7
In-Reply-To: <CAJ9Ak2pLqUesOWKNtjwG7P_BW7-EqJP4Kaj0FF_+72Wn=oGoew@mail.gmail.com>
In-Reply-To: <cover.1360857415.git.git@drmicha.warpmail.net>
References: <cover.1360857415.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216315>

Currently, verify_signed_buffer() only checks the return code of gpg,
and some callers implement additional unreliable checks for "Good
signature" in the gpg output meant for the user.

Use the status output instead and parse for a line beinning with
"[GNUPG:] GOODSIG ". This is the only reliable way of checking for a
good gpg signature.

If needed we can change this easily to "[GNUPG:] VALIDSIG " if we want
to take into account the trust model.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 gpg-interface.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 4559033..c582b2e 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -96,15 +96,17 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 /*
  * Run "gpg" to see if the payload matches the detached signature.
  * gpg_output, when set, receives the diagnostic output from GPG.
+ * gpg_status, when set, receives the status output from GPG.
  */
 int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
 			 struct strbuf *gpg_output)
 {
 	struct child_process gpg;
-	const char *args_gpg[] = {NULL, "--verify", "FILE", "-", NULL};
+	const char *args_gpg[] = {NULL, "--status-fd=1", "--verify", "FILE", "-", NULL};
 	char path[PATH_MAX];
 	int fd, ret;
+	struct strbuf buf = STRBUF_INIT;
 
 	args_gpg[0] = gpg_program;
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
@@ -119,9 +121,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args_gpg;
 	gpg.in = -1;
+	gpg.out = -1;
 	if (gpg_output)
 		gpg.err = -1;
-	args_gpg[2] = path;
+	args_gpg[3] = path;
 	if (start_command(&gpg)) {
 		unlink(path);
 		return error(_("could not run gpg."));
@@ -134,9 +137,15 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 		strbuf_read(gpg_output, gpg.err, 0);
 		close(gpg.err);
 	}
+	strbuf_read(&buf, gpg.out, 0);
+	close(gpg.out);
+
 	ret = finish_command(&gpg);
 
 	unlink_or_warn(path);
 
+	ret |= !strstr(buf.buf, "\n[GNUPG:] GOODSIG ");
+	strbuf_release(&buf);
+
 	return ret;
 }
-- 
1.8.1.3.797.ge0260c7
