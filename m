From: Jeff King <peff@peff.net>
Subject: [tig PATCH] blame broken in recent master
Date: Wed, 30 Mar 2011 10:24:30 -0400
Message-ID: <20110330142430.GA32523@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Mar 30 16:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4wL2-0002Qc-C2
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 16:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593Ab1C3OYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 10:24:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab1C3OYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 10:24:37 -0400
Received: (qmail 10534 invoked by uid 107); 30 Mar 2011 14:25:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 10:25:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 10:24:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170387>

As of 730ae86 (Rename prepare_io to prepare_update and make it more
specialized, 2011-03-16), "tig blame" finds no actual blamed commits.

The problem seems to be that prepare_update switched from calling
format_argv to argv_copy, and we end up calling "git blame %(blameargs)"
without "%(blameargs)" expanded. Blame looks like the only caller which
actually uses a placeholder, so it is the only one broken.

The patch below fixes it for me, but it seems like a hack. I'm not
really sure why the switch in prepare_update was made; clearly it is
part of some refactoring, but I'm not sure what your larger plans were.

---
diff --git a/tig.c b/tig.c
index c1e5270..9ef61d3 100644
--- a/tig.c
+++ b/tig.c
@@ -4240,15 +4240,20 @@ blame_read_file(struct view *view, const char *line, bool *read_file)
 			"git", "blame", "%(blameargs)", "--incremental",
 				*opt_ref ? opt_ref : "--incremental", "--", opt_file, NULL
 		};
+		const char **formatted_argv = NULL;
+
+		format_argv(&formatted_argv, blame_argv, FALSE, !view->prev);
 
 		if (view->lines == 0 && !view->prev)
 			die("No blame exist for %s", view->vid);
 
-		if (view->lines == 0 || !start_update(view, blame_argv, opt_cdup)) {
+		if (view->lines == 0 || !start_update(view, formatted_argv, opt_cdup)) {
 			report("Failed to load blame data");
+			argv_free(formatted_argv);
 			return TRUE;
 		}
 
+		argv_free(formatted_argv);
 		*read_file = FALSE;
 		return FALSE;
 
