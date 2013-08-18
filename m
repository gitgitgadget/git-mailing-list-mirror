From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 06/24] read-cache: Don't compare uid, gid and ino on cygwin
Date: Sun, 18 Aug 2013 21:41:55 +0200
Message-ID: <1376854933-31241-7-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xp-0003q6-O5
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab3HRTsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:25 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44770 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTsY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:24 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so3104600wiw.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LXku0wInZWb6zB7p6PnM9s/+39qTf0LqSJy0GANLxxc=;
        b=uyWlqTH3P9DQV/zy7FDbyYfFYcig5uXISrN2TiViUi1wkUbYEKmcw+rxT7h7Ha7d1C
         tu4y3nKkNyE/13rWWFgZ8MWp4RhTxNJgyXfZesqKLpxNngv6lnWIWfuPs1sjtvd0KKie
         n9xOpbw45EvX/i0AqZlPbLbXoU1iYE9bXXQApkqfh85MjvBnPDvvqoiJYmE0IEc2pqvb
         e+TyMxFf6/PjoEX29dT1IaASani/KBYsVTdnHb7bxq2ROkATYVNWEIP5fGjZAVt6fqhe
         1pU8OkFnV1gb9cbHBzloTQazMC16jHbDI0KJ8eGdNejUouYVSexGPSyRiB1muXsRylZN
         21Uw==
X-Received: by 10.180.12.243 with SMTP id b19mr5451211wic.18.1376855303330;
        Sun, 18 Aug 2013 12:48:23 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id bt8sm11762873wib.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232496>

Cygwin doesn't have uid, gid and ino stats fields.  Therefore we should
never check them in the match_stat_data when working on the CYGWIN
platform.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This patch was not tested on Cygwin yet.  I think it's needed though,
because the re-reading of the index if it changed will no longer use
it's own index_changed function, but use the stat_validity_check
function instead.  Would be great if someone running Cygwin could test
this.

 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 1f827de..aa17ce7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -82,6 +82,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 		changed |= CTIME_CHANGED;
 #endif
 
+#if !defined (__CYGWIN__)
 	if (check_stat) {
 		if (sd->sd_uid != (unsigned int) st->st_uid ||
 			sd->sd_gid != (unsigned int) st->st_gid)
@@ -89,6 +90,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 		if (sd->sd_ino != (unsigned int) st->st_ino)
 			changed |= INODE_CHANGED;
 	}
+#endif
 
 #ifdef USE_STDEV
 	/*
-- 
1.8.3.4.1231.g9fbf354.dirty
