From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [PATCH v3] Fix buffer overflow in config parser
Date: Fri, 17 Apr 2009 14:05:11 +0200
Organization: Intra2net AG
Message-ID: <200904171405.48269.thomas.jarosch@intra2net.com>
References: <49E50003.2040907@intra2net.com> <49E5888D.2090607@viscovery.net> <49E58F38.5060103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, markus.heidelberg@web.de,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 14:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lumqt-0007o5-LJ
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 14:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758533AbZDQMFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 08:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbZDQMFx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 08:05:53 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:43427 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbZDQMFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 08:05:52 -0400
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 05ACB462F;
	Fri, 17 Apr 2009 14:05:50 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 908FD2AC4B;
	Fri, 17 Apr 2009 14:05:49 +0200 (CEST)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 8E1F72AC4A;
	Fri, 17 Apr 2009 14:05:48 +0200 (CEST)
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-78.2.30.fc9.i686; KDE/4.2.1; i686; ; )
In-Reply-To: <49E58F38.5060103@viscovery.net>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-04-17_06)
X-Spam-Status: hits=-2.5 tests=[ALL_TRUSTED=-1.8,BAYES_20=-0.74]
X-Spam-Level: 975
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116735>

When interpreting a config value, the config parser reads in 1+ space
character(s) and puts -one- space character in the buffer as soon as
the first non-space character is encountered (if not inside quotes).

Unfortunately the buffer size check lacks the extra space character
which gets inserted at the next non-space character, resulting in
a crash with a specially crafted config entry.

The unit test now uses Java to compile a platform independent
.NET framework to output the test string in C# :o) Read:
Thanks to Johannes Sixt for the correct printf call
which replaces the perl invocation.

Signed-off-by: Thomas Jarosch <thomas.jarosch@intra2net.com>
---
 config.c                |    2 +-
 t/t1303-wacky-config.sh |    9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index b76fe4c..2d70398 100644
--- a/config.c
+++ b/config.c
@@ -51,7 +51,7 @@ static char *parse_value(void)
 
 	for (;;) {
 		int c = get_next_char();
-		if (len >= sizeof(value))
+		if (len >= sizeof(value) - 1)
 			return NULL;
 		if (c == '\n') {
 			if (quote)
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 1983076..a7d8d25 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -10,7 +10,7 @@ setup() {
 
 check() {
 	echo "$2" >expected
-	git config --get "$1" >actual
+	git config --get "$1" >actual 2>&1
 	test_cmp actual expected
 }
 
@@ -40,4 +40,11 @@ test_expect_success 'make sure git config escapes section names properly' '
 	check "$SECTION" bar
 '
 
+LONG_VALUE=$(printf "x%01021dx a" 7)
+test_expect_success 'do not crash on special long config line' '
+	setup &&
+	git config section.key "$LONG_VALUE" &&
+	check section.key "fatal: bad config file line 2 in .git/config"
+'
+
 test_done
-- 
1.6.1.3
