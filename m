From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] grep: support newline separated pattern list
Date: Sun, 20 May 2012 16:33:07 +0200
Message-ID: <4FB900A3.9050309@lsrfire.ath.cx>
References: <CAEV-rjc0PtuQZei95_24=Ou=mZZxA0Lsr6boXGrGy3z40otkNQ@mail.gmail.com> <4FB6426C.7040202@lsrfire.ath.cx> <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Torne (Richard Coles)" <torne@google.com>
X-From: git-owner@vger.kernel.org Sun May 20 16:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW7CS-00084q-Nr
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 16:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab2ETOdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 10:33:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:32931 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab2ETOdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 10:33:14 -0400
Received: from [192.168.2.105] (p4FFD8E63.dip.t-dialin.net [79.253.142.99])
	by india601.server4you.de (Postfix) with ESMTPSA id 50DB32F807A;
	Sun, 20 May 2012 16:33:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAEV-rjd=WjLu8e+UCnAHVxg7DTLWe+YrEO_Gs2rh5Oy1=KA5sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198061>

Currently, patterns that contain newline characters don't match anything
when given to git grep.  Regular grep(1) interprets patterns as lists of
newline separated search strings instead.

Implement this functionality by creating and inserting extra grep_pat
structures for patterns consisting of multiple lines when appending to
the pattern lists.  For simplicity, all pattern strings are duplicated.
The original pattern is truncated in place to make it contain only the
first line.

Requested-by: Torne (Richard Coles) <torne@google.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |    4 +++-
 grep.c                     |   33 ++++++++++++++++++++++++++++++++-
 grep.h                     |    2 +-
 t/t7810-grep.sh            |    5 +++++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4785f1c..3bec036 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -31,7 +31,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 Look for specified patterns in the tracked files in the work tree, blobs
-registered in the index file, or blobs in given tree objects.
+registered in the index file, or blobs in given tree objects.  Patterns
+are lists of one or more search expressions separated by newline
+characters.  An empty string as search expression matches all lines.
 
 
 CONFIGURATION
diff --git a/grep.c b/grep.c
index f961c2e..04e3ec6 100644
--- a/grep.c
+++ b/grep.c
@@ -9,7 +9,7 @@ static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
 					enum grep_header_field field)
 {
 	struct grep_pat *p = xcalloc(1, sizeof(*p));
-	p->pattern = pat;
+	p->pattern = xmemdupz(pat, patlen);
 	p->patternlen = patlen;
 	p->origin = origin;
 	p->no = no;
@@ -23,6 +23,36 @@ static void do_append_grep_pat(struct grep_pat ***tail, struct grep_pat *p)
 	**tail = p;
 	*tail = &p->next;
 	p->next = NULL;
+
+	switch (p->token) {
+	case GREP_PATTERN: /* atom */
+	case GREP_PATTERN_HEAD:
+	case GREP_PATTERN_BODY:
+		for (;;) {
+			struct grep_pat *new_pat;
+			size_t len = 0;
+			char *cp = p->pattern + p->patternlen, *nl = NULL;
+			while (++len <= p->patternlen) {
+				if (*(--cp) == '\n') {
+					nl = cp;
+					break;
+				}
+			}
+			if (!nl)
+				break;
+			new_pat = create_grep_pat(nl + 1, len - 1, p->origin,
+						  p->no, p->token, p->field);
+			new_pat->next = p->next;
+			if (!p->next)
+				*tail = &new_pat->next;
+			p->next = new_pat;
+			*nl = '\0';
+			p->patternlen -= len;
+		}
+		break;
+	default:
+		break;
+	}
 }
 
 void append_header_grep_pattern(struct grep_opt *opt,
@@ -439,6 +469,7 @@ void free_grep_patterns(struct grep_opt *opt)
 				free_pcre_regexp(p);
 			else
 				regfree(&p->regexp);
+			free(p->pattern);
 			break;
 		default:
 			break;
diff --git a/grep.h b/grep.h
index 36e49d8..ed7de6b 100644
--- a/grep.h
+++ b/grep.h
@@ -38,7 +38,7 @@ struct grep_pat {
 	const char *origin;
 	int no;
 	enum grep_pat_token token;
-	const char *pattern;
+	char *pattern;
 	size_t patternlen;
 	enum grep_header_field field;
 	regex_t regexp;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index d9ad633..24e9b19 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -351,6 +351,11 @@ test_expect_success 'grep -f, multiple patterns' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep, multiple patterns' '
+	git grep "$(cat patterns)" >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<EOF
 file:foo mmap bar
 file:foo_mmap bar
-- 
1.7.10.2
