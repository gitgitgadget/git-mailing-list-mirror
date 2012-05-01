From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] teach send-pack about --[no-]progress
Date: Tue, 1 May 2012 04:42:24 -0400
Message-ID: <20120501084224.GB4998@sigill.intra.peff.net>
References: <20120501084048.GA21904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 01 10:42:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP8fO-0007Wy-9l
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 10:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab2EAIme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 04:42:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52804
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab2EAImd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 04:42:33 -0400
Received: (qmail 1815 invoked by uid 107); 1 May 2012 08:42:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 04:42:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 04:42:24 -0400
Content-Disposition: inline
In-Reply-To: <20120501084048.GA21904@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196671>

The send_pack function gets a "progress" flag saying "yes,
definitely show progress" or "no, definitely do not show
progress". This gets set properly by transport_push when
send_pack is called directly.

However, when the send-pack command is executed separately
(as it is for the remote-curl helper), there is no way to
tell it "definitely do this". As a result, we do not
properly respect "git push --no-progress" for smart-http
remotes; you will still get progress if stderr is a tty.

This patch teaches send-pack --progress and --no-progress,
and teaches remote-curl to pass the appropriate option to
override send-pack's isatty check. This fixes the
--no-progress case above, and as a bonus, also makes "git
push --progress" work when stderr is not a tty.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/send-pack.c |   14 ++++++++++++--
 remote-curl.c       |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7d22715..d5d7105 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -410,6 +410,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	const char *receivepack = "git-receive-pack";
 	int flags;
 	int nonfastforward = 0;
+	int progress = -1;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
@@ -452,6 +453,14 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.verbose = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--progress")) {
+				progress = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--no-progress")) {
+				progress = 0;
+				continue;
+			}
 			if (!strcmp(arg, "--thin")) {
 				args.use_thin_pack = 1;
 				continue;
@@ -492,8 +501,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (!args.quiet)
-		args.progress = isatty(2);
+	if (progress == -1)
+		progress = !args.quiet && isatty(2);
+	args.progress = progress;
 
 	if (args.stateless_rpc) {
 		conn = NULL;
diff --git a/remote-curl.c b/remote-curl.c
index d159fe7..e5e9490 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -774,6 +774,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 		argv[argc++] = "--quiet";
 	else if (options.verbosity > 1)
 		argv[argc++] = "--verbose";
+	argv[argc++] = options.progress ? "--progress" : "--no-progress";
 	argv[argc++] = url;
 	for (i = 0; i < nr_spec; i++)
 		argv[argc++] = specs[i];
-- 
1.7.10.630.g31718
