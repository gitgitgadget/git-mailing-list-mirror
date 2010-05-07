From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/3 v4] Make diffcore_std only can run once before a diff_flush
Date: Thu,  6 May 2010 21:52:28 -0700
Message-ID: <1273207949-18500-3-git-send-email-struggleyb.nku@gmail.com>
References: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
 <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 06:52:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAFYV-00005k-F8
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 06:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab0EGEwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 00:52:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55907 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab0EGEwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 00:52:40 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so428683gyg.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 21:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XJi9nXxWXc+Ayt6UMpSXvt9sHtTr1/2NiudMBq95/Bc=;
        b=UxFEnBAVH8tYbkIm5dlQoZEI5RoyN754mFsDRV4RNxr5vlNZQBXU7fbhQdk+r7bxrX
         /RcAeFS5sFlk76aRvEPVvheF7JpXVoYSAwrF+y+5l8Gq0oXQx6aJHCeA9DaKozkYCsjG
         C8MIdqKldPXaeSBFSp0qrq9rEgzW4ycQrXE5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dge17WrY7GLFpwyo3EYDkyg3LuuvBXDoxmgyjBiKGzID08hf0ipp+gIKbXr8t2k44K
         xZNU3DGweLQ7r0o8XOK3oqIgUJs6mpHvUNRu8hUvCaAv6vP56FcLh5ed/tvxCVEq7EhQ
         BReDPNHi/98H4yrOgAeIv0DR/7Y/y/IcnQ7tw=
Received: by 10.101.106.37 with SMTP id i37mr9940265anm.232.1273207960273;
        Thu, 06 May 2010 21:52:40 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n2sm16458856ann.12.2010.05.06.21.52.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 21:52:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146521>

When file renames/copies detection is turned on, the
second diffcore_std will degrade a 'C' pair to a 'R' pair.

And this may happen when we run 'git log --follow' with
hard copies finding. That is, the try_to_follow_renames()
will run diffcore_std to find the copies, and then
'git log' will issue another diffcore_std, which will reduce
'src->rename_used' and recognize this copy as a rename.
This is not what we want.

So, I think we really don't need to run diffcore_std more
than one time.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 diff.c     |    8 ++++++++
 diffcore.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 4a350e3..f0985bc 100644
--- a/diff.c
+++ b/diff.c
@@ -3737,6 +3737,12 @@ void diffcore_fix_diff_index(struct diff_options *options)
 
 void diffcore_std(struct diff_options *options)
 {
+	/* We never run this function more than one time, because the
+	 * rename/copy detection logic can only run once.
+	 */
+	if (diff_queued_diff.run)
+		return;
+
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
 	if (options->break_opt != -1)
@@ -3756,6 +3762,8 @@ void diffcore_std(struct diff_options *options)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
+
+	diff_queued_diff.run = 1;
 }
 
 int diff_result_code(struct diff_options *opt, int status)
diff --git a/diffcore.h b/diffcore.h
index 5d05dea..491bea0 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -91,11 +91,13 @@ struct diff_queue_struct {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
+	int run;
 };
 #define DIFF_QUEUE_CLEAR(q) \
 	do { \
 		(q)->queue = NULL; \
 		(q)->nr = (q)->alloc = 0; \
+		(q)->run = 0; \
 	} while(0);
 
 extern struct diff_queue_struct diff_queued_diff;
-- 
1.6.0.4
