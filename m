From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] mingw: do not set errno to 0 on success
Date: Tue, 23 Nov 2010 20:53:08 +0100
Message-ID: <1290541988-4608-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 20:54:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKywE-0005aT-N1
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab0KWTxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 14:53:50 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54058 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab0KWTxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 14:53:49 -0500
Received: by eye27 with SMTP id 27so4910073eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Pnp/kmAvNzaRv0OOMTB4H+Zmjy3uJOXKk2TntcgSHrQ=;
        b=UJSaPGXMkdzNfg9DoCH7mn20qK4GXTgZ0Ih+iqSSq1zHASTMoRaGQEgGC45q5nv+R8
         5dEDCJ3F6qcO4WybIgow3TDMLP2T3+gPdmt1/dQrK4CaAo1O5ALnBd2TYnlg/Kx0kPoX
         qkUyAIAFmrj6qQenqRJc06pk3C0mXaFi+d8bM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kkpCt9c8w6BIGcBhor3W3M+o99Q4VbqV4tWU6mypB0xeiT3kKzkkpWCKm+Y0WIyXlr
         4CG6jgb9qFgfbrdrSoD4w+S1OAbPboaJdWB2yamWmTV8WCOgS+jC2Pa2OlvWsubi6A7n
         eKQ/9PLJ0P4mQ8981QPT8yerXdl6HjTBowZbw=
Received: by 10.213.16.72 with SMTP id n8mr2237909eba.38.1290542028417;
        Tue, 23 Nov 2010 11:53:48 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm6140624eeh.5.2010.11.23.11.53.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 11:53:47 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162017>

Currently do_lstat always sets errno to 0 on success. This incorrectly
overwrites previous errors.

Fetch the error-code into a temporary variable instead, and assign that
to errno on failure.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

A bug I found while hunting down another regression. maint-worthy, perhaps?

 compat/mingw.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index f2d9e1f..b98e600 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -195,9 +195,10 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
  */
 static int do_lstat(const char *file_name, struct stat *buf)
 {
+	int err;
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
 
-	if (!(errno = get_file_attr(file_name, &fdata))) {
+	if (!(err = get_file_attr(file_name, &fdata))) {
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
@@ -211,6 +212,7 @@ static int do_lstat(const char *file_name, struct stat *buf)
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
 		return 0;
 	}
+	errno = err;
 	return -1;
 }
 
-- 
1.7.3.2
