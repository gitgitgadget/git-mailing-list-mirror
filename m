From: mhagger@alum.mit.edu
Subject: [PATCH v2 4/4] cmd_fetch_pack(): respect constness of argv parameter
Date: Mon, 21 May 2012 09:59:59 +0200
Message-ID: <1337587199-21099-5-git-send-email-mhagger@alum.mit.edu>
References: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:08:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNf0-0003JW-DC
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab2EUIIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:08:04 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:47307 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563Ab2EUIH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:07:59 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2012 04:07:59 EDT
X-AuditID: 1207440e-b7f256d0000008c1-46-4fb9f6268b5f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 98.67.02241.626F9BF4; Mon, 21 May 2012 04:00:38 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L80LO1006950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:00:38 -0400
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqKv2bae/wdMeQ4uuK91MFg29V5gt
	bq+Yz2zRPeUtowOLx9/3H5g8ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGQ8aF7IX
	HBKs6P3YydjA+IC3i5GTQ0LAROLeor/sELaYxIV769m6GLk4hAQuM0p0/F/KDuGcYZJovf6e
	DaSKTUBK4mVjD1iHiICaxMS2QyxdjBwczALFEpcXm4CEhQV8JTa9+ApWwiKgKrHt0ldmEJtX
	wEVi1f0NLBDL5CWe3u8DG8kp4Cpx6PpusLgQUM2Gh4vZJjDyLmBkWMUol5hTmqubm5iZU5ya
	rFucnJiXl1qka6yXm1mil5pSuokREj58Oxjb18scYhTgYFTi4XWasdNfiDWxrLgy9xCjJAeT
	kiiv6SegEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeuw+BcrwpiZVVqUX5MClpDhYlcV61Jep+
	QgLpiSWp2ampBalFMFkZDg4lCd6pX4EaBYtS01Mr0jJzShDSTBycIIILZAMP0IYEkELe4oLE
	3OLMdIiiU4yKUuK8zSAJAZBERmke3ABYpL9iFAf6R5h3KUgVDzBJwHW/AhrMBDQ46AXY4JJE
	hJRUA6Oz4tILlrrrEzpuMhUsvaV1LCqj0dKTV8gjuuSbQ8jfj8fKtjxmnpll9+wkw5OKU6x9
	Jx72Pfjwvo3ze0dWlt+2iy2n038EndpgvT35nLjClYeLM2exv3UL6zkpqKT8MSL8/Mv/2x/1
	NunssV94y/KZSEqxn0zurV2Rty+Kf9x757vPlmcc1TeVWIozEg21mIuKEwFksQeZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198093>

From: Michael Haggerty <mhagger@alum.mit.edu>

The old code cast away the constness of the strings passed to the
function in argument argv[], which could result in their being
modified by filter_refs().  Fix by copying reference names from argv
and putting them into our own array (similarly to how refnames passed
to stdin were already handled).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This change results in heads being left set to NULL if nr_heads==0,
but all of the code paths are OK with this.

 builtin/fetch-pack.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 96849a4..7ad9e54 100644
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
@@ -910,7 +911,6 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch-pack");
 
-	heads = NULL;
 	for (i = 1; i < argc && *argv[i] == '-'; i++) {
 		const char *arg = argv[i];
 
@@ -976,17 +976,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	else
 		usage(fetch_pack_usage);
 
-	heads = (char **)(argv + i);
-	nr_heads = argc - i;
-
+	/*
+	 * Copy refs from cmdline to growable list, then append any
+	 * refs from the standard input:
+	 */
+	ALLOC_GROW(heads, argc - i, alloc_heads);
+	for (; i < argc; i++)
+		heads[nr_heads++] = xstrdup(argv[i]);
 	if (args.stdin_refs) {
-		/*
-		 * Copy refs from cmdline to new growable list, then
-		 * append the refs from the standard input.
-		 */
-		int alloc_heads = nr_heads;
-		int size = nr_heads * sizeof(*heads);
-		heads = memcpy(xmalloc(size), heads, size);
 		if (args.stateless_rpc) {
 			/* in stateless RPC mode we use pkt-line to read
 			 * from stdin, until we get a flush packet
-- 
1.7.10
