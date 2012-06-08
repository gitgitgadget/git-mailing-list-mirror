From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] revision: "simplify" options imply topo-order sort
Date: Fri,  8 Jun 2012 15:53:27 -0700
Message-ID: <1339196009-14555-2-git-send-email-gitster@pobox.com>
References: <1339196009-14555-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 00:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd84U-00005d-Op
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab2FHWxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:53:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab2FHWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:53:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78F078B8D
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3cb6
	B3f7/MzniQz0+XNNt4EaLn8=; b=bi8ysBavwyP0CYCXe1UKK678T9VswadbI/Re
	KMxOojJ4SleFOsgviyV1hqE6eajzO3PD+vuujM3otJyi2bXQ3Zx/ypEgZp9tRRbf
	vfCvLHp51H5RDCo25smxDeCK9l3E3O71wscgzhHNgISfYxCBqOHXCwXcbtxg34KM
	yLSeFKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fcV4CS
	w0/e8QdEKjLdUOVuKSgDeXLeEDIAgYcfPqCf+ENSXZJwsHRompXhmioCJ6NpsTXD
	udIH2SBJyx1hPphaxD5ni7dKioMC7HDXP3wwfdelMMMhsx/TxkzIwE3oZn7dyN1d
	s8KcqsvNh2Ele8eIAkFXzxUIy0azSvOKv/tSM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70EE58B8C
	for <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03B108B8B for
 <git@vger.kernel.org>; Fri,  8 Jun 2012 18:53:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc2.29.g85b30f3
In-Reply-To: <1339196009-14555-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C5EA0C92-B1BC-11E1-BA9D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199537>

The code internally runs sort_in_topo_order() already; it is more clear
to spell it out in the option parsing phase, instead of adding a special
case in simplify_merges() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.11.rc2.29.g85b30f3
