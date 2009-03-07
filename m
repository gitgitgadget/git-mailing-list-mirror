From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] http: add_fill_function checks if function has been added
Date: Sat, 07 Mar 2009 20:21:04 +0800
Message-ID: <49B266B0.4020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 07 13:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfvY9-0005aZ-Kd
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbZCGMVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbZCGMVN
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:21:13 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:16982 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbZCGMVN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:21:13 -0500
Received: by ti-out-0910.google.com with SMTP id d10so522124tib.23
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 04:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=k8+j4ZKdU4yqPVCSQSUStCm/1mtqNQ64T+4f3NGXxZ0=;
        b=chKzKmFSMp+rqVciC0OOfezzJWbOAoZ1Qo9hUfhNtIWhJbTnW+bTEp79M0l08Qc2WQ
         mKQei4rHx7hABPL6U81p1nZlnuhO+fTJTotJpFUBaIzSs2AbAmzqWx9lx9QyWZXWVtE8
         AKN5ZpSsMxLn/cwSwAye7n/s+GzIM0fTvABis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=ncK9ZJhTzGXRNMnZmfjrqF0nSRQzK3ivOWk3EhpVXsjFXSCo/Lk6d8nluOiaWy4/2M
         72hiO/VjQJPoa0vpCDRO6ySX7VUxqQnSb/W4NJXuUG7+nD83cBJZ/tsaZwTv29U5C7uZ
         byw6cZjHuafhqjdeLmdLgwWTzKH83T4vOGxgo=
Received: by 10.110.63.17 with SMTP id l17mr2447945tia.13.1236428468692;
        Sat, 07 Mar 2009 04:21:08 -0800 (PST)
Received: from ?116.87.148.213? ([116.87.148.213])
        by mx.google.com with ESMTPS id a4sm476250tib.11.2009.03.07.04.21.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Mar 2009 04:21:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112528>

This patch ensures that the same fill function is called once so to
prevent any possible issues.

Nevertheless, calling a fill function repeatedly in
''fill_active_slots'' will not lead to any obvious change in existing
behavior, though performance might be affected.

''add_fill_action'' checks if the function to be added has already been
added. Allocation of memory for the list ''fill_chain*'' is postponed
until the check passes, unlike previously.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index ee58799..cdedeb6 100644
--- a/http.c
+++ b/http.c
@@ -408,13 +408,17 @@ static struct fill_chain *fill_cfg = NULL;

 void add_fill_function(void *data, int (*fill)(void *))
 {
-	struct fill_chain *new = xmalloc(sizeof(*new));
+	struct fill_chain *new;
 	struct fill_chain **linkp = &fill_cfg;
+	for (;*linkp; linkp = &(*linkp)->next)
+		if ((*linkp)->fill == fill)
+			return;
+
+	new = xmalloc(sizeof(*new));
 	new->data = data;
 	new->fill = fill;
 	new->next = NULL;
-	while (*linkp)
-		linkp = &(*linkp)->next;
+
 	*linkp = new;
 }

-- 
1.6.2.rc1
