From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 10/23] http-push: do not SEGV after fetching a bad pack idx
 file
Date: Sat, 6 Jun 2009 00:04:47 +0800
Message-ID: <20090606000447.d0f803bc.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzF-00053w-9O
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbZFEQIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbZFEQIp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:45 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:50429 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbZFEQIo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:44 -0400
Received: by mail-px0-f202.google.com with SMTP id 40so80522pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=dhGq/r+9ACDtgCk6amfPZ4niPFr/psR8RRN7XeA3YoA=;
        b=hAdP4eU3yyK3QySuOTNkahZ2/y3bH3ww3/oXeFmuLpvFST+NC5wyskIIQfTIULJ8i2
         SrJSFBseZRlLGagILYHD2OoX7aTFGFOyJJCGR2pi515aZeUA7SObWcz6xLYmeKF34fcx
         F2ek5BnHDUBuqmeTjau4LbPo/5s1WIH2NDAmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=lTv+jPxhmo6gjRnq+9Ee2QvXa0QDhY5HjfFYL5wMKH2w+NgJpsXuP4XmFHzIF3PAbV
         5z4AnmL8KjIWXKDOQaejlfcALuT9k1rPw/hBlGNKQ5i+LelTrCOyTQcwVKc5k6z9li5x
         JvafVTxJMyoAK269HH2g6OlrE0YkCLNrEJieA=
Received: by 10.143.41.5 with SMTP id t5mr1414183wfj.134.1244218126768;
        Fri, 05 Jun 2009 09:08:46 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm411570wff.29.2009.06.05.09.08.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:46 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120791>

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
index c8cb6e4..a6ca2ac 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1065,6 +1065,8 @@ static int setup_index(unsigned char *sha1)
 		return -1;

 	new_pack = parse_pack_index(sha1);
+	if (!new_pack)
+		return -1; /* parse_pack_index() already issued error message */
 	new_pack->next = repo->packs;
 	repo->packs = new_pack;
 	return 0;
--
1.6.3.1
