From: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/2] Fix git rev-list --bisect and git bisect visualize when the bisection is done in old/new mode.
Date: Fri,  5 Jun 2015 18:34:21 +0200
Message-ID: <1433522061-14532-2-git-send-email-stuberl@ensimag.grenoble-inp.fr>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr, j_franck7@msn.com,
	valentinduperray@gmail.com, thomasxnguy@gmail.com,
	lucienkong@hotmail.com, chriscool@tuxfamily.org,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 18:36:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0uap-00035O-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 18:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbbFEQfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 12:35:30 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:55700 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422740AbbFEQf3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 12:35:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 00455284D;
	Fri,  5 Jun 2015 18:35:28 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahgumFtmqTvX; Fri,  5 Jun 2015 18:35:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E3309284C;
	Fri,  5 Jun 2015 18:35:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id DB6F820E4;
	Fri,  5 Jun 2015 18:35:27 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMCcasQP8++b; Fri,  5 Jun 2015 18:35:27 +0200 (CEST)
Received: from ensipc253.imag.fr (ensipc253.imag.fr [129.88.241.113])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id BA00120DF;
	Fri,  5 Jun 2015 18:35:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270854>


Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 revision.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 7ddbaa0..b631596 100644
--- a/revision.c
+++ b/revision.c
@@ -2075,12 +2075,23 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 
 static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
+	/*
+	 * if BISECT_OLDNEWMODE exists, this is an old/new bisect and the path is different
+	 */
+	struct stat st;
+	if (stat(git_path("BISECT_OLDNEWMODE"), &st))
+		return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
+	else
+		return for_each_ref_in_submodule(submodule, "refs/bisect/new", fn, cb_data);
 }
 
 static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
+	struct stat st;
+	if (stat(git_path("BISECT_OLDNEWMODE"), &st))
+		return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
+	else
+		return for_each_ref_in_submodule(submodule, "refs/bisect/old", fn, cb_data);
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
-- 
1.7.1
