From: Brian Collins <bricollins@gmail.com>
Subject: [PATCH] RFC Allow case insensitive search flag with git-grep for fixed-strings
Date: Thu, 29 Oct 2009 18:21:59 -0700
Message-ID: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 02:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3gBs-0002xp-LI
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 02:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbZJ3BV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 21:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755003AbZJ3BV6
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 21:21:58 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:42561 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbZJ3BV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 21:21:57 -0400
Received: by qyk4 with SMTP id 4so1457598qyk.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=lAVlmxzuev2swKNbPgWrvZ5TbEJNOQS0LL9EwuK4xG8=;
        b=FWQkxncqVKEvpFakOT1iTODVL6oXEO/KLG8vmzVnH+Dc1x9wr7CJT8Y2KvlqBA5cdW
         vckA9kUCF76gohUkAfKVwbB0XU9UHWxou1U7UFdyCxFhZYNNF+I1J1C4QtH4e7hZIOBb
         6K0SMevbqSBGiFtqCFWjVm1mohUKOPqZkK7DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=AfTHQuM1bFjHY4mxCxW7hnkELhgfK6AwkeIvhJspQiPFqBQSkvqwOQH/oo8er0rMyO
         Nkr2xZ2lz7hpZ2dmGyogLKLl9wl9uIYVllULZxD9BLBpAABey3qcuY18Lc+ya+dtT5LU
         9sLHwzCkJv5XkDwfUrpTLebjfnpnRzc95FzCs=
Received: by 10.224.69.229 with SMTP id a37mr504214qaj.90.1256865721866;
        Thu, 29 Oct 2009 18:22:01 -0700 (PDT)
Received: from ?10.2.11.78? ([209.17.173.13])
        by mx.google.com with ESMTPS id 23sm1684040qyk.15.2009.10.29.18.22.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 18:22:01 -0700 (PDT)
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131669>

You will have to excuse me, this is my first patch and I don't know if  
this is the right place to post this. Apologies in advance if I'm in  
the wrong place.

git-grep currently throws an error when you combine the -F and -i  
flags. This isn't in line with how GNU grep handles it. This patch  
allows the simultaneous use of those flags.

---
  builtin-grep.c |    8 +++++---
  grep.c         |   16 ++++++++++++----
  grep.h         |    2 ++
  3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..c73f05b 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -367,7 +367,7 @@ static int external_grep(struct grep_opt *opt,  
const char **paths, int cached)
  		push_arg("-h");
  	if (opt->regflags & REG_EXTENDED)
  		push_arg("-E");
-	if (opt->regflags & REG_ICASE)
+	if (opt->caseless)
  		push_arg("-i");
  	if (opt->binary == GREP_BINARY_NOMATCH)
  		push_arg("-I");
@@ -706,8 +706,8 @@ int cmd_grep(int argc, const char **argv, const  
char *prefix)
  		OPT_GROUP(""),
  		OPT_BOOLEAN('v', "invert-match", &opt.invert,
  			"show non-matching lines"),
-		OPT_BIT('i', "ignore-case", &opt.regflags,
-			"case insensitive matching", REG_ICASE),
+		OPT_BOOLEAN('i', "ignore-case", &opt.caseless,
+			"case insensitive matching"),
  		OPT_BOOLEAN('w', "word-regexp", &opt.word_regexp,
  			"match patterns only at word boundaries"),
  		OPT_SET_INT('a', "text", &opt.binary,
@@ -830,6 +830,8 @@ int cmd_grep(int argc, const char **argv, const  
char *prefix)
  		external_grep_allowed = 0;
  	if (!opt.pattern_list)
  		die("no pattern given.");
+	if (!opt.fixed && opt.caseless)
+		opt.regflags |= REG_ICASE;
  	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
  		die("cannot mix --fixed-strings and regexp");
  	compile_grep_patterns(&opt);
diff --git a/grep.c b/grep.c
index 5d162da..d8f14be 100644
--- a/grep.c
+++ b/grep.c
@@ -41,7 +41,8 @@ static void compile_regexp(struct grep_pat *p,  
struct grep_opt *opt)
  	int err;

  	p->word_regexp = opt->word_regexp;
-
+	p->caseless = opt->caseless;
+	
  	if (opt->fixed || is_fixed(p->pattern))
  		p->fixed = 1;
  	if (opt->regflags & REG_ICASE)
@@ -262,9 +263,16 @@ static void show_name(struct grep_opt *opt, const  
char *name)
  	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
  }

-static int fixmatch(const char *pattern, char *line, regmatch_t *match)
+
+static int fixmatch(const char *pattern, char *line, int caseless,  
regmatch_t *match)
  {
-	char *hit = strstr(line, pattern);
+	char *hit;
+	if (caseless) {
+		hit = strcasestr(line, pattern);
+	} else {
+		hit = strstr(line, pattern);
+	}
+	
  	if (!hit) {
  		match->rm_so = match->rm_eo = -1;
  		return REG_NOMATCH;
@@ -326,7 +334,7 @@ static int match_one_pattern(struct grep_pat *p,  
char *bol, char *eol,

   again:
  	if (p->fixed)
-		hit = !fixmatch(p->pattern, bol, pmatch);
+		hit = !fixmatch(p->pattern, bol, p->caseless, pmatch);
  	else
  		hit = !regexec(&p->regexp, bol, 1, pmatch, eflags);

diff --git a/grep.h b/grep.h
index f6eecc6..24b7d44 100644
--- a/grep.h
+++ b/grep.h
@@ -32,6 +32,7 @@ struct grep_pat {
  	enum grep_header_field field;
  	regex_t regexp;
  	unsigned fixed:1;
+	unsigned caseless:1;
  	unsigned word_regexp:1;
  };

@@ -64,6 +65,7 @@ struct grep_opt {
  	regex_t regexp;
  	int linenum;
  	int invert;
+	int caseless;
  	int status_only;
  	int name_only;
  	int unmatch_name_only;
-- 
1.6.4.4
