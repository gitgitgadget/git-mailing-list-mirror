From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Tue, 6 Nov 2007 21:41:18 -0500
Message-ID: <20071107024118.GA11043@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 03:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IparP-0006xX-D7
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 03:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbXKGClX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 21:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbXKGClX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 21:41:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55684 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbXKGClW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 21:41:22 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ipaqq-0004Vh-BH; Tue, 06 Nov 2007 21:41:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 825F320FBAE; Tue,  6 Nov 2007 21:41:18 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63767>

Back in e3c6f240fd9c5bdeb33f2d47adc859f37935e2df Junio taught
git-fetch to avoid copying objects when we are fetching from
a repository that is already registered as an alternate object
database.  In such a case there is no reason to copy any objects
as we can already obtain them through the alternate.

However we need to ensure the objects are all reachable, so we
run `git rev-list --objects $theirs --not --all` to verify this.
If any object is missing or unreadable then we need to instead copy
the objects from the remote.  When a missing object is detected
the git-rev-list process will exit with a non-zero exit status,
making this condition quite easy to detect.

Although git-fetch is currently a builtin (and so is rev-list) we
really cannot invoke the traverse_objects() API at this point in the
transport code.  The object walker within traverse_objects() calls
die() as soon as it finds an object it cannot read.  If that happens
we want to resume the fetch process by calling do_fetch_pack(),
instead of terminating.  To get aroaund this we spawn git-rev-list
into a background process to prevent a die() from killing the
foreground fetch process.

We aren't interested in the output of rev-list (a list of SHA-1
object names that are reachable) or its errors (a "spurious" error
about an object not being found as we need to copy it) so we redirect
both stdout and stderr to /dev/null.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |    6 ++++--
 run-command.h |    1 +
 transport.c   |   48 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index d99a6c4..476d00c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -41,7 +41,7 @@ int start_command(struct child_process *cmd)
 		cmd->close_out = 1;
 	}
 
-	need_err = cmd->err < 0;
+	need_err = !cmd->no_stderr && cmd->err < 0;
 	if (need_err) {
 		if (pipe(fderr) < 0) {
 			if (need_in)
@@ -87,7 +87,9 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
-		if (need_err) {
+		if (cmd->no_stderr)
+			dup_devnull(2);
+		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
 		}
diff --git a/run-command.h b/run-command.h
index 94e1e9d..1fc781d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -23,6 +23,7 @@ struct child_process {
 	unsigned close_out:1;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
+	unsigned no_stderr:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
 };
diff --git a/transport.c b/transport.c
index f4577b7..8505a84 100644
--- a/transport.c
+++ b/transport.c
@@ -615,17 +615,56 @@ static struct ref *get_refs_via_connect(struct transport *transport)
 	return refs;
 }
 
+static int fetch_local_nocopy(struct transport *transport,
+			       int nr_heads, struct ref **to_fetch)
+{
+	struct stat sb;
+	struct child_process revlist;
+	char **argv;
+	int i, j, err;
+
+	if (stat(transport->url, &sb) || !S_ISDIR(sb.st_mode))
+		return -1;
+
+	i = 0;
+	argv = xmalloc(sizeof(*argv) * (nr_heads + 5));
+	argv[i++] = xstrdup("rev-list");
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
+	err = start_command(&revlist);
+	if (!err)
+		err |= finish_command(&revlist);
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
@@ -634,6 +673,9 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.verbose = transport->verbose > 0;
 	args.depth = data->depth;
 
+	heads = xmalloc(nr_heads * sizeof(*heads));
+	origh = xmalloc(nr_heads * sizeof(*origh));
+	dest = xstrdup(transport->url);
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 	refs = fetch_pack(&args, dest, nr_heads, heads, &transport->pack_lockfile);
-- 
1.5.3.5.1590.gfadfad
