From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] grep: micro-optimize hit collection for AND nodes
Date: Sat, 07 Mar 2009 13:27:15 +0100
Message-ID: <1236428835.6486.43.camel@ubuntu.ubuntu-domain>
References: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfve5-00088X-CQ
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbZCGM1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbZCGM1V
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:27:21 -0500
Received: from india601.server4you.de ([85.25.151.105]:55026 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbZCGM1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:27:19 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 43CF92F8057;
	Sat,  7 Mar 2009 13:27:16 +0100 (CET)
In-Reply-To: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112530>

In addition to returning if an expression matches a line,
match_expr_eval() updates the expression's hit flag if the parameter
collect_hits is set.  It never sets collect_hits for children of AND
nodes, though, so their hit flag will never be updated.  Because of
that we can return early if the first child didn't match, no matter
if collect_hits is set or not.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index 062b2b6..db341b6 100644
--- a/grep.c
+++ b/grep.c
@@ -394,13 +394,9 @@ static int match_expr_eval(struct grep_opt *o,
 		h = !match_expr_eval(o, x->u.unary, bol, eol, ctx, 0);
 		break;
 	case GREP_NODE_AND:
-		if (!collect_hits)
-			return (match_expr_eval(o, x->u.binary.left,
-						bol, eol, ctx, 0) &&
-				match_expr_eval(o, x->u.binary.right,
-						bol, eol, ctx, 0));
-		h = match_expr_eval(o, x->u.binary.left, bol, eol, ctx, 0);
-		h &= match_expr_eval(o, x->u.binary.right, bol, eol, ctx, 0);
+		if (!match_expr_eval(o, x->u.binary.left, bol, eol, ctx, 0))
+			return 0;
+		h = match_expr_eval(o, x->u.binary.right, bol, eol, ctx, 0);
 		break;
 	case GREP_NODE_OR:
 		if (!collect_hits)
-- 
1.6.2
