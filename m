From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] git-tag: Fix -l option to use better shell style globs.
Date: Sat, 01 Sep 2007 07:10:09 +0200
Message-ID: <46D8F431.70801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 07:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRLFy-0003i8-Ua
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 07:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXIAFKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 01:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbXIAFKS
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 01:10:18 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:43343 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbXIAFKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 01:10:17 -0400
Received: by fk-out-0910.google.com with SMTP id z23so781970fkz
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 22:10:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=E8fscRk16t/AVfVoRQoUWQDNk6YHgNnC5q3OUm4fzFHno1pFkQfFggM5SnIYlu1IfbUMmRsoi2hQPfk1C9LlTJ70sL0BRGjdW0TKTMfeoOFAWA4c0DixjQciTAM8yYzyGO9dmeA/T8h13DOWdx6gXiCr766jJbSAkUD2kr2uil4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=m63U5DUcPQnlw27Yh6HwU31SqZQpymimRRG9Ly5HFqLP8uy6Ddxov+sk3qUzDyOYbr1Wk0aKI/BRbR2CfkfaJdwicLlP9DB0j6PBrHTs5XhzWVXnLt51aOEKZV8nHzGrGPq0AbIh0dPn5LyASYI4XsQT+GFvoLf8S35j1JFBOT8=
Received: by 10.82.178.11 with SMTP id a11mr5338481buf.1188623415136;
        Fri, 31 Aug 2007 22:10:15 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id e1sm111067ugf.2007.08.31.22.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Aug 2007 22:10:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57252>

This patch removes certain behaviour of "git tag -l foo", currently
listing every tag name having "foo" as a substring.  The same
thing now could be achieved doing "git tag -l '*foo*'".

This feature was added recently when git-tag.sh got the -n option
for showing tag annotations, because that commit also replaced the
old "grep pattern" behaviour with a more preferable "shell pattern"
behaviour (although slightly modified as you can see).
Thus, the following builtin-tag.c implemented it in order to
ensure that tests were passing unchanged with both programs.

Since common "shell patterns" match names with a given substring
_only_ when * is inserted before and after (as in "*substring*"), and
the "plain" behaviour cannot be achieved easily with the current
implementation, this is mostly the right thing to do, in order to
make it more flexible and consistent.

Tests for "git tag" were also changed to reflect this.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 builtin-tag.c  |   11 ++---------
 t/t7004-tag.sh |   20 +++++++++-----------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index d6d38ad..348919c 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -123,22 +123,15 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 static int list_tags(const char *pattern, int lines)
 {
 	struct tag_filter filter;
-	char *newpattern;

 	if (pattern == NULL)
-		pattern = "";
+		pattern = "*";

-	/* prepend/append * to the shell pattern: */
-	newpattern = xmalloc(strlen(pattern) + 3);
-	sprintf(newpattern, "*%s*", pattern);
-
-	filter.pattern = newpattern;
+	filter.pattern = pattern;
 	filter.lines = lines;

 	for_each_tag_ref(show_reference, (void *) &filter);

-	free(newpattern);
-
 	return 0;
 }

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c4fa446..606d4f2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -185,18 +185,17 @@ cba
 EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
-	git-tag -l a > actual &&
+	git-tag -l "*a*" > actual &&
 	git diff expect actual
 '

 cat >expect <<EOF
 v0.2.1
 v1.0.1
-v1.1.3
 EOF
 test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
-	git-tag -l .1 > actual &&
+	'listing tags with a suffix as pattern must print those matching' '
+	git-tag -l "*.1" > actual &&
 	git diff expect actual
 '

@@ -205,37 +204,36 @@ t210
 t211
 EOF
 test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
-	git-tag -l t21 > actual &&
+	'listing tags with a prefix as pattern must print those matching' '
+	git-tag -l "t21*" > actual &&
 	git diff expect actual
 '

 cat >expect <<EOF
 a1
-aa1
 EOF
 test_expect_success \
-	'listing tags using a name as pattern must print those matching' '
+	'listing tags using a name as pattern must print that one matching' '
 	git-tag -l a1 > actual &&
 	git diff expect actual
 '

 cat >expect <<EOF
 v1.0
-v1.0.1
 EOF
 test_expect_success \
-	'listing tags using a name as pattern must print those matching' '
+	'listing tags using a name as pattern must print that one matching' '
 	git-tag -l v1.0 > actual &&
 	git diff expect actual
 '

 cat >expect <<EOF
+v1.0.1
 v1.1.3
 EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
-	git-tag -l "1.1?" > actual &&
+	git-tag -l "v1.?.?" > actual &&
 	git diff expect actual
 '

-- 
1.5.0
