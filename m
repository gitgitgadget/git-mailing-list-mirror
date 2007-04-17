From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add keyword collapse support to convert.c
Date: Tue, 17 Apr 2007 21:52:58 +0100
Message-ID: <200704172152.58870.andyparkins@gmail.com>
References: <200704172146.33665.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdufw-0006oH-Pc
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031229AbXDQUxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031233AbXDQUxQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:53:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:27941 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031229AbXDQUxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:53:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so268811uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 13:53:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=A0AnotIEiknI5PbGt/CTg/odM4iS0oWi9FlGZRIxr22i6vzApf8ZXVUZYBwx8IV9woXxuYgmXV0MpxMKxoUTjgH6g/lOupyD8NHFjApyitjj0KKr20whf/eO9mF152jNEcVUfgoB496rFZ7odBmO9qpzGby2pT4/WB8PRnsmDrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=el/g4U8BGfLKWcWn68V0AoDjYmd8neXHik720jj3R58cMkHIOWARpUxuG8UZk2rbn4yzbgpLYxxhTIfIBVPdmm/e8uw8JPUqikrG/0tHcPc5gRFIYSqE1HfEgXVWBREuI6JxVJLls2RplKalLnnhgadYGgbTtFgodHreVD4opXg=
Received: by 10.67.28.4 with SMTP id f4mr730933ugj.1176843193524;
        Tue, 17 Apr 2007 13:53:13 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id j1sm1717765ugf.2007.04.17.13.53.11;
        Tue, 17 Apr 2007 13:53:12 -0700 (PDT)
In-Reply-To: <200704172146.33665.andyparkins@gmail.com>
X-TUID: 1ca426c367e32ca3
X-Length: 8891
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44823>

This patch adds expansion of keywords support.  The collapse is only
performed when the "keywords" attribute it found for a file.  The check
for this attribute is done in the same way as the "crlf" attribute
check.

The actual collapse is performed by keyword_collapse_git() which is
called from convert_to_git() when the "keywords" attribute is found.

keyword_collapse_git() finds strings of the form

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
keyword_collapse_git() and the flag again updated.  It then returns 1 if
either of these conversion functions actually changed anything.

I've also included a test script to show that the keyword collapse is
working.  It particular demonstrates that the diff between a file with
keywords and the repository is blind to the expanded keyword.

git-apply is patched to perform the collapse as well on each fragment.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

This is on top of 1ddfc1ad616550764056077b9e12a35533298c89.

I'm positing it for posterity.  It's not going anywhere though, so I'm not
submitting it for inclusion.


 builtin-apply.c     |    2 +
 convert.c           |  123 +++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t0030-keywords.sh |   95 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100755 t/t0030-keywords.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index fd92ef7..212c7d4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1056,6 +1056,8 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 	unsigned long oldlines = 0, newlines = 0, context = 0;
 	struct fragment **fragp = &patch->fragments;
 
+	convert_to_git( patch->new_name, &line, &size );
+
 	while (size > 4 && !memcmp(line, "@@ -", 4)) {
 		struct fragment *fragment;
 		int len;
diff --git a/convert.c b/convert.c
index d0d4b81..a18e7ea 100644
--- a/convert.c
+++ b/convert.c
@@ -230,16 +230,133 @@ static int git_path_check_crlf(const char *path)
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
+static int keyword_collapse_git(const char *path, char **bufp, unsigned long *sizep)
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
+	 * Allocate an identically sized buffer, keyword collapse can
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
+			else if (c == '$' || c == '\n' || c == '\r' || c == '\0' )
+				parser_state = END_KEYWORD;
+			else
+				keywordlength++;
+			break;
+		case IN_EXPANSION:   /* The expansion gets silently removed */
+			if (c == '$' || c == '\n' || c == '\r' || c == '\0' )
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
+		break;
+	case 1:
+		changes += forcecrlf_to_git(path, bufp, sizep);
+		break;
+	default:
+		changes += autocrlf_to_git(path, bufp, sizep);
+		break;
+	}
+
+	switch (git_path_check_keyword(path)) {
+	case 0:
+		changes += 0;
+		break;
 	case 1:
-		return forcecrlf_to_git(path, bufp, sizep);
+		changes += keyword_collapse_git(path, bufp, sizep);
+		break;
 	default:
-		return autocrlf_to_git(path, bufp, sizep);
+		changes += 0;
+		break;
 	}
+	return (changes != 0);
 }
 
 int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
diff --git a/t/t0030-keywords.sh b/t/t0030-keywords.sh
new file mode 100755
index 0000000..5180b0e
--- /dev/null
+++ b/t/t0030-keywords.sh
@@ -0,0 +1,95 @@
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
+test_expect_failure 'Keywords collapse active' '
+
+	git show HEAD:keywordsfile > keywordsfile.cmp &&
+	cmp keywordsfile keywordsfile.cmp
+
+'
+
+# expect success because we want to find the keyword line collapsed in the
+# and hence appearing unchanged in the output of git-diff
+test_expect_success 'git-diff with keywords present' '
+	echo "Non-keyword containing line" >> keywordsfile &&
+	git diff -- keywordsfile | grep -qs "^ \$keyword:\$$"
+'
+
+# Check git-apply blindness
+cat > keyword-patch.diff << EOF
+diff --git a/keywordsfile b/keywordsfile
+--- a/keywordsfile
++++ b/keywordsfile
+@@ -1,2 +1,2 @@
+ \$keyword:\$
+-Non-keyword containing line
++Another non-keyword containing line
+EOF
+
+test_expect_success 'patch application with keywords active' '
+	git-apply --check keyword-patch.diff
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
+# If keywords are later disabled on that file, then the keyword collapsed
+# will be ignored, so a diff should now show differences, because git is no
+# longer keyword blind
+test_expect_success 'git-diff with keywords in file but disabled' '
+	git diff -- keywordsfile | grep -qs "^diff"
+'
+
+# Expect success because the repository should be identical to the working tree
+test_expect_success 'Keywords collapse inactive' '
+
+	git add keywordsfile &&
+	git commit -m "test-not-keywords"
+
+	git show HEAD:keywordsfile > keywordsfile.cmp &&
+	cmp keywordsfile keywordsfile.cmp
+'
+
+test_expect_failure 'patch application without keywords active' '
+	git-apply --check keyword-patch.diff
+'
+
+test_done
-- 
1.5.1.1.822.g0049
