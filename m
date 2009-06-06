From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 10/23] http-push: do not SEGV after fetching a bad pack idx
 file
Date: Sat, 6 Jun 2009 16:43:37 +0800
Message-ID: <20090606164337.42b74cfa.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrb1-0003yU-99
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbZFFIt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbZFFIt2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:49:28 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:33895 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbZFFIt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:49:27 -0400
Received: by mail-px0-f181.google.com with SMTP id 11so21643pxi.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=dhGq/r+9ACDtgCk6amfPZ4niPFr/psR8RRN7XeA3YoA=;
        b=fuvK3tpyFJYGM4g5UbLNwYjtGwqLrOiFDsVdcX9qY0qRS6DVzJxmS3pbgeLVcD6oM2
         1g5kH0ZmWnrvntMaVmEimRsBFUcOqSxgAoAnbybLDkTOfVGcRyZCBIdUf1ukS8/RgExi
         QXvz44vwh6yxBA1Ub++y+7f79jQrw2Rg66Apc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=h67LFYXIYOaVbg0l6rU4T7ZCmIwWyczCOq0gct9ZQt2iahxENO2A9bhVdr5vJoLzKA
         W1bapn6+wV88mbmtbbDpRT07FytBEEDC9WPD8UJGka9tIThhkpc36nmx1kqq9IBGMYMx
         kmPGNbehEzXfDarPkE5MCj2SGzYB4LKcWBqSQ=
Received: by 10.142.214.5 with SMTP id m5mr1471871wfg.110.1244278170095;
        Sat, 06 Jun 2009 01:49:30 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 30sm2706575wff.29.2009.06.06.01.49.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:49:29 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120891>

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
