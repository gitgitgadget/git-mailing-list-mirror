From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFD PATCH] git-fetch--tool and "insanely" long actions
Date: Fri, 20 Apr 2007 02:34:04 +0100
Message-ID: <20070420013411.26401.77137.julian@quantumfyre.co.uk>
References: <462811F6.9060503@gmail.com>
Cc: git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 03:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hei48-00052d-Tj
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 03:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXDTBhe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 21:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbXDTBhe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 21:37:34 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40030 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978AbXDTBhd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 21:37:33 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E2924C61AE
	for <git@vger.kernel.org>; Fri, 20 Apr 2007 02:37:31 +0100 (BST)
Received: (qmail 6901 invoked by uid 103); 20 Apr 2007 02:36:32 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3125. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 1.687262 secs); 20 Apr 2007 01:36:32 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 20 Apr 2007 02:36:30 +0100
In-Reply-To: <462811F6.9060503@gmail.com>
X-git-sha1: e607b7c4b69c6e0c60103db2cfbab7ecd3c90565 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45053>

On Thu, 19 Apr 2007, A Large Angry SCM wrote:

> This fixes a problem my repository mirroring script has been having since
> the git-fetch--tool was added to master in the middle of March. However,
> it is not a proper fix since it causes actual errors from snprintf() to be
> ignored. A proper fix is complicated by the lack of a consistent indicator
> that the buffer is too small across snprintf() implementations.
.
.
.
>       if (sizeof(msg) <= len)
> -             die("insanely long action");
> +             msg[sizeof(msg)-1] = '\0';

Or you could just let the whole thing through?

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index e9d6764..9b5ae9f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -36,21 +36,26 @@ static int update_ref(const char *action,
 		      unsigned char *oldval)
 {
 	int len;
-	char msg[1024];
+	char buffer[1024];
+	int ret = 0;
+	char *msg = buffer;
 	char *rla = getenv("GIT_REFLOG_ACTION");
 	static struct ref_lock *lock;
 
 	if (!rla)
 		rla = "(reflog update)";
-	len = snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	if (sizeof(msg) <= len)
-		die("insanely long action");
+	len = strlen(rla) + strlen(action) + 3;
+	if (len > sizeof(buffer))
+		msg = xmalloc(len);
+	snprintf(msg, len, "%s: %s", rla, action);
 	lock = lock_any_ref_for_update(refname, oldval);
 	if (!lock)
-		return 1;
+		ret = 1;
 	if (write_ref_sha1(lock, sha1, msg) < 0)
-		return 1;
-	return 0;
+		ret = 1;
+	if (msg != buffer)
+		free(msg);
+	return ret;
 }
 
 static int update_local_ref(const char *name,
-- 
1.5.1.1
