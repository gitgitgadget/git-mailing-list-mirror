From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH] log: decorate detached HEAD differently
Date: Wed, 18 Feb 2015 14:19:25 +0100
Message-ID: <2df73f987d69531622681a560ce8ccbd88b15501.1424264942.git.git@drmicha.warpmail.net>
References: <54E46635.4060009@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julien Cretel <j.cretel@umail.ucc.ie>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 14:19:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO4XM-0005fP-P0
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 14:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbbBRNT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 08:19:28 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33842 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbbBRNT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 08:19:27 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 3FE8F20B1B
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 08:19:27 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 18 Feb 2015 08:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=tPebKU9TqB6OuF
	8NNet2xG/AMwI=; b=fkU0sWEan80ka28fKEKZ5iyKAyaqq7IcBiCR7JQMI0iXNd
	ZhnzhP10iy0sdESj8xdWR79thlJJnfvyQCAQudTgjAqyXNqNHm8xFKI+9oMAaKuE
	ju5QNdUpP756jzZU4np8jEkzU3EujsnKvfWr4GnsPAm26k8OSShH6ZD63pMiQ=
X-Sasl-enc: wJLT7Ix8znc5aTbIaCg/q+dzWI7J0vPad9CZroA8tIQB 1424265566
Received: from localhost (unknown [88.70.121.210])
	by mail.messagingengine.com (Postfix) with ESMTPA id A4D3BC0029D;
	Wed, 18 Feb 2015 08:19:26 -0500 (EST)
X-Mailer: git-send-email 2.3.0.136.g92a3b58
In-Reply-To: <54E46635.4060009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264015>

"git status" and "git branch" let the user know when the HEAD is
detached, while "git log --decorate" does not.

Change the decoration by a detached HEAD to "detached HEAD". This can be
seen as giving more information about the decoration item itself in the
same way as we prefix tags by "tag: ".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This turned out to be easy to do, though I am still undecided.
Personally, I like to think of refs as objects (and have implemented refname
objects in the past), but that view is not too popular.

So, maybe the analogy between ref peeling and symref resolving (for HEAD) is
not that strong after all. They are both indirections, though different technically.

The RFC patch only checks HEAD for being a symref, the output is analogous to 
the summary of "git commit".

 log-tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 7f0890e..2eac4b6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -118,8 +118,14 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 		type = DECORATION_REF_TAG;
 	else if (!strcmp(refname, "refs/stash"))
 		type = DECORATION_REF_STASH;
-	else if (!strcmp(refname, "HEAD"))
+	else if (!strcmp(refname, "HEAD")) {
+		char *junk_sha1[20];
+		char *head;
 		type = DECORATION_REF_HEAD;
+		head = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
+		if (!strcmp(head, "HEAD"))
+			refname = "detached HEAD";
+	}
 
 	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
 		refname = prettify_refname(refname);
-- 
2.3.0.136.g92a3b58
