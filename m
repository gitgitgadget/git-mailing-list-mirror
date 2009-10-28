From: David Brown <davidb@codeaurora.org>
Subject: [PATCH] commit: More generous accepting of RFC-2822 footer lines.
Date: Wed, 28 Oct 2009 10:13:44 -0700
Message-ID: <20091028171344.GA22290@quaoar.codeaurora.org>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 18:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3C5o-0005rw-Th
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 18:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbZJ1RNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 13:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbZJ1RNl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 13:13:41 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:31500 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZJ1RNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 13:13:40 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5784"; a="26299451"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 28 Oct 2009 10:13:45 -0700
Received: from quaoar.codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 8603110004B6
	for <git@vger.kernel.org>; Wed, 28 Oct 2009 10:17:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091027234520.GA11433@quaoar.codeaurora.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131481>

From: David Brown <davidb@quicinc.com>

'git commit -s' will insert a blank line before the Signed-off-by
line at the end of the message, unless this last line is a
Signed-off-by line itself.  Common use has other trailing lines
at the ends of commit text, in the style of RFC2822 headers.

Be more generous in considering lines to be part of this footer.
If the last paragraph of the commit message reasonably resembles
RFC-2822 formatted lines, don't insert that blank line.

The new Signed-off-by line is still only suppressed when the
author's existing Signed-off-by is the last line of the message.

Signed-off-by: David Brown <davidb@quicinc.com>
---
 builtin-commit.c  |   43 ++++++++++++++++++++++++++++++++++++++++++-
 t/t7501-commit.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..c395cbf 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -414,6 +414,47 @@ static void determine_author_info(void)
 	author_date = date;
 }
 
+static int ends_rfc2822_footer(struct strbuf *sb)
+{
+	int ch;
+	int hit = 0;
+	int i, j, k;
+	int len = sb->len;
+	int first = 1;
+	const char *buf = sb->buf;
+
+	for (i = len - 1; i > 0; i--) {
+		if (hit && buf[i] == '\n')
+			break;
+		hit = (buf[i] == '\n');
+	}
+
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
+			continue;
+
+		first = 0;
+
+		for (j = 0; i + j < len; j++) {
+			ch = buf[i + j];
+			if (ch == ':')
+				break;
+			if (isalnum(ch) ||
+			    (ch == '-'))
+				continue;
+			return 0;
+		}
+	}
+	return 1;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s)
 {
@@ -489,7 +530,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
 			; /* do nothing */
 		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (prefixcmp(sb.buf + i, sign_off_header))
+			if (!ends_rfc2822_footer(&sb))
 				strbuf_addch(&sb, '\n');
 			strbuf_addbuf(&sb, &sob);
 		}
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index e2ef532..d2de576 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -247,6 +247,47 @@ $existing" &&
 
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
+test_expect_success 'signoff gap 2' '
+
+	echo 4 >positive &&
+	git add positive &&
+	alt="fixed: 34" &&
+	git commit -s -m "welcome
+
+We have now
+$alt" &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	(
+		echo welcome
+		echo
+		echo We have now
+		echo $alt
+		echo
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
