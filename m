From: Johan Herland <johan@herland.net>
Subject: [PATCH v4] quickfetch(): Prevent overflow of the rev-list command line
Date: Thu, 09 Jul 2009 16:49:26 +0200
Message-ID: <200907091649.26575.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <4A55FCD5.2020908@viscovery.net>
 <20090709143203.GA31138@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 16:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOuwL-0007c2-AG
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 16:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbZGIOta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 10:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbZGIOta
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 10:49:30 -0400
Received: from mx.getmail.no ([84.208.15.66]:41308 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751496AbZGIOt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 10:49:29 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI008JORUGUL40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 16:49:28 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KMI00CZ7RUEI210@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 09 Jul 2009 16:49:28 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.9.143626
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <20090709143203.GA31138@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122980>

quickfetch() calls rev-list to check whether the objects we are about to
fetch are already present in the repo (if so, we can skip the object fetch).
However, when there are many (~1000) refs to be fetched, the rev-list
command line grows larger than the maximum command line size on some systems
(32K in Windows). This causes rev-list to fail, making quickfetch() return
non-zero, which unnecessarily triggers the transport machinery. This somehow
causes fetch to fail with an exit code.

By using the --stdin option to rev-list (and feeding the object list to its
standard input), we prevent the overflow of the rev-list command line,
which causes quickfetch(), and subsequently the overall fetch, to succeed.

However, using rev-list --stdin is not entirely straightforward: rev-list
terminates immediately when encountering an unknown object, which can
trigger SIGPIPE if we are still writing object's to its standard input.
We therefore temporarily ignore SIGPIPE so that the fetch process is not
terminated.

The patch also contains a testcase to verify the fix (note that before
the patch, the testcase would only fail on msysGit).

Signed-off-by: Johan Herland <johan@herland.net>
Improved-by: Johannes Sixt <j6t@kdbg.org>
Improved-by: Alex Riesen <raa.lkml@gmail.com>
Tested-by: Peter Krefting <peter@softwolves.pp.se>
---

On Thursday 09 July 2009, Jeff King wrote:
> That being said, in the patch in question there is an early return after
> the push that misses the corresponding pop. That should be fixed.

Thanks, fixed.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

 builtin-fetch.c       |   65 ++++++++++++++++++++++++++++--------------------
 t/t5502-quickfetch.sh |   20 +++++++++++++++
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cd5eb9a..34ba878 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -400,14 +400,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 /*
  * We would want to bypass the object transfer altogether if
- * everything we are going to fetch already exists and connected
+ * everything we are going to fetch already exists and is connected
  * locally.
  *
- * The refs we are going to fetch are in to_fetch (nr_heads in
- * total).  If running
+ * The refs we are going to fetch are in ref_map.  If running
  *
- *  $ git rev-list --objects to_fetch[0] to_fetch[1] ... --not --all
+ *  $ git rev-list --objects --stdin --not --all
  *
+ * (feeding all the refs in ref_map on its standard input)
  * does not error out, that means everything reachable from the
  * refs we are going to fetch exists and is connected to some of
  * our existing refs.
@@ -416,8 +416,9 @@ static int quickfetch(struct ref *ref_map)
 {
 	struct child_process revlist;
 	struct ref *ref;
-	char **argv;
-	int i, err;
+	int err;
+	const char *argv[] = {"rev-list",
+		"--quiet", "--objects", "--stdin", "--not", "--all", NULL};
 
 	/*
 	 * If we are deepening a shallow clone we already have these
@@ -429,34 +430,44 @@ static int quickfetch(struct ref *ref_map)
 	if (depth)
 		return -1;
 
-	for (i = 0, ref = ref_map; ref; ref = ref->next)
-		i++;
-	if (!i)
+	if (!ref_map)
 		return 0;
 
-	argv = xmalloc(sizeof(*argv) * (i + 6));
-	i = 0;
-	argv[i++] = xstrdup("rev-list");
-	argv[i++] = xstrdup("--quiet");
-	argv[i++] = xstrdup("--objects");
-	for (ref = ref_map; ref; ref = ref->next)
-		argv[i++] = xstrdup(sha1_to_hex(ref->old_sha1));
-	argv[i++] = xstrdup("--not");
-	argv[i++] = xstrdup("--all");
-	argv[i++] = NULL;
-
 	memset(&revlist, 0, sizeof(revlist));
-	revlist.argv = (const char**)argv;
+	revlist.argv = argv;
 	revlist.git_cmd = 1;
-	revlist.no_stdin = 1;
 	revlist.no_stdout = 1;
 	revlist.no_stderr = 1;
-	err = run_command(&revlist);
+	revlist.in = -1;
+
+	err = start_command(&revlist);
+	if (err) {
+		error("could not run rev-list");
+		return err;
+	}
+
+	/* If rev-list --stdin encounters an unknown commit, it terminates,
+	 * which will cause SIGPIPE in the write loop below. */
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	for (ref = ref_map; ref; ref = ref->next) {
+		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
+		    write_in_full(revlist.in, "\n", 1) < 0) {
+			if (err != EPIPE && err != EINVAL)
+				error("failed write to rev-list: %s", strerror(errno));
+			err = -1;
+			break;
+		}
+	}
+
+	if (close(revlist.in)) {
+		error("failed to close rev-list's stdin: %s", strerror(errno));
+		err = -1;
+	}
+
+	sigchain_pop(SIGPIPE);
 
-	for (i = 0; argv[i]; i++)
-		free(argv[i]);
-	free(argv);
-	return err;
+	return finish_command(&revlist) || err;
 }
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 16eadd6..1037a72 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -119,4 +119,24 @@ test_expect_success 'quickfetch should not copy from alternate' '
 
 '
 
+test_expect_success 'quickfetch should handle ~1000 refs (on Windows)' '
+
+	git gc &&
+	head=$(git rev-parse HEAD) &&
+	branchprefix="$head refs/heads/branch" &&
+	for i in 0 1 2 3 4 5 6 7 8 9; do
+		for j in 0 1 2 3 4 5 6 7 8 9; do
+			for k in 0 1 2 3 4 5 6 7 8 9; do
+				echo "$branchprefix$i$j$k" >> .git/packed-refs
+			done
+		done
+	done &&
+	(
+		cd cloned &&
+		git fetch &&
+		git fetch
+	)
+
+'
+
 test_done
-- 
1.6.3.rc0.1.gf800
