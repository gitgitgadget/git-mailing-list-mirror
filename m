From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 08/17] cmd_init_db(): when creating directories, handle errors conservatively
Date: Sat, 18 Jan 2014 23:48:52 +0100
Message-ID: <1390085341-2553-9-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eii-0005WS-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaARWuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:50:24 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52577 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751742AbaARWti (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:38 -0500
X-AuditID: 12074412-b7fc96d0000023d5-7f-52db05021afb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 75.87.09173.2050BD25; Sat, 18 Jan 2014 17:49:38 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN91030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:37 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqMvEejvIYN9zYYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Yc2MWa8F3zopjl76zNDA+
	Zu9i5OSQEDCRmHmthwXCFpO4cG89WxcjF4eQwGVGiT3HlrFAOCeYJM4d/ckGUsUmoCuxqKeZ
	CcQWEVCTmNh2CKybWcBBYvPnRkYQW1ggQeLV1InMIDaLgKrE56fbWEFsXgFniemb2oHqOYC2
	KUisvi4EEuYUcJE4Mv8C2EghoJKbr5+wT2DkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI
	10wvN7NELzWldBMjJFSEdjCuPyl3iFGAg1GJh/cA0+0gIdbEsuLK3EOMkhxMSqK8yiAhvqT8
	lMqMxOKM+KLSnNTiQ4wSHMxKIrzBG24FCfGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5N
	LUgtgsnKcHAoSfAKsAANFSxKTU+tSMvMKUFIM3FwgggukA08QBskQQp5iwsSc4sz0yGKTjEq
	SonzyoMkBEASGaV5cANgUf2KURzoH2He+8xAVTzAhADX/QpoMBPQYJHYmyCDSxIRUlINjO1M
	KlEXb786q99/7JN4Pd/kdy0m7bKNaX/YyraZTv6cuyfTgTfDwz1G07nWemly6yIZL04jgc2H
	BL98+3ip72yDk/BGvbDr8nJqAjM9337W8PxqYF0U3hsyQ5HpW7BsWcYbqTXT2V5es9M4cejE
	jqkf0s9mXtARO7LX9YoG03z/yZx6lyYVKrEUZyQaajEXFScCABSOhQ7FAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240667>

safe_create_leading_directories_const() returns a non-zero value on
error.  The old code at this calling site recognized a couple of
particular error values, and treated all other return values as
success.  Instead, be more conservative: recognize the errors we are
interested in, but treat any other nonzero values as failures.  This
is more robust in case somebody adds another possible return value
without telling us.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/init-db.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 6f69593..c7c76bb 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -515,13 +515,14 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 				saved = shared_repository;
 				shared_repository = 0;
 				switch (safe_create_leading_directories_const(argv[0])) {
+				case SCLD_OK:
+				case SCLD_PERMS:
+					break;
 				case SCLD_EXISTS:
 					errno = EEXIST;
 					/* fallthru */
-				case SCLD_FAILED:
-					die_errno(_("cannot mkdir %s"), argv[0]);
-					break;
 				default:
+					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				}
 				shared_repository = saved;
-- 
1.8.5.2
