From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/3] archive: specfile syntax change: "$Format:%PLCHLDR$"
 instead of just "%PLCHLDR" (take 2)
Date: Fri, 07 Sep 2007 00:34:06 +0200
Message-ID: <46E0805E.303@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx>	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se>	<Pine.LNX.4.64.0709041139140.28586@racer.site>	<46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org> <46E028B9.2090908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITPvx-0003EP-Dq
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbXIFWeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 18:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756629AbXIFWeO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:34:14 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44716
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157AbXIFWeM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 18:34:12 -0400
Received: from [10.0.1.201] (p508ED793.dip.t-dialin.net [80.142.215.147])
	by neapel230.server4you.de (Postfix) with ESMTP id BA59A873B6;
	Fri,  7 Sep 2007 00:34:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46E028B9.2090908@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57938>

As suggested by Johannes, --pretty=format: placeholders in specfiles
need to be wrapped in $Format:...$ now.  This syntax change restricts
the expansion of placeholders and makes it easier to use with files
that contain non-placeholder percent signs.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This replacement patch fixes a bug in the "$Format:" search logic.  It
now uses memmem() and thus depends on patch 3.5 which introduces this
function.  Patch 5 still applies unchanged.

 Documentation/gitattributes.txt |    5 +++-
 builtin-archive.c               |   52 +++++++++++++++++++++++++++++++++++---
 t/t5000-tar-tree.sh             |    4 +-
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 47a621b..37b3be8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -432,7 +432,10 @@ several placeholders when adding this file to an archive.  The
 expansion depends on the availability of a commit ID, i.e. if
 gitlink:git-archive[1] has been given a tree instead of a commit or a
 tag then no replacement will be done.  The placeholders are the same
-as those for the option `--pretty=format:` of gitlink:git-log[1].
+as those for the option `--pretty=format:` of gitlink:git-log[1],
+except that they need to be wrapped like this: `$Format:PLACEHOLDERS$`
+in the file.  E.g. the string `$Format:%H$` will be replaced by the
+commit hash.
 
 
 GIT
diff --git a/builtin-archive.c b/builtin-archive.c
index faccce3..65bf9cb 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -81,14 +81,58 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
+static void *format_specfile(const struct commit *commit, const char *format,
+                             unsigned long *sizep)
+{
+	unsigned long len = *sizep, result_len = 0;
+	const char *a = format;
+	char *result = NULL;
+
+	for (;;) {
+		const char *b, *c;
+		char *fmt, *formatted = NULL;
+		unsigned long a_len, fmt_len, formatted_len, allocated = 0;
+
+		b = memmem(a, len, "$Format:", 8);
+		if (!b || a + len < b + 9)
+			break;
+		c = memchr(b + 8, '$', len - 8);
+		if (!c)
+			break;
+
+		a_len = b - a;
+		fmt_len = c - b - 8;
+		fmt = xmalloc(fmt_len + 1);
+		memcpy(fmt, b + 8, fmt_len);
+		fmt[fmt_len] = '\0';
+
+		formatted_len = format_commit_message(commit, fmt, &formatted,
+		                                      &allocated);
+		result = xrealloc(result, result_len + a_len + formatted_len);
+		memcpy(result + result_len, a, a_len);
+		memcpy(result + result_len + a_len, formatted, formatted_len);
+		result_len += a_len + formatted_len;
+		len -= c + 1 - a;
+		a = c + 1;
+	}
+
+	if (result && len) {
+		result = xrealloc(result, result_len + len);
+		memcpy(result + result_len, a, len);
+		result_len += len;
+	}
+
+	*sizep = result_len;
+
+	return result;
+}
+
 static void *convert_to_archive(const char *path,
                                 const void *src, unsigned long *sizep,
                                 const struct commit *commit)
 {
 	static struct git_attr *attr_specfile;
 	struct git_attr_check check[1];
-	char *interpolated = NULL;
-	unsigned long allocated = 0;
 
 	if (!commit)
 		return NULL;
@@ -102,9 +146,7 @@ static void *convert_to_archive(const char *path,
 	if (!ATTR_TRUE(check[0].value))
 		return NULL;
 
-	*sizep = format_commit_message(commit, src, &interpolated, &allocated);
-
-	return interpolated;
+	return format_specfile(commit, src, sizep);
 }
 
 void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3d5d01b..6e89e07 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -36,7 +36,7 @@ test_expect_success \
      echo simple textfile >a/a &&
      mkdir a/bin &&
      cp /bin/sh a/bin &&
-     printf "%s" "$SPECFILEFORMAT" >a/specfile &&
+     printf "A\$Format:%s\$O" "$SPECFILEFORMAT" >a/specfile &&
      ln -s a a/l1 &&
      (p=long_path_to_a_file && cd a &&
       for depth in 1 2 3 4 5; do mkdir $p && cd $p; done &&
@@ -119,7 +119,7 @@ test_expect_success \
 
 test_expect_success \
      'validate specfile contents' \
-     'git log --max-count=1 "--pretty=format:$SPECFILEFORMAT" HEAD \
+     'git log --max-count=1 "--pretty=format:A${SPECFILEFORMAT}O" HEAD \
       >f/a/specfile.expected &&
       diff f/a/specfile.expected f/a/specfile'
 
-- 
1.5.3
