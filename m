From: Dana How <danahow@gmail.com>
Subject: [PATCH] Alter sha1close() 3rd argument to request flush only
Date: Tue, 08 May 2007 12:59:57 -0700
Message-ID: <4640D6BD.7000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:00:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlVrC-0004h9-CV
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031455AbXEHUAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031325AbXEHUAH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:00:07 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:5778 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031363AbXEHUAB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:00:01 -0400
Received: by py-out-1112.google.com with SMTP id a29so1580795pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 13:00:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=siZyWbOniLzydDjzKw9MbRfFvfuZiKBl3l5eXUCgDACVzQlwuSEcw6peA38qmn6Yh9VI0z2VgUYxS9jZBue2AfMjEa6f8DV87mCKU58+4B0al8dDn0AJUF8wIqfbJuqiL1Em5z3lf/FTpHf01XXfUGZCwIdc7pfXFyJBsfIlHjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=RELdgaZAvMZ6lD+yx4m42D0gr21uCU2vXoQiOHVSQ5TqguiK+Evzb05ESLFs6wDWWz5QGT76VofdEfgRJiJdlkLr+1DQUl+BOShaYJqx4w2TCOZOr5G5FZvhg2qb+zNnYrEieDsjzqe/wf2rYDCThVRfR5Y+veEvLhr4WAL4y10=
Received: by 10.35.91.10 with SMTP id t10mr13831546pyl.1178654400225;
        Tue, 08 May 2007 13:00:00 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id w67sm19003365pyg.2007.05.08.12.59.58;
        Tue, 08 May 2007 12:59:59 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46611>


update=0 suppressed writing the final SHA-1 but was not used.
Now final=0 suppresses SHA-1 finalization, SHA-1 writing,
and closing -- in other words,  only flush the buffer.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 csum-file.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7c806ad..9913cb5 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -29,18 +29,20 @@ static void sha1flush(struct sha1file *f, unsigned int count)
 	}
 }
 
-int sha1close(struct sha1file *f, unsigned char *result, int update)
+int sha1close(struct sha1file *f, unsigned char *result, int final)
 {
 	unsigned offset = f->offset;
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, offset);
+		f->offset = 0;
 	}
+	if (!final)
+		return 0;	/* only want to flush (no checksum write, no close) */
 	SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
-	if (update)
-		sha1flush(f, 20);
+	sha1flush(f, 20);
 	if (close(f->fd))
 		die("%s: sha1 file error on close (%s)", f->name, strerror(errno));
 	free(f);
-- 
1.5.2.rc0.787.g0014
