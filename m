From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 3/6] msvc: opendir: do not start the search
Date: Tue, 23 Nov 2010 18:30:41 +0100
Message-ID: <1290533444-3404-4-git-send-email-kusmabite@gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiM-0003bQ-Hz
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882Ab0KWRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:27 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab0KWRbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:25 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so4809402eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=t62gxsgwFIVK2EbCwjtt6pDWc0TkgLQrWjaVrQDHhDQ=;
        b=udSqeuSFvuwqXS28xv0jtjvHK3oDMSKXOYOFGnThpPEB6aqjPYJcg2Cp8pXOv+hnWN
         ZIdncML8RwKkgYBgNyykpeFU6XlZpNjUa7nKECeUBCcubJCVNGWxBQLBDVX3HipBV01S
         W2wRc+9vaIJ3O7LBO1L6GZw6j37dEcuNOsAR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eRHjrX63pXB9M/aqMs8t6JytidCkwKvjq3ag+TBhyPpZ/TU64qruuMnSV+Jxwce0fT
         qelNz7e52AgcDS5yQ3nky3H2k3t3E6bFwFD7TIZANB6Q0jwXFB8r3yxZWFbAkiXM1+uz
         qqKRZsaHpf/6L9sQ5DrBKK1RjFFz9gi01Q2N4=
Received: by 10.213.105.76 with SMTP id s12mr3566419ebo.2.1290533484710;
        Tue, 23 Nov 2010 09:31:24 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm6007275eeh.12.2010.11.23.09.31.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:24 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
In-Reply-To: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161988>

compat/mingw.c's readdir expects to be the one that starts the search,
and if it isn't, then the first entry will be missing or incorrect.

Fix this by removing the call to _findfirst, and initializing dd_handle
to INVALID_HANDLE_VALUE.

At the same time, make sure we use FindClose instead of _findclose,
which is symmetric to readdir's FindFirstFile. Take into account that
the find-handle might already be closed by readdir.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/msvc.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/compat/msvc.c b/compat/msvc.c
index 205304e..38f2d92 100644
--- a/compat/msvc.c
+++ b/compat/msvc.c
@@ -13,17 +13,13 @@ DIR *opendir(const char *name)
 	p->dd_name[len] = '/';
 	p->dd_name[len+1] = '*';
 
-	p->dd_handle = _findfirst(p->dd_name, &p->dd_dta);
-
-	if (p->dd_handle == -1) {
-		free(p);
-		return NULL;
-	}
+	p->dd_handle = (long)INVALID_HANDLE_VALUE;
 	return p;
 }
 int closedir(DIR *dir)
 {
-	_findclose(dir->dd_handle);
+	if (dir->dd_handle != (long)INVALID_HANDLE_VALUE)
+		FindClose((HANDLE)dir->dd_handle);
 	free(dir);
 	return 0;
 }
-- 
1.7.3.2.493.ge4bf7
