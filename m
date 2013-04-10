From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] transport-helper: mention helper name when it dies
Date: Wed, 10 Apr 2013 17:16:03 -0400
Message-ID: <20130410211603.GB3256@sigill.intra.peff.net>
References: <20130410211311.GA24277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 23:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2NL-0006Ey-SB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758479Ab3DJVQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:16:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39232 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992Ab3DJVQK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:16:10 -0400
Received: (qmail 7540 invoked by uid 107); 10 Apr 2013 21:18:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:18:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:16:03 -0400
Content-Disposition: inline
In-Reply-To: <20130410211311.GA24277@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220767>

When we try to read from a remote-helper and get EOF or an
error, we print a message indicating that the helper died.
However, users may not know that a remote helper was in use
(e.g., when using git-over-http), or even what a remote
helper is.

Let's print the name of the helper (e.g., "git-remote-https");
this makes it more obvious what the program is for, and
provides a useful token for reporting bugs or searching for
more information (e.g., in manpages).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5801-remote-helpers.sh | 2 +-
 transport-helper.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index aafc46a..8b2cb68 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -182,7 +182,7 @@ test_expect_success 'proper failure checks for pushing' '
 	cd local &&
 	test_must_fail git push --all 2> error &&
 	cat error &&
-	grep -q "Reading from remote helper failed" error
+	grep -q "Reading from helper .git-remote-testgit. failed" error
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 96081cc..3fc43b9 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -46,7 +46,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 		die_errno("Full write to remote helper failed");
 }
 
-static int recvline_fh(FILE *helper, struct strbuf *buffer)
+static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 {
 	strbuf_reset(buffer);
 	if (debug)
@@ -54,7 +54,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		die("Reading from remote helper failed");
+		die("Reading from helper 'git-remote-%s' failed", name);
 	}
 
 	if (debug)
@@ -64,7 +64,7 @@ static int recvline(struct helper_data *helper, struct strbuf *buffer)
 
 static int recvline(struct helper_data *helper, struct strbuf *buffer)
 {
-	return recvline_fh(helper->out, buffer);
+	return recvline_fh(helper->out, buffer, helper->name);
 }
 
 static void xchgline(struct helper_data *helper, struct strbuf *buffer)
@@ -536,7 +536,7 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	recvline_fh(input, &cmdbuf);
+	recvline_fh(input, &cmdbuf, name);
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
-- 
1.8.2.rc0.33.gd915649
