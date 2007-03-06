From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] git-bundle: --list-prereqs
Date: Mon, 05 Mar 2007 16:41:41 -0800
Message-ID: <7vodn7ursq.fsf@assigned-by-dhcp.cox.net>
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
X-From: git-owner@vger.kernel.org Tue Mar 06 01:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HONkZ-0004wO-1J
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 01:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933660AbXCFAlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 19:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933672AbXCFAlp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 19:41:45 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33807 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933660AbXCFAlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 19:41:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306004141.CBBI748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Mar 2007 19:41:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XChh1W00l1kojtg0000000; Mon, 05 Mar 2007 19:41:42 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41518>

This is primarily of interest while debugging the bundle creation,
but there may be other uses.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * I am not sure if this should be a separate command, but the
   current command set did not have a way to review prereqs,
   short of:

	sed -ne '/^PACK/q' -e 'p' bundle.bdl

   It would make sense to have 'git bundle verify' output the
   heads and prereqs, maybe with --verbose, but I think doing
   that always might be even more helpful.

 builtin-bundle.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9286f3d..4fe74a7 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -241,6 +241,19 @@ static int list_heads(struct bundle_header *header, int argc, const char **argv)
 	return 0;
 }
 
+static int list_prereqs(struct bundle_header *header, int argc, const char **argv)
+{
+	int i;
+
+	struct ref_list *p = &header->prerequisites;
+	for (i = 0; i < p->nr; i++) {
+		printf("%s %s\n",
+		       sha1_to_hex(p->list[i].sha1),
+		       p->list[i].name);
+	}
+	return 0;
+}
+
 static void show_commit(struct commit *commit)
 {
 	write_or_die(1, sha1_to_hex(commit->object.sha1), 40);
@@ -432,6 +445,10 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		close(bundle_fd);
 		return !!list_heads(&header, argc, argv);
 	}
+	if (!strcmp(cmd, "list-prereqs")) {
+		close(bundle_fd);
+		return !!list_prereqs(&header, argc, argv);
+	}
 	if (!strcmp(cmd, "create")) {
 		if (nongit)
 			die("Need a repository to create a bundle.");
@@ -443,4 +460,3 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	} else
 		usage(bundle_usage);
 }
-
-- 
1.5.0.3.862.g71037
