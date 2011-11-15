From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] upload-archive: drop extra argument to prepare_argv
Date: Tue, 15 Nov 2011 14:46:03 -0500
Message-ID: <20111115194603.GA19305@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
 <20111115173715.GA4478@sigill.intra.peff.net>
 <7vobwdus7w.fsf@alter.siamese.dyndns.org>
 <20111115191832.GA16030@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 20:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQOxR-00077o-A5
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 20:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368Ab1KOTqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 14:46:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42771
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327Ab1KOTqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 14:46:06 -0500
Received: (qmail 9752 invoked by uid 107); 15 Nov 2011 19:46:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 14:46:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 14:46:03 -0500
Content-Disposition: inline
In-Reply-To: <20111115191832.GA16030@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185484>

We pass a "sent_argv" which is an out-parameter to hold the
argv that we were sent over the wire. But we also pass in
the "argv" we got on the command line, which is not used at
all. Drop this useless and confusing parameter.

The parameter was obsoleted by c09cd77e, which moved the
enter_repo function (which looked at argv[1]) out of
prepare_argv and into cmd_upload_archive.

Signed-off-by: Jeff King <peff@peff.net>
---
On Tue, Nov 15, 2011 at 02:18:32PM -0500, Jeff King wrote:

> > Let's just do "static" for now, if we know the array is large enough.
> 
> OK, here it is.

And here's the other more invasive cleanup on top (patch 2 is the meaty
one).

 builtin/upload-archive.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index f47c0f0..80575b9 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -19,7 +19,7 @@
 
 #define MAX_ARGS (64)
 
-static void prepare_argv(const char **sent_argv, const char **argv)
+static void prepare_argv(const char **sent_argv)
 {
 	const char *arg_cmd = "argument ";
 	char *p;
@@ -95,7 +95,7 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(argv[1], 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
-	prepare_argv(sent_argv, argv);
+	prepare_argv(sent_argv);
 	if (start_command(&cld)) {
 		int err = errno;
 		packet_write(1, "NACK fork failed on the remote side\n");
-- 
1.7.7.3.8.g38efa
