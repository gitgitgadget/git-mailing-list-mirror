From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 6/8] mingw: wrap SSL_set_(w|r)fd to call
 _get_osfhandle
Date: Tue, 13 Oct 2009 19:25:23 +0000
Message-ID: <1255461925-2244-7-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com> <1255461925-2244-6-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:58 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn1J-000704-Sa
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:54 +0200
Received: by gxk28 with SMTP id 28so6051840gxk.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=PlKApmW4RuXHgapGHsMSdJBa2yxW44Jh2h1yyz6X9sI=;
        b=RNL0o6NkTAQZ6sroB3gXF5xznBJEym2cKWLMie2+Qr1B1Kik9KmwPNkiCPc+sbKR+M
         L4xu9nYyGoMvEahHRkoxKO+wlVut05IBZOJTKfCeVqtEf5fOdrgaENsv3g0hRmchOPS0
         FddmY3y2cZKj5YDTuAyf5LVb2CcjPleUpEzIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Yq11bKN3EbFgNcFja0AV9xxkJvQMB+CIgUGr3ZE9wzWxqusnRYPjRh3EES5GR4i9wU
         GBL42hXjOSmFlCZjuULjE4Lvgm8O6IkISCfeoQUjxL2q/e1JvzR68xsA1nN9PLUO2kbF
         kc2Xiy8x9As6gZIZpV/kMc4SiYM8zt//wld6I=
Received: by 10.150.45.42 with SMTP id s42mr912096ybs.23.1255462005641;
        Tue, 13 Oct 2009 12:26:45 -0700 (PDT)
Received: by 10.176.11.6 with SMTP id 6gr7400yqk.0;
	Tue, 13 Oct 2009 12:26:32 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.132.10 with SMTP id j10mr422201ebn.6.1255461991234; Tue, 13 Oct 2009 12:26:31 -0700 (PDT)
Received: by 10.211.132.10 with SMTP id j10mr422200ebn.6.1255461991199; Tue, 13 Oct 2009 12:26:31 -0700 (PDT)
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com [209.85.219.209]) by gmr-mx.google.com with ESMTP id 13si332074ewy.6.2009.10.13.12.26.30; Tue, 13 Oct 2009 12:26:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.209 as permitted sender) client-ip=209.85.219.209;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.209 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ewy5 with SMTP id 5so1083473ewy.6 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=Z0Dg90Xv8Gs8yZAASL6TZsmeMFPoUZ/mWvGFItrtwjQ=; b=fSgQ31JdUEm6I+qBCddQIz8E/cZwTft3eu/pPPioZSo+KXJDJs50wL1xypzZjfFC2u 47CVwxSYHyOJ3KGUjGfYP/2cAtwDeEu5rqXY9EvkXk/iU9pYOeRrzAGRVvO8vLO29sdy XC9e4WZlDaCP5kzBEq6pZDIesijdATO44DtUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=EoWzjSojGuEmvRP8ZDoOkETx1+ZDWK6Nk/1tFOqJOWrVwRFjvrNAqWpoZbG9+W0K7t DGmF/uQlIDmaH5kvIAlkZDTBADQc5qQI5Nb4fo7XByRVO++eEyou47sQ315rp+I9yE6b z/LtzpfaLofafOG0rHSihC3iXcpwyZ/ATocZo=
Received: by 10.211.155.11 with SMTP id h11mr9215286ebo.62.1255461990118; Tue, 13 Oct 2009 12:26:30 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 10sm201287eyd.4.2009.10.13.12.26.25 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:26:26 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-6-git-send-email-kusmabite@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130190>


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
1.6.4
