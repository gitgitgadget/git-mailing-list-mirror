From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] revision: do not include sibling history in
 --ancestry-path output
Date: Thu, 25 Aug 2011 18:00:57 -0700
Message-ID: <7v7h61gf5i.fsf_-_@alter.siamese.dyndns.org>
References: <20110824213205.GI45292@book.hvoigt.net>
 <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 03:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwknC-0007bB-6W
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 03:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab1HZBBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 21:01:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab1HZBA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 21:00:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56C894A38;
	Thu, 25 Aug 2011 21:00:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YcDIdq36oxntTCC6sERFJy3wWME=; b=Ty8TqW
	Cak6V0KizkZ0mSxTvNv4gixhPMcJwd70gyEHPaZsFju4G7pXQ1Z5zeNTMtWgjkWy
	d/i7gtn77/RkX1Wkc8Qd5R6m2zClNjiT7SSzXU9FywTcfMRKC5KmFBnV7SHoBcOE
	3NX/V44fu7c8cdvigBcZgvvgouYauUMxHQUrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hK7DqBEux8bXyvURFbVC1ei+DEuXWZo/
	OEIapagvxOCF/LtCU6DCp17I49SaQyWChSF/8IRGSqHfO5vu8Bp96CIvEPLA/5AR
	NqotGOS6KyS4alHeT99Gi5pY80TcZCvM2WGIemzIvZpECnGs0Y2fXT/aBNy3GY1i
	U7JfQopl78Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EDEB4A36;
	Thu, 25 Aug 2011 21:00:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D21424A33; Thu, 25 Aug 2011
 21:00:58 -0400 (EDT)
In-Reply-To: <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com> (Brad King's message of "Thu, 25 Aug 2011 12:49:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC39B252-CF7E-11E0-93A8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180142>

If the commit specified as the bottom of the commit range has a direct
parent that has another child commit that contributed to the resulting
history, "rev-list --ancestry-path" was confused and listed that side
history as well.

             D---E
            /     \
        ---X---A---B---C

In this history, "rev-list --ancestry-path A..C" should list among what
the corresponding command without --ancestry-path option would produce,
namely, D, E, B and C, but limiting the result to those that are
descendant of A (i.e. B and C). Due to the command line parser subtlety
corrected by the previous commit, it also listed those that are descendant
of X as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And this should fix the breakage you demonstrated.

 revision.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 3e87c86..48a2db4 100644
--- a/revision.c
+++ b/revision.c
@@ -724,12 +724,16 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
  * to filter the result of "A..B" further to the ones that can actually
  * reach A.
  */
-static struct commit_list *collect_bottom_commits(struct commit_list *list)
+static struct commit_list *collect_bottom_commits(struct rev_info *revs)
 {
-	struct commit_list *elem, *bottom = NULL;
-	for (elem = list; elem; elem = elem->next)
-		if (elem->item->object.flags & UNINTERESTING)
-			commit_list_insert(elem->item, &bottom);
+	struct commit_list *bottom = NULL;
+	int i;
+	for (i = 0; i < revs->cmdline.nr; i++) {
+		struct rev_cmdline_entry *elem = &revs->cmdline.rev[i];
+		if ((elem->flags & UNINTERESTING) &&
+		    elem->item->type == OBJ_COMMIT)
+			commit_list_insert((struct commit *)elem->item, &bottom);
+	}
 	return bottom;
 }
 
@@ -743,7 +747,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *bottom = NULL;
 
 	if (revs->ancestry_path) {
-		bottom = collect_bottom_commits(list);
+		bottom = collect_bottom_commits(revs);
 		if (!bottom)
 			die("--ancestry-path given but there are no bottom commits");
 	}
-- 
1.7.6.1.385.gb7fcd0
