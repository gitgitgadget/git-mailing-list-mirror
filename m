From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2 5/5] Use kwset in grep
Date: Sun, 21 Aug 2011 00:42:18 +0200
Message-ID: <20110820224218.GF2199@fredrik-Q430-Q530>
References: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, dpotapov@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 00:42:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuuFG-0008Lc-PK
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 00:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab1HTWmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 18:42:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35673 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab1HTWmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 18:42:21 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2936995bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wTuQJRCL+eaRsfc2QtrQdHL7JJ1JarmBEsQFDPrzlsc=;
        b=KWsXWn+7rsO1BvwTDlPJ6S2k2oPmp2Xj6A3BX1cOe741BvmpxPEO2yM+z9M8UIEGxy
         x/1UTgpLQXZmS7HARvW/J7ZJG3uYWGRzniLtfCBJGHn8e1dYm3rFAAysgNfkwNT4gtsZ
         38RYdGJ5d7dyLlzm3AG6qtGPVpk9ddlR054ps=
Received: by 10.204.153.27 with SMTP id i27mr309353bkw.323.1313880141128;
        Sat, 20 Aug 2011 15:42:21 -0700 (PDT)
Received: from fredrik-Q430-Q530 (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id z7sm1060536bkj.5.2011.08.20.15.42.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 15:42:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179791>

Benchmarks for the hot cache case:

before:
$ perf stat --repeat=5 git grep qwerty > /dev/null

Performance counter stats for 'git grep qwerty' (5 runs):

        3,478,085 cache-misses             #      2.322 M/sec   ( +-   2.690% )
       11,356,177 cache-references         #      7.582 M/sec   ( +-   2.598% )
        3,872,184 branch-misses            #      0.363 %       ( +-   0.258% )
    1,067,367,848 branches                 #    712.673 M/sec   ( +-   2.622% )
    3,828,370,782 instructions             #      0.947 IPC     ( +-   0.033% )
    4,043,832,831 cycles                   #   2700.037 M/sec   ( +-   0.167% )
            8,518 page-faults              #      0.006 M/sec   ( +-   3.648% )
              847 CPU-migrations           #      0.001 M/sec   ( +-   3.262% )
            6,546 context-switches         #      0.004 M/sec   ( +-   2.292% )
      1497.695495 task-clock-msecs         #      3.303 CPUs    ( +-   2.550% )

       0.453394396  seconds time elapsed   ( +-   0.912% )

after:
$ perf stat --repeat=5 git grep qwerty > /dev/null

Performance counter stats for 'git grep qwerty' (5 runs):

        2,989,918 cache-misses             #      3.166 M/sec   ( +-   5.013% )
       10,986,041 cache-references         #     11.633 M/sec   ( +-   4.899% )  (scaled from 95.06%)
        3,511,993 branch-misses            #      1.422 %       ( +-   0.785% )
      246,893,561 branches                 #    261.433 M/sec   ( +-   3.967% )
    1,392,727,757 instructions             #      0.564 IPC     ( +-   0.040% )
    2,468,142,397 cycles                   #   2613.494 M/sec   ( +-   0.110% )
            7,747 page-faults              #      0.008 M/sec   ( +-   3.995% )
              897 CPU-migrations           #      0.001 M/sec   ( +-   2.383% )
            6,535 context-switches         #      0.007 M/sec   ( +-   1.993% )
       944.384228 task-clock-msecs         #      3.177 CPUs    ( +-   0.268% )

       0.297257643  seconds time elapsed   ( +-   0.450% )


So we gain about 35% by using the kwset code.

As a side effect of using kwset two grep tests are fixed by this
patch. The first is fixed because kwset can deal with case-insensitive
search containing NULs, something strcasestr cannot do. The second one
is fixed because we consider patterns containing NULs as fixed strings
(regcomp cannot accept patterns with NULs).

Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 grep.c                 |   66 +++++++++++++++++++++++++++++++++---------------
 grep.h                 |    2 +
 t/t7008-grep-binary.sh |    4 +--
 3 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/grep.c b/grep.c
index 26e8d8e..6618cd8 100644
--- a/grep.c
+++ b/grep.c
@@ -137,16 +137,50 @@ static void free_pcre_regexp(struct grep_pat *p)
 }
 #endif /* !USE_LIBPCRE */
 
+static int is_fixed(const char *s, size_t len)
+{
+	size_t i;
+
+	/* regcomp cannot accept patterns with NULs so we
+	 * consider any pattern containing a NUL fixed.
+	 */
+	if (memchr(s, 0, len))
+		return 1;
+
+	for (i = 0; i < len; i++) {
+		if (is_regex_special(s[i]))
+			return 0;
+	}
+
+	return 1;
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
 
-	if (p->fixed)
+	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+		p->fixed = 1;
+	else
+		p->fixed = 0;
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
+		kwsincr(p->kws, p->pattern, p->patternlen);
+		kwsprep(p->kws);
 		return;
+	}
 
 	if (opt->pcre) {
 		compile_pcre_regexp(p, opt);
@@ -395,7 +429,9 @@ void free_grep_patterns(struct grep_opt *opt)
 		case GREP_PATTERN: /* atom */
 		case GREP_PATTERN_HEAD:
 		case GREP_PATTERN_BODY:
-			if (p->pcre_regexp)
+			if (p->kws)
+				kwsfree(p->kws);
+			else if (p->pcre_regexp)
 				free_pcre_regexp(p);
 			else
 				regfree(&p->regexp);
@@ -455,26 +491,14 @@ static void show_name(struct grep_opt *opt, const char *name)
 static int fixmatch(struct grep_pat *p, char *line, char *eol,
 		    regmatch_t *match)
 {
-	char *hit;
-
-	if (p->ignore_case) {
-		char *s = line;
-		do {
-			hit = strcasestr(s, p->pattern);
-			if (hit)
-				break;
-			s += strlen(s) + 1;
-		} while (s < eol);
-	} else
-		hit = memmem(line, eol - line, p->pattern, p->patternlen);
-
-	if (!hit) {
+	struct kwsmatch kwsm;
+	size_t offset = kwsexec(p->kws, line, eol - line, &kwsm);
+	if (offset == -1) {
 		match->rm_so = match->rm_eo = -1;
 		return REG_NOMATCH;
-	}
-	else {
-		match->rm_so = hit - line;
-		match->rm_eo = match->rm_so + p->patternlen;
+	} else {
+		match->rm_so = offset;
+		match->rm_eo = match->rm_so + kwsm.size[0];
 		return 0;
 	}
 }
diff --git a/grep.h b/grep.h
index ae50c45..a652800 100644
--- a/grep.h
+++ b/grep.h
@@ -7,6 +7,7 @@
 typedef int pcre;
 typedef int pcre_extra;
 #endif
+#include "kwset.h"
 
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -41,6 +42,7 @@ struct grep_pat {
 	regex_t regexp;
 	pcre *pcre_regexp;
 	pcre_extra *pcre_extra_info;
+	kwset_t kws;
 	unsigned fixed:1;
 	unsigned ignore_case:1;
 	unsigned word_regexp:1;
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index e058d18..917a264 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -84,7 +84,7 @@ test_expect_success 'git grep -Fi Y<NUL>f a' "
 	git grep -f f -Fi a
 "
 
-test_expect_failure 'git grep -Fi Y<NUL>x a' "
+test_expect_success 'git grep -Fi Y<NUL>x a' "
 	printf 'YQx' | q_to_nul >f &&
 	test_must_fail git grep -f f -Fi a
 "
@@ -94,7 +94,7 @@ test_expect_success 'git grep y<NUL>f a' "
 	git grep -f f a
 "
 
-test_expect_failure 'git grep y<NUL>x a' "
+test_expect_success 'git grep y<NUL>x a' "
 	printf 'yQx' | q_to_nul >f &&
 	test_must_fail git grep -f f a
 "
