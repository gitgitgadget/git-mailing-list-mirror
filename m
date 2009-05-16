From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/11] http-push: do not SEGV after fetching a bad pack idx
 file
Date: Sat, 16 May 2009 11:51:41 +0800
Message-ID: <20090516115141.58c5dc39.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 05:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5B0T-0005js-Ap
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 05:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713AbZEPDze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 23:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756331AbZEPDzc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 23:55:32 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:61221 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbZEPDz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 23:55:27 -0400
Received: by mail-pz0-f115.google.com with SMTP id 13so1344167pzk.33
        for <git@vger.kernel.org>; Fri, 15 May 2009 20:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=NfZksqBtc2ENgDHCrj0DSPZ1rxhY2yv4EHTMuQ1E2uo=;
        b=v2Pe2ymaYfGqzfMboMXjgnhJ3C1AI8ZkbiFV0+++/JzYcpse32c00gcWC/9Q3XLimW
         pwDRhF8QXGYuQe5WBURKFgzq7zv0vcjWQH1NWh4EUAdYQkbRGDtYpxW3GiTIvzTEI6Pf
         b8CM5LbnqxEz4fVE6jiMFeLc8TcBdYVQHnL0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=fTfWNudEK9ap3b/ZFnPvDB7zyoPy9Lv25CfjIwhQkmn1L6A3CwIZYro0JzkOAnxVQS
         dasO2yZBiWhom8BCMqLgwJJTSzHwOQeH5l+5nIiGZV6XAXpRobmAaean1mpmF9o3n3rk
         LMNev83O33MEF79JZbkr/bHK0e4S0y2mt9Ykg=
Received: by 10.115.14.15 with SMTP id r15mr6125820wai.107.1242446128881;
        Fri, 15 May 2009 20:55:28 -0700 (PDT)
Received: from your-cukc5e3z5n (cm112.zeta149.maxonline.com.sg [116.87.149.112])
        by mx.google.com with ESMTPS id n6sm2167806wag.39.2009.05.15.20.55.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 20:55:28 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119327>

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
index 1011ca8..875b2c6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1060,6 +1060,8 @@ static int setup_index(unsigned char *sha1)
 		return -1;
 
 	new_pack = parse_pack_index(sha1);
+	if (!new_pack)
+		return -1; /* parse_pack_index() already issued error message */
 	new_pack->next = repo->packs;
 	repo->packs = new_pack;
 	return 0;
-- 
1.6.3.rc0
