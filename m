From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Restore default verbosity for http fetches.
Date: Tue, 2 Oct 2007 22:49:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710022248160.9321@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 04:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcuIx-0007Nn-Ee
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 04:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbXJCCtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 22:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbXJCCtR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 22:49:17 -0400
Received: from iabervon.org ([66.92.72.58]:36692 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755505AbXJCCtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 22:49:16 -0400
Received: (qmail 24150 invoked by uid 1000); 3 Oct 2007 02:49:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2007 02:49:15 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59771>

This adds a verbosity level below 0 for suppressing default messages
with --quiet, and makes the default for http be verbose instead of
quiet. This matches the behavior of the shell script version of git-fetch.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c |    2 +-
 transport.c     |   10 +++++-----
 transport.h     |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ac68ff5..cf7498b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -533,7 +533,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (verbose >= 2)
 		transport->verbose = 1;
 	if (quiet)
-		transport->verbose = 0;
+		transport->verbose = -1;
 	if (upload_pack)
 		set_option(TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/transport.c b/transport.c
index 7266fd3..6fe6ec8 100644
--- a/transport.c
+++ b/transport.c
@@ -161,7 +161,7 @@ static struct ref *get_refs_via_rsync(const struct transport *transport)
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
-	args[1] = transport->verbose ? "-rv" : "-r";
+	args[1] = (transport->verbose > 0) ? "-rv" : "-r";
 	args[2] = buf.buf;
 	args[3] = temp_dir.buf;
 	args[4] = NULL;
@@ -214,7 +214,7 @@ static int fetch_objs_via_rsync(struct transport *transport,
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
-	args[1] = transport->verbose ? "-rv" : "-r";
+	args[1] = (transport->verbose > 0) ? "-rv" : "-r";
 	args[2] = "--ignore-existing";
 	args[3] = "--exclude";
 	args[4] = "info";
@@ -290,7 +290,7 @@ static int rsync_transport_push(struct transport *transport,
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
-	args[1] = transport->verbose ? "-av" : "-a";
+	args[1] = (transport->verbose > 0) ? "-av" : "-a";
 	args[2] = "--ignore-existing";
 	args[3] = "--exclude";
 	args[4] = "info";
@@ -344,7 +344,7 @@ static int fetch_objs_via_walker(struct transport *transport,
 	walker->get_all = 1;
 	walker->get_tree = 1;
 	walker->get_history = 1;
-	walker->get_verbosely = transport->verbose;
+	walker->get_verbosely = transport->verbose >= 0;
 	walker->get_recover = 0;
 
 	for (i = 0; i < nr_objs; i++)
@@ -637,7 +637,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.keep_pack = data->keep;
 	args.lock_pack = 1;
 	args.use_thin_pack = data->thin;
-	args.verbose = transport->verbose;
+	args.verbose = transport->verbose > 0;
 	args.depth = data->depth;
 
 	for (i = 0; i < nr_heads; i++)
diff --git a/transport.h b/transport.h
index 6e318e4..4bb51d7 100644
--- a/transport.h
+++ b/transport.h
@@ -24,7 +24,7 @@ struct transport {
 
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
-	unsigned verbose : 1;
+	signed verbose : 2;
 };
 
 #define TRANSPORT_PUSH_ALL 1
-- 
1.5.3.2.1107.ge9eab8-dirty
