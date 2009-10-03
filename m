From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 6/7] mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
Date: Sat,  3 Oct 2009 00:39:44 +0000
Message-ID: <1254530385-2824-6-git-send-email-kusmabite@gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtsfn-0004WA-9g
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbZJCAkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbZJCAkR
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:40:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:43951 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbZJCAkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:40:16 -0400
Received: by qw-out-2122.google.com with SMTP id 3so587565qwe.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=j1ETYoVKsgNrhDI8e7WgVrv1d7yENgeL9reY9TuSVXI=;
        b=RH4zQcOs/qaIgRLA5+xifQRSlgXBeLhf11oNDLEMOoh4mSnN5NEV18oSWE4zUOeNAz
         dfXBNg7Ed5R/TgNLalrLzFh/vrVEQYRepnzWCkFA/4ji0jKES3uBvxy30NPCClDuu50s
         tuAgzsajzTzkxNjClkkVhxSYyPGzxdeNBtWrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VtsVmOnSqhTP8+Dnq3p0sb2nuSIMN1OZhaA5n+dYtOBBbVGHyHbz17eoBIcxHiz5aA
         aE7W3odOmCszRknw8b+T06VLRA7eURNAVtj6tJCWi+pHSlNZvC/SCL2/6UFO5eSVSFBB
         BXdhua2UtRlSty8x0GMv9R4gbQ7WGb+uIPRFg=
Received: by 10.224.82.11 with SMTP id z11mr1655597qak.87.1254530420462;
        Fri, 02 Oct 2009 17:40:20 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 22sm308847qyk.6.2009.10.02.17.40.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:40:19 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129476>

SSL_set_fd (and friends) expects a OS file handle on Windows, not
a file descriptor as on UNIX(-ish).

This patch makes the Windows version of SSL_set_fd behave like the
UNIX versions, by calling _get_osfhandle on it's input.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 5b5258b..6907345 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -124,6 +124,27 @@ static inline int waitpid(pid_t pid, int *status, unsigned options)
 	return -1;
 }
 
+#ifndef NO_OPENSSL
+#include <openssl/ssl.h>
+static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
+{
+	return SSL_set_fd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_fd mingw_SSL_set_fd
+
+static inline int mingw_SSL_set_rfd(SSL *ssl, int fd)
+{
+	return SSL_set_rfd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_rfd mingw_SSL_set_rfd
+
+static inline int mingw_SSL_set_wfd(SSL *ssl, int fd)
+{
+	return SSL_set_wfd(ssl, _get_osfhandle(fd));
+}
+#define SSL_set_wfd mingw_SSL_set_wfd
+#endif
+
 /*
  * implementations of missing functions
  */
-- 
1.6.5.rc2.7.g4f8d3
