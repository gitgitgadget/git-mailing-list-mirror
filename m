From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] quote: add "sq_dequote_to_argv" to put unwrapped args
 in an argv array
Date: Sun, 29 Mar 2009 11:44:52 +0200
Message-ID: <20090329114452.b19a2f60.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 11:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnrc9-0004CJ-SK
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 11:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbZC2Jp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 05:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbZC2Jp5
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 05:45:57 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:56535 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbZC2Jp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 05:45:56 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 9F4944C81CF;
	Sun, 29 Mar 2009 11:45:47 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with SMTP id 8C8204C8125;
	Sun, 29 Mar 2009 11:45:44 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115006>

This new function unwraps the space separated shell quoted elements in
its first argument and put a copy of them in the argv array passed as
its second argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 quote.c |   17 +++++++++++++++++
 quote.h |    2 ++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/quote.c b/quote.c
index 8cf0ef4..5b12a4a 100644
--- a/quote.c
+++ b/quote.c
@@ -120,6 +120,23 @@ char *sq_dequote(char *arg)
 	return sq_dequote_many(arg, NULL);
 }
 
+int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
+{
+	char *next = arg;
+
+	if (!*arg)
+		return 0;
+	do {
+		char *dequoted = sq_dequote_many(next, &next);
+		if (!dequoted)
+			return 1;
+		ALLOC_GROW(*argv, *nr + 1, *alloc);
+		(*argv)[(*nr)++] = xstrdup(dequoted);
+	} while (next);
+
+	return 0;
+}
+
 /* 1 means: quote as octal
  * 0 means: quote as octal if (quote_path_fully)
  * -1 means: never quote
diff --git a/quote.h b/quote.h
index c2f98e7..bbd0f09 100644
--- a/quote.h
+++ b/quote.h
@@ -47,6 +47,8 @@ extern char *sq_dequote(char *);
  */
 extern char *sq_dequote_many(char *arg, char **next);
 
+extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
+
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
 extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
-- 
1.6.2.1.404.gb0085.dirty
