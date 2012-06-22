From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] revision: "simplify" options imply topo-order sort
Date: Fri, 22 Jun 2012 15:27:38 -0700
Message-ID: <1340404061-11619-2-git-send-email-gitster@pobox.com>
References: <1340404061-11619-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 00:27:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCKU-0007W8-43
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642Ab2FVW1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:27:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754401Ab2FVW1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:27:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FFC49493
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3HCh
	oshAbbfhmkrhGjDZroP0fdI=; b=kkrG71g0ZLySQ32DctkGxQnjuCdrSzAxqklo
	E1swpYe6mivpCgA9Raq3lRm/00EeGMvLkDDcQpqTrIyPACcvsDHfKG5lPJCBGIsg
	CqXtbj348xHR7XS+QG9Lyy7OhuFQj5ajUPbOLwWy2twiiIcQPWMfZQ870VJxgwVn
	fH6Vjfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=S6r1pc
	6Vb9jcOSPee5211j+tCSqqWrnOpVizKnPrOPhjpf762YJGOiXyTwa7oh0S0jTKEz
	R+L2DwTNrWt1CEVKQAhxTrwpk28f/u5YwEax1xtfGU62rEoDIi9gaS+cT2wKpw/n
	U32gYpOlj7ACzM5lYbqS5iGWx9iUSO+d2jgME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 858309492
	for <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B61B9491 for
 <git@vger.kernel.org>; Fri, 22 Jun 2012 18:27:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340404061-11619-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7C7AD53E-BCB9-11E1-B691-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200479>

The code internally runs sort_in_topo_order() already; it is more clear
to spell it out in the option parsing phase, instead of adding a special
case in simplify_merges() function.
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 935e7a7..00aaefe 100644
--- a/revision.c
+++ b/revision.c
@@ -1358,11 +1358,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--simplify-merges")) {
 		revs->simplify_merges = 1;
+		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->simplify_history = 0;
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--simplify-by-decoration")) {
 		revs->simplify_merges = 1;
+		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->simplify_history = 0;
 		revs->simplify_by_decoration = 1;
@@ -2016,8 +2018,6 @@ static void simplify_merges(struct rev_info *revs)
 	struct commit_list *list;
 	struct commit_list *yet_to_do, **tail;
 
-	if (!revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
 	if (!revs->prune)
 		return;
 
-- 
1.7.11.1.29.gf71be5c
