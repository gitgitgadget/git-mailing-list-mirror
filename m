From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] add --summary option to git-push
Date: Fri, 26 Jun 2009 20:23:17 -0400
Message-ID: <1246062197-28685-1-git-send-email-larry@elder-gods.org>
References: <7vtz249lpf.fsf@alter.siamese.dyndns.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 27 02:23:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLhi-0000ic-Gn
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 02:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbZF0AX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 20:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbZF0AX2
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 20:23:28 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:34852 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbZF0AX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 20:23:27 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 845E7822106; Fri, 26 Jun 2009 20:23:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.3.336.gc126d
In-Reply-To: <7vtz249lpf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122341>

--summary will cause git-push to output a one-line of each commit pushed.
--summary=n will display at most n commits for each ref pushed.

$ git push --dry-run --summary origin :
To /home/larry/gitsandbox/a
   80f0e50..5593a38  master -> master
    5593a38 foo
    81c03f8 bar

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 Documentation/git-push.txt |    6 ++++++
 builtin-push.c             |   12 +++++++++---
 transport.c                |   43 +++++++++++++++++++++++++++++++------------
 transport.h                |    2 +-
 4 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2653388..803fe36 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -85,6 +85,12 @@ nor in any Push line of the corresponding remotes file---see below).
 --dry-run::
 	Do everything except actually send the updates.
 
+--summary::
+	Print a one-line summary of each commit pushed.
+
+--summary=<n>::
+	Like --summary, but with a limit of <n> commits per ref.
+
 --porcelain::
 	Produce machine-readable output.  The output status line for each ref
 	will be tab-separated and sent to stdout instead of stderr.  The full
diff --git a/builtin-push.c b/builtin-push.c
index 0a0297f..00cf846 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -113,7 +113,7 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, int flags, int summary)
 {
 	int i, errs;
 	struct remote *remote = remote_get(repo);
@@ -173,7 +173,7 @@ static int do_push(const char *repo, int flags)
 
 		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
+		err = transport_push(transport, refspec_nr, refspec, flags, summary);
 		err |= transport_disconnect(transport);
 
 		if (!err)
@@ -192,6 +192,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int rc;
 	const char *repo = NULL;	/* default repository */
 
+	int summary = 0;
+
 	struct option options[] = {
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
@@ -205,6 +207,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		{ OPTION_INTEGER, 0, "summary", &summary, "n", "print a summary of [at most n] pushed commits",
+		  PARSE_OPT_OPTARG, NULL, -1
+		},
+
 		OPT_END()
 	};
 
@@ -218,7 +224,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, flags, summary);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/transport.c b/transport.c
index b074067..562e788 100644
--- a/transport.c
+++ b/transport.c
@@ -750,17 +750,19 @@ static const char *status_abbrev(unsigned char sha1[20])
 	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
-static void print_ok_ref_status(struct ref *ref, int porcelain)
+static void print_ok_ref_status(struct ref *ref, int porcelain, int summary)
 {
+	char quickref[84];
+
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
-	else if (is_null_sha1(ref->old_sha1))
+	else if (is_null_sha1(ref->old_sha1)) {
 		print_ref_status('*',
 			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
 			"[new branch]"),
 			ref, ref->peer_ref, NULL, porcelain);
-	else {
-		char quickref[84];
+		strcpy (quickref, status_abbrev(ref->new_sha1));
+	} else {
 		char type;
 		const char *msg;
 
@@ -778,9 +780,25 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 
 		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
 	}
+
+	if (summary) {
+		FILE *temp = stdout;
+		stdout = stderr;
+		if (summary < 0) {
+			char *argv[] = {"log", "--pretty=format:    %h %s", quickref};
+			cmd_log(3, argv, 0);
+		} else {
+			char dashn[15];
+			sprintf(dashn, "-n%d", summary);
+			char *argv[] = {"log", "--pretty=format:    %h %s", dashn, quickref};
+			cmd_log(4, argv, 0);
+		}
+		fprintf(stderr, "\n");
+		stdout = temp;
+	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
+static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain, int summary)
 {
 	if (!count)
 		fprintf(stderr, "To %s\n", dest);
@@ -812,7 +830,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 						 "remote failed to report status", porcelain);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain);
+		print_ok_ref_status(ref, porcelain, summary);
 		break;
 	}
 
@@ -820,7 +838,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 static void print_push_status(const char *dest, struct ref *refs,
-							  int verbose, int porcelain)
+							  int verbose, int porcelain, int summary)
 {
 	struct ref *ref;
 	int n = 0;
@@ -828,18 +846,18 @@ static void print_push_status(const char *dest, struct ref *refs,
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n, porcelain);
+				n += print_one_push_status(ref, dest, n, porcelain, summary);
 	}
 
 	for (ref = refs; ref; ref = ref->next)
 		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, porcelain, summary);
 
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, porcelain, summary);
 	}
 }
 
@@ -997,7 +1015,8 @@ int transport_set_option(struct transport *transport,
 }
 
 int transport_push(struct transport *transport,
-		   int refspec_nr, const char **refspec, int flags)
+				   int refspec_nr, const char **refspec,
+				   int flags, int summary)
 {
 	verify_remote_names(refspec_nr, refspec);
 
@@ -1024,7 +1043,7 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
+		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain, summary);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 51b5397..360051e 100644
--- a/transport.h
+++ b/transport.h
@@ -68,7 +68,7 @@ int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 
 int transport_push(struct transport *connection,
-		   int refspec_nr, const char **refspec, int flags);
+				   int refspec_nr, const char **refspec, int flags, int summary);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-- 
1.6.0.4
