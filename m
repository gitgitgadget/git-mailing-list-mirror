From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/7] sha1_name: prepare to introduce AT_KIND_PUSH
Date: Thu, 23 May 2013 20:42:49 +0530
Message-ID: <1369321970-7759-7-git-send-email-artagnon@gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 23 17:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXB5-0003im-Su
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 17:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319Ab3EWPL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 11:11:26 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59273 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759247Ab3EWPLU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 11:11:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf10so2062962pab.24
        for <git@vger.kernel.org>; Thu, 23 May 2013 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tKAVsSY3apcrBorDCe+HclFsbt6xKEeWKQJOdF9wwME=;
        b=zeiuHcyFTsjvgyygdx2/N06RwuSl8HB5dYnQ4PXd0QGfAQ3RYTFPjHIADkd217LpXf
         Vv508dyr6Lpab/8f6+mC/Dovx14/ntONtvoGpx5oZvRSBcMYGCZKpFOHAKEpZvL/JcZS
         7ral7rxWk4Ccwdg+vdGvfc6PNRX5kW09vOVvmRki4oyBlvJ1IddU/d+NVmej+YWwZzBp
         GDMKG1lZIdSL+2m+JCNAon7vYV+h7r2NNPOK5sBASgEA1QomSnL1ICpx/nTWTuUz75Xk
         aT+cshR7T6v27QVsdS5YtLkgxWyQHw7JaA82D23mH0ZRusIImb46dhSwFD67LL7JM5LJ
         Cl/g==
X-Received: by 10.68.200.162 with SMTP id jt2mr13357096pbc.138.1369321880296;
        Thu, 23 May 2013 08:11:20 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vb8sm12099173pbc.11.2013.05.23.08.11.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 May 2013 08:11:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225260>

Introduce an AT_KIND_PUSH to be represented as "@{p[ush]}".  Determine
it using branch.remote.push_refspec.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 106716e..5f6958b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -23,7 +23,7 @@ struct disambiguate_state {
 	unsigned always_call_fn:1;
 };
 
-#define AT_KIND_UPSTREAM 0
+enum at_kind { AT_KIND_UPSTREAM, AT_KIND_PUSH };
 
 static void update_candidates(struct disambiguate_state *ds, const unsigned char *current)
 {
@@ -426,7 +426,8 @@ static inline int at_mark(const char *string, int len, int *kind)
 		int kind;
 		const char *suffix[2];
 	} at_form[] = {
-		{ AT_KIND_UPSTREAM, { "@{upstream}", "@{u}" } }
+		{ AT_KIND_UPSTREAM, { "@{upstream}", "@{u}" } },
+		{ AT_KIND_PUSH, { "@{push}", "@{p}" } }
 	};
 
 	for (j = 0; j < ARRAY_SIZE(at_form); j++) {
@@ -1022,6 +1023,12 @@ static void die_no_upstream(struct branch *upstream, char *name) {
  *   given buf and returns the number of characters parsed if
  *   successful.
  *
+ * - "<branch>@{push}" finds the name of the ref that
+ *   <branch> is configured to push to (missing <branch> defaults
+ *   to the current branch), and places the name of the branch in the
+ *   given buf and returns the number of characters parsed if
+ *   successful.
+ *
  * If the input is not of the accepted format, it returns a negative
  * number to signal an error.
  *
@@ -1077,6 +1084,8 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 		free(cp);
 		cp = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 		break;
+	case AT_KIND_PUSH:
+		break;
 	}
 
 	strbuf_reset(buf);
-- 
1.8.3.rc3.17.gd95ec6c.dirty
