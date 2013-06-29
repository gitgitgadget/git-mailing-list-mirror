From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/2] commit: reject overlong UTF-8 sequences
Date: Sat, 29 Jun 2013 17:41:41 +0000
Message-ID: <20130629174140.GC226907@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 29 19:49:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UszGc-0002rZ-Rf
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 19:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab3F2Rsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 13:48:55 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:48950
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752152Ab3F2Rsy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jun 2013 13:48:54 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2013 13:48:54 EDT
Received: from omta21.westchester.pa.mail.comcast.net ([76.96.62.72])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id uGX31l0051ZXKqc51Hhnof; Sat, 29 Jun 2013 17:41:47 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta21.westchester.pa.mail.comcast.net with comcast
	id uHhk1l01925wmie3hHhm8D; Sat, 29 Jun 2013 17:41:47 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 58E5C28063;
	Sat, 29 Jun 2013 17:41:44 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372527707;
	bh=puZHROy4M73DccfDYmcdf4ZuB0EfjlMjQkuWwj2U7bY=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=L7XAfrAgnmGqv1dG1WXZVfxtrH//Tp+A31jBBDrnhXEyEDmuPVxJBg/kPQecIuoJO
	 YVUYIx4F9asrRW3JTvoglqblLyQcNoOW00+gYPYRXr9kg57n7Ifap0ENmHte1nnM1M
	 QeQDGNVPe8/BOT4jbnhEmW4WB1LaFeBKfJI9C830Tl1rfOyBTFall/dvZ2TWUwslUC
	 sH2RDn8ReAAwpir8/TI7HWs8DpQMmt1+GW6swoXXUnpfgVs1ChRpesLpTVReQMpCfX
	 5l1QWiQP39lfQA8YkZ4m7NmNiMSNRXsSPdoNCbLGKS09RtUiLeS6ZfQVDgNxgLxuzt
	 tNtjZT7YK5Xbw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229257>

The commit code accepts pseudo-UTF-8 sequences that encode a character with more
bytes than necessary.  Reject such sequences, since they are not valid UTF-8.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c                   | 14 ++++++++++++--
 t/t3900-i18n-commit.sh     |  8 ++++++++
 t/t3900/UTF-8-overlong.txt |  3 +++
 3 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 t/t3900/UTF-8-overlong.txt

diff --git a/commit.c b/commit.c
index 2280413..e57fec6 100644
--- a/commit.c
+++ b/commit.c
@@ -1240,11 +1240,15 @@ int commit_tree(const struct strbuf *msg, unsigned char *tree,
 static int find_invalid_utf8(const char *buf, int len)
 {
 	int offset = 0;
+	static const unsigned int max_codepoint[] = {
+		0x7f, 0x7ff, 0xffff, 0x1fffff
+	};
 
 	while (len) {
 		unsigned char c = *buf++;
 		int bytes, bad_offset;
 		unsigned int codepoint;
+		unsigned int min_val, max_val;
 
 		len--;
 		offset++;
@@ -1273,8 +1277,12 @@ static int find_invalid_utf8(const char *buf, int len)
 		if (len < bytes)
 			return bad_offset;
 
-		/* Place the encoded bits at the bottom of the value. */
+		/* Place the encoded bits at the bottom of the value and compute the
+		 * valid range.
+		 */
 		codepoint = (c & 0x7f) >> bytes;
+		min_val = max_codepoint[bytes-1] + 1;
+		max_val = max_codepoint[bytes];
 
 		offset += bytes;
 		len -= bytes;
@@ -1287,13 +1295,15 @@ static int find_invalid_utf8(const char *buf, int len)
 				return bad_offset;
 		} while (--bytes);
 
-		/* Check the value here */
+		/* Check the value and length here */
 		if (codepoint >= 0xd800 && codepoint <= 0xdfff)
 			return bad_offset;
 		if (codepoint > 0x10ffff)
 			return bad_offset;
 		if ((codepoint & 0x1ffffe) == 0xfffe)
 			return bad_offset;
+		if (codepoint < min_val || codepoint > max_val)
+			return bad_offset;
 	}
 	return -1;
 }
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 16ed707..de0fcef 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -47,6 +47,14 @@ test_expect_success 'UTF-8 invalid characters refused' '
 	grep "did not conform" "$HOME"/stderr
 '
 
+test_expect_success 'UTF-8 overlong sequences rejected' '
+	rm -f "$HOME/stderr" &&
+	echo "UTF-8 overlong" >F &&
+	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-8-overlong.txt \
+		2>"$HOME"/stderr &&
+	grep "did not conform" "$HOME"/stderr
+'
+
 rm -f "$HOME/stderr"
 
 for H in ISO8859-1 eucJP ISO-2022-JP
diff --git a/t/t3900/UTF-8-overlong.txt b/t/t3900/UTF-8-overlong.txt
new file mode 100644
index 0000000..fa157e9
--- /dev/null
+++ b/t/t3900/UTF-8-overlong.txt
@@ -0,0 +1,3 @@
+???ommit message
+
+This is not a space:??
-- 
1.8.3.1
