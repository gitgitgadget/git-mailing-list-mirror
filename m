From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] fetch: run gc --auto after fetching
Date: Sat, 26 Jan 2013 17:40:38 -0500
Message-ID: <20130126224038.GA20849@sigill.intra.peff.net>
References: <20130126224011.GA20675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 23:41:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzEQo-0008N0-GL
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 23:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab3AZWkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 17:40:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51675 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab3AZWkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 17:40:40 -0500
Received: (qmail 25300 invoked by uid 107); 26 Jan 2013 22:42:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 17:42:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 17:40:38 -0500
Content-Disposition: inline
In-Reply-To: <20130126224011.GA20675@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214642>

We generally try to run "gc --auto" after any commands that
might introduce a large number of new objects. An obvious
place to do so is after running "fetch", which may introduce
new loose objects or packs (depending on the size of the
fetch).

While an active developer repository will probably
eventually trigger a "gc --auto" on another action (e.g.,
git-rebase), there are two good reasons why it is nicer to
do it at fetch time:

  1. Read-only repositories which track an upstream (e.g., a
     continuous integration server which fetches and builds,
     but never makes new commits) will accrue loose objects
     and small packs, but never coalesce them into a more
     efficient larger pack.

  2. Fetching is often already perceived to be slow to the
     user, since they have to wait on the network. It's much
     more pleasant to include a potentially slow auto-gc as
     part of the already-long network fetch than in the
     middle of productive work with git-rebase or similar.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b5a898..1ddbf0d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -959,6 +959,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct string_list list = STRING_LIST_INIT_NODUP;
 	struct remote *remote;
 	int result = 0;
+	static const char *argv_gc_auto[] = {
+		"gc", "--auto", NULL,
+	};
 
 	packet_trace_identity("fetch");
 
@@ -1026,5 +1029,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
 
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+
 	return result;
 }
-- 
1.8.0.2.16.g72e2fc9
