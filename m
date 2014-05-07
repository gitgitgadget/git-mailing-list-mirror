From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/20] read-cache.c: split racy stat test to a separate function
Date: Wed,  7 May 2014 21:51:55 +0700
Message-ID: <1399474320-6840-16-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Dy-0006HP-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbaEGOx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:26 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47148 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbaEGOxY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:24 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so1150478pdj.38
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXsh3zU8PFF1TiysEHKvwohWMVawQN1E6rKw366tMdY=;
        b=nC7w4HcreqhPm5T5NSZUL/raIYU/8D7ZhrTeMpRH5fvsBYAzui4yAWLExAUFAN/hrJ
         FKKWw/SyIiJrVaIlzOEKc9kLe7nj/DdIfRsEXAcZGpWNQxytf+Q6VWFSdvgrK9SQ04JB
         dWkvu/VB4uU3ANdyMS/lnsrMLA8Hi5v2ywmV3OMEqmTuZfbi7usKqIUGlAFod7ip9IwQ
         NJQahBixY8ojPBunwNTjqirYiuS49ZDof7ndJZbPlGzImowfpMFBB23m49HuioDYip+6
         b73GjE3I4dNyUlRt6M/5j6PMXGzTZcEbA1vE1hg2jzy2bQBUjjRyEk9xu223bm4bbU6Y
         4p9A==
X-Received: by 10.66.148.98 with SMTP id tr2mr19749279pab.33.1399474403821;
        Wed, 07 May 2014 07:53:23 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id qv3sm3631319pbb.87.2014.05.07.07.53.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:22 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248321>

---
 read-cache.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 66c2279..72adcd6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -258,20 +258,26 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 	return changed;
 }
 
-static int is_racy_timestamp(const struct index_state *istate,
-			     const struct cache_entry *ce)
+static int is_racy_stat(const struct index_state *istate,
+			const struct stat_data *sd)
 {
-	return (!S_ISGITLINK(ce->ce_mode) &&
-		istate->timestamp.sec &&
+	return (istate->timestamp.sec &&
 #ifdef USE_NSEC
 		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < ce->ce_stat_data.sd_mtime.sec ||
-		 (istate->timestamp.sec == ce->ce_stat_data.sd_mtime.sec &&
-		  istate->timestamp.nsec <= ce->ce_stat_data.sd_mtime.nsec))
+		(istate->timestamp.sec < sd->sd_mtime.sec ||
+		 (istate->timestamp.sec == sd->sd_mtime.sec &&
+		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
 #else
-		istate->timestamp.sec <= ce->ce_stat_data.sd_mtime.sec
+		istate->timestamp.sec <= sd->sd_mtime.sec
 #endif
-		 );
+		);
+}
+
+static int is_racy_timestamp(const struct index_state *istate,
+			     const struct cache_entry *ce)
+{
+	return (!S_ISGITLINK(ce->ce_mode) &&
+		is_racy_stat(istate, &ce->ce_stat_data));
 }
 
 int ie_match_stat(const struct index_state *istate,
-- 
1.9.1.346.ga2b5940
