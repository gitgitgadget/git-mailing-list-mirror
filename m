From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] git-push: plumb in --mirror mode
Date: Tue, 2 Oct 2007 13:00:51 +0100
Message-ID: <20071002120051.GC30636@shadowen.org>
References: <7vhclalzlq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 14:01:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcgQx-0004FR-FU
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 14:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbXJBMA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 08:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXJBMA4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 08:00:56 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:1218 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbXJBMA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 08:00:56 -0400
Received: from 81-179-148-120.dsl.pipex.com ([81.179.148.120] helo=localhost.localdomain)
	by hellhawk.shadowen.org with esmtpa (Exim 4.50)
	id 1IcgQp-0007VK-2s; Tue, 02 Oct 2007 13:00:55 +0100
Received: from localhost ([127.0.0.1] helo=pinky)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IcgQl-0001Kn-KT; Tue, 02 Oct 2007 13:00:51 +0100
Content-Disposition: inline
In-Reply-To: <7vhclalzlq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: none
X-SPF-Guess: neutral
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59686>

Plumb in the --mirror mode for git-push.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 builtin-push.c |   14 +++++++++++++-
 transport.c    |    8 ++++++++
 transport.h    |    1 +
 3 files changed, 22 insertions(+), 1 deletions(-)
diff --git a/builtin-push.c b/builtin-push.c
index 4ee36c2..e421e96 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,7 +8,7 @@
 #include "remote.h"
 #include "transport.h"
 
-static const char push_usage[] = "git-push [--all] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char push_usage[] = "git-push [--all | --mirror] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
 static int all, thin, verbose;
 static const char *receivepack;
@@ -85,6 +85,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int flags = 0;
+	int modes_specified = 0;
 	const char *repo = NULL;	/* default repository */
 
 	for (i = 1; i < argc; i++) {
@@ -105,6 +106,12 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp(arg, "--all")) {
 			flags |= TRANSPORT_PUSH_ALL;
+			modes_specified++;
+			continue;
+		}
+		if (!strcmp(arg, "--mirror")) {
+			flags |= TRANSPORT_PUSH_MIRROR;
+			modes_specified++;
 			continue;
 		}
 		if (!strcmp(arg, "--tags")) {
@@ -137,5 +144,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (all && refspec)
 		usage(push_usage);
 
+	if (modes_specified > 1) {
+		error("--all and --mirror are incompatible");
+		usage(push_usage);
+	}
+
 	return do_push(repo, flags);
 }
diff --git a/transport.c b/transport.c
index 7266fd3..e45f3c0 100644
--- a/transport.c
+++ b/transport.c
@@ -281,6 +281,9 @@ static int rsync_transport_push(struct transport *transport,
 	struct child_process rsync;
 	const char *args[8];
 
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		return error("rsync transport does not support mirror mode");
+
 	/* first push the objects */
 
 	strbuf_addstr(&buf, transport->url);
@@ -373,6 +376,9 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	int argc;
 	int err;
 
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		return error("http transport does not support mirror mode");
+
 	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
 	argv[0] = "http-push";
 	argc = 1;
@@ -667,6 +673,8 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 		argv[argc++] = "--all";
 	if (flags & TRANSPORT_PUSH_FORCE)
 		argv[argc++] = "--force";
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		argv[argc++] = "--mirror";
 	if (data->receivepack) {
 		char *rp = xmalloc(strlen(data->receivepack) + 16);
 		sprintf(rp, "--receive-pack=%s", data->receivepack);
diff --git a/transport.h b/transport.h
index 6e318e4..8383774 100644
--- a/transport.h
+++ b/transport.h
@@ -29,6 +29,7 @@ struct transport {
 
 #define TRANSPORT_PUSH_ALL 1
 #define TRANSPORT_PUSH_FORCE 2
+#define TRANSPORT_PUSH_MIRROR 4
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
