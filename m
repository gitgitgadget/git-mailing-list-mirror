From: Dana How <danahow@gmail.com>
Subject: [PATCH 3/8] git-repack --max-pack-size: make close optional in sha1close()
Date: Mon, 30 Apr 2007 16:20:14 -0700
Message-ID: <463679AE.7020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifAg-0002AB-1s
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946748AbXD3XUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946882AbXD3XUh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:20:37 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:40721 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423778AbXD3XUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:20:16 -0400
Received: by py-out-1112.google.com with SMTP id a29so1462889pyi
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 16:20:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=IjzIV4iUBF70F1HrE1IbPsSGGwZegiUcX4pkWYnN0TwJwZnQC+Pyi3g59S/dm99HOZnUqd3mMbyHk8PzKBA8IFMz+Ewen6vy8gk8NgMTLucY5kQnezPowk1qEHkL77dl+VFgENOf65vwXZ05xHmv2lc5v5W8z2oOLec4bFI7UoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=F/btzLIucLzFCtutGe1NHkcH3J804nRbmI0FSsbdYmeie+q7fZ9MgNcXbYyhSxjkDxzWoPuj7tElKooLopE0J3OHte4IWcynXyWrxkzYBDrWivQqhitmvocWIu5mCkbnp8SuYxcUX5wNUNZCAr90E7kcs7JHk4kOmqqD2A6+PKQ=
Received: by 10.65.121.9 with SMTP id y9mr12863991qbm.1177975216111;
        Mon, 30 Apr 2007 16:20:16 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 18sm23021313nzo.2007.04.30.16.20.15;
        Mon, 30 Apr 2007 16:20:15 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45893>


sha1close() flushes, writes checksum, and closes.
The 2nd can be suppressed; make the last suppressible as well.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 csum-file.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 7c806ad..993c899 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -35,7 +35,10 @@ int sha1close(struct sha1file *f, unsigned char *result, int update)
 	if (offset) {
 		SHA1_Update(&f->ctx, f->buffer, offset);
 		sha1flush(f, offset);
+		f->offset = 0;
 	}
+	if (update < 0)
+		return 0;	/* only want to flush (no checksum write, no close) */
 	SHA1_Final(f->buffer, &f->ctx);
 	if (result)
 		hashcpy(result, f->buffer);
-- 
1.5.2.rc0.766.gba60-dirty
