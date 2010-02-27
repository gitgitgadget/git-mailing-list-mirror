From: Adam Simpkins <simpkins@facebook.com>
Subject: [PATCH 2/3] reflog: honor gc.reflogexpire=never
Date: Fri, 26 Feb 2010 19:50:03 -0800
Message-ID: <1267242604-5215-2-git-send-email-simpkins@facebook.com>
References: <20100227012130.GA28452@facebook.com>
 <1267242604-5215-1-git-send-email-simpkins@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Adam Simpkins <simpkins@facebook.com>
To: <git@vger.kernel.org>, <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 04:52:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDik-0001G2-HL
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 04:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967760Ab0B0Dv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:51:57 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:50205 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967749Ab0B0Dv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:51:56 -0500
Received: from mail.thefacebook.com ([192.168.18.83])
	by pp01.snc1.tfbnw.net (8.14.3/8.14.3) with ESMTP id o1R3paEK004077
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Fri, 26 Feb 2010 19:51:39 -0800
Received: from simpkins (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.83) with Microsoft SMTP Server (TLS) id 8.2.213.0; Fri, 26 Feb
 2010 19:50:36 -0800
Received: from simpkins by simpkins with local (Exim 4.69)	(envelope-from
 <simpkins@facebook.com>)	id 1NlDhM-0001Mw-KA; Fri, 26 Feb 2010 19:50:36 -0800
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1267242604-5215-1-git-send-email-simpkins@facebook.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166
 definitions=2010-02-27_02:2010-02-06,2010-02-27,2010-02-26 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141168>

Previously, if gc.reflogexpire or gc.reflogexpire were set to "never"
or "false", the builtin default values were used instead.

Signed-off-by: Adam Simpkins <simpkins@facebook.com>
---
 builtin-reflog.c  |    6 ++----
 t/t1410-reflog.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 7498210..64e45bd 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -530,16 +530,14 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	int i, status, do_all;
 	int explicit_expiry = 0;
 
+	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
+	default_reflog_expire = now - 90 * 24 * 3600;
 	git_config(reflog_expire_config, NULL);
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
 	memset(&cb, 0, sizeof(cb));
 
-	if (!default_reflog_expire_unreachable)
-		default_reflog_expire_unreachable = now - 30 * 24 * 3600;
-	if (!default_reflog_expire)
-		default_reflog_expire = now - 90 * 24 * 3600;
 	cb.expire_total = default_reflog_expire;
 	cb.expire_unreachable = default_reflog_expire_unreachable;
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 80af6b9..25046c4 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -214,4 +214,45 @@ test_expect_success 'delete' '
 
 '
 
+test_expect_success 'rewind2' '
+
+	test_tick && git reset --hard HEAD~2 &&
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4
+
+'
+
+test_expect_success '--expire=never' '
+
+	git reflog expire --verbose \
+		--expire=never \
+		--expire-unreachable=never \
+		--all &&
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4
+
+'
+
+test_expect_success 'gc.reflogexpire=never' '
+
+	git config gc.reflogexpire never &&
+	git config gc.reflogexpireunreachable never &&
+	git reflog expire --verbose --all &&
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4
+'
+
+test_expect_success 'gc.reflogexpire=false' '
+
+	git config gc.reflogexpire false &&
+	git config gc.reflogexpireunreachable false &&
+	git reflog expire --verbose --all &&
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4 &&
+
+	git config --unset gc.reflogexpire &&
+	git config --unset gc.reflogexpireunreachable
+
+'
+
 test_done
-- 
1.6.3.3
