From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 13/19] fsck: Optionally ignore specific fsck issues
 completely
Date: Thu, 18 Jun 2015 22:09:26 +0200
Organization: gmx
Message-ID: <da999d68703a6318d7a2be0f11a79cbf6ccb99a7.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8B-0003nn-49
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbbFRUJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:09:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:60165 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324AbbFRUJa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:09:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MXmpv-1ZancP3W0F-00Wodg; Thu, 18 Jun 2015 22:09:26
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:2oliYFXLIpQbMe0WbS0EAZRt1/YQk0yDxxCvSSzvYPpviYPMQMC
 sPb/zOsjHvVCgaAukzDVbpkoN4HEFwOrlbmV4jh/Tbz+Aq8cYyRgxKkKWWF3PCc3ICjllLF
 R5LQLXdxEA1URNXVhfZSNoe9U+visu2q19myfbzamDoL/uaCS2KiiqaUtNt9RIXG/jd2kdp
 WNUcrCGdmag17zM4x/TPw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272055>

An fsck issue in a legacy repository might be so common that one would
like not to bother the user with mentioning it at all. With this change,
that is possible by setting the respective message type to "ignore".

This change "abuses" the missingemail=warn test to verify that "ignore"
is also accepted and works correctly. And while at it, it makes sure
that multiple options work, too (they are passed to unpack-objects or
index-pack as a comma-separated list via the --strict=... command-line
option).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 5 +++++
 fsck.h                          | 1 +
 t/t5504-fetch-receive-strict.sh | 9 ++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 2b2a360..0f7eb22 100644
--- a/fsck.c
+++ b/fsck.c
@@ -137,6 +137,8 @@ static int parse_msg_type(const char *str, int len)
 		return FSCK_ERROR;
 	else if (!substrcmp(str, len, "warn"))
 		return FSCK_WARN;
+	else if (!substrcmp(str, len, "ignore"))
+		return FSCK_IGNORE;
 	else
 		die("Unknown fsck message type: '%.*s'",
 				len, str);
@@ -220,6 +222,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 
diff --git a/fsck.h b/fsck.h
index 738c9df..7e49372 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,6 +3,7 @@
 
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
+#define FSCK_IGNORE 3
 
 struct fsck_options;
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 0d64229..cb077b7 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -133,7 +133,14 @@ test_expect_success 'push with receive.fsck.missingemail=warn' '
 	git --git-dir=dst/.git config \
 		receive.fsck.missingemail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missingemail" act
+	grep "missingemail" act &&
+	git --git-dir=dst/.git branch -D bogus &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.missingemail ignore &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.baddate warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	test_must_fail grep "missingemail" act
 '
 
 test_expect_success \
-- 
2.3.1.windows.1.9.g8c01ab4
