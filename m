From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 12/16] vcs-svn: verify that deltas consume all inline data
Date: Sat, 19 Mar 2011 18:20:50 +1100
Message-ID: <1300519254-20201-13-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:22:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qUP-0007jt-LR
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab1CSHWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:22:02 -0400
Received: from [119.15.97.146] ([119.15.97.146]:59363 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754442Ab1CSHVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 91329C05B;
	Sat, 19 Mar 2011 18:17:57 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39EY+6k9G5uh; Sat, 19 Mar 2011 18:17:47 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 564DDC058;
	Sat, 19 Mar 2011 18:17:43 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169408>

From: Jonathan Nieder <jrnieder@gmail.com>

By constraining the format of deltas, we can more easily detect
corruption and other breakage.

Requiring deltas not to provide unconsumed data also opens the
possibility of ignoring the declared amount of new data and simply
streaming the data as needed to fulfill copyfrom_data requests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 t/t9011-svn-da.sh |    5 ++---
 vcs-svn/svndiff.c |    2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index c6dbb21..7f422ca 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -123,11 +123,10 @@ test_expect_success 'preimage view: reject truncated preimage' '
 	test_must_fail test-svn-fe -d preimage clear.longread 9
 '
 
-test_expect_success 'inline data' '
+test_expect_success 'forbid unconsumed inline data' '
 	printf "SVNQ%b%s%b%s" "QQQQ\003" "bar" "QQQQ\001" "x" |
 		q_to_nul >inline.clear &&
-	test-svn-fe -d preimage inline.clear 18 >actual &&
-	test_cmp empty actual
+	test_must_fail test-svn-fe -d preimage inline.clear 18 >actual
 '
 
 test_expect_success 'reject truncated inline data' '
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 118e8c6..6b505dc 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -208,6 +208,8 @@ static int apply_window_in_core(struct window *ctx)
 	     )
 		if (execute_one_instruction(ctx, &instructions, &data_pos))
 			return -1;
+	if (data_pos != ctx->data.len)
+		return error("invalid delta: does not copy all inline data");
 	return 0;
 }
 
-- 
1.7.3.2.846.gf4b062
