From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 04/17] http-push: do not SEGV after fetching a bad pack idx
 file
Date: Sat, 30 May 2009 01:58:47 +0800
Message-ID: <20090530015847.fad3e1f8.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6Nx-0008Tp-FV
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130AbZE2SAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757824AbZE2SAr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:00:47 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:53739 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730AbZE2SAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:00:46 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1678194pxi.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8MGkdaegKRv/D+y1PzV+FfHEC+uBQ9Zj1l4hdJdvs14=;
        b=m4xU9WBGyKStqYBxZfueMKw3iSnb0UD4xkM+HkWQlyJG9y5do+fkRrN9hOV0nn/KhO
         aoqrO7/Wohti1w0o1Iy9hc6BjBQVXLp+EPsbuAiPYHdFWHUbkCODxj3EqOEAkMB6kWUQ
         mQ+B03bjLVD0qnQs/kAYTvS82rE/01fh+IZ0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=WBzU1Uf0xGUo6Mrh9rrPbiHt2Wc24H3ecgxVyj3annmoses8lUit1XKcqfF0vfGuM7
         JkPJqwLo4vdIkoEkYMU0fiiqkDaXqiOnpR0d+lDF7NtQVL8CnX9KHk3iBL2vPig3poCK
         hLIKegO/T7LfsxGC6fWXgNMs9dTYulEieFWKc=
Received: by 10.114.173.8 with SMTP id v8mr4446911wae.22.1243620048543;
        Fri, 29 May 2009 11:00:48 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id n6sm2546225wag.39.2009.05.29.11.00.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:00:48 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120292>

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
