From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCHv2 1/2] builtin-remote.c: Split out prune_remote as a
	separate function.
Date: Fri, 3 Apr 2009 11:02:37 +0200
Message-ID: <20090403090237.GA5199@pvv.org>
References: <20090402123823.GA1756@pvv.org> <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com> <20090402134414.GB26699@coredump.intra.peff.net> <7vab6zexq7.fsf@gitster.siamese.dyndns.org> <20090402201803.GA5397@pvv.org> <7vljqieq1r.fsf@gitster.siamese.dyndns.org> <20090403090036.GA23955@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 11:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpfJy-0003K8-3Z
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 11:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbZDCJCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 05:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbZDCJCr
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 05:02:47 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:52803 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbZDCJCq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 05:02:46 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LpfIL-0001ZA-OD; Fri, 03 Apr 2009 11:02:37 +0200
Content-Disposition: inline
In-Reply-To: <20090403090036.GA23955@pvv.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115521>

prune_remote will be used in update(), so this function was split
out to avoid code duplication.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 builtin-remote.c |   56 +++++++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 9ef846f..9804d6c 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -26,6 +26,7 @@ static const char * const builtin_remote_usage[] = {
 static int verbose;
 
 static int show_all(void);
+static int prune_remote(const char *remote, int dry_run);
 
 static inline int postfixcmp(const char *string, const char *postfix)
 {
@@ -1128,46 +1129,51 @@ static int prune(int argc, const char **argv)
 		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
-	struct ref_states states;
-	const char *dangling_msg;
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
 	if (argc < 1)
 		usage_with_options(builtin_remote_usage, options);
 
-	dangling_msg = (dry_run
-			? " %s will become dangling!\n"
-			: " %s has become dangling!\n");
+	for (; argc; argc--, argv++)
+		result |= prune_remote(*argv, dry_run);
 
-	memset(&states, 0, sizeof(states));
-	for (; argc; argc--, argv++) {
-		int i;
+	return result;
+}
 
-		get_remote_ref_states(*argv, &states, GET_REF_STATES);
+static int prune_remote(const char *remote, int dry_run)
+{
+	int result = 0;
+	struct ref_states states;
+	const char *dangling_msg = dry_run
+		? " %s will become dangling!\n"
+		: " %s has become dangling!\n";
 
-		if (states.stale.nr) {
-			printf("Pruning %s\n", *argv);
-			printf("URL: %s\n",
-			       states.remote->url_nr
-			       ? states.remote->url[0]
-			       : "(no URL)");
-		}
+	memset(&states, 0, sizeof(states));
+	int i;
 
-		for (i = 0; i < states.stale.nr; i++) {
-			const char *refname = states.stale.items[i].util;
+	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
-			if (!dry_run)
-				result |= delete_ref(refname, NULL, 0);
+	if (states.stale.nr) {
+		printf("Pruning %s\n", remote);
+		printf("URL: %s\n",
+		       states.remote->url_nr
+		       ? states.remote->url[0]
+		       : "(no URL)");
+	}
 
-			printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
-			       abbrev_ref(refname, "refs/remotes/"));
-			warn_dangling_symref(dangling_msg, refname);
-		}
+	for (i = 0; i < states.stale.nr; i++) {
+		const char *refname = states.stale.items[i].util;
 
-		free_remote_ref_states(&states);
+		if (!dry_run)
+			result |= delete_ref(refname, NULL, 0);
+
+		printf(" * [%s] %s\n", dry_run ? "would prune" : "pruned",
+		       abbrev_ref(refname, "refs/remotes/"));
+		warn_dangling_symref(dangling_msg, refname);
 	}
 
+	free_remote_ref_states(&states);
 	return result;
 }
 
-- 
1.6.2.1.471.gdeb91.dirty
