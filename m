From: Dana How <danahow@gmail.com>
Subject: [PATCH 6/8] git-repack --max-pack-size: write_one() implements limits
Date: Mon, 30 Apr 2007 16:23:20 -0700
Message-ID: <46367A68.4010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifDM-000375-LY
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946883AbXD3XXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946885AbXD3XXY
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:23:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:47485 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946883AbXD3XXX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:23:23 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2084834nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:23:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ejVMsEL+TUmTRKMhnfbHGKbMS1uw8OUkJffeBW2Rj5h/JwdWmnzpWhLQZoGq8Zk6If3wktd6BR/EIeyZZdcn+fI/dh6UitzytXxn3aoShrcV5voElcpFXtVmFsZi0vusACrTKUmpr35tDAvOSyEYdFKqB0zg0M2nnFeQN+hL4qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=GQ8VWh0bOQohgvH8cZYVDsomGf/1zp51rqc7Rw2VnCaOPgQGx2XsWwoOK09a4JrNjBhKilR8zxDiRSsyOr2HvdW2pHAsoI2UCpwhY9EWl3DP/iggQ+FRu9qm6WPzRrYoGugmXvvi1vB8FqCNUrafyr4dV51g5i6Sh2mfYQEONr4=
Received: by 10.65.43.17 with SMTP id v17mr12889829qbj.1177975402861;
        Mon, 30 Apr 2007 16:23:22 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 36sm8028503nzk.2007.04.30.16.23.21;
        Mon, 30 Apr 2007 16:23:22 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45897>


If --max-pack-size is specified,  generate the appropriate
write limit for each object and pass it to write_object().
Detect and return write "failure".

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d3ebe1d..b50de05 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -612,11 +612,17 @@ static off_t write_one(struct sha1file *f,
 		return offset;
 
 	/* if we are deltified, write out base object first. */
-	if (e->delta)
+	if (e->delta) {
 		offset = write_one(f, e->delta, offset);
+		if (!offset)
+			return 0;
+	}
 
 	e->offset = offset;
-	size = write_object(f, e, 0);
+	/* pass in write limit if limited packsize and not first object */
+	size = write_object(f, e, pack_size_limit && nr_written ? pack_size_limit - offset : 0);
+	if (!size)
+		return e->offset = 0;
 
 	/* make sure off_t is sufficiently large not to wrap */
 	if (offset > offset + size)
-- 
1.5.2.rc0.766.gba60-dirty
