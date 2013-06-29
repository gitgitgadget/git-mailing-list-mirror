From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Sat, 29 Jun 2013 17:40:23 +0000
Message-ID: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 29 19:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UszFM-0001hh-GI
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 19:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab3F2Rrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 13:47:37 -0400
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:40130 "EHLO
	qmta09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751Ab3F2Rrf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jun 2013 13:47:35 -0400
Received: from omta16.emeryville.ca.mail.comcast.net ([76.96.30.72])
	by qmta09.emeryville.ca.mail.comcast.net with comcast
	id uHaW1l0021ZMdJ4A9HgUCB; Sat, 29 Jun 2013 17:40:28 +0000
Received: from castro.crustytoothpaste.net ([IPv6:2001:470:1f04:79::2])
	by omta16.emeryville.ca.mail.comcast.net with comcast
	id uHgS1l00h25wmie8cHgTjv; Sat, 29 Jun 2013 17:40:28 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BEF8628063;
	Sat, 29 Jun 2013 17:40:26 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372527628;
	bh=aKOzr3i1g7Yk1wWJjzWfwSSUHph94GTNA/XLj822CsE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=VbRv1lXooPj9xgsQhllaJ8SNcKXaKj8uIDO2Uulzln+x6E3tY7OHpSNx9WCd3NOcO
	 GRHaD5zxPxAc/NqGDdEK2c4ki1Nd6Lswln1TaB+XDkI0e0DdBL2t12AS1C3ZO9+NUJ
	 F5WOg9GevWTUpE1X/ft0SgqNkFC0CHe5WH5qJnK6yoGfJcaziEf6QlPi3GZYd/lIi8
	 DavtLeJ4qAsAysByRRqjoy0KBuaE9d/ZXyz1611SBRC/z2GGebRO9TaUKi1ppJ20g5
	 cDGzSB6fNmmXaIBjPlM/7TPt/APyl0SWAvYljNlsC08SuULA1Z7ZrKBn+Fz9gPI/91
	 YrTVKL2vMIaaw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229256>

The commit code already contains code for validating UTF-8, but it does not
check for invalid values, such as guaranteed non-characters and surrogates.  Fix
this by explicitly checking for and rejecting such characters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 commit.c                  | 18 +++++++++++++++---
 t/t3900-i18n-commit.sh    |  9 +++++++++
 t/t3900/UTF-8-invalid.txt |  3 +++
 3 files changed, 27 insertions(+), 3 deletions(-)
 create mode 100644 t/t3900/UTF-8-invalid.txt

diff --git a/commit.c b/commit.c
index 888e02a..2280413 100644
--- a/commit.c
+++ b/commit.c
@@ -1244,6 +1244,7 @@ static int find_invalid_utf8(const char *buf, int len)
 	while (len) {
 		unsigned char c = *buf++;
 		int bytes, bad_offset;
+		unsigned int codepoint;
 
 		len--;
 		offset++;
@@ -1264,24 +1265,35 @@ static int find_invalid_utf8(const char *buf, int len)
 			bytes++;
 		}
 
-		/* Must be between 1 and 5 more bytes */
-		if (bytes < 1 || bytes > 5)
+		/* Must be between 1 and 3 more bytes */
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
+		/* Check the value here */
+		if (codepoint >= 0xd800 && codepoint <= 0xdfff)
+			return bad_offset;
+		if (codepoint > 0x10ffff)
+			return bad_offset;
+		if ((codepoint & 0x1ffffe) == 0xfffe)
+			return bad_offset;
 	}
 	return -1;
 }
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 37ddabb..16ed707 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -39,6 +39,15 @@ test_expect_failure 'UTF-16 refused because of NULs' '
 	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
 '
 
+test_expect_success 'UTF-8 invalid characters refused' '
+	rm -f "$HOME/stderr" &&
+	echo "UTF-8 characters" >F &&
+	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-8-invalid.txt \
+		2>"$HOME"/stderr &&
+	grep "did not conform" "$HOME"/stderr
+'
+
+rm -f "$HOME/stderr"
 
 for H in ISO8859-1 eucJP ISO-2022-JP
 do
diff --git a/t/t3900/UTF-8-invalid.txt b/t/t3900/UTF-8-invalid.txt
new file mode 100644
index 0000000..343684d
--- /dev/null
+++ b/t/t3900/UTF-8-invalid.txt
@@ -0,0 +1,3 @@
+Commit message
+
+Invalid surrogate:???
-- 
1.8.3.1
