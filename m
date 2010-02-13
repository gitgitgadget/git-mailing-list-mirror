From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 5/5] Use kwset in grep
Date: Sat, 13 Feb 2010 15:21:10 +0100
Message-ID: <20100213142110.GF9543@fredrik-laptop>
References: <20100213141558.22851.13660.stgit@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 15:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgIs5-0006L2-Mc
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240Ab0BMOVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 09:21:15 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:53809 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab0BMOVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 09:21:14 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so2560766ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fjqeBkGuNPdgyKCpzFAmWytnAXNx0bTP3msUrBSs7xo=;
        b=GIIwJBttRQMXNNoa3lgG19R0dE+QmSBK0ggVE1YEL1ijPHJlVRxu4owAVuHR5YIUTC
         D6ofMm8YO5iL5cLVmaYcwzdPksy2+0nECWJ5n+VeHO2UEeQve9IhuxImanYDeRO2fr78
         UpjqMMx9UZOEFD3FPo1sCuMPlgypn24Xe6/g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bJCGPQtaj3qpq2689YYi3lLouzZ1mVWrffo3bWC5mAzzm9D2GR2poztWz417G5IeOR
         eXSZnB8HXDQVwEPnXjtofPzpkMPGtojrGTUrjqz3AXaK3a92f1NPZobz9HSdttOUDRna
         y11QrAFqwLm9pwhyTrpe0+dZhOIZtJ1YQJ7LI=
Received: by 10.213.111.18 with SMTP id q18mr1047669ebp.39.1266070873540;
        Sat, 13 Feb 2010 06:21:13 -0800 (PST)
Received: from fredrik-laptop (c83-250-157-96.bredband.comhem.se [83.250.157.96])
        by mx.google.com with ESMTPS id 28sm10678563eyg.20.2010.02.13.06.21.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 06:21:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100213141558.22851.13660.stgit@fredrik-laptop>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139802>

Best of five runs in the linux repository:

before:

$ time git grep qwerty
drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */

real	0m1.065s
user	0m1.400s
sys	0m0.536s


after:

$ time git grep qwerty
drivers/char/keyboard.c:        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */

real	0m0.621s
user	0m0.560s
sys	0m0.564s

So we gain about 40% by using the kwset code.

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---

 grep.c |   61 +++++++++++++++++++++++++++++++++++++++++--------------------
 grep.h |    2 ++
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/grep.c b/grep.c
index a0864f1..deb5f71 100644
--- a/grep.c
+++ b/grep.c
@@ -51,16 +51,38 @@ struct grep_opt *grep_opt_dup(const struct grep_opt *opt)
 	return ret;
 }
 
+static int is_fixed(const char *s)
+{
+	while (*s && !is_regex_special(*s))
+		s++;
+	return !*s;
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
-
-	if (p->fixed)
+	p->fixed = 0;
+
+	if (opt->fixed || is_fixed(p->pattern))
+		p->fixed = 1;
+
+	if (p->fixed) {
+		if (opt->regflags & REG_ICASE || p->ignore_case) {
+			static char trans[256];
+			int i;
+			for (i = 0; i < 256; i++)
+				trans[i] = tolower(i);
+			p->kws = kwsalloc(trans);
+		} else {
+			p->kws = kwsalloc(NULL);
+		}
+		kwsincr(p->kws, p->pattern, strlen(p->pattern));
+		kwsprep(p->kws);
 		return;
+	}
 
 	err = regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
@@ -241,7 +263,10 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			regfree(&p->regexp);
+			if (p->fixed)
+				kwsfree(p->kws);
+			else
+				regfree(&p->regexp);
 			break;
 		default:
 			break;
@@ -277,21 +302,17 @@ static void show_name(struct grep_opt *opt, const char *name)
 }
 
 
-static int fixmatch(const char *pattern, char *line, int ignore_case, regmatch_t *match)
+static int fixmatch(const kwset_t kws, char *line, size_t sz,
+		    regmatch_t *match)
 {
-	char *hit;
-	if (ignore_case)
-		hit = strcasestr(line, pattern);
-	else
-		hit = strstr(line, pattern);
-
-	if (!hit) {
+	struct kwsmatch kwsm;
+	size_t offset = kwsexec(kws, line, sz, &kwsm);
+	if (offset == -1) {
 		match->rm_so = match->rm_eo = -1;
 		return REG_NOMATCH;
-	}
-	else {
-		match->rm_so = hit - line;
-		match->rm_eo = match->rm_so + strlen(pattern);
+	} else {
+		match->rm_so = offset;
+		match->rm_eo = match->rm_so + kwsm.size[0];
 		return 0;
 	}
 }
@@ -346,7 +367,7 @@ static int match_one_pattern(struct grep_pat *p, char *bol, char *eol,
 
  again:
 	if (p->fixed)
-		hit = !fixmatch(p->pattern, bol, p->ignore_case, pmatch);
+		hit = !fixmatch(p->kws, bol, eol-bol, pmatch);
 	else
 		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);
 
@@ -670,9 +691,9 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
 
-		if (p->fixed)
-			hit = !fixmatch(p->pattern, bol, p->ignore_case, &m);
-		else {
+		if (p->fixed) {
+			hit = !fixmatch(p->kws, bol, *left_p, &m);
+		} else {
 #ifdef REG_STARTEND
 			m.rm_so = 0;
 			m.rm_eo = *left_p;
diff --git a/grep.h b/grep.h
index 9703087..3c79154 100644
--- a/grep.h
+++ b/grep.h
@@ -1,6 +1,7 @@
 #ifndef GREP_H
 #define GREP_H
 #include "color.h"
+#include "kwset.h"
 
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -31,6 +32,7 @@ struct grep_pat {
 	const char *pattern;
 	enum grep_header_field field;
 	regex_t regexp;
+	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
