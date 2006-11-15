X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Seek back to current filepos when mmap()ing with NO_MMAP
Date: Wed, 15 Nov 2006 17:27:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611151727000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 16:28:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31451>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkNcH-0003a2-Nh for gcvg-git@gmane.org; Wed, 15 Nov
 2006 17:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030658AbWKOQ15 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 11:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbWKOQ15
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 11:27:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:27115 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030658AbWKOQ14 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 11:27:56 -0500
Received: (qmail invoked by alias); 15 Nov 2006 16:27:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 15 Nov 2006 17:27:54 +0100
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


"git-index-pack --fix-thin" relies on mmap() not changing the current
file position (otherwise the pack will be corrupted when writing the
final SHA1). Meet that expectation.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Sorry for not catching that earlier. It only affects platforms
	where you have to set NO_MMAP=YesPlease, anyway.

 compat/mmap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 55cb120..a4d2e50 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -7,6 +7,7 @@
 void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
 {
 	int n = 0;
+	off_t current_offset = lseek(fd, 0, SEEK_CUR);
 
 	if (start != NULL || !(flags & MAP_PRIVATE))
 		die("Invalid usage of gitfakemmap.");
@@ -39,6 +40,11 @@ void *gitfakemmap(void *start, size_t le
 		n += count;
 	}
 
+	if (current_offset != lseek(fd, current_offset, SEEK_SET)) {
+		errno = EINVAL;
+		return MAP_FAILED;
+	}
+
 	return start;
 }
 
-- 
dummy-dirty
