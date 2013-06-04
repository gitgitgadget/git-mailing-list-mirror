From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/15] pretty: limit recursion in format_commit_one()
Date: Tue,  4 Jun 2013 18:05:28 +0530
Message-ID: <1370349337-20938-7-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRT-0006ui-16
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab3FDMeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:11 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49179 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3FDMeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:07 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so169358pdb.40
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3yVOuBjXSlx+/VgPvOuXGrEf8mv7N5iLRTd0JnZDeTk=;
        b=zef/owMAhjeelW9Rfg/8Dh7N+XXoue1IGkzukKPNEg/2L+Gfkpxv/IRXhFcU7ksJ8N
         MWjw1tMbvdEqtxEoRWfQzmjG7pN2EOu8hdTQgTOn2Xw+vsIQZF4DXmoCO++/DlHm0IQM
         uEmcSuZxdTne7dFlE4XJTeBw+C2rUqIiHji6wKveHqXm1zf6OUGoAJ5CBlPBEHw3iekz
         MGNihufgUAuN4RT2+QzGo4Y76RwwQY1zZ9z0rqUz1lgK4wJiLfAcbnfkbAHWPkgJDdN8
         +1iAx/OehKKBwHgudPhiI4t1EDVN2F0P8v24yO23apAPbLrj79Ks0DQbyFWKTFrQtOkJ
         jTyw==
X-Received: by 10.66.158.36 with SMTP id wr4mr28620258pab.28.1370349246859;
        Tue, 04 Jun 2013 05:34:06 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226349>

To make sure that a pretty_ctx->format substitution doesn't result in an
infinite recursion, change the prototype of format_commit_one() to
accept one last argument: no_recurse.  So, a single substitution by
format() must yield a result that can be parsed by format_commit_one()
without the help of format().

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 pretty.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index 095e5ba..0063f2d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1061,7 +1061,8 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
-				void *context)
+				void *context,
+				int no_recurse)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
@@ -1069,7 +1070,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	struct commit_list *p;
 	int h1, h2;
 
-	if (c->pretty_ctx->format) {
+	if (!no_recurse && c->pretty_ctx->format) {
 		struct strbuf subst = STRBUF_INIT;
 		int ret = c->pretty_ctx->format(sb, placeholder, context,
 						c->pretty_ctx->user_data,
@@ -1083,7 +1084,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			 * ret: the length of the original string
 			 * before substitution.
 			 */
-			ret = format_commit_one(sb, subst.buf, context) ? ret : 0;
+			ret = format_commit_one(sb, subst.buf, context, 1) ? ret : 0;
 			strbuf_release(&subst);
 			return ret;
 		} else if (ret)
@@ -1332,7 +1333,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	}
 	while (1) {
 		int modifier = *placeholder == 'C';
-		int consumed = format_commit_one(&local_sb, placeholder, c);
+		int consumed = format_commit_one(&local_sb, placeholder, c, 0);
 		total_consumed += consumed;
 
 		if (!modifier)
@@ -1452,7 +1453,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 	if (((struct format_commit_context *)context)->flush_type != no_flush)
 		consumed = format_and_pad_commit(sb, placeholder, context);
 	else
-		consumed = format_commit_one(sb, placeholder, context);
+		consumed = format_commit_one(sb, placeholder, context, 0);
 	if (magic == NO_MAGIC)
 		return consumed;
 
-- 
1.8.3.GIT
