From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] checkout: indicate when a detached head is checked out for a branch
Date: Fri, 18 Jul 2014 11:50:42 +0200
Message-ID: <35dbe7e3f3e4566d775bea19d816adc44db8ed5c.1405676303.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 11:51:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X84oa-0001sk-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 11:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934286AbaGRJuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 05:50:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33393 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934278AbaGRJus (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 05:50:48 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 270D1218D4
	for <git@vger.kernel.org>; Fri, 18 Jul 2014 05:50:43 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 18 Jul 2014 05:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=Fy0QbDfKD+0Ep+t7HO9/8exsnI0=; b=aDXyv9BiNDW7GZOw7nRY
	t07IZBbvm115DXZ/A4PF0g3OZVEmMBYL5icazssg0dIg/L8FAAR6zwWCY6Q28Hxl
	sJTVa9OztVbtXGbjWjmGGqoQWydet4ebfP34C1zdDpgX/BoBUE2hVX3Zut5F1b31
	uEzLkWQFWkrVhV1gDIb6OWE=
X-Sasl-enc: XCMzyVfmbJgDeRjik7hHbrZYIS8u99bqm2eODKU/ikCu 1405677043
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 41F42C007B5;
	Fri, 18 Jul 2014 05:50:43 -0400 (EDT)
X-Mailer: git-send-email 2.0.1.583.gbe96573
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253805>

In a setup with more than 1 workdir, it can happen that a user requests
to checkout a branch that is already checked out somewhere else. The
current "hint" about this gives the impression that it is merely warning
about this fact.

Actually, "checkout" changes its behavior in such a situation from
checking out the requested branch to checking out its head as a detached
head. The only indication is the usual checkout message which appears
before the hint.

Change the hint to make it clearer that checkout changed its behavior to
something that is possible to do in that situation, but may or may not
be what the user intended.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I really like the new --to feature and will convert all my "new workdir"
checkouts to that. But that detached checkout is so easy to miss - in fact
I noticed it only when I compared "new-workdir" to "checkout --to" for a
test repo with one branch, to see what a converter would need to do.

I'm even wondering whether we should do this DWIMmery at all, given how
"dangerous" a detached head is for those who are not aware of it
before gc kicks in.

(Sorry if that dupes something on the list, can't keep up these days;
so this is coming from a "mere user" ;-)

 builtin/checkout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cfc6db7..38a5670 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -645,9 +645,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 			if (new->checkout && !*new->checkout)
-				fprintf(stderr, _("hint: the main checkout is holding this branch\n"));
+				fprintf(stderr, _("hint: the main checkout is holding this branch; detaching branch head instead.\n"));
 			else if (new->checkout)
-				fprintf(stderr, _("hint: the linked checkout %s is holding this branch\n"),
+				fprintf(stderr, _("hint: the linked checkout %s is holding this branch; detaching branch head instead.\n"),
 					new->checkout);
 		}
 	} else if (new->path) {	/* Switch branches. */
-- 
2.0.1.583.gbe96573
