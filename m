From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Add 'ident' conversion.
Date: Sat, 21 Apr 2007 23:08:24 -0700
Message-ID: <11772221052901-git-send-email-junkio@cox.net>
References: <11772221041630-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 08:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVFZ-0007Eb-IG
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXDVGIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbXDVGI2
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:08:28 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54713 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbXDVGI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:08:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422060825.FBUQ1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Sun, 22 Apr 2007 02:08:25 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q68R1W0041kojtg0000200; Sun, 22 Apr 2007 02:08:25 -0400
X-Mailer: git-send-email 1.5.1.2.919.g280f4
In-Reply-To: <11772221041630-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45217>

The 'ident' attribute set to path squashes "$ident:<any bytes
except dollor sign>$" to "$ident$" upon checkin, and expands it
to "$ident: <blob SHA-1> $" upon checkout.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 convert.c         |  186 +++++++++++++++++++++++++++++++++++++++++++++++++---
 t/t0021-filter.sh |   22 +++++--
 2 files changed, 192 insertions(+), 16 deletions(-)

diff --git a/convert.c b/convert.c
index 1fa8f2a..0b85dd7 100644
--- a/convert.c
+++ b/convert.c
@@ -395,20 +395,161 @@ static void setup_convert_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_crlf;
 	static struct git_attr *attr_filter;
+	static struct git_attr *attr_ident;
 
 	if (!attr_crlf) {
 		attr_crlf = git_attr("crlf", 4);
 		attr_filter = git_attr("filter", 6);
+		attr_ident = git_attr("ident", 5);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config);
 	}
 	check[0].attr = attr_crlf;
 	check[1].attr = attr_filter;
+	check[2].attr = attr_ident;
+}
+
+static int count_ident(const char *cp, unsigned long size)
+{
+	/*
+	 * "$ident: 0000000000000000000000000000000000000000 $" <=> "$ident$"
+	 */
+	int cnt = 0;
+	char ch;
+
+	while (size) {
+		ch = *cp++;
+		size--;
+		if (ch != '$')
+			continue;
+		if (size < 6)
+			break;
+		if (memcmp("ident", cp, 5))
+			continue;
+		ch = cp[5];
+		cp += 6;
+		size -= 6;
+		if (ch == '$')
+			cnt++; /* $ident$ */
+		if (ch != ':')
+			continue;
+
+		/*
+		 * "$ident: ... "; scan up to the closing dollar sign and discard.
+		 */
+		while (size) {
+			ch = *cp++;
+			size--;
+			if (ch == '$') {
+				cnt++;
+				break;
+			}
+		}
+	}
+	return cnt;
+}
+
+static char *ident_to_git(const char *path, const char *src, unsigned long *sizep, int ident)
+{
+	int cnt;
+	unsigned long size;
+	char *dst, *buf;
+
+	if (!ident)
+		return NULL;
+	size = *sizep;
+	cnt = count_ident(src, size);
+	if (!cnt)
+		return NULL;
+	buf = xmalloc(size);
+
+	for (dst = buf; size; size--) {
+		char ch = *src++;
+		*dst++ = ch;
+		if ((ch == '$') && (6 <= size) &&
+		    !memcmp("ident:", src, 6)) {
+			unsigned long rem = size - 6;
+			const char *cp = src + 6;
+			do {
+				ch = *cp++;
+				if (ch == '$')
+					break;
+				rem--;
+			} while (rem);
+			if (!rem)
+				continue;
+			memcpy(dst, "ident$", 6);
+			dst += 6;
+			size -= (cp - src);
+			src = cp;
+		}
+	}
+
+	*sizep = dst - buf;
+	return buf;
+}
+
+static char *ident_to_worktree(const char *path, const char *src, unsigned long *sizep, int ident)
+{
+	int cnt;
+	unsigned long size;
+	char *dst, *buf;
+	unsigned char sha1[20];
+
+	if (!ident)
+		return NULL;
+
+	size = *sizep;
+	cnt = count_ident(src, size);
+	if (!cnt)
+		return NULL;
+
+	hash_sha1_file(src, size, "blob", sha1);
+	buf = xmalloc(size + cnt * 43);
+
+	for (dst = buf; size; size--) {
+		const char *cp;
+		char ch = *src++;
+		*dst++ = ch;
+		if ((ch != '$') || (size < 6) || memcmp("ident", src, 5))
+			continue;
+
+		if (src[5] == ':') {
+			/* discard up to but not including the closing $ */
+			unsigned long rem = size - 6;
+			cp = src + 6;
+			do {
+				ch = *cp++;
+				if (ch == '$')
+					break;
+				rem--;
+			} while (rem);
+			if (!rem)
+				continue;
+			size -= (cp - src);
+		} else if (src[5] == '$')
+			cp = src + 5;
+		else
+			continue;
+
+		memcpy(dst, "ident: ", 7);
+		dst += 7;
+		memcpy(dst, sha1_to_hex(sha1), 40);
+		dst += 40;
+		*dst++ = ' ';
+		size -= (cp - src);
+		src = cp;
+		*dst++ = *src++;
+		size--;
+	}
+
+	*sizep = dst - buf;
+	return buf;
 }
 
 static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 {
-	const char *value = check[0].value;
+	const char *value = check->value;
 
 	if (ATTR_TRUE(value))
 		return CRLF_TEXT;
@@ -424,7 +565,7 @@ static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 static struct convert_driver *git_path_check_convert(const char *path,
 					     struct git_attr_check *check)
 {
-	const char *value = check[1].value;
+	const char *value = check->value;
 	struct convert_driver *drv;
 
 	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
@@ -435,20 +576,29 @@ static struct convert_driver *git_path_check_convert(const char *path,
 	return NULL;
 }
 
+static int git_path_check_ident(const char *path, struct git_attr_check *check)
+{
+	const char *value = check->value;
+
+	return !!ATTR_TRUE(value);
+}
+
 char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
 {
-	struct git_attr_check check[2];
+	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
+	int ident = 0;
 	char *filter = NULL;
 	char *buf, *buf2;
 
 	setup_convert_check(check);
-	if (!git_checkattr(path, 2, check)) {
+	if (!git_checkattr(path, 3, check)) {
 		struct convert_driver *drv;
-		crlf = git_path_check_crlf(path, check);
-		drv = git_path_check_convert(path, check);
+		crlf = git_path_check_crlf(path, check + 0);
+		drv = git_path_check_convert(path, check + 1);
 		if (drv && drv->clean)
 			filter = drv->clean;
+		ident = git_path_check_ident(path, check + 2);
 	}
 
 	buf = apply_filter(path, src, sizep, filter);
@@ -459,26 +609,40 @@ char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
 		buf = buf2;
 	}
 
+	buf2 = ident_to_git(path, buf ? buf : src, sizep, ident);
+	if (buf2) {
+		free(buf);
+		buf = buf2;
+	}
+
 	return buf;
 }
 
 char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep)
 {
-	struct git_attr_check check[2];
+	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
+	int ident = 0;
 	char *filter = NULL;
 	char *buf, *buf2;
 
 	setup_convert_check(check);
-	if (!git_checkattr(path, 2, check)) {
+	if (!git_checkattr(path, 3, check)) {
 		struct convert_driver *drv;
-		crlf = git_path_check_crlf(path, check);
-		drv = git_path_check_convert(path, check);
+		crlf = git_path_check_crlf(path, check + 0);
+		drv = git_path_check_convert(path, check + 1);
 		if (drv && drv->smudge)
 			filter = drv->smudge;
+		ident = git_path_check_ident(path, check + 2);
 	}
 
-	buf = crlf_to_worktree(path, src, sizep, crlf);
+	buf = ident_to_worktree(path, src, sizep, ident);
+
+	buf2 = crlf_to_worktree(path, buf ? buf : src, sizep, crlf);
+	if (buf2) {
+		free(buf);
+		buf = buf2;
+	}
 
 	buf2 = apply_filter(path, buf ? buf : src, sizep, filter);
 	if (buf2) {
diff --git a/t/t0021-filter.sh b/t/t0021-filter.sh
index d6bb1c6..725a425 100755
--- a/t/t0021-filter.sh
+++ b/t/t0021-filter.sh
@@ -13,24 +13,36 @@ test_expect_success setup '
 	git config filter.rot13.smudge ./rot13.sh &&
 	git config filter.rot13.clean ./rot13.sh &&
 
-	echo "*.t filter=rot13" >.gitattributes &&
+	{
+	    echo "*.t filter=rot13"
+	    echo "*.i ident"
+	} >.gitattributes &&
 
 	{
 	    echo a b c d e f g h i j k l m
 	    echo n o p q r s t u v w x y z
+	    echo '\''$ident$'\''
 	} >test &&
 	cat test >test.t &&
 	cat test >test.o &&
-	git add test test.t &&
-	rm -f test test.t &&
-	git checkout -- test test.t
+	cat test >test.i &&
+	git add test test.t test.i &&
+	rm -f test test.t test.i &&
+	git checkout -- test test.t test.i
 '
 
+script='s/^\$ident: \([0-9a-f]*\) \$/\1/p'
+
 test_expect_success check '
 
 	cmp test.o test &&
-	cmp test.o test.t
+	cmp test.o test.t &&
 
+	# ident should be stripped in the repository
+	git diff --raw --exit-code :test :test.i &&
+	id=$(git rev-parse --verify :test) &&
+	embedded=$(sed -ne "$script" test.i) &&
+	test "z$id" = "z$embedded"
 '
 
 test_done
-- 
1.5.1.2.919.g280f4
