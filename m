From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/5] git-fetch: avoid local fetching from alternate (again)
Date: Sun, 11 Nov 2007 02:29:47 -0500
Message-ID: <20071111072947.GE19146@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 08:30:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir7Gm-0003KR-BG
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 08:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXKKH3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 02:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXKKH3w
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 02:29:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41463 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXKKH3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 02:29:51 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir7GP-000103-4A; Sun, 11 Nov 2007 02:29:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 53CE920FBAE; Sun, 11 Nov 2007 02:29:47 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64418>

Back in e3c6f240fd9c5bdeb33f2d47adc859f37935e2df Junio taught
git-fetch to avoid copying objects when we are fetching from
a repository that is already registered as an alternate object
database.  In such a case there is no reason to copy any objects
as we can already obtain them through the alternate.

However we need to ensure the objects are all reachable, so we
run `git rev-list --objects $theirs --not --all` to verify this.
If any object is missing or unreadable then we need to fetch/copy
the objects from the remote.  When a missing object is detected
the git-rev-list process will exit with a non-zero exit status,
making this condition quite easy to detect.

Although git-fetch is currently a builtin (and so is rev-list)
we cannot invoke the traverse_objects() API at this point in the
transport code.  The object walker within traverse_objects() calls
die() as soon as it finds an object it cannot read.  If that happens
we want to resume the fetch process by calling do_fetch_pack().
To get around this we spawn git-rev-list into a background process
to prevent a die() from killing the foreground fetch process,
thus allowing the fetch process to resume into do_fetch_pack()
if copying is necessary.

We aren't interested in the output of rev-list (a list of SHA-1
object names that are reachable) or its errors (a "spurious" error
about an object not being found as we need to copy it) so we redirect
both stdout and stderr to /dev/null.

We run this git-rev-list based check before any fetch as we may
already have the necessary objects local from a prior fetch.  If we
don't then its very likely the first $theirs object listed on the
command line won't exist locally and git-rev-list will die very
quickly, allowing us to start the network transfer.  This test even
on remote URLs may save bandwidth if someone runs `git pull origin`,
sees a merge conflict, resets out, then redoes the same pull just
a short time later.  If the remote hasn't changed between the two
pulls and the local repository hasn't had git-gc run in it then
there is probably no need to perform network transfer as all of
the objects are local.

Documentation for the new quickfetch function was suggested and
written by Junio, based on his original comment in git-fetch.sh.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c       |   69 +++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5502-quickfetch.sh |   33 +++++++++++++++++++++++
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index a935b5a..31e138e 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -8,10 +8,12 @@
 #include "path-list.h"
 #include "remote.h"
 #include "transport.h"
+#include "run-command.h"
 
 static const char fetch_usage[] = "git-fetch [-a | --append] [--upload-pack <upload-pack>] [-f | --force] [--no-tags] [-t | --tags] [-k | --keep] [-u | --update-head-ok] [--depth <depth>] [-v | --verbose] [<repository> <refspec>...]";
 
 static int append, force, tags, no_tags, update_head_ok, verbose, quiet;
+static const char *depth;
 static char *default_rla = NULL;
 static struct transport *transport;
 
@@ -335,9 +337,72 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 	fclose(fp);
 }
 
+/*
+ * We would want to bypass the object transfer altogether if
+ * everything we are going to fetch already exists and connected
+ * locally.
+ *
+ * The refs we are going to fetch are in to_fetch (nr_heads in
+ * total).  If running
+ *
+ *  $ git-rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
+ *
+ * does not error out, that means everything reachable from the
+ * refs we are going to fetch exists and is connected to some of
+ * our existing refs.
+ */
+static int quickfetch(struct ref *ref_map)
+{
+	struct child_process revlist;
+	struct ref *ref;
+	char **argv;
+	int i, err;
+
+	/*
+	 * If we are deepening a shallow clone we already have these
+	 * objects reachable.  Running rev-list here will return with
+	 * a good (0) exit status and we'll bypass the fetch that we
+	 * really need to perform.  Claiming failure now will ensure
+	 * we perform the network exchange to deepen our history.
+	 */
+	if (depth)
+		return -1;
+
+	for (i = 0, ref = ref_map; ref; ref = ref->next)
+		i++;
+	if (!i)
+		return 0;
+
+	argv = xmalloc(sizeof(*argv) * (i + 6));
+	i = 0;
+	argv[i++] = xstrdup("rev-list");
+	argv[i++] = xstrdup("--quiet");
+	argv[i++] = xstrdup("--objects");
+	for (ref = ref_map; ref; ref = ref->next)
+		argv[i++] = xstrdup(sha1_to_hex(ref->old_sha1));
+	argv[i++] = xstrdup("--not");
+	argv[i++] = xstrdup("--all");
+	argv[i++] = NULL;
+
+	memset(&revlist, 0, sizeof(revlist));
+	revlist.argv = (const char**)argv;
+	revlist.git_cmd = 1;
+	revlist.no_stdin = 1;
+	revlist.no_stdout = 1;
+	revlist.no_stderr = 1;
+	err = run_command(&revlist);
+
+	for (i = 0; argv[i]; i++)
+		free(argv[i]);
+	free(argv);
+	return err;
+}
+
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret = transport_fetch_refs(transport, ref_map);
+	int ret = quickfetch(ref_map);
+	if (ret)
+		ret = transport_fetch_refs(transport, ref_map);
 	if (!ret)
 		store_updated_refs(transport->url, ref_map);
 	transport_unlock_pack(transport);
@@ -473,7 +538,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	static const char **refs = NULL;
 	int ref_nr = 0;
 	int cmd_len = 0;
-	const char *depth = NULL, *upload_pack = NULL;
+	const char *upload_pack = NULL;
 	int keep = 0;
 
 	for (i = 1; i < argc; i++) {
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b4760f2..16eadd6 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -86,4 +86,37 @@ test_expect_success 'quickfetch should not leave a corrupted repository' '
 
 '
 
+test_expect_success 'quickfetch should not copy from alternate' '
+
+	(
+		mkdir quickclone &&
+		cd quickclone &&
+		git init-db &&
+		(cd ../.git/objects && pwd) >.git/objects/info/alternates &&
+		git remote add origin .. &&
+		git fetch -k -k
+	) &&
+	obj_cnt=$( (
+		cd quickclone &&
+		git count-objects | sed -e "s/ *objects,.*//"
+	) ) &&
+	pck_cnt=$( (
+		cd quickclone &&
+		git count-objects -v | sed -n -e "/packs:/{
+				s/packs://
+				p
+				q
+			}"
+	) ) &&
+	origin_master=$( (
+		cd quickclone &&
+		git rev-parse origin/master
+	) ) &&
+	echo "loose objects: $obj_cnt, packfiles: $pck_cnt" &&
+	test $obj_cnt -eq 0 &&
+	test $pck_cnt -eq 0 &&
+	test z$origin_master = z$(git rev-parse master)
+
+'
+
 test_done
-- 
1.5.3.5.1661.gcbf0
