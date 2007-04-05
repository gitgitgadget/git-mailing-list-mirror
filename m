From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-fetch--tool pick-rref
Date: Thu, 05 Apr 2007 03:22:54 -0700
Message-ID: <7v7isrrugx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	<Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	<20070403210319.GH27706@spearce.org>
	<Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	<20070403211709.GJ27706@spearce.org>
	<Pine.LNX.4.64.0704031425220.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704031427050.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 12:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZP7N-00087P-IQ
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 12:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966025AbXDEKW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 06:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966063AbXDEKW5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 06:22:57 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58410 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966025AbXDEKWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 06:22:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405102255.GRU792.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 06:22:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jNNu1W0091kojtg0000000; Thu, 05 Apr 2007 06:22:55 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43812>

This script helper takes list of fully qualified refnames and
results from ls-remote and grabs only the lines for the named
refs from the latter.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Linus Torvalds <torvalds@linux-foundation.org> writes:
  > On Tue, 3 Apr 2007, Linus Torvalds wrote:
  >> 
  >> Yes, we could definitely skip the re-lookup if we had a "don't really 
  >> care, I can recreate the object myself" flag (ie anybody who is going to 
  >> write that object)
  >
  > Side note: with "alternates" files, you might well *always* have the 
  > objects. If you do
  >
  > 	git clone -l -s ...
  >
  > to create various branches, and then pull between them, you'll actually 
  > end up in the situation that you'll always find the objects and get back 
  > to the really expensive case..

  Ah, that's true.  If you "git clone -l -s A B", create new
  objects in A and pull from B, the transfer would not exclude
  new objects as they are not visible from B's refs.

  In that scenario, the keep-pack behaviour is already worse than
  the unpack-objects behaviour.  The former creates a packfile
  that duplicates objects that are in A while the latter, although
  expensive, ends up doing nothing.

  I wonder if we can have a backdoor to avoid any object transfer
  in such a case to begin with...

  ... and this two patch series does exactly that.

 builtin-fetch--tool.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e9d6764..be341c1 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -436,10 +436,87 @@ static int expand_refs_wildcard(const char *ls_remote_result, int numrefs,
 	return 0;
 }
 
+static int pick_rref(int sha1_only, const char *rref, const char *ls_remote_result)
+{
+	int err = 0;
+	int lrr_count = lrr_count, i, pass;
+	const char *cp;
+	struct lrr {
+		const char *line;
+		const char *name;
+		int namelen;
+		int shown;
+	} *lrr_list = lrr_list;
+
+	for (pass = 0; pass < 2; pass++) {
+		/* pass 0 counts and allocates, pass 1 fills... */
+		cp = ls_remote_result;
+		i = 0;
+		while (1) {
+			const char *np;
+			while (*cp && isspace(*cp))
+				cp++;
+			if (!*cp)
+				break;
+			np = strchr(cp, '\n');
+			if (!np)
+				np = cp + strlen(cp);
+			if (pass) {
+				lrr_list[i].line = cp;
+				lrr_list[i].name = cp + 41;
+				lrr_list[i].namelen = np - (cp + 41);
+			}
+			i++;
+			cp = np;
+		}
+		if (!pass) {
+			lrr_count = i;
+			lrr_list = xcalloc(lrr_count, sizeof(*lrr_list));
+		}
+	}
+
+	while (1) {
+		const char *next;
+		int rreflen;
+		int i;
+
+		while (*rref && isspace(*rref))
+			rref++;
+		if (!*rref)
+			break;
+		next = strchr(rref, '\n');
+		if (!next)
+			next = rref + strlen(rref);
+		rreflen = next - rref;
+
+		for (i = 0; i < lrr_count; i++) {
+			struct lrr *lrr = &(lrr_list[i]);
+
+			if (rreflen == lrr->namelen &&
+			    !memcmp(lrr->name, rref, rreflen)) {
+				if (!lrr->shown)
+					printf("%.*s\n",
+					       sha1_only ? 40 : lrr->namelen + 41,
+					       lrr->line);
+				lrr->shown = 1;
+				break;
+			}
+		}
+		if (lrr_count <= i) {
+			error("pick-rref: %.*s not found", rreflen, rref);
+			err = 1;
+		}
+		rref = next;
+	}
+	free(lrr_list);
+	return err;
+}
+
 int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 {
 	int verbose = 0;
 	int force = 0;
+	int sopt = 0;
 
 	while (1 < argc) {
 		const char *arg = argv[1];
@@ -447,6 +524,8 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 			verbose = 1;
 		else if (!strcmp("-f", arg))
 			force = 1;
+		else if (!strcmp("-s", arg))
+			sopt = 1;
 		else
 			break;
 		argc--;
@@ -491,6 +570,11 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 			reflist = get_stdin();
 		return parse_reflist(reflist);
 	}
+	if (!strcmp("pick-rref", argv[1])) {
+		if (argc != 4)
+			return error("pick-rref takes 2 args");
+		return pick_rref(sopt, argv[2], argv[3]);
+	}
 	if (!strcmp("expand-refs-wildcard", argv[1])) {
 		const char *reflist;
 		if (argc < 4)
-- 
1.5.1.45.g1ddb
