From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] run-command: add pre-exec callback
Date: Tue, 22 Jul 2008 03:12:46 -0400
Message-ID: <20080722071246.GA3584@sigill.intra.peff.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:13:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLC4K-0003wR-2a
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYGVHMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYGVHMs
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:12:48 -0400
Received: from peff.net ([208.65.91.99]:2233 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbYGVHMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:12:47 -0400
Received: (qmail 3223 invoked by uid 111); 22 Jul 2008 07:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:12:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:12:46 -0400
Content-Disposition: inline
In-Reply-To: <20080722071009.GA3610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89451>

This is a function provided by the caller which is called
_after_ the process is forked, but before the spawned
program is executed. On platforms (like mingw) where
subprocesses are forked and executed in a single call, the
preexec callback is simply ignored.

This will be used in the following patch to do some setup
for 'less' that must happen in the forked child.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |    2 ++
 run-command.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 6e29fdf..73d0c31 100644
--- a/run-command.c
+++ b/run-command.c
@@ -110,6 +110,8 @@ int start_command(struct child_process *cmd)
 					unsetenv(*cmd->env);
 			}
 		}
+		if (cmd->preexec_cb)
+			cmd->preexec_cb();
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else {
diff --git a/run-command.h b/run-command.h
index 5203a9e..4f2b7d7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -42,6 +42,7 @@ struct child_process {
 	unsigned no_stderr:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
+	void (*preexec_cb)(void);
 };
 
 int start_command(struct child_process *);
-- 
1.6.0.rc0.1.g9291f.dirty
