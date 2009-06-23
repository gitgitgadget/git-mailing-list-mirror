From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH] add --porcelain option to git-push
Date: Mon, 22 Jun 2009 21:10:01 -0400
Message-ID: <20090623011001.GA15352@cthulhu>
References: <20090622214032.GC19364@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 03:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIuWW-0005y6-TV
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 03:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbZFWBJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 21:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZFWBJ7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 21:09:59 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:56236 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbZFWBJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 21:09:58 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 6964382205F; Mon, 22 Jun 2009 21:10:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090622214032.GC19364@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122069>

If --porcelain is used git-push will produce machine-readable output.  The
output status line for each ref will be tab-separated and sent to stdout instead
of stderr.  The full symbolic names of the refs will be given.  For example

$ git push --dry-run --porcelain master :foobar 2>/dev/null \
  | perl -pe 's/\t/ TAB /g'

= TAB refs/heads/master:refs/heads/master TAB [up to date]
- TAB :refs/heads/foobar TAB [deleted]
---
 Documentation/git-push.txt |   11 ++++++
 builtin-push.c             |    3 +-
 transport.c                |   75 +++++++++++++++++++++++++------------------
 transport.h                |    1 +
 4 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index fd53c49..2653388 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -85,6 +85,11 @@ nor in any Push line of the corresponding remotes file---see below).
 --dry-run::
 	Do everything except actually send the updates.
 
+--porcelain::
+	Produce machine-readable output.  The output status line for each ref
+	will be tab-separated and sent to stdout instead of stderr.  The full
+	symbolic names of the refs will be given.
+
 --tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
 	addition to refspecs explicitly listed on the command
@@ -148,6 +153,12 @@ representing the status of a single ref. Each line is of the form:
  <flag> <summary> <from> -> <to> (<reason>)
 -------------------------------
 
+If --porcelain is used, then each line of the output is of the form:
+
+-------------------------------
+ <flag> \t <from>:<to> \t <summary> (<reason>)
+-------------------------------
+
 flag::
 	A single character indicating the status of the ref. This is
 	blank for a successfully pushed ref, `!` for a ref that was
diff --git a/builtin-push.c b/builtin-push.c
index 7be1239..0a0297f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -200,6 +200,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
+		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
diff --git a/transport.c b/transport.c
index 501a77b..b074067 100644
--- a/transport.c
+++ b/transport.c
@@ -719,19 +719,30 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref, int verb
 
 #define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 
-static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg)
+static void print_ref_status(char flag, const char *summary, struct ref *to, struct ref *from, const char *msg, int porcelain)
 {
-	fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
-	if (from)
-		fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
-	else
-		fputs(prettify_refname(to->name), stderr);
-	if (msg) {
-		fputs(" (", stderr);
-		fputs(msg, stderr);
-		fputc(')', stderr);
+	if (porcelain) {
+		if (from)
+			fprintf(stdout, "%c\t%s:%s\t", flag, from->name, to->name);
+		else
+			fprintf(stdout, "%c\t:%s\t", flag, to->name);
+		if (msg)
+			fprintf(stdout, "%s (%s)\n", summary, msg);
+		else
+			fprintf(stdout, "%s\n", summary);
+	} else {
+		fprintf(stderr, " %c %-*s ", flag, SUMMARY_WIDTH, summary);
+		if (from)
+			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
+		else
+			fputs(prettify_refname(to->name), stderr);
+		if (msg) {
+			fputs(" (", stderr);
+			fputs(msg, stderr);
+			fputc(')', stderr);
+		}
+		fputc('\n', stderr);
 	}
-	fputc('\n', stderr);
 }
 
 static const char *status_abbrev(unsigned char sha1[20])
@@ -739,15 +750,15 @@ static const char *status_abbrev(unsigned char sha1[20])
 	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
-static void print_ok_ref_status(struct ref *ref)
+static void print_ok_ref_status(struct ref *ref, int porcelain)
 {
 	if (ref->deletion)
-		print_ref_status('-', "[deleted]", ref, NULL, NULL);
+		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
 	else if (is_null_sha1(ref->old_sha1))
 		print_ref_status('*',
 			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
-			  "[new branch]"),
-			ref, ref->peer_ref, NULL);
+			"[new branch]"),
+			ref, ref->peer_ref, NULL, porcelain);
 	else {
 		char quickref[84];
 		char type;
@@ -765,50 +776,51 @@ static void print_ok_ref_status(struct ref *ref)
 		}
 		strcat(quickref, status_abbrev(ref->new_sha1));
 
-		print_ref_status(type, quickref, ref, ref->peer_ref, msg);
+		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count)
+static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
 	if (!count)
 		fprintf(stderr, "To %s\n", dest);
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-		print_ref_status('X', "[no match]", ref, NULL, NULL);
+		print_ref_status('X', "[no match]", ref, NULL, NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NODELETE:
 		print_ref_status('!', "[rejected]", ref, NULL,
-				"remote does not support deleting refs");
+						 "remote does not support deleting refs", porcelain);
 		break;
 	case REF_STATUS_UPTODATE:
 		print_ref_status('=', "[up to date]", ref,
-				ref->peer_ref, NULL);
+						 ref->peer_ref, NULL, porcelain);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-				"non-fast forward");
+						 "non-fast forward", porcelain);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
-				ref->deletion ? NULL : ref->peer_ref,
-				ref->remote_status);
+						 ref->deletion ? NULL : ref->peer_ref,
+						 ref->remote_status, porcelain);
 		break;
 	case REF_STATUS_EXPECTING_REPORT:
 		print_ref_status('!', "[remote failure]", ref,
-				ref->deletion ? NULL : ref->peer_ref,
-				"remote failed to report status");
+						 ref->deletion ? NULL : ref->peer_ref,
+						 "remote failed to report status", porcelain);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref);
+		print_ok_ref_status(ref, porcelain);
 		break;
 	}
 
 	return 1;
 }
 
-static void print_push_status(const char *dest, struct ref *refs, int verbose)
+static void print_push_status(const char *dest, struct ref *refs,
+							  int verbose, int porcelain)
 {
 	struct ref *ref;
 	int n = 0;
@@ -816,18 +828,18 @@ static void print_push_status(const char *dest, struct ref *refs, int verbose)
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n);
+				n += print_one_push_status(ref, dest, n, porcelain);
 	}
 
 	for (ref = refs; ref; ref = ref->next)
 		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
+			n += print_one_push_status(ref, dest, n, porcelain);
 
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n);
+			n += print_one_push_status(ref, dest, n, porcelain);
 	}
 }
 
@@ -997,6 +1009,7 @@ int transport_push(struct transport *transport,
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
+		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int ret;
 
 		if (flags & TRANSPORT_PUSH_ALL)
@@ -1011,7 +1024,7 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose);
+		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 27bfc52..51b5397 100644
--- a/transport.h
+++ b/transport.h
@@ -35,6 +35,7 @@ struct transport {
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_VERBOSE 16
+#define TRANSPORT_PUSH_PORCELAIN 32
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.0.4
