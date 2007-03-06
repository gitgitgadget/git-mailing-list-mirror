From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] git-bundle: various fixups
Date: Mon, 05 Mar 2007 16:41:39 -0800
Message-ID: <7vtzwzurss.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
	<7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 06 01:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONkY-0004wO-Dy
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933670AbXCFAlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933672AbXCFAln
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:41:43 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46271 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933670AbXCFAll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 19:41:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306004140.SKM26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 19:41:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XChg1W00c1kojtg0000000; Mon, 05 Mar 2007 19:41:41 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41517>

verify_bundle() returned with an error early only when all
prerequisite commits were missing.  It should error out much
earlier when some are missing.

When the rev-list is limited in ways other than revision range
(e.g. --max-count or --max-age), create_bundle() listed all
positive refs given from the command line as if they are
available, but resulting pack may not have some of them.  Add a
logic to make sure all of them are included, and error out
otherwise.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-bundle.c |   46 +++++++++++++++++++++++++++++++++-------------
 1 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 0265845..9286f3d 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -189,7 +189,7 @@ static int verify_bundle(struct bundle_header *header)
 			error(message);
 		error("%s %s", sha1_to_hex(e->sha1), e->name);
 	}
-	if (revs.pending.nr == 0)
+	if (revs.pending.nr != p->nr)
 		return ret;
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
@@ -274,6 +274,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	int pid, in, out, i, status;
 	char buffer[1024];
 	struct rev_info revs;
+	struct object_array tips;
 
 	bundle_fd = (!strcmp(path, "-") ? 1 :
 			open(path, O_CREAT | O_WRONLY, 0666));
@@ -311,19 +312,23 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	if (argc > 1)
 		return error("unrecognized argument: %s'", argv[1]);
+
+	memset(&tips, 0, sizeof(tips));
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
-		if (!(e->item->flags & UNINTERESTING)) {
-			unsigned char sha1[20];
-			char *ref;
-			if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
-				continue;
-			write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
-			write_or_die(bundle_fd, " ", 1);
-			write_or_die(bundle_fd, ref, strlen(ref));
-			write_or_die(bundle_fd, "\n", 1);
-			free(ref);
-		}
+		unsigned char sha1[20];
+		char *ref;
+
+		if (e->item->flags & UNINTERESTING)
+			continue;
+		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
+			continue;
+		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
+		write_or_die(bundle_fd, " ", 1);
+		write_or_die(bundle_fd, ref, strlen(ref));
+		write_or_die(bundle_fd, "\n", 1);
+		add_object_array(e->item, e->name, &tips);
+		free(ref);
 	}
 
 	/* end header */
@@ -350,7 +355,22 @@ static int create_bundle(struct bundle_header *header, const char *path,
 			return -1;
 	if (!WIFEXITED(status) || WEXITSTATUS(status))
 		return error ("pack-objects died");
-	return 0;
+
+	/*
+	 * Make sure the refs we wrote out is correct; --max-count and
+	 * other limiting options could have prevented all the tips
+	 * from getting output.
+	 */
+	status = 0;
+	for (i = 0; i < tips.nr; i++) {
+		if (!(tips.objects[i].item->flags & SHOWN)) {
+			status = 1;
+			error("%s: not included in the resulting pack",
+			      tips.objects[i].name);
+		}
+	}
+
+	return status;
 }
 
 static int unbundle(struct bundle_header *header, int bundle_fd,
-- 
1.5.0.3.862.g71037
