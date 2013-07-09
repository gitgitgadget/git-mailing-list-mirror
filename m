From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] commit: reject non-characters
Date: Tue, 9 Jul 2013 12:16:33 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1307091213090.2313@ds9.cixit.se>
References: <cover.1372957719.git.sandals@crustytoothpaste.net> <20130704171943.GA267700@vauxhall.crustytoothpaste.net> <alpine.DEB.2.00.1307051345260.11814@ds9.cixit.se> <7vfvvozvx4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 13:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVum-0001fP-P8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 13:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab3GILQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 07:16:54 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49326 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752990Ab3GILQy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 07:16:54 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r69BGZB6015488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Jul 2013 13:16:35 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r69BGXnt015484;
	Tue, 9 Jul 2013 13:16:34 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vfvvozvx4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 09 Jul 2013 13:16:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229946>

Unicode clause D14 defines all characters U+nFFFE and U+nFFFF (where
0 <= n <= 10h) as well as the range U+FDD0..U+FDEF as non-characters,
reserved for internal use only.  Disallow these characters in commit
messages as they are normally not recommended for interchange.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---
Junio C Hamano:

> Yeah, while we are at it, doing this may not hurt.  I think Brian's
> two patches are in fairly good shape otherwise, so perhaps you can
> do this as a follow-up patch on top of the tip of the topic,
> e82bd6cc (commit: reject overlong UTF-8 sequences, 2013-07-04)?

OK, here you are. Enjoy :)

  commit.c               |  7 +++++--
  t/t3900-i18n-commit.sh | 18 ++++++++++++++++++
  2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 5097dba..0587732 100644
--- a/commit.c
+++ b/commit.c
@@ -1305,8 +1305,11 @@ static int find_invalid_utf8(const char *buf, int len)
  		/* Surrogates are only for UTF-16 and cannot be encoded in UTF-8. */
  		if ((codepoint & 0x1ff800) == 0xd800)
  			return bad_offset;
-		/* U+FFFE and U+FFFF are guaranteed non-characters. */
-		if ((codepoint & 0x1ffffe) == 0xfffe)
+		/* U+xxFFFE and U+xxFFFF are guaranteed non-characters. */
+		if ((codepoint & 0xffffe) == 0xfffe)
+			return bad_offset;
+		/* So are anything in the range U+FDD0..U+FDEF. */
+		if (codepoint >= 0xfdd0 && codepoint <= 0xfdef)
  			return bad_offset;
  	}
  	return -1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 051ea9d..38b00c3 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -58,6 +58,24 @@ test_expect_success 'UTF-8 overlong sequences rejected' '
  	grep "did not conform" "$HOME"/stderr
  '

+test_expect_success 'UTF-8 non-characters refused' '
+	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	echo "UTF-8 non-character 1" >F &&
+	printf "Commit message\n\nNon-character:\364\217\277\276\n" \
+		>"$HOME/invalid" &&
+	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
+	grep "did not conform" "$HOME"/stderr
+'
+
+test_expect_success 'UTF-8 non-characters refused' '
+	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	echo "UTF-8 non-character 2." >F &&
+	printf "Commit message\n\nNon-character:\357\267\220\n" \
+		>"$HOME/invalid" &&
+	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
+	grep "did not conform" "$HOME"/stderr
+'
+
  for H in ISO8859-1 eucJP ISO-2022-JP
  do
  	test_expect_success "$H setup" '
-- 
1.8.3.1
