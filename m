From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 1/4] compat/setenv.c: update errno when erroring out
Date: Wed, 14 Dec 2011 15:07:08 +0100
Message-ID: <1323871631-2872-2-git-send-email-kusmabite@gmail.com>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, schwab@linux-m68k.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 15:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RapUW-0001cC-Th
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 15:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab1LNOHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 09:07:24 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58893 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757264Ab1LNOHU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 09:07:20 -0500
Received: by lagp5 with SMTP id p5so326742lag.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 06:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=acTyUTKFkCSYpathjuMQtCQ6V84rt13hcoAVUmKkwIk=;
        b=Oav+BX3EunXk13/M3UIxCUwe6A+0/Bzky7BDNPjsimnNxUM31rX0O6fPOhSnDSJmyR
         9q5WusZftk2AHkyLNIhwwhSW4P+8APZpPoG5tDeZQPn75IkMkdEa7MBo8ejaOzHFbrS+
         bqWGdJhn64T0+QCZQ3V7A4PzEfjUk+bzeLcCY=
Received: by 10.152.110.99 with SMTP id hz3mr2484275lab.29.1323871639087;
        Wed, 14 Dec 2011 06:07:19 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id pu10sm2321205lab.10.2011.12.14.06.07.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 06:07:17 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.272.g9e47e
In-Reply-To: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187111>

Previously, gitsetenv didn't update errno as it should when
erroring out. Fix this.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/setenv.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/setenv.c b/compat/setenv.c
index 3a22ea7..89947b7 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -6,7 +6,10 @@ int gitsetenv(const char *name, const char *value, int replace)
 	size_t namelen, valuelen;
 	char *envstr;
 
-	if (!name || !value) return -1;
+	if (!name || !value) {
+		errno = EINVAL;
+		return -1;
+	}
 	if (!replace) {
 		char *oldval = NULL;
 		oldval = getenv(name);
@@ -16,7 +19,10 @@ int gitsetenv(const char *name, const char *value, int replace)
 	namelen = strlen(name);
 	valuelen = strlen(value);
 	envstr = malloc((namelen + valuelen + 2));
-	if (!envstr) return -1;
+	if (!envstr) {
+		errno = ENOMEM;
+		return -1;
+	}
 
 	memcpy(envstr, name, namelen);
 	envstr[namelen] = '=';
-- 
1.7.7.1.msysgit.0.272.g9e47e
