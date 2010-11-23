From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 2/6] msvc: opendir: allocate enough memory
Date: Tue, 23 Nov 2010 18:30:40 +0100
Message-ID: <1290533444-3404-3-git-send-email-kusmabite@gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiN-0003bQ-LE
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0KWRb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab0KWRbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:23 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so4809402eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gZ+2ZMJjXagT/Tb8Qzh9l0il3Lrq09x486/ARodLZyw=;
        b=eSERo+rwZhLMRttZmBr48+GSH4SwSAw5Rmf3OGIuCpdx+XYsCfjWQWNJtDantHFolU
         cC0xSCfT3cHU6WWzM1ET8YRYf30PdNiqPqcObNUcDcFtt2hzk+I1f9xxHVkqVK57wQfN
         q9FdZwvWSiWeJYCCROvlJFcZgqgFfzPQog1V8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V6ZDkHzPQJhyzwnwA21ufslk7PTCokQVootgne7AULLUQc/CJXrVncZFwt3bJ4CU5i
         NP3zmoZxZk7lcfrGydbaE8HqihVWkjLwKTuiswH3xq2lfU/cHzoT1JBJ2+cy0yiT7Dj6
         /o6fDNKHSIZJRPMaITZKzAWAMFgNhO/ejLvRU=
Received: by 10.14.119.1 with SMTP id m1mr5949526eeh.1.1290533482715;
        Tue, 23 Nov 2010 09:31:22 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm6007322eeh.18.2010.11.23.09.31.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161983>

The defintion of DIR expects the allocating function to extend
dd_name by over-allocating. This is not currently done in our
implementation of opendir. Fix this.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index db3df51..205304e 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -5,12 +5,11 @@
 
 DIR *opendir(const char *name)
 {
-	int len;
+	int len = strlen(p->dd_name);
 	DIR *p;
-	p = xmalloc(sizeof(DIR));
-	memset(p, 0, sizeof(DIR));
-	strncpy(p->dd_name, name, PATH_MAX);
-	len = strlen(p->dd_name);
+	p = xmalloc(sizeof(DIR) + len + 2);
+	memset(p, 0, sizeof(DIR) + len + 2);
+	strcpy(p->dd_name, name);
 	p->dd_name[len] = '/';
 	p->dd_name[len+1] = '*';
 
-- 
1.7.3.2.493.ge4bf7
