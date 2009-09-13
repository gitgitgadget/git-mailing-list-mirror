From: Owen Taylor <otaylor@redhat.com>
Subject: [PATCH 3/4] push: add --show-subjects option to show commit synopsis
Date: Sun, 13 Sep 2009 19:31:24 -0400
Message-ID: <1252884685-9169-4-git-send-email-otaylor@redhat.com>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
 <1252884685-9169-2-git-send-email-otaylor@redhat.com>
 <1252884685-9169-3-git-send-email-otaylor@redhat.com>
Cc: "Owen W. Taylor" <otaylor@fishsoup.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 01:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmyXn-0001Gx-HC
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 01:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZIMXbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbZIMXba
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 19:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbZIMXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 19:31:26 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVS8O005195;
	Sun, 13 Sep 2009 19:31:28 -0400
Received: from localhost.localdomain (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVPJ2026475;
	Sun, 13 Sep 2009 19:31:28 -0400
In-Reply-To: <1252884685-9169-3-git-send-email-otaylor@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128428>

From: Owen W. Taylor <otaylor@fishsoup.net>

When --show-subjects is specified, include a synopsis of added
and removed with each OK or REJECT_NONFASTFORWARD reference update.

(The code for printing the synposis is borrowed and adapted from
builtin-fmt-merge-msg.c)

Signed-off-by: Owen W. Taylor <otaylor@fishsoup.net>
---
 Documentation/git-push.txt |    4 +
 builtin-push.c             |    3 +-
 transport.c                |  174 +++++++++++++++++++++++++++++++++++++++++---
 transport.h                |    1 +
 4 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index c0bbf16..c9fd033 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -142,6 +142,10 @@ useful if you write an alias or script around 'git-push'.
 --verbose::
 	Run verbosely.
 
+--show-subjects::
+	When displaying ref updates, include a synopsis of what
+	commits are being added and removed.
+
 include::urls-remotes.txt[]
 
 OUTPUT
diff --git a/builtin-push.c b/builtin-push.c
index 63a0bb0..7c9e394 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--confirm] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--confirm] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [--show-subjects] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -177,6 +177,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BIT('q', "quiet", &flags, "be quiet", TRANSPORT_PUSH_QUIET),
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
+		OPT_BIT(0, "show-subjects", &flags, "show commit subjects", TRANSPORT_PUSH_SHOW_SUBJECTS),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BIT( 0 , "all", &flags, "push all refs", TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
diff --git a/transport.c b/transport.c
index aa1852d..c07291e 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "commit.h"
+#include "diff.h"
 #include "transport.h"
 #include "run-command.h"
 #include "pkt-line.h"
@@ -8,6 +10,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "revision.h"
 
 /* rsync support */
 
@@ -619,7 +622,151 @@ static const char *status_abbrev(unsigned char sha1[20])
 	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
-static void print_ok_ref_status(struct ref *ref, int porcelain)
+struct list {
+	char **list;
+	unsigned nr, alloc;
+};
+
+static void append_to_list(struct list *list, char *value)
+{
+	if (list->nr == list->alloc) {
+		list->alloc += 32;
+		list->list = xrealloc(list->list, sizeof(char *) * list->alloc);
+	}
+	list->list[list->nr++] = value;
+}
+
+static void free_list(struct list *list)
+{
+	int i;
+
+	if (list->alloc == 0)
+		return;
+
+	for (i = 0; i < list->nr; i++) {
+		free(list->list[i]);
+	}
+	free(list->list);
+	list->nr = list->alloc = 0;
+}
+
+static void shortlog(struct commit *from, struct commit *to,
+		     const char *heading, int limit)
+{
+	struct rev_info rev;
+	int i, count = 0;
+	struct commit *commit;
+	struct list subjects = { NULL, 0, 0 };
+	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
+	const char *prefix;
+
+	init_revisions(&rev, NULL);
+	rev.commit_format = CMIT_FMT_ONELINE;
+	rev.limited = 1;
+	rev.ignore_merges = 0;
+
+	setup_revisions(0, NULL, &rev, NULL);
+
+	add_pending_object(&rev, &from->object, "");
+	add_pending_object(&rev, &to->object, "");
+	from->object.flags |= UNINTERESTING;
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+	while ((commit = get_revision(&rev)) != NULL) {
+		char *oneline, *bol, *eol;
+
+		count++;
+		if (subjects.nr > limit)
+			continue;
+
+		bol = strstr(commit->buffer, "\n\n");
+		if (bol) {
+			unsigned char c;
+			do {
+				c = *++bol;
+			} while (isspace(c));
+			if (!c)
+				bol = NULL;
+		}
+
+		if (!bol) {
+			append_to_list(&subjects, xstrdup(sha1_to_hex(commit->object.sha1)));
+			continue;
+		}
+
+		eol = strchr(bol, '\n');
+		if (eol) {
+			oneline = xmemdupz(bol, eol - bol);
+		} else {
+			oneline = xstrdup(bol);
+		}
+		append_to_list(&subjects, oneline);
+	}
+
+	if (heading || count > limit) {
+		fprintf(stderr, "      ");
+		if (heading)
+			fprintf(stderr, "%s", heading);
+		if (heading && count > limit)
+			fprintf(stderr, " (%d)", count);
+		else if (count > limit)
+			fprintf(stderr, "%d commits", count);
+		fprintf(stderr, ":\n");
+		prefix = "         ";
+	} else {
+		prefix = "      ";
+	}
+
+	for (i = 0; i < count && i < limit; i++)
+		if (i == limit - 1 && count > limit)
+			fprintf(stderr, "%s...\n", prefix);
+		else
+			fprintf(stderr, "%s%s\n", prefix, subjects.list[i]);
+
+	clear_commit_marks(from, flags);
+	clear_commit_marks(to, flags);
+	free_commit_list(rev.commits);
+	rev.commits = NULL;
+	rev.pending.nr = 0;
+
+	free_list(&subjects);
+}
+
+/* Maximum lines number of subjects to show (including ...) */
+#define SUBJECTS_LIMIT 8
+
+static void print_subjects(struct ref *ref)
+{
+	struct commit *old;
+	struct commit *new;
+	struct commit_list *merge_bases;
+	int added = 1;
+	int removed = 1;
+
+	old = lookup_commit_reference_gently(ref->old_sha1, 1);
+	if (!old) {
+		fprintf(stderr, "      Unknown changes (please run 'git fetch')\n");
+		return;
+	}
+	new = lookup_commit_reference(ref->new_sha1);
+
+	merge_bases = get_merge_bases(old, new, 1);
+	if (merge_bases && !merge_bases->next && merge_bases->item == old)
+		removed = 0;
+	if (merge_bases && !merge_bases->next && merge_bases->item == new)
+		added = 0;
+
+	if (added && !removed) {
+		shortlog(old, new, NULL, SUBJECTS_LIMIT);
+	} else {
+		if (added)
+			shortlog(old, new, "Added commits", SUBJECTS_LIMIT);
+		if (removed)
+			shortlog(new, old, "Removed commits", SUBJECTS_LIMIT);
+	}
+}
+
+static void print_ok_ref_status(struct ref *ref, int porcelain, int show_subjects)
 {
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
@@ -646,10 +793,13 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		strcat(quickref, status_abbrev(ref->new_sha1));
 
 		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
+
+		if (show_subjects)
+			print_subjects(ref);
 	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
+static int print_one_push_status(struct ref *ref, const char *dest, int count, int show_subjects, int porcelain)
 {
 	if (!count)
 		fprintf(stderr, "To %s\n", dest);
@@ -669,6 +819,8 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 	case REF_STATUS_REJECT_NONFASTFORWARD:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 						 "non-fast forward", porcelain);
+		if (show_subjects)
+			print_subjects(ref);
 		break;
 	case REF_STATUS_REMOTE_REJECT:
 		print_ref_status('!', "[remote rejected]", ref,
@@ -681,7 +833,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 						 "remote failed to report status", porcelain);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain);
+		print_ok_ref_status(ref, porcelain, show_subjects);
 		break;
 	}
 
@@ -689,7 +841,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 static void print_push_status(const char *dest, struct ref *refs,
-			      int verbose, int porcelain, int * nonfastforward)
+			      int verbose, int show_subjects, int porcelain, int * nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
@@ -697,19 +849,19 @@ static void print_push_status(const char *dest, struct ref *refs,
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n, porcelain);
+				n += print_one_push_status(ref, dest, n, show_subjects, porcelain);
 	}
 
 	for (ref = refs; ref; ref = ref->next)
 		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, show_subjects, porcelain);
 
 	*nonfastforward = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, show_subjects, porcelain);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
 			*nonfastforward = 1;
 	}
@@ -912,6 +1064,7 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int dry_run = flags & TRANSPORT_PUSH_DRY_RUN;
 		int confirm = flags & TRANSPORT_PUSH_CONFIRM;
+		int show_subjects = flags & TRANSPORT_PUSH_SHOW_SUBJECTS;
 		int ret;
 
 		if (flags & TRANSPORT_PUSH_ALL)
@@ -942,7 +1095,7 @@ int transport_push(struct transport *transport,
 			 * confirmed, send the porcelain-formatted output to stdout.
 			 */
 			print_push_status(transport->url, remote_refs,
-					  verbose, 0,
+					  verbose, show_subjects, 0,
 					  nonfastforward);
 
 			if (ret)
@@ -970,8 +1123,9 @@ int transport_push(struct transport *transport,
 		 */
 		if (!(quiet || (confirm && !porcelain)) || push_had_errors(remote_refs))
 			print_push_status(transport->url, remote_refs,
-					verbose | porcelain, porcelain,
-					nonfastforward);
+					verbose | porcelain,
+					show_subjects && !confirm && !porcelain,
+					porcelain, nonfastforward);
 
 		if (!dry_run) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 1d691d7..6a002a3 100644
--- a/transport.h
+++ b/transport.h
@@ -38,6 +38,7 @@ struct transport {
 #define TRANSPORT_PUSH_PORCELAIN 32
 #define TRANSPORT_PUSH_QUIET 64
 #define TRANSPORT_PUSH_CONFIRM 128
+#define TRANSPORT_PUSH_SHOW_SUBJECTS 256
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.2.5
