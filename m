From: Laszlo Papp <djszapi2@gmail.com>
Subject: [PATCH] Fix resource leaks in wrapper.c
Date: Tue, 27 Oct 2009 04:53:55 +0100
Message-ID: <1256615635-4940-1-git-send-email-djszapi@archlinux.us>
Cc: Laszlo Papp <djszapi@archlinux.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 04:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2dDV-0002sw-Vj
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 04:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZJ0D7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 23:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbZJ0D7P
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 23:59:15 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:52422 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbZJ0D7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 23:59:14 -0400
Received: by fxm18 with SMTP id 18so12642407fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Du7fwLfgYOFjuNb9fgm78P6WboX9I9/lg6GODHi9QTY=;
        b=cbgMVLGTJ4zMFJFKAi9+CK1V5EA2ZTBhwNurNr8bRi6XEFKfLDSM+2tU1yjRDEJdi7
         3PSETh49ffw6xQt+FO0ODwx7Xy6cXvoxg8hx9iH/4Unkn09ehTOphwb+om0rNIIPMDKB
         Uxp6fDMWSHLPfI4LU5zvvR2rmdObpHw3VHdUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HhnkTJrhjNJtnxQyByLNGKXQ3gTUGv+SBqqoBC1A5DbOrSuJQULrdNTPxVQjzG5KLZ
         f3Y78P20bjiRuHwUgbXw81gk8NrsN1Qoxz9FHEHyngX29qOXXK9jBjDPPoKXcBCY/Ryd
         HBSPeQEyoLdPCug0NRX5C5mH0HBisguxC7wv0=
Received: by 10.204.152.27 with SMTP id e27mr5095734bkw.192.1256615644392;
        Mon, 26 Oct 2009 20:54:04 -0700 (PDT)
Received: from localhost (94-21-25-228.pool.digikabel.hu [94.21.25.228])
        by mx.google.com with ESMTPS id 28sm7969960fkx.1.2009.10.26.20.54.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 20:54:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131308>

Fix the following issues with the desired close tags:

[wrapper.c:276]: (error) Resource leak: fd
[wrapper.c:291]: (error) Resource leak: fd

Signed-off-by: Laszlo Papp <djszapi@archlinux.us>
---
 wrapper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index c9be140..76ecf0a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -266,7 +266,7 @@ int odb_mkstemp(char *template, size_t limit, const char *pattern)
 	fd = mkstemp(template);
 	if (0 <= fd)
 		return fd;
-
+	close(fd);
 	/* slow path */
 	/* some mkstemp implementations erase template on failure */
 	snprintf(template, limit, "%s/%s",
@@ -284,7 +284,7 @@ int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
 	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 	if (0 <= fd)
 		return fd;
-
+	close(fd);
 	/* slow path */
 	safe_create_leading_directories(name);
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-- 
1.6.5
