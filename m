From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 05/11] Remove va_copy at MSVC because there are va_copy.
Date: Tue, 18 Aug 2009 00:04:00 +0800
Message-ID: <1250525040-5868-1-git-send-email-lznuaa@gmail.com>
Cc: Johannes.Schindelin@gmx.de, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Aug 17 18:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4h6-0004dA-L9
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605AbZHQQEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756529AbZHQQEL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:04:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:23998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbZHQQEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:04:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so484482rvb.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8P5Cdk3H6w4IujkBAFFXI3wXSnFQzFhb7sh5YVqz9iM=;
        b=JQhlf5cb05go+7ht13hx1isJv8MgHFiy18HcMPIjm0SirHnqiCufByrXfBjWSBD6wJ
         9iCj8oSxRLSBR1QoA37zP9P2wYUJ3Q7ek6+BmYDBrS2uzAyJriMee5sTqwns051Zwl/b
         wnj/qYJh3c9y1UNdFUCRiPtmvc9xpKGHVDtGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nL/fOf9i0uSA9FwIPPtg8Y1zkAYqaYddAINkEO607Y0So4PSAZfT4FTTqvOc/FuPN+
         Wxs2tYXldZbwTVbN9gB2BhA4kuc3+hajd47E3RVzIH83uP1rYCrYrwfs3S8/D9Pt7tAT
         l3rp6ZT/otTjyaFJCbgmecBprDjHnnR+D1kmk=
Received: by 10.140.125.19 with SMTP id x19mr974537rvc.78.1250525052556;
        Mon, 17 Aug 2009 09:04:12 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id b39sm21462389rvf.50.2009.08.17.09.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 09:04:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126205>

MSVs have not implemented va_copy. remove va_copy at MSVC environment.
It will malloc buffer each time.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/winansi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 9217c24..6091138 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -3,7 +3,11 @@
  */
 
 #include <windows.h>
+#ifdef _MSC_VER
+#include <stdio.h>
+#else
 #include "../git-compat-util.h"
+#endif
 
 /*
  Functions to be wrapped:
@@ -310,9 +314,13 @@ static int winansi_vfprintf(FILE *stream, const char *format, va_list list)
 	if (!console)
 		goto abort;
 
+#ifndef _MSC_VER 
 	va_copy(cp, list);
 	len = vsnprintf(small_buf, sizeof(small_buf), format, cp);
 	va_end(cp);
+#else
+	len= sizeof(small_buf) ;
+#endif
 
 	if (len > sizeof(small_buf) - 1) {
 		buf = malloc(len + 1);
-- 
1.6.4.msysgit.0
