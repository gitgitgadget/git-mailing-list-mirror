From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/11] commit: avoid race when creating orphan commits
Date: Sun,  8 Feb 2015 17:14:01 +0100
Message-ID: <1423412045-15616-8-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUVO-0002tl-P4
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbbBHQOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:14:40 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55555 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756532AbbBHQO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:14:27 -0500
X-AuditID: 12074413-f79f26d0000030e7-7b-54d78b623a60
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.B1.12519.26B87D45; Sun,  8 Feb 2015 11:14:26 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9lB014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:25 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqJvUfT3E4NRSQYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZ2y8KFGzhqbi91ruBsYmri5GTQ0LARGJR+29mCFtM4sK99WxdjFwc
	QgKXGSX2HfnFCOGcYJJ42HgerIpNQFdiUU8zE4gtIqAmMbHtEAuIzSywmkli612gbg4OYQE3
	ibVTikFMFgFViflvNUAqeAVcJPY//cwKsUtO4vzxn2ATOQVcJZa86QWzhYBq9tzqZZrAyLuA
	kWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkh4Ce9g3HVS7hCjAAejEg+v
	gcz1ECHWxLLiytxDjJIcTEqivEfDgUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeBcdvhYixJuS
	WFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4D3RCTRUsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQT8cXAqABJ8QDt7QRp5y0uSMwFikK0nmJUlBLn/Q+SEABJ
	ZJTmwY2FJY1XjOJAXwrzpnYBVfEAEw5c9yugwUxAgxcvvQIyuCQRISXVwLi1WT/uiketstyU
	AvvTaiK2x3dVJ4lK3vhnM7vywZWiX3kvruZxfHrXdHn6bseyv2wz+YpfLb+7w0iOT9/WNv0m
	R4381veZredmND0pnSjx9vemVAmdJOl5e9n8Wk53y7yKlDqV1LNqx7u1zybLmHbw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263520>

If, during the initial check, HEAD doesn't point at anything, then we
should make sure that it *still* doesn't point at anything when we are
ready to update the reference. Otherwise, another process might commit
while we are working (e.g., while we are waiting for the user to edit
the commit message) and we will silently overwrite it.

This fixes a failing test in t7516.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c        | 2 +-
 t/t7516-commit-races.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5654abd..c566e32 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1772,7 +1772,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
-				   ? current_head->object.sha1 : NULL,
+				   ? current_head->object.sha1 : null_sha1,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index 5efa351..17a139e 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -17,7 +17,7 @@ test_expect_success 'set up editor' '
 	chmod +x editor
 '
 
-test_expect_failure 'race to create orphan commit' '
+test_expect_success 'race to create orphan commit' '
 	test_must_fail env EDITOR=./editor git commit --allow-empty &&
 	git show -s --pretty=format:%s >subject &&
 	grep -q hare subject &&
-- 
2.1.4
