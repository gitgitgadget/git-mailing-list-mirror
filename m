From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] grep: factor out create_grep_pat()
Date: Sun, 20 May 2012 16:32:39 +0200
Message-ID: <4FB90087.2020606@lsrfire.ath.cx>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com> <4FB6426C.7040202@lsrfire.ath.cx> <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Torne (Richard Coles)" <torne@google.com>
X-From: git-owner@vger.kernel.org Sun May 20 16:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW7CS-00084q-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 16:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252Ab2ETOcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 10:32:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:32925 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab2ETOcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 10:32:52 -0400
Received: from [192.168.2.105] (p4FFD8E63.dip.t-dialin.net [79.253.142.99])
	by india601.server4you.de (Postfix) with ESMTPSA id 211132F807A;
	Sun, 20 May 2012 16:32:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198060>

Add create_grep_pat(), a shared helper for all grep pattern allocation
and initialization needs.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/grep.c b/grep.c
index f8ffa46..a673ced 100644
--- a/grep.c
+++ b/grep.c
@@ -3,15 +3,26 @@
 #include "userdiff.h"
 #include "xdiff-interface.h"
 
-void append_header_grep_pattern(struct grep_opt *opt, enum grep_header_field field, const char *pat)
+static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
+					const char *origin, int no,
+					enum grep_pat_token t,
+					enum grep_header_field field)
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
 	p->pattern = pat;
-	p->patternlen = strlen(pat);
-	p->origin = "header";
-	p->no = 0;
-	p->token = GREP_PATTERN_HEAD;
+	p->patternlen = patlen;
+	p->origin = origin;
+	p->no = no;
+	p->token = t;
 	p->field = field;
+	return p;
+}
+
+void append_header_grep_pattern(struct grep_opt *opt,
+				enum grep_header_field field, const char *pat)
+{
+	struct grep_pat *p = create_grep_pat(pat, strlen(pat), "header", 0,
+					     GREP_PATTERN_HEAD, field);
 	*opt->header_tail = p;
 	opt->header_tail = &p->next;
 	p->next = NULL;
@@ -26,12 +37,7 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen,
 		     const char *origin, int no, enum grep_pat_token t)
 {
-	struct grep_pat *p = xcalloc(1, sizeof(*p));
-	p->pattern = pat;
-	p->patternlen = patlen;
-	p->origin = origin;
-	p->no = no;
-	p->token = t;
+	struct grep_pat *p = create_grep_pat(pat, patlen, origin, no, t, 0);
 	*opt->pattern_tail = p;
 	opt->pattern_tail = &p->next;
 	p->next = NULL;
-- 
1.7.10.2
