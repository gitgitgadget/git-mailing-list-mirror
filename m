From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitattributes: fix relative path matching
Date: Thu, 07 Feb 2008 00:22:16 -0800
Message-ID: <7vodatp45j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 09:23:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN229-0005Dl-IJ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 09:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbYBGIW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 03:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYBGIW1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 03:22:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbYBGIW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 03:22:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E66302B17;
	Thu,  7 Feb 2008 03:22:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 173A22B16;
	Thu,  7 Feb 2008 03:22:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72909>

There was an embarrassing pair of off-by-one miscounting that
failed to match path "a/b/c" when "a/.gitattributes" tried to
name it with relative path "b/c".

This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c                |    6 +++---
 t/t0003-attributes.sh |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)
 create mode 100755 t/t0003-attributes.sh

diff --git a/attr.c b/attr.c
index 741db3b..64b77b1 100644
--- a/attr.c
+++ b/attr.c
@@ -406,7 +406,7 @@ static void debug_info(const char *what, struct attr_stack *elem)
 {
 	fprintf(stderr, "%s: %s\n", what, elem->origin ? elem->origin : "()");
 }
-static void debug_set(const char *what, const char *match, struct git_attr *attr, void *v)
+static void debug_set(const char *what, const char *match, struct git_attr *attr, const void *v)
 {
 	const char *value = v;
 
@@ -543,10 +543,10 @@ static int path_matches(const char *pathname, int pathlen,
 	if (*pattern == '/')
 		pattern++;
 	if (pathlen < baselen ||
-	    (baselen && pathname[baselen - 1] != '/') ||
+	    (baselen && pathname[baselen] != '/') ||
 	    strncmp(pathname, base, baselen))
 		return 0;
-	return fnmatch(pattern, pathname + baselen, FNM_PATHNAME) == 0;
+	return fnmatch(pattern, pathname + baselen + 1, FNM_PATHNAME) == 0;
 }
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
new file mode 100755
index 0000000..47f08a4
--- /dev/null
+++ b/t/t0003-attributes.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description=gitattributes
+
+. ./test-lib.sh
+
+attr_check () {
+
+	path="$1"
+	expect="$2"
+
+	git check-attr test -- "$path" >actual &&
+	echo "$path: test: $2" >expect &&
+	diff -u expect actual
+
+}
+
+
+test_expect_success 'setup' '
+
+	mkdir -p a/b/d a/c &&
+	(
+		echo "f	test=f"
+	) >.gitattributes &&
+	(
+		echo "g test=a/g" &&
+		echo "b/g test=a/b/g"
+	) >a/.gitattributes &&
+	(
+		echo "h test=a/b/h" &&
+		echo "d/* test=a/b/d/*"
+	) >a/b/.gitattributes
+
+'
+
+test_expect_success 'attribute test' '
+
+	attr_check f f &&
+	attr_check a/f f &&
+	attr_check a/c/f f &&
+	attr_check a/g a/g &&
+	attr_check a/b/g a/b/g &&
+	attr_check b/g unspecified &&
+	attr_check a/b/h a/b/h &&
+	attr_check a/b/d/g "a/b/d/*"
+
+'
+
+test_done
-- 
1.5.4.1213.g2bdeb
