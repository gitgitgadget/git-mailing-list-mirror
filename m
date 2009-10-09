From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 6/8] mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
Date: Fri,  9 Oct 2009 17:04:40 +0200
Message-ID: <1255100682-13952-6-git-send-email-kusmabite@gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-2-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-3-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-4-git-send-email-kusmabite@gmail.com>
 <1255100682-13952-5-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:11:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwH89-0007fT-K2
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761001AbZJIPGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760951AbZJIPGI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:06:08 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:49018 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539AbZJIPGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:06:07 -0400
Received: by mail-ew0-f208.google.com with SMTP id 4so697151ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PlPaajrnIMhgMNzqmQ6dlAVn5jKNha2J4yjyBVpkBGM=;
        b=eZSJOb3B0/eZiKjrU4a1+BMbp3sHIFY6jjHZlbBKfRn9eB/IP2+m5FaJ80jFMSQog4
         HpVvkihRr0r2Z7HjaWgx16wL9f3PQxBaeWdJkrphKDOwyEhaP+YycCytCNrMHtYWqUQW
         1qK60Cq1DjGO1g58q2Pv7sIX56NwGDZTl/n6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=obXrCKIEPcJAwOO0pTjYbOYgE7HxyfAd1Sff/okASqzGcw3fypuLj881D4Iq+IxkVo
         F6xSTudnn9saP7uaPnL1Ldd14VpHTQ/fl69oXaQTvU1SI9zJG7RwBiQ1TLKafwr3ouQS
         atGSbLkDt/Ptu2hJGIR4vJ3FxpAdbMFO2Al5U=
Received: by 10.216.89.138 with SMTP id c10mr927925wef.47.1255100755439;
        Fri, 09 Oct 2009 08:05:55 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 10sm1143351eyz.8.2009.10.09.08.05.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 08:05:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1255100682-13952-5-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129813>

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
1.6.5.rc1.60.g41795
