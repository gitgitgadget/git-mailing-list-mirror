From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/15] tar-tree: remove dependency on sq_quote_print()
Date: Tue,  4 Jun 2013 18:05:25 +0530
Message-ID: <1370349337-20938-4-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRF-0006cZ-5T
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab3FDMeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:01 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38167 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab3FDMd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:33:58 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so175373pdj.13
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6qLjB7IZapn4OGjuiEAJ9XFkBljc25T8Bf87fsk2ueo=;
        b=i1qD7UcpaLA1INh8skn1BdxdhkXG3lLBfnq2beKvZQudv6ihA6WuqBkuq/Fkc+VWQG
         L8/xdQunGVfk9fPAxGWflhpReKkZ6GeW8optCV3i9ba/yNL91idB83Nb9RjBgxPB73LS
         oAgUcp577SYQNQsUcaGOLChLpJBFwY/xpt7UqEvPblCfQC4N7LTe6cDSZmjrBCnLc+tL
         uDQqxOy99L+5glLlfx6Vipcpko/CRVMn1ggWO7/JyLehmsskcla3q4OmdEUOpeuPEYDL
         56ABqbMLbe+30y4j0HETy7uIjWtFEoPX45sko5zkCTJ4KJbMenoVDJ7ASr94COEhn8aM
         r9Dw==
X-Received: by 10.66.4.106 with SMTP id j10mr28999097paj.218.1370349238168;
        Tue, 04 Jun 2013 05:33:58 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.33.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:33:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226346>

Currently, there is exactly one caller of sq_quote_print(), namely
cmd_tar_tree().  In the interest of removing sq_quote_print() and
simplification, replace it with an equivalent call to sq_quote_argv().
No functional changes intended.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/tar-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index 3f1e701..ba3ffe6 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -26,8 +26,8 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	 * $0 tree-ish basedir ==>
 	 * 	git archive --format-tar --prefix=basedir tree-ish
 	 */
-	int i;
 	const char **nargv = xcalloc(sizeof(*nargv), argc + 3);
+	struct strbuf sb = STRBUF_INIT;
 	char *basedir_arg;
 	int nargc = 0;
 
@@ -65,11 +65,10 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	fprintf(stderr,
 		"*** \"git tar-tree\" is now deprecated.\n"
 		"*** Running \"git archive\" instead.\n***");
-	for (i = 0; i < nargc; i++) {
-		fputc(' ', stderr);
-		sq_quote_print(stderr, nargv[i]);
-	}
-	fputc('\n', stderr);
+	sq_quote_argv(&sb, nargv, 0);
+	strbuf_addch(&sb, '\n');
+	fputs(sb.buf, stderr);
+	strbuf_release(&sb);
 	return cmd_archive(nargc, nargv, prefix);
 }
 
-- 
1.8.3.GIT
