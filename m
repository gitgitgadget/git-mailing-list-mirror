From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-bundle: fix pack generation.
Date: Mon, 05 Mar 2007 23:45:31 -0800
Message-ID: <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
References: <45ECEB40.4000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:45:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOUMZ-0005ON-CO
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933983AbXCFHpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933984AbXCFHpd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:45:33 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41683 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933983AbXCFHpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:45:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306074533.IIQN2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 02:45:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XKlY1W0031kojtg0000000; Tue, 06 Mar 2007 02:45:32 -0500
In-Reply-To: <45ECEB40.4000907@gmail.com> (Mark Levedahl's message of "Mon, 05
	Mar 2007 23:17:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41554>

The handcrafted built-in rev-list lookalike forgot to mark the trees
and blobs contained in the boundary commits uninteresting, resulting
in unnecessary objects in the pack.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I'll have this in 'master' tonight.  Also I am thinking about
   changing 'git bundle verify' to spit out heads and prereqs
   unconditionally, in addition to 'foo.bdl is ok'.  Comments?

 builtin-bundle.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index d41a413..279b8f8 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -263,6 +263,11 @@ static void show_object(struct object_array_entry *p)
 	write_or_die(1, "\n", 1);
 }
 
+static void show_edge(struct commit *commit)
+{
+	; /* nothing to do */
+}
+
 static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
@@ -341,6 +346,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	dup2(in, 1);
 	close(in);
 	prepare_revision_walk(&revs);
+	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
 	close(1);
 	while (waitpid(pid, &status, 0) < 0)
-- 
1.5.0.3.862.g71037
