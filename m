From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 13/18] Optionally ignore specific fsck issues completely
Date: Mon, 8 Dec 2014 17:15:21 +0100 (CET)
Message-ID: <d278090ef5a49b887e329dc16aaeb7b6c69dcaac.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yG-0006Mx-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbaLHQP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:49194 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908AbaLHQPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:24 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LZhsq-1XYbFW0QkW-00lWLX;
 Mon, 08 Dec 2014 17:15:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:8rPu9HgxM7bZVdPpcu28b2s+PqEu1zqKAETIJIhkjZ/GL2JraNn
 V2rA2kzjyvOpuG1Mzaol4DS8AKCBX05PHn731OTDg7D/R+AU4PrWInN/WeQ00WBEFcTkMCG
 5wenVK8Ik4rKMnFrIX0yGy+pzQYduSBEhOdxeUw7cri5YTuCvFAatCuxP9n3dl/WTO7QNe6
 8MrTRRPGFa1lyssBhTu8A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261067>

An fsck issue in a legacy repository might be so common that one would
like not to bother the user with mentioning it at all. With this change,
that is possible by setting the respective error to "ignore".

This change "abuses" the missing-email=warn test to verify that "ignore"
is also accepted and works correctly. And while at it, it makes sure
that multiple options work, too (they are passed to unpack-objects or
index-pack as a comma-separated list via the --strict=... command-line
option).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 5 +++++
 fsck.h                          | 1 +
 t/t5504-fetch-receive-strict.sh | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index f8339af..abfd3af 100644
--- a/fsck.c
+++ b/fsck.c
@@ -146,6 +146,8 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
 				type = FSCK_ERROR;
 			else if (!substrcmp(type_str, type_len, "warn"))
 				type = FSCK_WARN;
+			else if (!substrcmp(type_str, type_len, "ignore"))
+				type = FSCK_IGNORE;
 			else
 				die("Unknown fsck message type: '%.*s'",
 					len - equal - 1, type_str);
@@ -184,6 +186,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	if (msg_type == FSCK_IGNORE)
+		return 0;
+
 	append_msg_id(&sb, msg_id_str[id]);
 
 	va_start(ap, fmt);
diff --git a/fsck.h b/fsck.h
index 9d67ea2..82bedf9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,6 +3,7 @@
 
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
+#define FSCK_IGNORE 3
 
 struct fsck_options;
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 8a47db2..0e521d9 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -132,7 +132,12 @@ test_expect_success 'push with receive.fsck.missing-mail = warn' '
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config receive.fsck.missing-email warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missing-email" act
+	grep "missing-email" act &&
+	git --git-dir=dst/.git branch -D bogus &&
+	git  --git-dir=dst/.git config receive.fsck.missing-email ignore &&
+	git  --git-dir=dst/.git config receive.fsck.bad-date warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	test_must_fail grep "missing-email" act
 '
 
 test_expect_success 'receive.fsck.unterminated-header = warn triggers error' '
-- 
2.0.0.rc3.9669.g840d1f9
