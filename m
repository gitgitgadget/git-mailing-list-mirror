From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 3/4] git-push: plumb in --mirror mode
Date: Thu, 8 Nov 2007 17:01:29 -0000
Message-ID: <1194541289.0@pinky>
References: <20071108165801.GM9736@shadowen.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 18:02:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqAlW-0005gQ-SA
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 18:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760754AbXKHRBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 12:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760833AbXKHRBV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 12:01:21 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4169 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760534AbXKHRBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 12:01:20 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1IqAkp-0003uA-L1
	for git@vger.kernel.org; Thu, 08 Nov 2007 17:01:19 +0000
InReply-To: <20071108165801.GM9736@shadowen.org>
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64056>


Plumb in the --mirror mode for git-push.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 builtin-push.c |   14 ++++++++++++--
 transport.c    |    7 +++++++
 transport.h    |    1 +
 3 files changed, 20 insertions(+), 2 deletions(-)
diff --git a/builtin-push.c b/builtin-push.c
index 2c56195..d49157c 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git-push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -91,6 +91,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
 	int all = 0;
+	int mirror = 0;
 	int dry_run = 0;
 	int force = 0;
 	int tags = 0;
@@ -100,6 +101,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BOOLEAN( 0 , "all", &all, "push all refs"),
+		OPT_BOOLEAN( 0 , "mirror", &mirror, "mirror all refs"),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force updates"),
@@ -119,13 +121,21 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		add_refspec("refs/tags/*");
 	if (all)
 		flags |= TRANSPORT_PUSH_ALL;
+	if (mirror)
+		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
 	}
-	if ((flags & TRANSPORT_PUSH_ALL) && refspec)
+	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) && refspec)
 		usage_with_options(push_usage, options);
 
+	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
+				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
+		error("--all and --mirror are incompatible");
+		usage_with_options(push_usage, options);
+	}
+
 	return do_push(repo, flags);
 }
diff --git a/transport.c b/transport.c
index f4577b7..08e62b1 100644
--- a/transport.c
+++ b/transport.c
@@ -284,6 +284,9 @@ static int rsync_transport_push(struct transport *transport,
 	struct child_process rsync;
 	const char *args[10];
 
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		return error("rsync transport does not support mirror mode");
+
 	/* first push the objects */
 
 	strbuf_addstr(&buf, transport->url);
@@ -386,6 +389,9 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	int argc;
 	int err;
 
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		return error("http transport does not support mirror mode");
+
 	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
 	argv[0] = "http-push";
 	argc = 1;
@@ -653,6 +659,7 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 
 	args.receivepack = data->receivepack;
 	args.send_all = !!(flags & TRANSPORT_PUSH_ALL);
+	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->thin;
 	args.verbose = transport->verbose;
diff --git a/transport.h b/transport.h
index d27f562..7f337d2 100644
--- a/transport.h
+++ b/transport.h
@@ -30,6 +30,7 @@ struct transport {
 #define TRANSPORT_PUSH_ALL 1
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
+#define TRANSPORT_PUSH_MIRROR 8
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
