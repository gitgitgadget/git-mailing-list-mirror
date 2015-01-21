From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 13/19] fsck: Optionally ignore specific fsck issues
 completely
Date: Wed, 21 Jan 2015 20:26:43 +0100
Organization: gmx
Message-ID: <571995874185461d6cf4fca0f725ff459f0720b0.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0vT-0003FF-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbbAUT0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:26:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:57470 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbbAUT0r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:26:47 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Le5XQ-1XO7EO18F2-00puKL; Wed, 21 Jan 2015 20:26:44
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:PY7lYVfyUTTHJrQ/6VH/GEmRYFfQPE8zR0mekt0haHJR/IBii4h
 8chm5dkQqzOrxNYeXoy2f2VNENAowaCeW8EP2qTOB5prICOMV72BDnmCNg9GCH1g7KV98gd
 Lonrzj2QuP5/AS+J3X9vfMFHXuFUoRtYEz0GHzMqkBAPMqTlreqvcr2oky3UrpV0NG+aqBC
 Urc5sd77Lk/NFhWxxVUwA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262758>

An fsck issue in a legacy repository might be so common that one would
like not to bother the user with mentioning it at all. With this change,
that is possible by setting the respective error to "ignore".

This change "abuses" the warn=missing-email test to verify that "ignore"
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
index 27a381b..028a7ca 100644
--- a/fsck.c
+++ b/fsck.c
@@ -152,6 +152,8 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 				severity = FSCK_ERROR;
 			else if (!substrcmp(mode, equal, "warn"))
 				severity = FSCK_WARN;
+			else if (!substrcmp(mode, equal, "ignore"))
+				severity = FSCK_IGNORE;
 			else
 				die("Unknown fsck message severity: '%.*s'",
 					equal, mode);
@@ -193,6 +195,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_severity = fsck_msg_severity(id, options), result;
 
+	if (msg_severity == FSCK_IGNORE)
+		return 0;
+
 	if (msg_severity == FSCK_FATAL)
 		msg_severity = FSCK_ERROR;
 
diff --git a/fsck.h b/fsck.h
index 4349860..7be6c50 100644
--- a/fsck.h
+++ b/fsck.h
@@ -3,6 +3,7 @@
 
 #define FSCK_ERROR 1
 #define FSCK_WARN 2
+#define FSCK_IGNORE 3
 
 struct fsck_options;
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 75d718f..5e54a13 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -132,7 +132,12 @@ test_expect_success 'push with receive.fsck.warn = missing-email' '
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config receive.fsck.warn missing-email &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missing-email" act
+	grep "missing-email" act &&
+	git --git-dir=dst/.git branch -D bogus &&
+	git  --git-dir=dst/.git config receive.fsck.ignore missing-email &&
+	git  --git-dir=dst/.git config receive.fsck.warn bad-date &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	test_must_fail grep "missing-email" act
 '
 
 test_expect_success 'receive.fsck.warn = unterminated-header triggers error' '
-- 
2.2.0.33.gc18b867
