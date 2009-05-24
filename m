From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/18] http-push: do not SEGV after fetching a bad pack idx
 file
Date: Sun, 24 May 2009 22:19:46 +0800
Message-ID: <20090524221946.c42d059a.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eam-0005ol-8u
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbZEXOVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbZEXOVo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:44 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:48930 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbZEXOVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:43 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so2153790pxi.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8MGkdaegKRv/D+y1PzV+FfHEC+uBQ9Zj1l4hdJdvs14=;
        b=ZaAkgv9G2edXBmDxfSHdnb7T+dd94ACojQk1xUCGzvxEc/AFvPJQOYBkFS1kONSd2T
         BNBD1jbwIRDUOvzw3Hnf6apFsJsMDJj40NRo3fTS4w4oKi4N2a2rPDZBetQCwiCd7GdQ
         otVUfRRTX7NxQfv3u1i0BSzleE1SthzOyu2ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=YvQI0GtLUg6yfKnMO4FSH2PwB5adf7g+Y0XkabIQT2Hml5er7kqnJIPW+qebW1F592
         261rXQxO84NCCF9UOed43ZJil3egr885MIHgxN5vx3R/xbhcofZ24PLQpWM30NARa4vM
         Z0/7dWeVaMF4cdQL0FNpFtjaPSpXpETWFgAO0=
Received: by 10.114.211.1 with SMTP id j1mr12540900wag.176.1243174905702;
        Sun, 24 May 2009 07:21:45 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id c26sm12494502waa.50.2009.05.24.07.21.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:45 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119833>

In a70c232 ("http-fetch: do not SEGV after fetching a bad pack idx
file"), changes were made to the setup_index method in http-fetch.c
(known in its present form as http-walker.c after 30ae764 ("Modularize
commit-walker")). Since http-push.c has similar similar code for
processing index files, these changes should apply to http-push.c's
implementation of setup_index as well.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 9655b2c..c48bb73 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1061,6 +1061,8 @@ static int setup_index(unsigned char *sha1)
 		return -1;

 	new_pack = parse_pack_index(sha1);
+	if (!new_pack)
+		return -1; /* parse_pack_index() already issued error message */
 	new_pack->next = repo->packs;
 	repo->packs = new_pack;
 	return 0;
--
1.6.3.1
