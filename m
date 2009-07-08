From: Johan Herland <johan@herland.net>
Subject: [PATCH] quickfetch(): Prevent overflow of the rev-list command line
Date: Wed, 8 Jul 2009 15:58:51 +0200
Message-ID: <200907081558.51767.johan@herland.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <alpine.DEB.2.00.0906221342310.26061@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOXgE-0003Wk-Jq
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 15:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbZGHN7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbZGHN7U
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 09:59:20 -0400
Received: from sam.opera.com ([213.236.208.81]:56761 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791AbZGHN7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 09:59:19 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n68DwpSj030809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jul 2009 13:58:57 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.2.00.0906221342310.26061@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122899>

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
We therefore ignore SIGPIPE so that the fetch process is not terminated.

Signed-off-by: Johan Herland <johan@herland.net>
Tested-by: Peter Krefting <peter@softwolves.pp.se>
---

Hi,

It seems the git fetch failure described by Peter earlier in this thread
is caused by a long ref list overflowing the command line buffer on
Windows (32K I am told), when calling rev-list from quickfetch(). AFAICS
this overflow will trigger on any fetch from msysgit with more than ~800
(32K / 40) refs.

According to Peter, this patch fixes the submodule update failure.

CC-ing Shawn since he is the original author of quickfetch().


Have fun! :)

...Johan

 builtin-fetch.c |   63 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cd5eb9a..52febc6 100644
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
@@ -416,9 +416,10 @@ static int quickfetch(struct ref *ref_map)
 {
 	struct child_process revlist;
 	struct ref *ref;
-	char **argv;
-	int i, err;
-
+	int err;
+	const char *argv[] = {
+		"rev-list", "--quiet", "--objects", "--stdin", "--not", "--all", NULL
+	};
 	/*
 	 * If we are deepening a shallow clone we already have these
 	 * objects reachable.  Running rev-list here will return with
@@ -429,34 +430,40 @@ static int quickfetch(struct ref *ref_map)
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
+	/* If rev-list --stdin encounters an unknown commit, it terminates,
+	 * which will cause SIGPIPE in the write loop below. */
+	signal(SIGPIPE, SIG_IGN);
+
+	err = start_command(&revlist);
+	if (err) {
+		error("could not run rev-list");
+		return err;
+	}
 
-	for (i = 0; argv[i]; i++)
-		free(argv[i]);
-	free(argv);
-	return err;
+	for (ref = ref_map; ref; ref = ref->next) {
+		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
+		    write_in_full(revlist.in, "\n", 1) < 0) {
+			error("failed write to rev-list");
+			err = errno;
+			break;
+		}
+	}
+
+	if (close(revlist.in)) {
+		error("failed to close rev-list's stdin");
+		err = errno;
+	}
+	return finish_command(&revlist) || err;
 }
 
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
-- 
1.6.3.2.316.gda4e
