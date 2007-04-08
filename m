From: Dana How <danahow@gmail.com>
Subject: [PATCH 6/8] git-repack --max-pack-size: write_one() implements limits
Date: Sun, 08 Apr 2007 16:25:17 -0700
Message-ID: <461979DD.6030408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 01:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaglA-00082p-0J
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 01:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXDHXZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 19:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXDHXZV
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 19:25:21 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:2256 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXDHXZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 19:25:20 -0400
Received: by py-out-1112.google.com with SMTP id a29so897294pyi
        for <git@vger.kernel.org>; Sun, 08 Apr 2007 16:25:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=lkQRUlYnDk0Cc/zC6LeoMUbyGslTjQ65g/FYcVJHFwFFl2f2Q2doMbu8/WHr3VEZI+Lpbucb3g3vodX9wVBrtvLuUWFFQVAeTVRBBY4yBY63pw+m1LheqdBqge3CdTTYps7xt1xbcyILQEBg8WdJiJM08YD9qHtIKmhXv/Ne6nM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=eBCB8MOUhaXnmEC0QmDBjLZHydqGmDKI/sBj/BbChHrnMtTEOSWsT+e+HsJocqEyLgRUJH8cupwmwdmCYXzXTLCfOM/Z7nTdfjvohpNJUoxlQ9HWQnmP5P1gM3gLNnVdg1GMWw7uRDTOlyXJIhLKlO+89ujPFg7YTEzwSOwwAAk=
Received: by 10.65.153.10 with SMTP id f10mr10503762qbo.1176074720068;
        Sun, 08 Apr 2007 16:25:20 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 12sm15984815nzn.2007.04.08.16.25.18;
        Sun, 08 Apr 2007 16:25:18 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44016>


If --max-pack-size (offset_limit) is specified,
generate the appropriate write limit for each object and
pass it to write_object().  Detect and return
write "failure".

Signed-off-by: Dana How <how@deathvalley.cswitch.com>
---
 builtin-pack-objects.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9530008..a088f2e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -556,16 +556,24 @@ static off_t write_one(struct sha1file *f,
 			       struct object_entry *e,
 			       off_t offset)
 {
+	off_t result;
 	if (e->offset || e->preferred_base)
 		/* offset starts from header size and cannot be zero
 		 * if it is written already.
 		 */
 		return offset;
 	/* if we are deltified, write out its base object first. */
-	if (e->delta)
+	if (e->delta) {
 		offset = write_one(f, e->delta, offset);
+		if (!offset)
+			return offset;
+	}
+	/* pass in write limit if limited packsize and not first object */
+	result = write_object(f, e, offset_limit && nr_written ? offset_limit - offset : 0);
+	if (!result)
+		return result;
 	e->offset = offset;
-	return offset + write_object(f, e, 0);
+	return offset + result;
 }
 
 /*
-- 
1.5.1.89.g8abf0
