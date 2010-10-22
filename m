From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 05/15] mingw: support waitpid with pid > 0 and WNOHANG
Date: Fri, 22 Oct 2010 02:05:34 +0200
Message-ID: <1287705944-5668-5-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCPq4PmBBoEtB0ywA@googlegroups.com Fri Oct 22 02:07:04 2010
Return-path: <msysgit+bncCOPdven-DxCPq4PmBBoEtB0ywA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCPq4PmBBoEtB0ywA@googlegroups.com>)
	id 1P95A0-0004SJ-4n
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:04 +0200
Received: by mail-ww0-f58.google.com with SMTP id 28sf109548wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=n0F5yY7ZOa+qSo1LHUc7Vx5fMxO1s8ZkewTiA3Dx2rg=;
        b=4B9G3bzxW3tEjbx00mGssj4AQppQjPYvZvIQNWe3271/GA7IPIxxPlemoGS2w0gtLz
         qn20aHR4Yf19nXbDSRSzU/FHIxoIlZEDP/8iWtQOg4WY1MBF6/cLJVtLXKppmYA6r5vx
         BwpIrhwXkKx1lj7zxxFbSPwpE+nLnJhXg2x/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=HyRPvRrXHfEWeBnaAgpA4lKQMImM7yhsrqq8l+Jaa3OhpASFNkNZRjSCXo46e5108s
         fpijND963iSy6bKWXkb4RKY29kDFUOUBh8dTlyRcXHjJM3z9HBO1KLy8T8jqrPGMz96i
         sGXssgIzl0ReOBzNoaJOvoc0fF4qAWx9Uf5m4=
Received: by 10.216.231.71 with SMTP id k49mr298461weq.14.1287705999591;
        Thu, 21 Oct 2010 17:06:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.10.75 with SMTP id 51ls268311eeu.6.p; Thu, 21 Oct 2010
 17:06:38 -0700 (PDT)
Received: by 10.14.127.69 with SMTP id c45mr232642eei.14.1287705998633;
        Thu, 21 Oct 2010 17:06:38 -0700 (PDT)
Received: by 10.14.127.69 with SMTP id c45mr232641eei.14.1287705998612;
        Thu, 21 Oct 2010 17:06:38 -0700 (PDT)
Received: from mail-ew0-f53.google.com (mail-ew0-f53.google.com [209.85.215.53])
        by gmr-mx.google.com with ESMTP id t3si505568eeh.7.2010.10.21.17.06.37;
        Thu, 21 Oct 2010 17:06:37 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.53 as permitted sender) client-ip=209.85.215.53;
Received: by ewy10 with SMTP id 10so184767ewy.12
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:37 -0700 (PDT)
Received: by 10.213.48.131 with SMTP id r3mr2346775ebf.69.1287705997468;
        Thu, 21 Oct 2010 17:06:37 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2465168eeh.2.2010.10.21.17.06.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.53 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159596>

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
