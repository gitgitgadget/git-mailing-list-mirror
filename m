From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] for-each-ref: fix setup of option-parsing for --sort
Date: Sat, 10 Nov 2007 17:47:54 +0100
Message-ID: <1194713274-31200-1-git-send-email-hjemli@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqtVJ-0001tt-7a
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 17:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbXKJQr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 11:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXKJQr6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 11:47:58 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:51223 "EHLO mail48.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbXKJQr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 11:47:58 -0500
Received: from localhost.localdomain (ti231210a341-0189.bb.online.no [88.88.168.189])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id lAAGlFTO021625;
	Sat, 10 Nov 2007 17:47:15 +0100 (MET)
X-Mailer: git-send-email 1.5.3.5.623.g0a1d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64359>

The option value for --sort is already a pointer to a pointer to struct
ref_sort, so just use it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On Nov 10, 2007 5:25 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Could you add a test for that too, please?

Is this ok?


 builtin-for-each-ref.c  |    2 +-
 t/t6300-for-each-ref.sh |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index da8c794..e909e66 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -847,7 +847,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, "show only <n> matched refs"),
 		OPT_STRING(  0 , "format", &format, "format", "format to use for the output"),
-		OPT_CALLBACK(0 , "sort", &sort_tail, "key",
+		OPT_CALLBACK(0 , "sort", sort_tail, "key",
 		            "field name to sort on", &opt_parse_sort),
 		OPT_END(),
 	};
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d0809eb..c722635 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -148,4 +148,26 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 	git diff expected actual
 '
 
+cat >expected <<\EOF
+refs/heads/master
+refs/tags/testtag
+EOF
+
+test_expect_success 'Verify ascending sort' '
+	git-for-each-ref --format="%(refname)" --sort=refname >actual &&
+	git diff expected actual
+'
+
+
+cat >expected <<\EOF
+refs/tags/testtag
+refs/heads/master
+EOF
+
+test_expect_success 'Verify descending sort' '
+	git-for-each-ref --format="%(refname)" --sort=-refname >actual &&
+	git diff expected actual
+'
+
+
 test_done
-- 
1.5.3.5.623.g0a1d
