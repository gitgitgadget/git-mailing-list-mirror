From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/2] commit: reject invalid UTF-8 codepoints
Date: Thu, 4 Jul 2013 17:19:43 +0000
Message-ID: <20130704171943.GA267700@vauxhall.crustytoothpaste.net>
References: <cover.1372957719.git.sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 19:27:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunJ7-0001JT-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab3GDR04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:26:56 -0400
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:45108
	"EHLO qmta14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756646Ab3GDR0z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 13:26:55 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jul 2013 13:26:55 EDT
Received: from omta03.emeryville.ca.mail.comcast.net ([76.96.30.27])
	by qmta14.emeryville.ca.mail.comcast.net with comcast
	id wHJi1l0020b6N64AEHKpev; Thu, 04 Jul 2013 17:19:49 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta03.emeryville.ca.mail.comcast.net with comcast
	id wHKn1l00W25wmie8PHKoud; Thu, 04 Jul 2013 17:19:49 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E463728074;
	Thu,  4 Jul 2013 17:19:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1372957719.git.sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372958389;
	bh=6h2o0UE44gghBfWD83WeUz/FqcJDX3FV9mM9706wPbE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=lAe8elJ+OuAi6H9EIqc2PdZ4bXAKVLHAUGE7feEm+y7tJQGoYV6lfI1DQZBtCrENZ
	 9yiLbFIAYowFSI81YdRvamjQsldlxj7mFnFF/2acS3K+62RP35IT6afCMDEb8boRCm
	 glAIxaY1G8zNIb/zVchgyX0E5UThzI3XUWjhNtV2ZJEldzH69gIGlZGWcsLg+pCNqt
	 CH+Nw+1PUztym0kH+FfAb/VDYtEHL3ZnGRWQtVz15MHN1WueyrrmyC6LuqVeboQgRY
	 WXoTr7MrsZmijHeMeOj4JVeP7KZ7v5R21WnsyCbaDhtfCz/OiSI4UFEp9aoHC+VhdZ
	 MuPS4EbfaqAEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229599>

The commit code already contains code for validating UTF-8, but it does not
check for invalid values, such as guaranteed non-characters and surrogates.  Fix
this by explicitly checking for and rejecting such characters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c               | 27 ++++++++++++++++++++++-----
 t/t3900-i18n-commit.sh | 12 ++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index 888e02a..2264106 100644
--- a/commit.c
+++ b/commit.c
@@ -1244,6 +1244,7 @@ static int find_invalid_utf8(const char *buf, int len)
 	while (len) {
 		unsigned char c = *buf++;
 		int bytes, bad_offset;
+		unsigned int codepoint;
 
 		len--;
 		offset++;
@@ -1264,24 +1265,40 @@ static int find_invalid_utf8(const char *buf, int len)
 			bytes++;
 		}
 
-		/* Must be between 1 and 5 more bytes */
-		if (bytes < 1 || bytes > 5)
+		/*
+		 * Must be between 1 and 3 more bytes.  Longer sequences result in
+		 * codepoints beyond U+10FFFF, which are guaranteed never to exist.
+		 */
+		if (bytes < 1 || bytes > 3)
 			return bad_offset;
 
 		/* Do we *have* that many bytes? */
 		if (len < bytes)
 			return bad_offset;
 
+		/* Place the encoded bits at the bottom of the value. */
+		codepoint = (c & 0x7f) >> bytes;
+
 		offset += bytes;
 		len -= bytes;
 
 		/* And verify that they are good continuation bytes */
 		do {
+			codepoint <<= 6;
+			codepoint |= *buf & 0x3f;
 			if ((*buf++ & 0xc0) != 0x80)
 				return bad_offset;
 		} while (--bytes);
 
-		/* We could/should check the value and length here too */
+		/* No codepoints can ever be allocated beyond U+10FFFF. */
+		if (codepoint > 0x10ffff)
+			return bad_offset;
+		/* Surrogates are only for UTF-16 and cannot be encoded in UTF-8. */
+		if ((codepoint & 0x1ff800) == 0xd800)
+			return bad_offset;
+		/* U+FFFE and U+FFFF are guaranteed non-characters. */
+		if ((codepoint & 0x1ffffe) == 0xfffe)
+			return bad_offset;
 	}
 	return -1;
 }
@@ -1292,8 +1309,8 @@ static int find_invalid_utf8(const char *buf, int len)
  * If it isn't, it assumes any non-utf8 characters are Latin1,
  * and does the conversion.
  *
- * Fixme: we should probably also disallow overlong forms and
- * invalid characters. But we don't do that currently.
+ * Fixme: we should probably also disallow overlong forms.
+ * But we don't do that currently.
  */
 static int verify_utf8(struct strbuf *buf)
 {
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 37ddabb..ee8ba6c 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -39,6 +39,18 @@ test_expect_failure 'UTF-16 refused because of NULs' '
 	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
 '
 
+test_expect_success 'UTF-8 invalid characters refused' '
+	test_when_finished "rm -f $HOME/stderr $HOME/invalid" && 
+	rm -f "$HOME/stderr" &&
+	echo "UTF-8 characters" >F &&
+	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
+		>"$HOME/invalid" &&
+	git commit -a -F "$HOME/invalid" \
+		2>"$HOME"/stderr &&
+	grep "did not conform" "$HOME"/stderr
+'
+
+rm -f "$HOME/stderr"
 
 for H in ISO8859-1 eucJP ISO-2022-JP
 do
-- 
1.8.3.1
