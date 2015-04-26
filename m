From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/14] merge: clarify collect_parents() logic
Date: Sat, 25 Apr 2015 22:26:00 -0700
Message-ID: <1430025967-24479-8-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5L-0002kU-En
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbbDZF01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751191AbbDZF0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BE6AB466F5;
	Sun, 26 Apr 2015 01:26:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=k1Ja
	Mvva/cWoN+8RhYgOSE1xijw=; b=h5QviUrrrqevX8heWs3ryYZU9J0SeatwuNRi
	MB85ptiBQwKoCfk4IVWPvF3aukaX/410fdAKnS49E5Uu51tg5S105MDWiUc5ElGs
	6Pj+/hMhdXOyXXwXWD+kPHNdkiRv75VoG3bCf/O0v6hSshabW6EW2t1Xy96reSko
	OH6f2lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DrzWw8
	0wssStqQbxxHOKau95NkEuc/B96QR7u3+BHhnNcfsDPHgV/ZldNN6knFT59Gu4wB
	M5nWDGSHDLOlqfptDLz4FkEyEG221Sm4ETHFxKEvOMA+vcqwDCMT6Ifw+YmtYYcT
	0kdg3C9BEhF5TGD/D2ipwvy6AE//UDmbaFSts=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B7BE3466F4;
	Sun, 26 Apr 2015 01:26:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 354A0466F3;
	Sun, 26 Apr 2015 01:26:18 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C406BF1A-EBD4-11E4-910B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267812>

Clarify this small function in three ways.

 - The function initially collects all commits to be merged into a
   commit_list "remoteheads"; the "remotes" pointer always points at
   the tail of this list (either the remoteheads variable itself, or
   the ->next slot of the element at the end of the list) to help
   elongate the list by repeated calls to commit_list_insert().
   Because the new element appended by commit_list_insert() will
   always have its ->next slot NULLed out, there is no need for us
   to assign NULL to *remotes to terminate the list at the end.

 - The variable "head_subsumed" always confused me every time I read
   this code.  What is happening here is that we inspect what the
   caller told us to merge (including the current HEAD) and come up
   with the list of parents to be recorded for the resulting merge
   commit, omitting commits that are ancestor of other commits.
   This filtering may remove the current HEAD from the resulting
   parent list---and we signal that fact with this variable, so that
   we can later record it as the first parent when "--no-ff" is in
   effect.

 - The "parents" list is created for this function by reduce_heads()
   and was not deallocated after its use, even though the loop
   control was written in such a way to allow us to do so by taking
   the "next" element in a separate variable so that it can be used
   in the next-step part of the loop control.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b2d0332..d2e36e2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1061,11 +1061,19 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 					 "not something we can merge");
 		remotes = &commit_list_insert(commit, remotes)->next;
 	}
-	*remotes = NULL;
 
+	/*
+	 * Is the current HEAD reachable from another commit being
+	 * merged?  If so we do not want to record it as a parent of
+	 * the resulting merge, unless --no-ff is given.  We will flip
+	 * this variable to 0 when we find HEAD among the independent
+	 * tips being merged.
+	 */
+	*head_subsumed = 1;
+
+	/* Find what parents to record by checking independent ones. */
 	parents = reduce_heads(remoteheads);
 
-	*head_subsumed = 1; /* we will flip this to 0 when we find it */
 	for (remoteheads = NULL, remotes = &remoteheads;
 	     parents;
 	     parents = next) {
@@ -1075,6 +1083,7 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 			*head_subsumed = 0;
 		else
 			remotes = &commit_list_insert(commit, remotes)->next;
+		free(parents);
 	}
 	return remoteheads;
 }
-- 
2.4.0-rc3-238-g36f5934
