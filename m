From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: [PATCH v2] Fix buffer overflow in config parser
Date: Tue, 14 Apr 2009 23:28:35 +0200
Message-ID: <49E50003.2040907@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 14 23:30:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtqDT-0006nZ-O6
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbZDNV2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbZDNV2j
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:28:39 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:52573 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbZDNV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:28:38 -0400
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 694718BFF;
	Tue, 14 Apr 2009 23:28:36 +0200 (CEST)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id 08F1A2AC4B;
	Tue, 14 Apr 2009 23:28:36 +0200 (CEST)
Received: from pikkukde.a.i2n (pikkukde.m.i2n [192.168.12.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 0AC0D2AC4A;
	Tue, 14 Apr 2009 23:28:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-04-14_08)
X-Spam-Status: hits=-4.1 tests=[ALL_TRUSTED=-1.8,BAYES_00=-2.312]
X-Spam-Level: 959
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116577>

When interpreting a config value, the config parser reads in 1+ space
character(s) and puts -one- space character in the buffer as soon as
the first non-space character is encountered (if not inside quotes).

Unfortunately the buffer size check lacks the extra space character
which gets inserted at the next non-space character, resulting in
a crash with a specially crafted config entry.

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
 
+LONG_VALUE=`perl -e 'print "x" x 1023," a"'`
+test_expect_success 'do not crash on special long config line' '
+	setup &&
+	git config section.key "$LONG_VALUE" &&
+	check section.key "fatal: bad config file line 2 in .git/config"
+'
+
 test_done
-- 
1.6.1.3
