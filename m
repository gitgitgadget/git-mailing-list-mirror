From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 04/11] log --grep/--author: honor --all-match honored for multiple --grep patterns
Date: Fri, 14 Sep 2012 11:46:36 +0200
Message-ID: <f3240572634fa9e22efd814b1d792d36d56a9643.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUm-0007S2-Et
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab2INJqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:46:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52436 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753894Ab2INJqw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:52 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CE0742078F;
	Fri, 14 Sep 2012 05:46:51 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 14 Sep 2012 05:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=wX
	EicS8FMIulhRsGj+S3wwoQdA8=; b=MKBv6BnabOosYgY+HdRQhfUXTtVXqMwQnj
	aXEP5+HrwldBjAf29HRanYAANl0sxGTgBgHv7gi4PJDIku8zW9KsHI+K5ABW3iko
	KRB+nL6+VmmV8qju9ULY0/FiT078m/MiZrk+vGbcjlIwgHXrdC11Tw5ynlPONMqL
	4cGB8SCRI=
X-Sasl-enc: muSyzWLZBy1CsqpXy/h+Pgv808bJPKh2YZZxzFMBz4+R 1347616011
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6E77C483802;
	Fri, 14 Sep 2012 05:46:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205477>

From: Junio C Hamano <gitster@pobox.com>

Earlier, when we have both header expression (which has to be an OR
node by construction) and a pattern expression (which could be
anything), we created a top-level OR node that looks like this to
bind them together:

             OR
        /          \
       /            \
   pattern            OR
     / \           /     \
    .....    committer    OR
                         /   \
                     author   TRUE

In other words, the three elements on the top-level backbone that
were inspected by the "all-match" logic are "pattern", "committer"
and "author".  When there are more than one elements in the
"pattern", the top-level node of it is that OR, so that node is
inspected by "all-match", hence the result ends up ignoring the
"--all-match" given from the command line.  A match on either side
of the pattern was considered a match, hence

        git log --grep=A --grep=B --author=C --all-match

showed the same "authored by C and has either A or B" with or
without --all-match.

This patch turns the grep expression into this form:

              OR
          /       \
         /          \
        /              OR
    committer        /    \
                 author    \
                           pattern

when "--all-match" was given from the command line.  This way, the
set of nodes on the top-level backbone in the resulting expression
consists of "committer", "author", and whatever nodes were on the
top-level backbone of the "pattern" expression.  The "all-match"
logic inspects the same nodes in "pattern" as the case without the
author and/or the committer restriction.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 grep.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/grep.c b/grep.c
index be15c47..925aa92 100644
--- a/grep.c
+++ b/grep.c
@@ -476,6 +476,22 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	return header_expr;
 }
 
+static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y)
+{
+	struct grep_expr *z = x;
+
+	while (x) {
+		assert(x->node == GREP_NODE_OR);
+		if (x->u.binary.right &&
+		    x->u.binary.right->node == GREP_NODE_TRUE) {
+			x->u.binary.right = y;
+			break;
+		}
+		x = x->u.binary.right;
+	}
+	return z;
+}
+
 static void compile_grep_patterns_real(struct grep_opt *opt)
 {
 	struct grep_pat *p;
@@ -510,6 +526,9 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 
 	if (!opt->pattern_expression)
 		opt->pattern_expression = header_expr;
+	else if (opt->all_match)
+		opt->pattern_expression = grep_splice_or(header_expr,
+							 opt->pattern_expression);
 	else
 		opt->pattern_expression = grep_or_expr(opt->pattern_expression,
 						       header_expr);
-- 
1.7.12.592.g41e7905
