From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Thu, 28 Jul 2011 11:02:27 -0600
Message-ID: <20110728170222.GB15931@sigill.intra.peff.net>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com>
 <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
 <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
 <20110728160845.GA14337@sigill.intra.peff.net>
 <20110728164758.GA15931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 19:02:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTyl-0007km-Sv
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846Ab1G1RCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 13:02:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46684
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755842Ab1G1RCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 13:02:30 -0400
Received: (qmail 14241 invoked by uid 107); 28 Jul 2011 17:03:01 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Jul 2011 13:03:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2011 11:02:27 -0600
Content-Disposition: inline
In-Reply-To: <20110728164758.GA15931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178098>

On Thu, Jul 28, 2011 at 10:47:58AM -0600, Jeff King wrote:

> Ah, nevermind. I see now; the command-line option interface to "git
> archive" is not as rich as what you can pass via write_archive.
> 
> I think you can get around it by adding an option to "git archive" to
> indicate that we are filling a remote request, which is the only
> extra information that my series adds.

And that patch would look something like the one below. You can also now
drop the "remote" parameter to write_archive entirely, but I didn't do
so here. Applied on top of the merge of your series into next, this
passes t5000.

-Peff

---
diff --git a/builtin/archive.c b/builtin/archive.c
index 883c009..6668340 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -85,6 +85,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *exec = "git-upload-archive";
 	const char *output = NULL;
 	const char *remote = NULL;
+	int is_remote = 0;
 	struct option local_opts[] = {
 		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
@@ -92,6 +93,9 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
 			"path to the remote git-upload-archive command"),
+		{ OPTION_BOOLEAN, 0, "remote-request", &is_remote, NULL,
+			"indicate we are serving a remote request",
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_END()
 	};
 
@@ -106,5 +110,5 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	return write_archive(argc, argv, prefix, 1, output, 0);
+	return write_archive(argc, argv, prefix, 1, output, is_remote);
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 0c192b5..c57e8bd 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -27,8 +27,9 @@ static void prepare_argv(const char **sent_argv, const char **argv)
 	int len;
 
 	/* put received options in sent_argv[] */
-	sent_argc = 1;
+	sent_argc = 2;
 	sent_argv[0] = "archive";
+	sent_argv[1] = "--remote-request";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
 		len = packet_read_line(0, p, (buf + sizeof buf) - p);
