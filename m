From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 06/16] mingw: support waitpid with pid > 0 and WNOHANG
Date: Fri, 22 Oct 2010 02:35:17 +0200
Message-ID: <1287707727-5780-7-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCNuYPmBBoEnyFK5g@googlegroups.com Fri Oct 22 02:36:56 2010
Return-path: <msysgit+bncCOPdven-DxCNuYPmBBoEnyFK5g@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCNuYPmBBoEnyFK5g@googlegroups.com>)
	id 1P95cr-0002V4-8M
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:36:53 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf139996wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=n0F5yY7ZOa+qSo1LHUc7Vx5fMxO1s8ZkewTiA3Dx2rg=;
        b=yQ7hXyaNyNpDhpzNg/L0czWV08I5nMjaZB/rc0DF9Bmqu42NnyL6fu/qlzagFoA371
         qUhBEUctFjyizZqzzCjy67jOhwxf6bST92PXG+mA3MIcSIl8aMJ4Phiq1VonTbx4RajB
         0X6x4QqIs8h/PRNZXvfLaAlyz7KfqRqbi58t4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=strgAYbJ6l15yGxUTN5u6zFj1+ZoIKteEtMQB8fWVJL4Znn1EdvjNLiPi1vZqAv4Vt
         6W8LrP0lLP5XW04c7SHeUUioC1R182XM4fniJLyX0OYMoQCkrbbAz9KEA0OcPfj3eNRc
         h3uVk6tfzdr7FK5dBDcewTRjhhtnpWqFe012Y=
Received: by 10.216.237.132 with SMTP id y4mr294479weq.1.1287707789378;
        Thu, 21 Oct 2010 17:36:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.3.29 with SMTP id 29ls269333eeg.0.p; Thu, 21 Oct 2010
 17:36:28 -0700 (PDT)
Received: by 10.14.119.79 with SMTP id m55mr173844eeh.12.1287707788561;
        Thu, 21 Oct 2010 17:36:28 -0700 (PDT)
Received: by 10.14.119.79 with SMTP id m55mr173843eeh.12.1287707788540;
        Thu, 21 Oct 2010 17:36:28 -0700 (PDT)
Received: from mail-ey0-f176.google.com (mail-ey0-f176.google.com [209.85.215.176])
        by gmr-mx.google.com with ESMTP id r57si1454182eeh.1.2010.10.21.17.36.27;
        Thu, 21 Oct 2010 17:36:27 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.176 as permitted sender) client-ip=209.85.215.176;
Received: by eyg24 with SMTP id 24so160419eyg.7
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:27 -0700 (PDT)
Received: by 10.213.14.1 with SMTP id e1mr5353648eba.94.1287707787277;
        Thu, 21 Oct 2010 17:36:27 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2485405eeh.8.2010.10.21.17.36.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.176 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159617>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    6 ++++++
 compat/mingw.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e2e3c54..2e7c644 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1550,6 +1550,12 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 		return -1;
 	}
 
+	if (pid > 0 && options & WNOHANG) {
+		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
+			return 0;
+		options &= ~WNOHANG;
+	}
+
 	if (options == 0) {
 		int i;
 		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
diff --git a/compat/mingw.h b/compat/mingw.h
index 7c4eeea..379d7bf 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -140,6 +140,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
+#define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
-- 
1.7.3.1.199.g72340
