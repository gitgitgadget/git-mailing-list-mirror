From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] commit: reject overlong UTF-8 sequences
Date: Thu, 4 Jul 2013 17:20:34 +0000
Message-ID: <20130704172034.GB267700@vauxhall.crustytoothpaste.net>
References: <cover.1372957719.git.sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 19:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunJu-0002By-D3
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790Ab3GDR1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:27:46 -0400
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:33517
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756593Ab3GDR1q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 13:27:46 -0400
Received: from omta10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by qmta12.emeryville.ca.mail.comcast.net with comcast
	id wHGS1l0040cQ2SL01HLfeG; Thu, 04 Jul 2013 17:20:39 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta10.emeryville.ca.mail.comcast.net with comcast
	id wHLd1l00P25wmie8WHLfxT; Thu, 04 Jul 2013 17:20:39 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A8EE528074;
	Thu,  4 Jul 2013 17:20:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1372957719.git.sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372958439;
	bh=S4HsMZpUKnGYDIPU6EhBidaIoAl7IgnIpm0hAvvmztk=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=c2GVVjYLVJhxN1bQnuQaNkWE9E9MasgRMJozg9NoNuoBHeMkVe+4TUyuhDrwQnw+N
	 Oe8UGqar/Y6+HatLOhbb2YM/NqTjpx+7SS0ZIvxDGdcEaCoLCY+FAgPRInS3iAw92Q
	 PS1T5GVVTA4cVgB0OML/2YUssh/IQGraXUVJ7T95td/MoI3sMOSaMsGeiLzGEir+Xj
	 jrv8WkOUYnImGVXPCXDr9R89dMcd5KOx8YZt2G0wXXkt0ghRjnnZXjwCLj37YY5wZW
	 JzP3FQKYmtbX7OCI71NzLC52BT1aHuqrPGjVIxV2FkrTORwez98duQuSa1ivP6GT/2
	 BH60o8GJyEEYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229600>

The commit code accepts pseudo-UTF-8 sequences that encode a character with more
bytes than necessary.  Reject such sequences, since they are not valid UTF-8.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c               | 17 +++++++++++------
 t/t3900-i18n-commit.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 2264106..b59c187 100644
--- a/commit.c
+++ b/commit.c
@@ -1240,11 +1240,15 @@ int commit_tree(const struct strbuf *msg, unsigned char *tree,
 static int find_invalid_utf8(const char *buf, int len)
 {
 	int offset = 0;
+	static const unsigned int max_codepoint[] = {
+		0x7f, 0x7ff, 0xffff, 0x10ffff
+	};
 
 	while (len) {
 		unsigned char c = *buf++;
 		int bytes, bad_offset;
 		unsigned int codepoint;
+		unsigned int min_val, max_val;
 
 		len--;
 		offset++;
@@ -1276,8 +1280,12 @@ static int find_invalid_utf8(const char *buf, int len)
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
@@ -1290,8 +1298,8 @@ static int find_invalid_utf8(const char *buf, int len)
 				return bad_offset;
 		} while (--bytes);
 
-		/* No codepoints can ever be allocated beyond U+10FFFF. */
-		if (codepoint > 0x10ffff)
+		/* Reject codepoints that are out of range for the sequence length. */
+		if (codepoint < min_val || codepoint > max_val)
 			return bad_offset;
 		/* Surrogates are only for UTF-16 and cannot be encoded in UTF-8. */
 		if ((codepoint & 0x1ff800) == 0xd800)
@@ -1308,9 +1316,6 @@ static int find_invalid_utf8(const char *buf, int len)
  *
  * If it isn't, it assumes any non-utf8 characters are Latin1,
  * and does the conversion.
- *
- * Fixme: we should probably also disallow overlong forms.
- * But we don't do that currently.
  */
 static int verify_utf8(struct strbuf *buf)
 {
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index ee8ba6c..94fa1e8 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -50,6 +50,17 @@ test_expect_success 'UTF-8 invalid characters refused' '
 	grep "did not conform" "$HOME"/stderr
 '
 
+test_expect_success 'UTF-8 overlong sequences rejected' '
+	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	rm -f "$HOME/stderr" "$HOME/invalid" &&
+	echo "UTF-8 overlong" >F &&
+	printf "\340\202\251ommit message\n\nThis is not a space:\300\240\n" \
+		>"$HOME/invalid" &&
+	git commit -a -F "$HOME/invalid" \
+		2>"$HOME"/stderr &&
+	grep "did not conform" "$HOME"/stderr
+'
+
 rm -f "$HOME/stderr"
 
 for H in ISO8859-1 eucJP ISO-2022-JP
-- 
1.8.3.1
