From: Junio C Hamano <junkio@cox.net>
Subject: Re: builtin git-bundle - pack contains many more objects than required
Date: Mon, 05 Mar 2007 22:18:15 -0800
Message-ID: <7vmz2quc7s.fsf@assigned-by-dhcp.cox.net>
References: <45ECEB40.4000907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOT07-0001Tr-EZ
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 07:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbXCFGSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 01:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933952AbXCFGSR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 01:18:17 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57013 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbXCFGSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 01:18:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306061817.JWDU748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 01:18:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XJJF1W00S1kojtg0000000; Tue, 06 Mar 2007 01:18:16 -0500
In-Reply-To: <45ECEB40.4000907@gmail.com> (Mark Levedahl's message of "Mon, 05
	Mar 2007 23:17:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41540>

Mark Levedahl <mlevedahl@gmail.com> writes:

> However, a simple example:
>
> git>git-rev-list --objects HEAD~1..HEAD
> 5ced0572217f82f20c4a3460492768e07c08aeea
> 1d30eaabe4b6f7218e4e4cfff5670a493aa7358e
> 2a1d6a2be1511f65b601897f05962e5f673257d8 contrib
> cbd77b2f57114d4fa2f119f1b1ee17968d6d67d4 contrib/emacs
> 8554e3967cc692c6916e5aee35952074d07e8bf0 contrib/emacs/Makefile
>
> shows that the bundle for this case should have five objects as
> shown. In this case, 916 objects are actually included in the pack
> when executing
>
> git bundle create test.bdl HEAD~1..HEAD

Indeed.  The internal rev-list reimplemented in builtin-bundle.c
lacks the code to mark trees and blobs in commits that are on
the other side of the edge uninteresting.

This is on top of the patches I send to the list and Dscho
earlier.

--

 builtin-bundle.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 4fe74a7..199a30d 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -278,6 +278,11 @@ static void show_object(struct object_array_entry *p)
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
@@ -361,6 +366,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	dup2(in, 1);
 	close(in);
 	prepare_revision_walk(&revs);
+	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
 	close(1);
 	while (waitpid(pid, &status, 0) < 0)
