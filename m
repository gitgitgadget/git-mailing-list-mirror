From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 10:41:45 +0100
Message-ID: <200704171041.46176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 11:42:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdkCH-0002vX-Hp
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbXDQJl6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbXDQJl6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:41:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:33214 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbXDQJl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:41:57 -0400
Received: by ug-out-1314.google.com with SMTP id 44so123845uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 02:41:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=YKuEdySFJ+fP8z5v6noKmDruKw0oqLZ5Z6wSAGcDLSTFtwNQA66l1VXY7X4LY1ckyLbjR+7FHO+B+dMsTfByXRRmnnJeDbFdp2spdCRPdSD12HyXbDAQujCmzhKXO3/6nfHdMd28KYQL/BPoFntGQbP/+S3Qc7SxGc5sZbUp8gE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=VLoR5Od01z4CYizrg4514Gt9cOZvPZkPdPt0bcAUhiPEty7rCO0QuQCdkf7ATwj6F0nJM6zFwMKBjzNfZZkRxF9JTKckFe9RU3HiHOc5CeGbhAA/yhLypVkLJtR70I5hK2xHHasdO3+7L2aoiUYk2Gqa/7wB3zJxfOk6n+j48Rg=
Received: by 10.82.185.12 with SMTP id i12mr2325327buf.1176802913816;
        Tue, 17 Apr 2007 02:41:53 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z34sm2181410ikz.2007.04.17.02.41.51;
        Tue, 17 Apr 2007 02:41:52 -0700 (PDT)
X-TUID: 77ac5a702fc2996d
X-UID: 302
X-Length: 7583
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44750>

This patch adds expansion of keywords support.  The unexpansion is only
performed when the "keywords" attribute it found for a file.  The check
for this attribute is done in the same way as the "crlf" attribute
check.

The actual unexpansion is performed by keyword_unexpand_git() which is
called from convert_to_git() when the "keywords" attribute is found.

keyword_unexpand_git() finds strings of the form

 $KEYWORD: ARBITRARY STRING$

And collapses them into

 $KEYWORD:$

No parsing of the keyword itself is performed, the content is simply
dropped.

Despite the fact that this doesn't do anything useful from the users
perspective, this patch forms the more important half of keyword
expansion support - because it prevents the expansion from entering the
repository.  It effectively creates blind spots that git tools won't
see.

convert_to_git() has also been changed so that it no longer only does
CRLF conversion.  Instead, a flag is kept to say whether any conversion
was done by the CRLF code, and then that converted buffer is passed to
keyword_unexpand_git() and the flag again updated.  It then returns 1 if
either of these conversion functions actually changed anything.

I've also included a test script to show that the keyword unexpansion is
working.  It particular demonstrates that the diff between a file with
keywords and the repository is blind to the expanded keyword.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I'm not submitting this for application; I've not polished it, and I've not
written the expansion half yet.

However, I did want to show what I've been banging on about with keyword
expansion, and this does a reasonable job.  The test code shows that the idea
is sound - what goes in the repository is stable, and what appears in the
working directory can contain any arbitrary keyword expansion.

Adding expansion is harder, as I have no clue which calls to make to find
even the most basic information about an object; but I thought I'd get
feedback before I expend that effort.

Areas that might cause problems are the git-apply type of commands, I haven't
checked to see if they use convert_to_git() on their input to normalise it
for entry into the repository.  I hope so, as the CRLF support relies on it as
well :-)

 convert.c           |  115 +++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t0030-keywords.sh |   76 +++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+), 3 deletions(-)
 create mode 100755 t/t0030-keywords.sh

diff --git a/convert.c b/convert.c
index d0d4b81..0c7b270 100644
--- a/convert.c
+++ b/convert.c
@@ -230,16 +230,125 @@ static int git_path_check_crlf(const char *path)
 	return attr_crlf_check.isset;
 }
 
+/* ------------------ keywords -------------------- */
+
+static void setup_keyword_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_keyword;
+
+	if (!attr_keyword)
+		attr_keyword = git_attr("keywords", 8);
+	check->attr = attr_keyword;
+}
+
+static int git_path_check_keyword(const char *path)
+{
+	struct git_attr_check attr_keyword_check;
+
+	setup_keyword_check(&attr_keyword_check);
+
+	if (git_checkattr(path, 1, &attr_keyword_check))
+		return -1;
+	return attr_keyword_check.isset;
+}
+
+static int keyword_unexpand_git(const char *path, char **bufp, unsigned long *sizep)
+{
+	char *buffer, *nbuf, *keyword;
+	unsigned long size, keywordlength;
+	int changes = 0;
+	enum {
+		IN_VOID,
+		PRE_KEYWORD,
+		IN_KEYWORD,
+		IN_EXPANSION,
+		END_KEYWORD
+	} parser_state = IN_VOID;
+
+	size = *sizep;
+	if (!size)
+		return 0;
+	buffer = *bufp;
+
+	/*
+	 * Allocate an identically sized buffer, keyword unexpansion can
+	 * only reduce the size so we'll never overflow (although we might
+	 * waste a few bytes
+	 */
+	nbuf = xmalloc(size);
+	*bufp = nbuf;
+
+	while (size) {
+		unsigned char c;
+
+		c = *buffer;
+
+		switch( parser_state ) {
+		case IN_VOID:        /* Normal characters, wait for '$' */
+			if (c == '$')
+				parser_state = PRE_KEYWORD;
+			break;
+		case PRE_KEYWORD:    /* Gap between '$' and keyword */
+			keywordlength = 0;
+			keyword = buffer;
+			if (!isspace(c))
+				parser_state = IN_KEYWORD;
+			else
+				break;
+		case IN_KEYWORD:     /* Keyword itself */
+			if (c == ':')
+				parser_state = IN_EXPANSION;
+			else if (c == '$' || c == '\n' || c == '\r')
+				parser_state = END_KEYWORD;
+			else
+				keywordlength++;
+			break;
+		case IN_EXPANSION:   /* The expansion gets silently removed */
+			if (c == '$' || c == '\n')
+				parser_state = END_KEYWORD;
+			else {
+				changes = 1;
+				/* Every character we skip reduces the overall size */
+				(*sizep)--;
+				buffer++;
+				size--;
+			}
+			continue;
+		case END_KEYWORD:    /* End of keyword */
+			parser_state = IN_VOID;
+			break;
+		}
+
+		*nbuf++ = c;
+		buffer++;
+		size--;
+	}
+
+	return (changes != 0);
+}
+
+
+/* ------------------------------------------------ */
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
+	int changes = 0;
+
 	switch (git_path_check_crlf(path)) {
 	case 0:
-		return 0;
+		changes += 0;
 	case 1:
-		return forcecrlf_to_git(path, bufp, sizep);
+		changes += forcecrlf_to_git(path, bufp, sizep);
 	default:
-		return autocrlf_to_git(path, bufp, sizep);
+		changes += autocrlf_to_git(path, bufp, sizep);
+	}
+
+	switch (git_path_check_keyword(path)) {
+	case 0:
+		changes += 0;
+	case 1:
+		changes += keyword_unexpand_git(path, bufp, sizep);
 	}
+	return (changes != 0);
 }
 
 int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
diff --git a/t/t0030-keywords.sh b/t/t0030-keywords.sh
new file mode 100755
index 0000000..375acb8
--- /dev/null
+++ b/t/t0030-keywords.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+cd $(dirname $0)
+
+test_description='Keyword expansion'
+
+. ./test-lib.sh
+
+# Adding the attribute "keywords" turns the keyword expansion on
+# I've used "notkeywords" as an attribute as a placeholder attribute
+# but this is just "somerandomattribute", it has no meaning
+
+# Expect success because the keyword attribute should be found
+test_expect_success 'Keywords attribute present' '
+
+	echo "keywordsfile keywords" >.gitattributes &&
+
+	echo "\$keyword: anythingcangohere\$" > keywordsfile &&
+
+	git add keywordsfile &&
+	git add .gitattributes &&
+	git commit -m test-keywords &&
+
+	git check-attr keywords -- keywordsfile
+'
+
+# Expect failure because the repository version should be different from the
+# working tree version.
+#
+#  In repository : $keyword:$
+#  In working dir: $keyword: anythingcangohere$
+#
+test_expect_failure 'Keywords unexpansion active' '
+
+	git show HEAD:keywordsfile > keywordsfile.cmp &&
+	cmp keywordsfile keywordsfile.cmp
+
+'
+
+# expect success because we want to find the keyword line unexpanded in the
+# and hence appearing unchanged in the output of git-diff
+test_expect_success 'git-diff with keywords present' '
+	echo "Non-keyword containing line" >> keywordsfile &&
+	git diff -- keywordsfile | grep -qs "^ \$keyword:\$$"
+'
+
+# Expect failure because the keywords attribute should NOT be found
+test_expect_failure 'Keywords attribute absent' '
+
+	echo "keywordsfile notkeywords" >.gitattributes &&
+
+	git add .gitattributes &&
+	git commit -m test-not-keywords &&
+
+	git check-attr keywords -- keywordsfile
+
+'
+
+# If keywords are later disabled on that file, then the keyword unexpansion
+# will be ignored, so a diff should now show differences, because git is no
+# longer keyword blind
+test_expect_success 'git-diff with keywords in file but disabled' '
+	git diff -- keywordsfile | grep -qs "^diff"
+'
+
+# Expect success because the repository should be identical to the working tree
+test_expect_success 'Keywords unexpansion inactive' '
+
+	git add keywordsfile &&
+	git commit -m "test-not-keywords"
+
+	git show HEAD:keywordsfile > keywordsfile.cmp &&
+	cmp keywordsfile keywordsfile.cmp
+'
+
+test_done
-- 
1.5.1.1.821.g88bdb
