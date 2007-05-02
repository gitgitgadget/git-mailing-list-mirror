From: Dana How <danahow@gmail.com>
Subject: [PATCH 1/5] git-repack --max-pack-size: alter sha1close() 3rd argument
Date: Tue, 01 May 2007 17:03:58 -0700
Message-ID: <4637D56E.8010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 02:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj2KG-0007Rx-9I
	for gcvg-git@gmane.org; Wed, 02 May 2007 02:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946102AbXEBAEE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 20:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946105AbXEBAED
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 20:04:03 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:42182 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946102AbXEBAEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 20:04:01 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2379164nzf
        for <git@vger.kernel.org>; Tue, 01 May 2007 17:04:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=P3edXlVHNqzvpbulNJFBDz4+Boq+jxBTm7oqrXgbFn0kmdYuLbXOHa87pIz83+ijWL9EP0GF2fTtzXG3PUgh3wBxAjZIy1FgjTkmiJjzGSrwhAlrBIbi3TTvCd2fqSAbVeGBNR31Qih10pEo2B8rPg9sx4Dw6p5sUomJXehCIJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=WkNADXBISAQqhXhZ+h1BMmHUCGZtqevR1xjvs9OFiZYGBJAQc3ypW1i7LJwKttax04bRB893aQDdnRA2fDS7vjcYFcauaOFc7FTBtawGhB9haT1iwAnhp63joH+3CMmXxYJof2wVBEtsb+IB9thQLweCJGNMeNoDiKZIZ2s6uws=
Received: by 10.65.53.3 with SMTP id f3mr61098qbk.1178064240738;
        Tue, 01 May 2007 17:04:00 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id m2sm94581nzf.2007.05.01.17.03.59;
        Tue, 01 May 2007 17:04:00 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45994>


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
1.5.2.rc0.789.gd951
