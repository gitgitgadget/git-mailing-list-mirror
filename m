From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] grep: factor out do_append_grep_pat()
Date: Sun, 20 May 2012 16:32:54 +0200
Message-ID: <4FB90096.9070600@lsrfire.ath.cx>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com> <4FB6426C.7040202@lsrfire.ath.cx> <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Torne (Richard Coles)" <torne@google.com>
X-From: git-owner@vger.kernel.org Sun May 20 16:33:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW7Cb-0008K7-5m
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 16:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab2ETOdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 10:33:32 -0400
Received: from india601.server4you.de ([85.25.151.105]:32928 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab2ETOdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 10:33:01 -0400
Received: from [192.168.2.105] (p4FFD8E63.dip.t-dialin.net [79.253.142.99])
	by india601.server4you.de (Postfix) with ESMTPSA id 75A6B2F807A;
	Sun, 20 May 2012 16:33:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198062>

Add do_append_grep_pat() as a shared function for adding patterns to
the header pattern list and the general pattern list.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Our first three star function. :)

 grep.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index a673ced..f961c2e 100644
--- a/grep.c
+++ b/grep.c
@@ -18,14 +18,19 @@ static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
 	return p;
 }
 
+static void do_append_grep_pat(struct grep_pat ***tail, struct grep_pat *p)
+{
+	**tail = p;
+	*tail = &p->next;
+	p->next = NULL;
+}
+
 void append_header_grep_pattern(struct grep_opt *opt,
 				enum grep_header_field field, const char *pat)
 {
 	struct grep_pat *p = create_grep_pat(pat, strlen(pat), "header", 0,
 					     GREP_PATTERN_HEAD, field);
-	*opt->header_tail = p;
-	opt->header_tail = &p->next;
-	p->next = NULL;
+	do_append_grep_pat(&opt->header_tail, p);
 }
 
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
@@ -38,9 +43,7 @@ void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen,
 		     const char *origin, int no, enum grep_pat_token t)
 {
 	struct grep_pat *p = create_grep_pat(pat, patlen, origin, no, t, 0);
-	*opt->pattern_tail = p;
-	opt->pattern_tail = &p->next;
-	p->next = NULL;
+	do_append_grep_pat(&opt->pattern_tail, p);
 }
 
 struct grep_opt *grep_opt_dup(const struct grep_opt *opt)
-- 
1.7.10.2
