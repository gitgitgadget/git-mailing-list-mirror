From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC 1/4] grep: prepare for re-using the space of the regexp member in struct grep_pat
Date: Mon,  2 May 2011 13:39:10 +0200
Message-ID: <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 13:39:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrTd-0000pW-J5
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab1EBLjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:39:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1EBLjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:39:40 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so4521802bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=fJ36eymKHaieBA8CH+oQCM1qqKLv2s4dNyPuLOb9LXU=;
        b=VBmHuc7qjsIrG0l0H+nZfD4UgsK5HcY4ycP53OADGs8CpCgMjBeKYWiEHDYfd+Y8Yt
         BW9T2QNkx74TIgwOHMHCcf77Uo+wwtN9jbSkncbJ2UYCagbcH5fuCjJWdfcOTvsHGNuL
         rtOiekyGkjkPKL+zW6vVu1QjHHaq1pYr/yQjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nf7Vb0Y3M9JF5ceWjpWQSDFri+3AErjZRkOLnqBtlQrBRO1pJjfV/iFUxWnokfIKfE
         MhJ5VN7rsujSEeuFlPOXyKZY6N2zm8UUfFpnzjeuyD56RfYxsGsWYQpZpvJxWQsNmSFF
         LqNOSWi4B6popPWflOPt+5pnFFugb+qzsDr8k=
Received: by 10.204.74.7 with SMTP id s7mr4281597bkj.57.1304336357013;
        Mon, 02 May 2011 04:39:17 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id l1sm3242785bkl.1.2011.05.02.04.39.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 04:39:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.349.gfeb1a
In-Reply-To: <cover.1304318972.git.bert.wesarg@googlemail.com>
In-Reply-To: <cover.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304321122.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172574>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 grep.c |   12 ++++++------
 grep.h |    4 +++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index 63c4280..b8eda9e 100644
--- a/grep.c
+++ b/grep.c
@@ -70,7 +70,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (p->fixed)
 		return;
 
-	err = regcomp(&p->regexp, p->pattern, opt->regflags);
+	err = regcomp(&p->u.regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
 		char where[1024];
@@ -81,8 +81,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 			sprintf(where, "%s, ", p->origin);
 		else
 			where[0] = 0;
-		regerror(err, &p->regexp, errbuf, 1024);
-		regfree(&p->regexp);
+		regerror(err, &p->u.regexp, errbuf, 1024);
+		regfree(&p->u.regexp);
 		die("%s'%s': %s", where, p->pattern, errbuf);
 	}
 }
@@ -320,7 +320,7 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			regfree(&p->regexp);
+			regfree(&p->u.regexp);
 			break;
 		default:
 			break;
@@ -464,7 +464,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 	if (p->fixed)
 		hit = !fixmatch(p, bol, eol, pmatch);
 	else
-		hit = !regmatch(&p->regexp, bol, eol, pmatch, eflags);
+		hit = !regmatch(&p->u.regexp, bol, eol, pmatch, eflags);
 
 	if (hit && p->word_regexp) {
 		if ((pmatch[0].rm_so < 0) ||
@@ -794,7 +794,7 @@ static int look_ahead(struct grep_opt *opt,
 		if (p->fixed)
 			hit = !fixmatch(p, bol, bol + *left_p, &m);
 		else
-			hit = !regmatch(&p->regexp, bol, bol + *left_p, &m, 0);
+			hit = !regmatch(&p->u.regexp, bol, bol + *left_p, &m, 0);
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
diff --git a/grep.h b/grep.h
index 06621fe..9912c11 100644
--- a/grep.h
+++ b/grep.h
@@ -32,7 +32,9 @@ struct grep_pat {
 	const char *pattern;
 	size_t patternlen;
 	enum grep_header_field field;
-	regex_t regexp;
+	union {
+		regex_t regexp;
+	} u;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
-- 
1.7.5.349.gfeb1a
