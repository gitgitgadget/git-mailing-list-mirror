From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 02/10] push: teach push new flag --create
Date: Sun, 28 Oct 2007 18:46:13 +0100
Message-ID: <1193593581114-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCH2-0000QQ-7l
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbXJ1Rt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbXJ1Rtz
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:49:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:63831 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754241AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMoY016194
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLsW019730;
	Sun, 28 Oct 2007 18:46:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935812741-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62576>

If you want to push a branch that does not yet exist on the
remote side you can push using a full refspec. For example you
can "push origin refs/heads/master".

This commit changes push such that refs that do not start with
'refs/' will be created at the remote as the matching local ref
if --create is used. If you want to create a new ref at the
remote, you can now say "git push --create origin master".

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-http-push.txt |    6 ++++++
 Documentation/git-push.txt      |    8 +++++++-
 Documentation/git-send-pack.txt |   14 +++++++++++---
 builtin-push.c                  |    6 +++++-
 http-push.c                     |    9 +++++++--
 remote.c                        |   24 +++++++++++++++---------
 remote.h                        |    2 +-
 send-pack.c                     |    9 +++++++--
 t/t5516-fetch-push.sh           |    8 ++++++++
 transport.c                     |    8 ++++++--
 transport.h                     |    1 +
 11 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 3a69b71..8753611 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -30,6 +30,12 @@ OPTIONS
 	the remote repository can lose commits; use it with
 	care.
 
+\--create::
+	Usually, the command refuses to create a remote ref that is
+	not specified by its full name, i.e. starting with 'refs/'.
+	This flag tells the command to create the remote ref under
+	the full name of the local matching ref.
+
 --dry-run::
 	Do everything except actually send the updates.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index e5dd4c1..67b354b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--dry-run] [--create] [--tags] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]
 
 DESCRIPTION
@@ -86,6 +86,12 @@ the remote repository.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
 
+\--create::
+	Usually, the command refuses to create a remote ref that is
+	not specified by its full name, i.e. starting with 'refs/'.
+	This flag tells the command to create the remote ref under
+	the full name of the local matching ref.
+
 \--repo=<repo>::
 	When no repository is specified the command defaults to
 	"origin"; this overrides it.
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 2fa01d4..01495df 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -44,6 +44,12 @@ OPTIONS
 	the remote repository can lose commits; use it with
 	care.
 
+\--create::
+	Usually, the command refuses to create a remote ref that is
+	not specified by its full name, i.e. starting with 'refs/'.
+	This flag tells the command to create the remote ref under
+	the full name of the local matching ref.
+
 \--verbose::
 	Run verbosely.
 
@@ -97,9 +103,11 @@ destination side.
    * it has to start with "refs/"; <dst> is used as the
      destination literally in this case.
 
-   * <src> == <dst> and the ref that matched the <src> must not
-     exist in the set of remote refs; the ref matched <src>
-     locally is used as the name of the destination.
+   * Only <src> is specified and the ref that matched
+     <src> must not exist in the set of remote refs;
+     and the '--create' flag is used;
+     the ref matched <src> locally is used as the name of
+     the destination.
 
 Without '--force', the <src> ref is stored at the remote only if
 <dst> does not exist, or <dst> is a proper subset (i.e. an
diff --git a/builtin-push.c b/builtin-push.c
index 4b39ef3..4ab1401 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -8,7 +8,7 @@
 #include "remote.h"
 #include "transport.h"
 
-static const char push_usage[] = "git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char push_usage[] = "git-push [--all] [--dry-run] [--create] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
 
 static int thin, verbose;
 static const char *receivepack;
@@ -113,6 +113,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 			flags |= TRANSPORT_PUSH_DRY_RUN;
 			continue;
 		}
+		if (!strcmp(arg, "--create")) {
+			flags |= TRANSPORT_PUSH_CREATE;
+			continue;
+		}
 		if (!strcmp(arg, "--tags")) {
 			add_refspec("refs/tags/*");
 			continue;
diff --git a/http-push.c b/http-push.c
index c02a3af..4ad9f26 100644
--- a/http-push.c
+++ b/http-push.c
@@ -13,7 +13,7 @@
 #include <expat.h>
 
 static const char http_push_usage[] =
-"git-http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
+"git-http-push [--all] [--dry-run] [--create] [--force] [--verbose] <remote> [<head>...]\n";
 
 #ifndef XML_STATUS_OK
 enum XML_Status {
@@ -81,6 +81,7 @@ static int push_verbosely;
 static int push_all;
 static int force_all;
 static int dry_run;
+static int create;
 
 static struct object_list *objects;
 
@@ -2307,6 +2308,10 @@ int main(int argc, char **argv)
 				dry_run = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--create")) {
+				create = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--verbose")) {
 				push_verbosely = 1;
 				continue;
@@ -2389,7 +2394,7 @@ int main(int argc, char **argv)
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, push_all))
+		       nr_refspec, refspec, push_all, create))
 		return -1;
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
diff --git a/remote.c b/remote.c
index cf6441a..687eb8e 100644
--- a/remote.c
+++ b/remote.c
@@ -606,7 +606,7 @@ static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec *rs,
-			  int errs)
+			  int errs, int create)
 {
 	struct ref *matched_src, *matched_dst;
 
@@ -653,13 +653,19 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(lit_dst_value , "refs/", 5))
 			matched_dst = make_linked_ref(lit_dst_value, dst_tail);
-		else {
+		else if (!memcmp(search_dst_value, "refs/", 5))
+			if (create)
+				matched_dst = make_linked_ref(search_dst_value, dst_tail);
+			else
+				error("dst refspec %s does not match any "
+				      "existing ref on the remote.\n"
+				      "To create it use --create "
+				      "or the full ref %s.",
+				       lit_dst_value, search_dst_value);
+		else
 			error("dst refspec %s does not match any "
 			      "existing ref on the remote and does "
 			      "not start with refs/.", lit_dst_value);
-			if (!rs->dst)
-				error("Did you mean %s?\n", search_dst_value);
-		}
 		break;
 	default:
 		matched_dst = NULL;
@@ -683,11 +689,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
 			       struct ref ***dst_tail, struct refspec *rs,
-			       int rs_nr)
+			       int rs_nr, int create)
 {
 	int i, errs;
 	for (i = errs = 0; i < rs_nr; i++)
-		errs |= match_explicit(src, dst, dst_tail, &rs[i], errs);
+		errs |= match_explicit(src, dst, dst_tail, &rs[i], errs, create);
 	return -errs;
 }
 
@@ -717,12 +723,12 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
  * without thinking.
  */
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, char **refspec, int all)
+	       int nr_refspec, char **refspec, int all, int create)
 {
 	struct refspec *rs =
 		parse_ref_spec(nr_refspec, (const char **) refspec);
 
-	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
+	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec, create))
 		return -1;
 
 	/* pick the remainder */
diff --git a/remote.h b/remote.h
index c62636d..7d731b1 100644
--- a/remote.h
+++ b/remote.h
@@ -57,7 +57,7 @@ void ref_remove_duplicates(struct ref *ref_map);
 struct refspec *parse_ref_spec(int nr_refspec, const char **refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
-	       int nr_refspec, char **refspec, int all);
+	       int nr_refspec, char **refspec, int all, int create);
 
 /*
  * Given a list of the remote refs and the specification of things to
diff --git a/send-pack.c b/send-pack.c
index e9b9a39..77acae1 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -7,7 +7,7 @@
 #include "remote.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all] [--dry-run] [--create] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 static const char *receivepack = "git-receive-pack";
 static int verbose;
@@ -15,6 +15,7 @@ static int send_all;
 static int force_update;
 static int use_thin_pack;
 static int dry_run;
+static int create;
 
 /*
  * Make a pack stream and spit it out into file descriptor fd
@@ -201,7 +202,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, send_all))
+		       nr_refspec, refspec, send_all, create))
 		return -1;
 
 	if (!remote_refs) {
@@ -398,6 +399,10 @@ int main(int argc, char **argv)
 				dry_run = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--create")) {
+				create = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--force")) {
 				force_update = 1;
 				continue;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 5ba09e2..42ca0ff 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -156,6 +156,14 @@ test_expect_success 'push nonexisting (3)' '
 
 '
 
+test_expect_success 'push nonexisting (4)' '
+
+	mk_test &&
+	git push testrepo --create master &&
+	check_push_result $the_commit heads/master
+
+'
+
 test_expect_success 'push with matching heads' '
 
 	mk_test heads/master &&
diff --git a/transport.c b/transport.c
index 400af71..fbdbd0d 100644
--- a/transport.c
+++ b/transport.c
@@ -385,7 +385,7 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	int argc;
 	int err;
 
-	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
 	argv[0] = "http-push";
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
@@ -394,6 +394,8 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 		argv[argc++] = "--force";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
 		argv[argc++] = "--dry-run";
+	if (flags & TRANSPORT_PUSH_CREATE)
+		argv[argc++] = "--create";
 	argv[argc++] = transport->url;
 	while (refspec_nr--)
 		argv[argc++] = *refspec++;
@@ -658,7 +660,7 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	int argc;
 	int err;
 
-	argv = xmalloc((refspec_nr + 11) * sizeof(char *));
+	argv = xmalloc((refspec_nr + 12) * sizeof(char *));
 	argv[0] = "send-pack";
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
@@ -667,6 +669,8 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 		argv[argc++] = "--force";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
 		argv[argc++] = "--dry-run";
+	if (flags & TRANSPORT_PUSH_CREATE)
+		argv[argc++] = "--create";
 	if (data->receivepack) {
 		char *rp = xmalloc(strlen(data->receivepack) + 16);
 		sprintf(rp, "--receive-pack=%s", data->receivepack);
diff --git a/transport.h b/transport.h
index df12ea7..1d6a926 100644
--- a/transport.h
+++ b/transport.h
@@ -30,6 +30,7 @@ struct transport {
 #define TRANSPORT_PUSH_ALL 1
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
+#define TRANSPORT_PUSH_CREATE 8
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.5.3.4.439.ge8b49
