From: David Brown <davidb@codeaurora.org>
Subject: [PATCH] commit: More generous accepting of RFC-2822 footer lines.
Date: Tue, 27 Oct 2009 16:45:20 -0700
Message-ID: <20091027234520.GA11433@quaoar.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 00:45:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2vjF-0004tj-V9
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 00:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbZJ0XpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 19:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756515AbZJ0XpS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 19:45:18 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:6977 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbZJ0XpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 19:45:17 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5784"; a="26242524"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 27 Oct 2009 16:45:22 -0700
Received: from quaoar.codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id CD95A10004B6
	for <git@vger.kernel.org>; Tue, 27 Oct 2009 16:48:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131390>

From: David Brown <davidb@quicinc.com>

'git commit -s' will insert a blank line before the Signed-off-by
line at the end of the message, unless this last line is a
Signed-off-by line itself.  Common use has other trailing lines
at the ends of commit text, in the style of RFC2822 headers.

Be more generous in considering lines to be part of this footer.
This may occasionally leave out the blank line for cases where
the commit text happens to start with a word ending in a colon,
but this results in less fixups than the extra blank lines with
Acked-by, or other custom footers.

Signed-off-by: David Brown <davidb@quicinc.com>
---
 builtin-commit.c  |   17 ++++++++++++++++-
 t/t7501-commit.sh |   19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..f081e80 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -414,6 +414,21 @@ static void determine_author_info(void)
 	author_date = date;
 }
 
+static int is_rfc2822_footer(const char *line)
+{
+	int ch;
+
+	while ((ch = *line++)) {
+		if (ch == ':')
+			return 1;
+		if ((33 <= ch && ch <= 57) ||
+		    (59 <= ch && ch <= 126))
+			continue;
+		break;
+	}
+	return 0;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s)
 {
@@ -489,7 +504,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
 			; /* do nothing */
 		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (prefixcmp(sb.buf + i, sign_off_header))
+			if (!is_rfc2822_footer(sb.buf + i))
 				strbuf_addch(&sb, '\n');
 			strbuf_addbuf(&sb, &sob);
 		}
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index e2ef532..05542b4 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -247,6 +247,25 @@ $existing" &&
 
 '
 
+test_expect_success 'signoff gap' '
+
+	echo 3 >positive &&
+	git add positive &&
+	alt="Alt-RFC-822-Header: Value" &&
+	git commit -s -m "welcome
+
+$alt" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	(
+		echo welcome
+		echo
+		echo $alt
+		git var GIT_COMMITTER_IDENT |
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+	) >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'multiple -m' '
 
 	>negative &&
-- 
1.6.5.1
