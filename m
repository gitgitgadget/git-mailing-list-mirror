From: mhagger@alum.mit.edu
Subject: [PATCH 2/2] cmd_fetch_pack(): fix constness problem and memory leak
Date: Wed,  2 May 2012 12:40:59 +0200
Message-ID: <1335955259-15309-3-git-send-email-mhagger@alum.mit.edu>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 12:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPWzm-0006EL-1h
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 12:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab2EBKlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 06:41:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37029 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab2EBKlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 06:41:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q42Af4FY009926;
	Wed, 2 May 2012 12:41:10 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196799>

From: Michael Haggerty <mhagger@alum.mit.edu>

The old code cast away the constness of the strings passed to the
function in argument argv[], which could result in their being
modified by filter_refs().  Moreover, if refs were passed via stdin,
then the memory allocated for them was never freed (though, of course,
this function is only called once so it is not a real problem).

Fix both errors by copying *all* reference names into our own array
and always freeing the array at the end of the function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I understand that it is not crucial to free memory allocated in a
cmd_*() function but it is unclear to me whether it is *preferred* to
let the process clean up take care of things.  If so, the last chunk
of this patch can be omitted.

 builtin/fetch-pack.c |  149 +++++++++++++++++++++++++-------------------------
 1 file changed, 75 insertions(+), 74 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7e9d62f..5f769e9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -899,10 +899,11 @@ static void fetch_pack_setup(void)
 
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, ret, nr_heads;
+	int i, ret;
 	struct ref *ref = NULL;
 	const char *dest = NULL;
-	char **heads;
+	int alloc_heads = 0, nr_heads = 0;
+	char **heads = NULL;
 	int fd[2];
 	char *pack_lockfile = NULL;
 	char **pack_lockfile_ptr = NULL;
@@ -910,86 +911,82 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch-pack");
 
-	nr_heads = 0;
-	heads = NULL;
-	for (i = 1; i < argc; i++) {
+	for (i = 1; i < argc && *argv[i] == '-'; i++) {
 		const char *arg = argv[i];
 
-		if (*arg == '-') {
-			if (!prefixcmp(arg, "--upload-pack=")) {
-				args.uploadpack = arg + 14;
-				continue;
-			}
-			if (!prefixcmp(arg, "--exec=")) {
-				args.uploadpack = arg + 7;
-				continue;
-			}
-			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
-				args.quiet = 1;
-				continue;
-			}
-			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
-				args.lock_pack = args.keep_pack;
-				args.keep_pack = 1;
-				continue;
-			}
-			if (!strcmp("--thin", arg)) {
-				args.use_thin_pack = 1;
-				continue;
-			}
-			if (!strcmp("--include-tag", arg)) {
-				args.include_tag = 1;
-				continue;
-			}
-			if (!strcmp("--all", arg)) {
-				args.fetch_all = 1;
-				continue;
-			}
-			if (!strcmp("--stdin", arg)) {
-				args.stdin_refs = 1;
-				continue;
-			}
-			if (!strcmp("-v", arg)) {
-				args.verbose = 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--depth=")) {
-				args.depth = strtol(arg + 8, NULL, 0);
-				continue;
-			}
-			if (!strcmp("--no-progress", arg)) {
-				args.no_progress = 1;
-				continue;
-			}
-			if (!strcmp("--stateless-rpc", arg)) {
-				args.stateless_rpc = 1;
-				continue;
-			}
-			if (!strcmp("--lock-pack", arg)) {
-				args.lock_pack = 1;
-				pack_lockfile_ptr = &pack_lockfile;
-				continue;
-			}
-			usage(fetch_pack_usage);
+		if (!prefixcmp(arg, "--upload-pack=")) {
+			args.uploadpack = arg + 14;
+			continue;
+		}
+		if (!prefixcmp(arg, "--exec=")) {
+			args.uploadpack = arg + 7;
+			continue;
+		}
+		if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
+			args.quiet = 1;
+			continue;
+		}
+		if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
+			args.lock_pack = args.keep_pack;
+			args.keep_pack = 1;
+			continue;
+		}
+		if (!strcmp("--thin", arg)) {
+			args.use_thin_pack = 1;
+			continue;
+		}
+		if (!strcmp("--include-tag", arg)) {
+			args.include_tag = 1;
+			continue;
+		}
+		if (!strcmp("--all", arg)) {
+			args.fetch_all = 1;
+			continue;
+		}
+		if (!strcmp("--stdin", arg)) {
+			args.stdin_refs = 1;
+			continue;
+		}
+		if (!strcmp("-v", arg)) {
+			args.verbose = 1;
+			continue;
+		}
+		if (!prefixcmp(arg, "--depth=")) {
+			args.depth = strtol(arg + 8, NULL, 0);
+			continue;
 		}
-		dest = arg;
-		heads = (char **)(argv + i + 1);
-		nr_heads = argc - i - 1;
-		break;
+		if (!strcmp("--no-progress", arg)) {
+			args.no_progress = 1;
+			continue;
+		}
+		if (!strcmp("--stateless-rpc", arg)) {
+			args.stateless_rpc = 1;
+			continue;
+		}
+		if (!strcmp("--lock-pack", arg)) {
+			args.lock_pack = 1;
+			pack_lockfile_ptr = &pack_lockfile;
+			continue;
+		}
+		usage(fetch_pack_usage);
 	}
-	if (!dest)
+	if (i < argc)
+		dest = argv[i++];
+	else
 		usage(fetch_pack_usage);
 
+	/*
+	 * Copy refs from cmdline to new growable list, then append
+	 * any refs from the standard input.
+	 */
+	ALLOC_GROW(heads, argc - i, alloc_heads);
+	for (; i < argc; i++)
+		heads[nr_heads++] = xstrdup(argv[i]);
+
 	if (args.stdin_refs) {
-		/*
-		 * Copy refs from cmdline to new growable list, then
-		 * append the refs from the standard input.
-		 */
-		int alloc_heads = nr_heads;
-		int size = nr_heads * sizeof(*heads);
-		heads = memcpy(xmalloc(size), heads, size);
 		if (args.stateless_rpc) {
-			/* in stateless RPC mode we use pkt-line to read
+			/*
+			 * in stateless RPC mode we use pkt-line to read
 			 * from stdin, until we get a flush packet
 			 */
 			static char line[1000];
@@ -1055,6 +1052,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		ref = ref->next;
 	}
 
+	for (i = 0; i < nr_heads; ++i)
+		free(heads[i]);
+	free(heads);
+
 	return ret;
 }
 
-- 
1.7.10
