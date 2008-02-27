From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Tue, 26 Feb 2008 23:18:38 -0800
Message-ID: <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 08:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUGZf-0008MH-VA
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 08:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYB0HS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 02:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYB0HS4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 02:18:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbYB0HSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 02:18:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A11DD2D50;
	Wed, 27 Feb 2008 02:18:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 974F22D4E; Wed, 27 Feb 2008 02:18:47 -0500 (EST)
In-Reply-To: <18372.53155.854763.12637@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Wed, 27 Feb 2008 13:49:07 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75205>

Paul Mackerras <paulus@samba.org> writes:

> It would be nice if git-log --merge --left-right did what git log
> --merge does but additionally, if the merge is a 2-way merge, marked
> commits with '<' or '>' according to which side of the merge they came
> from.  Would that be possible?  I think the visual indication that
> --left-right gives in gitk would be useful with --merge.

Like this?

A trivial feature that can be implemented in -4 lines ;-)

 revision.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 4e36b95..38d7d94 100644
--- a/revision.c
+++ b/revision.c
@@ -771,14 +771,9 @@ static void prepare_show_merge(struct rev_info *revs)
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other, 1);
-	while (bases) {
-		struct commit *it = bases->item;
-		struct commit_list *n = bases->next;
-		free(bases);
-		bases = n;
-		it->object.flags |= UNINTERESTING;
-		add_pending_object(revs, &it->object, "(merge-base)");
-	}
+	add_pending_commit_list(revs, bases, UNINTERESTING);
+	free_commit_list(bases);
+	head->object.flags |= SYMMETRIC_LEFT;
 
 	if (!active_nr)
 		read_cache();
@@ -797,6 +792,7 @@ static void prepare_show_merge(struct rev_info *revs)
 			i++;
 	}
 	revs->prune_data = prune;
+	revs->limited = 1;
 }
 
 int handle_revision_arg(const char *arg, struct rev_info *revs,
