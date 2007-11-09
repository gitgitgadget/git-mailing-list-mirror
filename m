From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 10/11] git-fetch: avoid local fetching from alternate (again)
Date: Fri, 9 Nov 2007 06:06:45 -0500
Message-ID: <20071109110645.GJ19368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:08:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqRiU-00081j-F6
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbXKILGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbXKILGu
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:06:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34121 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbXKILGt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:06:49 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IqRhE-0003DU-BO; Fri, 09 Nov 2007 06:06:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BABF620FBAE; Fri,  9 Nov 2007 06:06:45 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64165>

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
To get aroaund this we spawn git-rev-list into a background process
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

Documentation for the new fetch_local_nocopy function was suggested
and written by Junio, based on his original comment in git-fetch.sh.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 transport.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/transport.c b/transport.c
index f4577b7..883348b 100644
--- a/transport.c
+++ b/transport.c
@@ -615,17 +615,76 @@ static struct ref *get_refs_via_connect(struct transport *transport)
 	return refs;
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
+static int fetch_local_nocopy(struct transport *transport,
+			       int nr_heads, struct ref **to_fetch)
+{
+	struct git_transport_data *data = transport->data;
+	struct child_process revlist;
+	char **argv;
+	int i, j, err;
+
+	/*
+	 * If we are deepening a shallow clone we already have these
+	 * objects reachable.  Running rev-list here will return with
+	 * a good (0) exit status and we'll bypass the fetch that we
+	 * really need to perform.  Claiming failure now will ensure
+	 * we perform the network exchange to deepen our history.
+	 */
+	if (data->depth)
+		return -1;
+
+	i = 0;
+	argv = xmalloc(sizeof(*argv) * (nr_heads + 6));
+	argv[i++] = xstrdup("rev-list");
+	argv[i++] = xstrdup("--quiet");
+	argv[i++] = xstrdup("--objects");
+	for (j = 0; j < nr_heads; j++)
+		argv[i++] = xstrdup(sha1_to_hex(to_fetch[j]->old_sha1));
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
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct git_transport_data *data = transport->data;
-	char **heads = xmalloc(nr_heads * sizeof(*heads));
-	char **origh = xmalloc(nr_heads * sizeof(*origh));
+	char **heads, **origh;
 	struct ref *refs;
-	char *dest = xstrdup(transport->url);
+	char *dest;
 	struct fetch_pack_args args;
 	int i;
 
+	if (!fetch_local_nocopy(transport, nr_heads, to_fetch))
+		return 0;
+
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->uploadpack;
 	args.keep_pack = data->keep;
@@ -634,6 +693,9 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.verbose = transport->verbose > 0;
 	args.depth = data->depth;
 
+	heads = xmalloc(nr_heads * sizeof(*heads));
+	origh = xmalloc(nr_heads * sizeof(*origh));
+	dest = xstrdup(transport->url);
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 	refs = fetch_pack(&args, dest, nr_heads, heads, &transport->pack_lockfile);
-- 
1.5.3.5.1622.g41d10
