From: Michal Marek <mmarek@suse.cz>
Subject: [PATCH] push: add -q option
Date: Thu, 30 Jul 2009 17:10:39 +0200
Message-ID: <1248966639-14393-1-git-send-email-mmarek@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWXHg-0003Oh-QX
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 17:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbZG3PK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 11:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbZG3PK6
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 11:10:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:46011 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbZG3PK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 11:10:56 -0400
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B478388B6C
	for <git@vger.kernel.org>; Thu, 30 Jul 2009 17:10:55 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id 5998E76678; Thu, 30 Jul 2009 17:10:55 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.14.g85346
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124463>

Implement git pull -q analogously to git fetch -q, i.e. pass it down to
send-pack and pack-objects. Also do not print the status message after
a successful push has completed.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 Documentation/git-push.txt |    5 +++++
 builtin-push.c             |   14 ++++++++++----
 builtin-send-pack.c        |   15 ++++++++++++---
 send-pack.h                |    1 +
 transport.c                |   23 ++++++++++++++---------
 transport.h                |    1 -
 6 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2653388..9957328 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -133,6 +133,11 @@ useful if you write an alias or script around 'git-push'.
 	transfer spends extra cycles to minimize the number of
 	objects to be sent and meant to be used on slower connection.
 
+-q::
+--quiet::
+	Pass --quiet to git-send-pack and do not print the status message
+	after a sucessfull push.
+
 -v::
 --verbose::
 	Run verbosely.
diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..08e9e69 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -88,7 +88,7 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, int flags, int verbosity)
 {
 	int i, errs;
 	struct remote *remote = remote_get(repo);
@@ -140,13 +140,18 @@ static int do_push(const char *repo, int flags)
 		struct transport *transport =
 			transport_get(remote, url[i]);
 		int err;
+
+		if (verbosity > 0)
+			transport->verbose = 1;
+		if (verbosity < 0)
+			transport->verbose = -1;
 		if (receivepack)
 			transport_set_option(transport,
 					     TRANS_OPT_RECEIVEPACK, receivepack);
 		if (thin)
 			transport_set_option(transport, TRANS_OPT_THIN, "yes");
 
-		if (flags & TRANSPORT_PUSH_VERBOSE)
+		if (verbosity > 0)
 			fprintf(stderr, "Pushing to %s\n", url[i]);
 		err = transport_push(transport, refspec_nr, refspec, flags);
 		err |= transport_disconnect(transport);
@@ -163,12 +168,13 @@ static int do_push(const char *repo, int flags)
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
+	int verbosity = 0;
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
 
 	struct option options[] = {
-		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
+		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
@@ -193,7 +199,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, flags, verbosity);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 47fb9f7..6815968 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -44,6 +44,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 		NULL,
+		NULL,
 	};
 	struct child_process po;
 	int i;
@@ -53,6 +54,8 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		argv[i++] = "--thin";
 	if (args->use_ofs_delta)
 		argv[i++] = "--delta-base-offset";
+	if (args->quiet)
+		argv[i++] = "-q";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
@@ -274,9 +277,11 @@ static void print_push_status(const char *dest, struct ref *refs)
 				n += print_one_push_status(ref, dest, n);
 	}
 
-	for (ref = refs; ref; ref = ref->next)
-		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
+	if (!args.quiet) {
+		for (ref = refs; ref; ref = ref->next)
+			if (ref->status == REF_STATUS_OK)
+				n += print_one_push_status(ref, dest, n);
+	}
 
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
@@ -516,6 +521,10 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.verbose = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--quiet")) {
+				args.quiet = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--thin")) {
 				args.use_thin_pack = 1;
 				continue;
diff --git a/send-pack.h b/send-pack.h
index 1d7b1b3..8b3cf02 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -3,6 +3,7 @@
 
 struct send_pack_args {
 	unsigned verbose:1,
+		quiet:1,
 		send_mirror:1,
 		force_update:1,
 		use_thin_pack:1,
diff --git a/transport.c b/transport.c
index de0d587..f63c8ef 100644
--- a/transport.c
+++ b/transport.c
@@ -410,7 +410,7 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 		argv[argc++] = "--force";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
 		argv[argc++] = "--dry-run";
-	if (flags & TRANSPORT_PUSH_VERBOSE)
+	if (transport->verbose > 0)
 		argv[argc++] = "--verbose";
 	argv[argc++] = transport->url;
 	while (refspec_nr--)
@@ -825,15 +825,17 @@ static void print_push_status(const char *dest, struct ref *refs,
 	struct ref *ref;
 	int n = 0;
 
-	if (verbose) {
+	if (verbose > 0 || porcelain) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
 				n += print_one_push_status(ref, dest, n, porcelain);
 	}
 
-	for (ref = refs; ref; ref = ref->next)
-		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+	if (verbose >= 0 || porcelain) {
+		for (ref = refs; ref; ref = ref->next)
+			if (ref->status == REF_STATUS_OK)
+				n += print_one_push_status(ref, dest, n, porcelain);
+	}
 
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
@@ -888,10 +890,12 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 				 NULL);
 	}
 
+	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->thin;
-	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
+	args.verbose = (transport->verbose > 0);
+	args.quiet = (transport->verbose < 0);
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
@@ -1008,7 +1012,6 @@ int transport_push(struct transport *transport,
 			transport->get_refs_list(transport, 1);
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
-		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int ret;
 
@@ -1024,12 +1027,14 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
+		print_push_status(transport->url, remote_refs,
+				transport->verbose, porcelain);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
 			for (ref = remote_refs; ref; ref = ref->next)
-				update_tracking_ref(transport->remote, ref, verbose);
+				update_tracking_ref(transport->remote, ref,
+						transport->verbose > 0);
 		}
 
 		if (!ret && !refs_pushed(remote_refs))
diff --git a/transport.h b/transport.h
index 51b5397..de3e541 100644
--- a/transport.h
+++ b/transport.h
@@ -34,7 +34,6 @@ struct transport {
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
-#define TRANSPORT_PUSH_VERBOSE 16
 #define TRANSPORT_PUSH_PORCELAIN 32
 
 /* Returns a transport suitable for the url */
-- 
1.6.4.14.g85346
